#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
TEKNOFEST 2026 Cip Tasarim Yarismasi - Mikrodenetleyici Kategorisi
FPGA Demo Test Araci - YARISMACI SURUMU

Final demosunda tasariminiz bu araca baglanacaktir. Bu surum, demo gunu
kullanilacak olanla AYNI protokol kodunu icerir (cerceveleme, saglama
toplami, sonuc ayristirma, ICD dogrulama); boylece Arayuz Tanim
Dokumaninizi (ICD) ve UART arayuzunuzu onceden kendi FPGA'niz uzerinde
dogrulayabilirsiniz.

Kapsam:
  A) Toplu cikarim kosumu: vektorler UART-stream uzerinden hizlandiriciya
     surulur, sonuclar core UART'tan okunur ve raporlanir.
  F) Saglamlik senaryolari: sessizlik, doygunluk, ardisik cerceve, kesik
     cerceve, cevre birimi araya girmesi (reset'siz gecis), tekrarlanabilirlik.

Demo gununde kullanilacak vektorler bu pakette YOKTUR. Kendi vektorlerinizle
veya sentetik verilerle (manifest vermezseniz otomatik uretilir) test edin.

Mimari notlar:
  * Her takimin arayuzu farkli oldugu icin butun protokol davranisi bir
    JSON konfigurasyon dosyasindan (ICD) okunur. Kod hicbir takima ozel
    varsayim icermez.
  * Cekirdek mantik (DemoRunner) hicbir sey yazdirmaz; olaylari bir
    callback'e (EventSink) gonderir. CLI bunun bir tuketicisidir; GUI
    ileride ikinci bir tuketici olarak eklenecektir.
  * Vektor kaynaklari (VectorSource) soyutlanmistir; manifest, klasor ve
    sentetik vektor kaynaklari desteklenir.

Bagimlilik: pyserial (yalnizca gercek donanim icin). --dry-run modu
bagimlilik gerektirmez.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import os
import queue
import random
import re
import statistics
import sys
import threading
import time
import zlib
from dataclasses import dataclass, field
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Callable, Dict, Iterable, Iterator, List, Optional, Tuple

HARNESS_VERSION = "1.0.1"
DEFAULT_PAYLOAD_LEN = 1960          # TFLite Micro Speech giris vektoru
DEFAULT_CLASSES = ["silence", "unknown", "yes", "no"]


# =============================================================================
# Yardimcilar
# =============================================================================

def now_ts() -> float:
    return time.perf_counter()


def iso_now() -> str:
    return datetime.now(timezone.utc).astimezone().isoformat(timespec="seconds")


def _make_crc16_table() -> List[int]:
    tbl = []
    for b in range(256):
        c = b << 8
        for _ in range(8):
            c = ((c << 1) ^ 0x1021) & 0xFFFF if (c & 0x8000) else (c << 1) & 0xFFFF
        tbl.append(c)
    return tbl


_CRC16_TABLE = _make_crc16_table()


def crc16_ccitt(data: bytes, init: int = 0xFFFF) -> int:
    """CRC-16/CCITT-FALSE (poly 0x1021, init 0xFFFF). Tablo ile bayt bayt."""
    crc = init
    tbl = _CRC16_TABLE
    for b in data:
        crc = ((crc << 8) & 0xFFFF) ^ tbl[((crc >> 8) ^ b) & 0xFF]
    return crc


def checksum_bytes(kind: str, data: bytes, endian: str = "little") -> bytes:
    kind = (kind or "none").lower()
    if kind == "none":
        return b""
    if kind == "sum8":
        return bytes([sum(data) & 0xFF])
    if kind == "xor8":
        x = 0
        for b in data:
            x ^= b
        return bytes([x])
    if kind == "crc16_ccitt":
        return crc16_ccitt(data).to_bytes(2, endian)
    if kind == "crc32":
        return (zlib.crc32(data) & 0xFFFFFFFF).to_bytes(4, endian)
    raise ValueError(f"Bilinmeyen checksum turu: {kind}")


def hexbytes(s: str) -> bytes:
    s = (s or "").replace(" ", "").replace("_", "").replace("0x", "")
    if not s:
        return b""
    if len(s) % 2:
        raise ValueError(f"Gecersiz hex dizisi: {s!r}")
    return bytes.fromhex(s)


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    h.update(path.read_bytes())
    return h.hexdigest()


def pct(values: List[float], p: float) -> float:
    if not values:
        return float("nan")
    s = sorted(values)
    k = (len(s) - 1) * (p / 100.0)
    lo, hi = int(k), min(int(k) + 1, len(s) - 1)
    return s[lo] + (s[hi] - s[lo]) * (k - lo)


def parse_number_list(text: str) -> List[float]:
    """Noktalivirgul/virgul/bosluk ayrimli sayi listesini cozer."""
    return [float(x) for x in re.findall(r"-?\d+(?:\.\d+)?", text or "")]


def probs_to_int8_scores(probs: List[float]) -> List[float]:
    """TFLite int8 softmax olcegindeki olasiliklari ham int8 cikisa cevirir."""
    return [float(max(-128, min(127, round(float(x) * 256.0) - 128))) for x in probs]


def score_vector_error_pct(hw_scores: List[float], golden_scores: List[float],
                           golden_probs: Optional[List[float]] = None) -> Optional[float]:
    """
    UART skorlarini golden cikisla karsilastirir ve ortalama mutlak hatayi
    yuzde-puan cinsinden dondurur. UART 0..1 olasilik veriyorsa dogrudan,
    aksi halde int8 softmax cikisi (-128..127) kabul edilerek dequantize edilir.
    """
    if not hw_scores:
        return None
    n = len(hw_scores)
    looks_prob = all(-1e-6 <= float(x) <= 1.0001 for x in hw_scores)
    if looks_prob:
        if golden_probs and len(golden_probs) == n:
            gp = [float(x) for x in golden_probs]
        elif golden_scores and len(golden_scores) == n:
            gp = [max(0.0, min(1.0, (float(x) + 128.0) / 256.0)) for x in golden_scores]
        else:
            return None
        hp = [max(0.0, min(1.0, float(x))) for x in hw_scores]
    else:
        if not golden_scores or len(golden_scores) != n:
            return None
        if any(float(x) < -128.0 or float(x) > 127.0 for x in hw_scores):
            return None
        # Ham int8 skorlar ayniysa hata tam olarak sifir olur.
        hp = [(float(x) + 128.0) / 256.0 for x in hw_scores]
        gp = [(float(x) + 128.0) / 256.0 for x in golden_scores]
    return statistics.mean(abs(a - b) for a, b in zip(hp, gp)) * 100.0


# =============================================================================
# Olay sistemi (GUI icin ayrilma noktasi)
# =============================================================================

@dataclass
class Event:
    kind: str                    # log | progress | sample | scenario | phase | error
    message: str = ""
    level: str = "info"          # info | warn | error | ok
    data: Dict[str, Any] = field(default_factory=dict)
    t: float = field(default_factory=time.time)


EventSink = Callable[[Event], None]


def null_sink(_: Event) -> None:
    pass


# =============================================================================
# Konfigurasyon
# =============================================================================

@dataclass
class PortConfig:
    """Tek bir seri arayuzun fiziksel ayarlari. Iki arayuz bagimsiz kurulur."""
    port: str = ""
    baudrate: int = 115200
    bytesize: int = 8
    parity: str = "N"            # N, E, O, M, S
    stopbits: float = 1          # 1, 1.5, 2
    rtscts: bool = False
    dsrdtr: bool = False
    xonxoff: bool = False
    read_timeout_s: float = 0.05
    write_timeout_s: float = 5.0
    dtr: Optional[bool] = None   # bazi kartlarda reset hattina bagli
    rts: Optional[bool] = None
    open_settle_ms: int = 200
    flush_input_on_open: bool = True

    @staticmethod
    def from_dict(d: Dict[str, Any]) -> "PortConfig":
        c = PortConfig()
        for k, v in (d or {}).items():
            if hasattr(c, k):
                setattr(c, k, v)
        return c


@dataclass
class FramingConfig:
    """UART-stream tarafinda cerceve yapisi."""
    preamble_hex: str = ""
    index_field_size: int = 0           # 0 = yok
    length_field_size: int = 0          # 0 = yok
    length_counts: str = "payload"      # payload | payload_plus_checksum
    endian: str = "little"
    checksum: str = "none"              # none|sum8|xor8|crc16_ccitt|crc32
    checksum_covers: str = "payload"    # payload | header_payload
    trailer_hex: str = ""
    chunk_size: int = 256               # 0 = tek seferde yaz
    inter_chunk_delay_ms: float = 0.0
    inter_frame_delay_ms: float = 20.0
    drain_after_write: bool = True

    @staticmethod
    def from_dict(d: Dict[str, Any]) -> "FramingConfig":
        c = FramingConfig()
        for k, v in (d or {}).items():
            if hasattr(c, k):
                setattr(c, k, v)
        return c


@dataclass
class PayloadConfig:
    length: int = DEFAULT_PAYLOAD_LEN
    encoding: str = "int8"       # int8 | uint8_offset128 | uint8_raw
    pad_value: int = 0

    @staticmethod
    def from_dict(d: Dict[str, Any]) -> "PayloadConfig":
        c = PayloadConfig()
        for k, v in (d or {}).items():
            if hasattr(c, k):
                setattr(c, k, v)
        return c


@dataclass
class ResultConfig:
    """Core UART'tan sonucun nasil okunacagi."""
    mode: str = "regex_line"     # regex_line | json_line | csv_line | binary_fixed
    line_terminator: str = "\n"
    encoding: str = "ascii"
    regex: str = r"RESULT\s*[:=]\s*(?P<label>[A-Za-z_0-9]+)(?:.*?scores\s*[:=]\s*(?P<scores>[-+0-9.,;\s]+))?"
    json_label_key: str = "label"
    json_scores_key: str = "scores"
    csv_label_index: int = 0
    csv_scores_start: int = 1
    binary_preamble_hex: str = ""
    binary_label_size: int = 1
    binary_score_count: int = 0
    binary_score_size: int = 1
    binary_score_signed: bool = True
    binary_endian: str = "little"
    label_map: Dict[str, str] = field(default_factory=dict)   # "0"->"silence" vb.
    classes: List[str] = field(default_factory=lambda: list(DEFAULT_CLASSES))
    timeout_ms: int = 5000
    ignore_regex: str = ""       # gurultu/banner satirlarini eleme

    @staticmethod
    def from_dict(d: Dict[str, Any]) -> "ResultConfig":
        c = ResultConfig()
        for k, v in (d or {}).items():
            if hasattr(c, k):
                setattr(c, k, v)
        return c


@dataclass
class HooksConfig:
    """Takima ozel, tasarim degisikligi gerektirmeyen kancalar."""
    boot_banner_regex: str = ""
    boot_timeout_ms: int = 10000
    boot_trigger_core_hex: str = ""
    core_init_hex: str = ""            # kosum basinda core UART'a gonderilecek
    stream_init_hex: str = ""          # kosum basinda stream UART'a gonderilecek
    pre_frame_core_hex: str = ""       # her cerceveden once core'a
    interleave_core_hex: str = ""      # F: cevre birimi tetikleyen komut
    interleave_expect_regex: str = ""  # o komuta beklenen yanit
    reset_hex: str = ""                # yazilimsal reset (kullanilmiyorsa bos)

    @staticmethod
    def from_dict(d: Dict[str, Any]) -> "HooksConfig":
        c = HooksConfig()
        for k, v in (d or {}).items():
            if hasattr(c, k):
                setattr(c, k, v)
        return c


@dataclass
class RunConfig:
    warmup_frames: int = 1
    retries_per_sample: int = 1
    inter_sample_delay_ms: float = 0.0
    stop_on_consecutive_timeouts: int = 10
    software_reference_ms: Optional[float] = None   # yazilim gerceklemesi suresi
    speedup_threshold: float = 10.0                 # yalniz raporlama amacli

    @staticmethod
    def from_dict(d: Dict[str, Any]) -> "RunConfig":
        c = RunConfig()
        for k, v in (d or {}).items():
            if hasattr(c, k):
                setattr(c, k, v)
        return c


@dataclass
class HarnessConfig:
    team_name: str = "UNKNOWN"
    team_id: str = ""
    notes: str = ""
    stream_port: PortConfig = field(default_factory=PortConfig)
    core_port: PortConfig = field(default_factory=PortConfig)
    framing: FramingConfig = field(default_factory=FramingConfig)
    payload: PayloadConfig = field(default_factory=PayloadConfig)
    result: ResultConfig = field(default_factory=ResultConfig)
    hooks: HooksConfig = field(default_factory=HooksConfig)
    run: RunConfig = field(default_factory=RunConfig)
    raw: Dict[str, Any] = field(default_factory=dict)

    def to_dict(self) -> Dict[str, Any]:
        """Kosumda gercekten kullanilan etkin ICD sozlugunu dondurur."""
        base = json.loads(json.dumps(self.raw or CONFIG_TEMPLATE))
        base.setdefault("team", {}).update({
            "name": self.team_name, "id": self.team_id, "notes": self.notes})
        base.setdefault("stream", {}).setdefault("port", {}).update(vars(self.stream_port))
        base.setdefault("stream", {}).setdefault("framing", {}).update(vars(self.framing))
        base.setdefault("stream", {}).setdefault("payload", {}).update(vars(self.payload))
        base.setdefault("core", {}).setdefault("port", {}).update(vars(self.core_port))
        base.setdefault("core", {}).setdefault("result", {}).update(vars(self.result))
        base.setdefault("hooks", {}).update(vars(self.hooks))
        base.setdefault("run", {}).update(vars(self.run))
        return base

    @staticmethod
    def load(path: Path) -> "HarnessConfig":
        return HarnessConfig.from_dict(json.loads(path.read_text(encoding="utf-8")))

    @staticmethod
    def from_dict(d: Dict[str, Any]) -> "HarnessConfig":
        c = HarnessConfig()
        team = d.get("team", {})
        c.team_name = team.get("name", "UNKNOWN")
        c.team_id = team.get("id", "")
        c.notes = team.get("notes", "")
        c.stream_port = PortConfig.from_dict(d.get("stream", {}).get("port", {}))
        c.core_port = PortConfig.from_dict(d.get("core", {}).get("port", {}))
        c.framing = FramingConfig.from_dict(d.get("stream", {}).get("framing", {}))
        c.payload = PayloadConfig.from_dict(d.get("stream", {}).get("payload", {}))
        c.result = ResultConfig.from_dict(d.get("core", {}).get("result", {}))
        c.hooks = HooksConfig.from_dict(d.get("hooks", {}))
        c.run = RunConfig.from_dict(d.get("run", {}))
        c.raw = d
        return c

    @staticmethod
    def default() -> "HarnessConfig":
        return HarnessConfig.from_dict(json.loads(json.dumps(CONFIG_TEMPLATE)))


# =============================================================================
# Tasima katmani (gercek seri port + kuru kosum simulatoru)
# =============================================================================

class Link:
    """Seri baglanti soyutlamasi."""
    def open(self) -> None: ...
    def close(self) -> None: ...
    def write(self, data: bytes) -> None: ...
    def read(self, n: int = 4096) -> bytes: ...
    def flush(self) -> None: ...
    def reset_input(self) -> None: ...
    @property
    def name(self) -> str: return "link"


class SerialLink(Link):
    def __init__(self, cfg: PortConfig, label: str):
        self.cfg = cfg
        self.label = label
        self._ser = None

    def open(self) -> None:
        try:
            import serial  # type: ignore
        except ImportError as e:
            raise RuntimeError(
                "pyserial bulunamadi. Kurulum: pip install pyserial "
                "(donanimsiz test icin --dry-run kullanin)"
            ) from e
        parity_map = {"N": serial.PARITY_NONE, "E": serial.PARITY_EVEN,
                      "O": serial.PARITY_ODD, "M": serial.PARITY_MARK,
                      "S": serial.PARITY_SPACE}
        stop_map = {1: serial.STOPBITS_ONE, 1.5: serial.STOPBITS_ONE_POINT_FIVE,
                    2: serial.STOPBITS_TWO}
        c = self.cfg
        self._ser = serial.Serial(
            port=c.port, baudrate=c.baudrate, bytesize=c.bytesize,
            parity=parity_map[c.parity.upper()], stopbits=stop_map[float(c.stopbits)],
            timeout=c.read_timeout_s, write_timeout=c.write_timeout_s,
            rtscts=c.rtscts, dsrdtr=c.dsrdtr, xonxoff=c.xonxoff,
        )
        if c.dtr is not None:
            self._ser.dtr = c.dtr
        if c.rts is not None:
            self._ser.rts = c.rts
        time.sleep(c.open_settle_ms / 1000.0)
        if c.flush_input_on_open:
            self._ser.reset_input_buffer()
        self._ser.reset_output_buffer()

    def close(self) -> None:
        if self._ser and self._ser.is_open:
            self._ser.close()

    def write(self, data: bytes) -> None:
        self._ser.write(data)

    def read(self, n: int = 4096) -> bytes:
        waiting = getattr(self._ser, "in_waiting", 0)
        return self._ser.read(max(1, min(n, waiting or 1)))

    def flush(self) -> None:
        self._ser.flush()

    def reset_input(self) -> None:
        self._ser.reset_input_buffer()

    @property
    def name(self) -> str:
        return f"{self.label}@{self.cfg.port}:{self.cfg.baudrate}"


class FakeDevice:
    """
    Kuru kosum (donanimsiz) simulatoru. Stream cercevesini ICD'deki
    framing ayarlarina gore cozer; boylece ham payload dahil farkli cerceve
    yapilari --dry-run ile sinanabilir.
    """
    def __init__(self, framing: FramingConfig, payload_cfg: PayloadConfig,
                 result_cfg: ResultConfig, latency_ms: float = 3.0,
                 drop_rate: float = 0.0, accuracy: float = 0.92, seed: int = 0):
        self.framing = framing
        self.payload_cfg = payload_cfg
        self.result_cfg = result_cfg
        self.payload_len = payload_cfg.length
        self.classes = result_cfg.classes
        self.latency_ms = latency_ms
        self.drop_rate = drop_rate
        self.accuracy = accuracy
        self.rng = random.Random(seed)
        self.rx = bytearray()
        self.tx = bytearray()
        self.truth_hint: Optional[str] = None
        self.golden_scores_hint: Optional[List[float]] = None
        self._pending: List[Tuple[float, bytes]] = []
        self.frame_count = 0

    def _resync_one(self) -> None:
        pre = hexbytes(self.framing.preamble_hex)
        if pre:
            j = self.rx.find(pre, 1)
            if j >= 0:
                del self.rx[:j]
                return
        if self.rx:
            del self.rx[:1]

    def _extract_payload(self) -> Optional[bytes]:
        f = self.framing
        pre = hexbytes(f.preamble_hex)
        trailer = hexbytes(f.trailer_hex)
        cksz = len(checksum_bytes(f.checksum, b"", f.endian))

        while True:
            if pre:
                i = self.rx.find(pre)
                if i < 0:
                    # Preamble'in parcali gelmesi ihtimali icin olasi son eki koru.
                    keep = max(0, len(pre) - 1)
                    if len(self.rx) > keep:
                        del self.rx[:len(self.rx) - keep]
                    return None
                if i:
                    del self.rx[:i]

            head_len = len(pre) + f.index_field_size + f.length_field_size
            if len(self.rx) < head_len:
                return None

            off = len(pre) + f.index_field_size
            if f.length_field_size:
                declared = int.from_bytes(
                    self.rx[off:off + f.length_field_size], f.endian)
                payload_len = declared - cksz if f.length_counts == "payload_plus_checksum" else declared
                if payload_len < 0:
                    self._resync_one()
                    continue
            else:
                payload_len = self.payload_len

            total = head_len + payload_len + cksz + len(trailer)
            if total <= 0:
                self._resync_one()
                continue

            if len(self.rx) < total:
                return None

            frame = bytes(self.rx[:total])
            payload = frame[head_len:head_len + payload_len]
            got_ck = frame[head_len + payload_len:head_len + payload_len + cksz]
            got_tr = frame[head_len + payload_len + cksz:total]

            if trailer and got_tr != trailer:
                self._resync_one()
                continue
            if cksz:
                head = frame[:head_len]
                covered = payload if f.checksum_covers == "payload" else head + payload
                exp_ck = checksum_bytes(f.checksum, covered, f.endian)
                if got_ck != exp_ck:
                    self._resync_one()
                    continue

            del self.rx[:total]
            return payload

    def _encode_result(self, label: str, scores: List[float]) -> bytes:
        c = self.result_cfg
        mode = c.mode
        term = c.line_terminator.encode(c.encoding, errors="ignore") or b"\n"
        if mode == "json_line":
            obj = {c.json_label_key: label, c.json_scores_key: scores}
            return json.dumps(obj, separators=(",", ":")).encode(c.encoding) + term
        if mode == "csv_line":
            vals = [label] + [str(int(x) if float(x).is_integer() else x) for x in scores]
            return ",".join(vals).encode(c.encoding) + term
        if mode == "binary_fixed":
            pre = hexbytes(c.binary_preamble_hex)
            try:
                lab = c.classes.index(label)
            except ValueError:
                lab = 0
            out = bytearray(pre)
            out += int(lab).to_bytes(c.binary_label_size, c.binary_endian, signed=False)
            count = int(c.binary_score_count)
            for x in (scores[:count] + [0.0] * max(0, count - len(scores))):
                bits = 8 * c.binary_score_size
                if c.binary_score_signed:
                    lo, hi = -(1 << (bits - 1)), (1 << (bits - 1)) - 1
                else:
                    lo, hi = 0, (1 << bits) - 1
                q = max(lo, min(hi, int(round(x))))
                out += q.to_bytes(c.binary_score_size, c.binary_endian,
                                  signed=c.binary_score_signed)
            return bytes(out)
        # regex_line icin genel, okunabilir varsayilan sonuc. Varsayilan regex ve
        # buna uyumlu takim regex'leri bunu dogrudan cozer.
        line = f"RESULT: {label} scores={','.join(str(int(x) if float(x).is_integer() else x) for x in scores)}"
        return line.encode(c.encoding) + term

    def feed(self, data: bytes) -> None:
        self.rx += data
        while True:
            payload = self._extract_payload()
            if payload is None:
                return
            self.frame_count += 1
            if self.rng.random() < self.drop_rate:
                continue
            h = zlib.crc32(payload)
            if self.golden_scores_hint and len(self.golden_scores_hint) == len(self.classes):
                scores = list(self.golden_scores_hint)
                label = self.truth_hint or self.classes[max(range(len(scores)), key=lambda i: scores[i])]
            else:
                label = self.truth_hint or self.classes[h % len(self.classes)]
                if (h % 100) >= int(self.accuracy * 100):
                    label = self.classes[(h // 7) % len(self.classes)]
                scores = [float(((h >> (4 * k)) % 41) - 20) for k in range(len(self.classes))]
                scores[self.classes.index(label)] = 120.0
            encoded = self._encode_result(label, scores)
            self._pending.append((time.perf_counter() + self.latency_ms / 1000.0,
                                  encoded))

    def drain(self) -> bytes:
        now = time.perf_counter()
        out = bytearray()
        keep = []
        for t, b in self._pending:
            (out.extend(b) if t <= now else keep.append((t, b)))
        self._pending = keep
        return bytes(out)


class FakeStreamLink(Link):
    def __init__(self, dev: FakeDevice):
        self.dev = dev

    def open(self): pass
    def close(self): pass
    def write(self, data: bytes) -> None: self.dev.feed(data)
    def read(self, n: int = 4096) -> bytes: return b""
    def flush(self): pass
    def reset_input(self): pass
    @property
    def name(self) -> str: return "stream@FAKE"


class FakeCoreLink(Link):
    def __init__(self, dev: FakeDevice):
        self.dev = dev

    def open(self): pass
    def close(self): pass
    def write(self, data: bytes) -> None: pass
    def read(self, n: int = 4096) -> bytes:
        time.sleep(0.001)
        return self.dev.drain()
    def flush(self): pass
    def reset_input(self): pass
    @property
    def name(self) -> str: return "core@FAKE"


# =============================================================================
# Cerceveleme (UART-stream -> hizlandirici)
# =============================================================================

class FrameBuilder:
    def __init__(self, framing: FramingConfig, payload_cfg: PayloadConfig):
        self.f = framing
        self.p = payload_cfg

    def encode_payload(self, values: List[int]) -> bytes:
        n = self.p.length
        vals = list(values[:n]) + [self.p.pad_value] * max(0, n - len(values))
        enc = self.p.encoding.lower()
        if enc == "int8":
            return bytes((v + 256) % 256 for v in vals)
        if enc == "uint8_offset128":
            return bytes(max(0, min(255, v + 128)) for v in vals)
        if enc == "uint8_raw":
            return bytes(max(0, min(255, v)) for v in vals)
        raise ValueError(f"Bilinmeyen payload encoding: {enc}")

    def build(self, payload: bytes, index: int = 0) -> bytes:
        f = self.f
        head = bytearray(hexbytes(f.preamble_hex))
        if f.index_field_size:
            head += index.to_bytes(f.index_field_size, f.endian)
        if f.length_field_size:
            ln = len(payload)
            if f.length_counts == "payload_plus_checksum":
                ln += len(checksum_bytes(f.checksum, payload, f.endian))
            head += ln.to_bytes(f.length_field_size, f.endian)
        covered = payload if f.checksum_covers == "payload" else bytes(head) + payload
        crc = checksum_bytes(f.checksum, covered, f.endian)
        return bytes(head) + payload + crc + hexbytes(f.trailer_hex)


def write_framed(link: Link, data: bytes, framing: FramingConfig) -> Tuple[float, float]:
    """Cerceveyi parcalar halinde yazar. (t_start, t_end) doner."""
    t0 = now_ts()
    cs = framing.chunk_size or len(data)
    for i in range(0, len(data), cs):
        link.write(data[i:i + cs])
        if framing.inter_chunk_delay_ms:
            time.sleep(framing.inter_chunk_delay_ms / 1000.0)
    if framing.drain_after_write:
        link.flush()
    return t0, now_ts()


# =============================================================================
# Sonuc ayristirma (core UART)
# =============================================================================

@dataclass
class ParsedResult:
    label: str
    scores: List[float]
    raw: str
    t_rx: float


class ResultParser:
    def __init__(self, cfg: ResultConfig):
        self.cfg = cfg
        self.buf = bytearray()
        self._re = re.compile(cfg.regex) if cfg.mode == "regex_line" and cfg.regex else None
        self._ignore = re.compile(cfg.ignore_regex) if cfg.ignore_regex else None
        self.lines_seen: List[str] = []

    def _map_label(self, raw_label: str) -> str:
        lm = self.cfg.label_map or {}
        if raw_label in lm:
            return lm[raw_label]
        if raw_label.isdigit():
            idx = int(raw_label)
            if str(idx) in lm:
                return lm[str(idx)]
            if 0 <= idx < len(self.cfg.classes):
                return self.cfg.classes[idx]
        return raw_label.strip().lower()

    def feed(self, data: bytes) -> List[ParsedResult]:
        self.buf += data
        if self.cfg.mode == "binary_fixed":
            return self._parse_binary()
        return self._parse_lines()

    def _parse_lines(self) -> List[ParsedResult]:
        out: List[ParsedResult] = []
        term = self.cfg.line_terminator.encode(self.cfg.encoding, errors="ignore") or b"\n"
        # Hosgorulu satirlama: "\r\n" beklenirken cihaz yalniz "\n" (veya tersi)
        # gonderirse de satir yakalanir; bastaki/sondaki CR zaten kirpilir.
        if term in (b"\r\n", b"\r"):
            term = b"\n" if b"\n" in self.buf or term == b"\r\n" else term
        while True:
            i = self.buf.find(term)
            if i < 0:
                break
            raw = bytes(self.buf[:i]).decode(self.cfg.encoding, errors="replace").strip("\r\n \t")
            del self.buf[:i + len(term)]
            if not raw:
                continue
            self.lines_seen.append(raw)
            if self._ignore and self._ignore.search(raw):
                continue
            r = self._parse_one_line(raw)
            if r:
                out.append(r)
        return out

    def _parse_one_line(self, raw: str) -> Optional[ParsedResult]:
        t = now_ts()
        mode = self.cfg.mode
        try:
            if mode == "regex_line":
                m = self._re.search(raw) if self._re else None
                if not m:
                    return None
                gd = m.groupdict()
                label = self._map_label(gd.get("label") or "")
                scores = self._nums(gd.get("scores") or "")
                return ParsedResult(label, scores, raw, t)
            if mode == "json_line":
                if "{" not in raw:
                    return None
                obj = json.loads(raw[raw.index("{"):])
                label = self._map_label(str(obj.get(self.cfg.json_label_key, "")))
                scores = [float(x) for x in (obj.get(self.cfg.json_scores_key) or [])]
                return ParsedResult(label, scores, raw, t)
            if mode == "csv_line":
                parts = [p.strip() for p in raw.split(",")]
                if len(parts) <= self.cfg.csv_label_index:
                    return None
                label = self._map_label(parts[self.cfg.csv_label_index])
                # csv modunda her satir sonuc gibi gorunur; banner/debug satirlarinin
                # sahte sonuc olarak yutulmamasi icin etiket taninmis olmali.
                if self.cfg.classes and label not in self.cfg.classes:
                    return None
                scores = self._nums(",".join(parts[self.cfg.csv_scores_start:]))
                return ParsedResult(label, scores, raw, t)
        except Exception:
            return None
        return None

    @staticmethod
    def _nums(s: str) -> List[float]:
        return parse_number_list(s)

    def _parse_binary(self) -> List[ParsedResult]:
        c = self.cfg
        pre = hexbytes(c.binary_preamble_hex)
        out: List[ParsedResult] = []
        rec = len(pre) + c.binary_label_size + c.binary_score_count * c.binary_score_size
        while True:
            if pre:
                i = self.buf.find(pre)
                if i < 0:
                    if len(self.buf) > 4096:
                        del self.buf[:-len(pre)]
                    break
                if len(self.buf) < i + rec:
                    break
                blk = bytes(self.buf[i:i + rec])
                del self.buf[:i + rec]
            else:
                if len(self.buf) < rec:
                    break
                blk = bytes(self.buf[:rec])
                del self.buf[:rec]
            off = len(pre)
            lab = int.from_bytes(blk[off:off + c.binary_label_size], c.binary_endian)
            off += c.binary_label_size
            scores = []
            for _ in range(c.binary_score_count):
                scores.append(float(int.from_bytes(
                    blk[off:off + c.binary_score_size], c.binary_endian,
                    signed=c.binary_score_signed)))
                off += c.binary_score_size
            out.append(ParsedResult(self._map_label(str(lab)), scores, blk.hex(), now_ts()))
        return out


class CoreReader(threading.Thread):
    """Core UART'i surekli okur, ayristirilan sonuclari kuyruga koyar."""
    def __init__(self, link: Link, parser: ResultParser, sink: EventSink):
        super().__init__(daemon=True)
        self.link = link
        self.parser = parser
        self.sink = sink
        self.q: "queue.Queue[ParsedResult]" = queue.Queue()
        self.raw_lines: List[Tuple[float, str]] = []
        self._stop_evt = threading.Event()
        self._lock = threading.Lock()

    def run(self) -> None:
        while not self._stop_evt.is_set():
            try:
                data = self.link.read(4096)
            except Exception as e:
                self.sink(Event("error", f"core okuma hatasi: {e}", "error"))
                break
            if data:
                with self._lock:
                    before = len(self.parser.lines_seen)
                    for r in self.parser.feed(data):
                        self.q.put(r)
                    for ln in self.parser.lines_seen[before:]:
                        self.raw_lines.append((time.time(), ln))
                        self.sink(Event("log", ln, "info", {"src": "core"}))
            else:
                time.sleep(0.002)

    def stop(self) -> None:
        self._stop_evt.set()

    def clear(self) -> None:
        while not self.q.empty():
            try:
                self.q.get_nowait()
            except queue.Empty:
                break

    def wait_result(self, timeout_s: float,
                    cancel: Optional[threading.Event] = None) -> Optional[ParsedResult]:
        """Kucuk dilimlerle bekler; cancel gelirse zaman asimini beklemeden doner."""
        end = now_ts() + timeout_s
        while True:
            if cancel is not None and cancel.is_set():
                return None
            remaining = end - now_ts()
            if remaining <= 0:
                return None
            try:
                return self.q.get(timeout=min(0.05, remaining))
            except queue.Empty:
                continue

    def wait_regex(self, pattern: str, timeout_s: float,
                   cancel: Optional[threading.Event] = None) -> Optional[str]:
        rx = re.compile(pattern)
        t_end = now_ts() + timeout_s
        seen = 0
        while now_ts() < t_end:
            if cancel is not None and cancel.is_set():
                return None
            with self._lock:
                lines = [l for _, l in self.raw_lines[seen:]]
                seen = len(self.raw_lines)
            for l in lines:
                if rx.search(l):
                    return l
            time.sleep(0.02)
        return None


# =============================================================================
# Vektor kaynaklari (Secenek E icin genisleme noktasi)
# =============================================================================

class Sample:
    """
    Bir cikarim vektoru.

    BELLEK NOTU: vektor 1960 elemanlidir; Python int listesi olarak tutulursa
    ornek basina ~55 kB eder (3000 ornek -> ~165 MB) ve arayuzu bogar. Bu
    yuzden veri ham BAYT olarak saklanir (ornek basina ~2 kB); int listesi
    yalnizca gerekince, .values ile uretilir.
    """
    __slots__ = ("name", "data", "data_encoding", "truth", "golden", "meta", "_values")

    def __init__(self, name: str, values: Optional[Sequence[int]] = None,
                 truth: Optional[str] = None, golden: Optional[str] = None,
                 meta: Optional[Dict[str, Any]] = None,
                 data: Optional[bytes] = None, data_encoding: str = "int8"):
        self.name = name
        self.truth = truth
        self.golden = golden
        self.meta = meta or {}
        self.data_encoding = data_encoding
        self._values: Optional[List[int]] = None
        if data is not None:
            self.data = data
        elif values is not None:
            self.data = bytes((int(v) + 256) % 256 for v in values)
            self.data_encoding = "int8"
        else:
            self.data = b""

    @property
    def values(self) -> List[int]:
        """Isaretli int listesi (-128..127). Istenirse uretilir, saklanmaz."""
        if self._values is not None:
            return self._values
        return _decode_bytes(self.data, self.data_encoding)

    def payload(self, target_encoding: str, length: int) -> bytes:
        """Tel uzerine yazilacak baytlar. Kodlama ayniysa kopyalama yapilmaz."""
        b = self.data
        if self.data_encoding != target_encoding:
            b = _encode_values(_decode_bytes(b, self.data_encoding), target_encoding)
        if len(b) < length:
            b = b + bytes(length - len(b))
        elif len(b) > length:
            b = b[:length]
        return b


def _decode_bytes(b: bytes, encoding: str) -> List[int]:
    if encoding == "uint8_offset128":
        return [x - 128 for x in b]
    if encoding == "uint8_raw":
        return list(b)
    return [x - 256 if x > 127 else x for x in b]


def _encode_values(values: Sequence[int], encoding: str) -> bytes:
    if encoding == "uint8_offset128":
        return bytes(max(0, min(255, v + 128)) for v in values)
    if encoding == "uint8_raw":
        return bytes(max(0, min(255, v)) for v in values)
    return bytes((int(v) + 256) % 256 for v in values)


class VectorSource:
    """Tum kaynaklarin ortak arayuzu. GUI kaynak listesini buradan cikarir."""
    name = "base"
    def samples(self) -> Iterator[Sample]:
        raise NotImplementedError


class ManifestSource(VectorSource):
    """
    CSV manifest: file,truth[,golden,golden_scores,golden_probs]
    'file' yolu manifest dosyasina goredir. Ikili dosyalar ham int8 kabul edilir.
    """
    name = "manifest"

    def __init__(self, manifest: Path, payload_len: int, file_encoding: str = "int8"):
        self.manifest = manifest
        self.payload_len = payload_len
        self.file_encoding = file_encoding

    def samples(self) -> Iterator[Sample]:
        base = self.manifest.parent
        with self.manifest.open(newline="", encoding="utf-8") as fh:
            for row in csv.DictReader(fh):
                p = (base / row["file"]).resolve()
                gs = parse_number_list(row.get("golden_scores") or "")
                gp = parse_number_list(row.get("golden_probs") or "")
                yield Sample(
                    name=row.get("name") or Path(row["file"]).stem,
                    data=_read_raw(p, self.payload_len, self.file_encoding),
                    data_encoding=_file_enc(p, self.file_encoding),
                    truth=(row.get("truth") or "").strip().lower() or None,
                    golden=(row.get("golden") or "").strip().lower() or None,
                    meta={"path": str(p), "golden_scores": gs, "golden_probs": gp},
                )


class DirectorySource(VectorSource):
    """
    Klasordeki *.bin dosyalari. Etiket dosya adinin ilk parcasindan cikarilir:
    'yes_0001.bin' -> truth='yes'. Etiket yoksa None.
    """
    name = "directory"

    def __init__(self, root: Path, payload_len: int, file_encoding: str = "int8",
                 pattern: str = "*.bin"):
        self.root, self.payload_len = root, payload_len
        self.file_encoding, self.pattern = file_encoding, pattern

    def samples(self) -> Iterator[Sample]:
        for p in sorted(self.root.glob(self.pattern)):
            stem = p.stem
            truth = stem.split("_")[0].lower() if "_" in stem else None
            yield Sample(name=stem,
                         data=_read_raw(p, self.payload_len, self.file_encoding),
                         data_encoding=_file_enc(p, self.file_encoding),
                         truth=truth if truth in DEFAULT_CLASSES else None,
                         meta={"path": str(p)})



SOURCE_REGISTRY = {
    "manifest": ManifestSource,
    "directory": DirectorySource,
}


def _file_enc(path: Path, encoding: str) -> str:
    """Metin dosyalari cozuldugu icin daima int8 olarak saklanir."""
    return "int8" if path.suffix.lower() in (".csv", ".txt") else encoding


def _read_raw(path: Path, n: int, encoding: str) -> bytes:
    """Vektoru ham bayt olarak dondurur (int listesi uretmeden)."""
    if path.suffix.lower() in (".csv", ".txt"):
        txt = path.read_bytes().decode("utf-8", "replace")
        vals = [int(float(x)) for x in re.findall(r"-?\d+(?:\.\d+)?", txt)][:n]
        return _encode_values(vals, "int8").ljust(n, b"\x00")
    raw = path.read_bytes()
    return raw[:n] if len(raw) >= n else raw.ljust(n, b"\x00")


def _read_vector(path: Path, n: int, encoding: str) -> List[int]:
    """Geriye donuk uyum icin: int listesi dondurur."""
    return _decode_bytes(_read_raw(path, n, encoding), _file_enc(path, encoding))


# =============================================================================
# Saglamlik senaryolari (Secenek F)
# =============================================================================

ALL_SCENARIOS: List[str] = [
    "silence_zeros", "silence_dither", "saturate_max", "saturate_min",
    "alternating", "back_to_back", "truncated_frame", "oversized_frame",
    "peripheral_interleave", "determinism", "recovery_after_idle",
]

SCENARIO_HELP: Dict[str, str] = {
    "silence_zeros":         "Tamamen sifir vektor. Hizlandirici cokmeden sonuc uretmeli.",
    "silence_dither":        "Cok dusuk seviyeli gurultu. 'silence' beklenir ama zorunlu degil.",
    "saturate_max":          "Tum degerler +127. Tasma/doygunluk davranisi.",
    "saturate_min":          "Tum degerler -128. Isaret/tasma davranisi.",
    "alternating":           "+127/-128 siralamasi. En kotu durum aktivite.",
    "back_to_back":          "Bekleme koymadan 5 cerceve. FIFO / el sikisma dayanikliligi.",
    "truncated_frame":       "Eksik cerceve gonderilir; sonraki gecerli cerceve yanitlanmali.",
    "oversized_frame":       "Fazladan bayt eklenir; senkronizasyon geri kazanilmali.",
    "peripheral_interleave": "Cikarimlar arasinda cevre birimi kullanilir; reset'siz donus (sartname 4.2.2.1).",
    "determinism":           "Ayni vektor 10 kez; sonuc her seferinde ayni olmali.",
    "recovery_after_idle":   "3 s bosta bekleme sonrasi yanit verebilmeli.",
}


@dataclass
class ScenarioOutcome:
    name: str
    passed: bool
    detail: str
    data: Dict[str, Any] = field(default_factory=dict)
    skipped: bool = False


def synth_vector(kind: str, n: int, rng: random.Random) -> List[int]:
    if kind == "zeros":
        return [0] * n
    if kind == "dither":
        return [rng.randint(-2, 2) for _ in range(n)]
    if kind == "max":
        return [127] * n
    if kind == "min":
        return [-128] * n
    if kind == "alternating":
        return [127 if i % 2 == 0 else -128 for i in range(n)]
    if kind == "random":
        return [rng.randint(-128, 127) for _ in range(n)]
    raise ValueError(kind)


# =============================================================================
# Kosum motoru
# =============================================================================

@dataclass
class SampleRecord:
    index: int
    name: str
    truth: Optional[str]
    golden: Optional[str]
    golden_scores: List[float]
    golden_probs: List[float]
    predicted: Optional[str]
    scores: List[float]
    latency_ms: Optional[float]
    tx_ms: float
    timeout: bool
    retries: int
    raw: str


class DemoRunner:
    """Cekirdek mantik. Hicbir sey yazdirmaz; olay gonderir."""

    def __init__(self, cfg: HarnessConfig, sink: EventSink = null_sink,
                 dry_run: bool = False, cancel: Optional[threading.Event] = None):
        self.cfg = cfg
        self.sink = sink
        self.dry_run = dry_run
        self.cancel = cancel or threading.Event()
        self.builder = FrameBuilder(cfg.framing, cfg.payload)
        self.parser = ResultParser(cfg.result)
        self.rng = random.Random(0)
        self._fake: Optional[FakeDevice] = None
        self.stream: Optional[Link] = None
        self.core: Optional[Link] = None
        self.reader: Optional[CoreReader] = None
        self.frame_index = 0

    # ---- baglanti ----------------------------------------------------------
    def connect(self) -> None:
        if self.dry_run:
            self._fake = FakeDevice(self.cfg.framing, self.cfg.payload, self.cfg.result)
            self.stream, self.core = FakeStreamLink(self._fake), FakeCoreLink(self._fake)
        else:
            self.stream = SerialLink(self.cfg.stream_port, "stream")
            self.core = SerialLink(self.cfg.core_port, "core")
        self.stream.open()
        self.core.open()
        self.reader = CoreReader(self.core, self.parser, self.sink)
        self.reader.start()
        self.sink(Event("phase", f"Baglanti kuruldu: {self.stream.name} | {self.core.name}", "ok"))

    def disconnect(self) -> None:
        if self.reader:
            self.reader.stop()
            self.reader.join(timeout=1.0)
        for l in (self.stream, self.core):
            try:
                if l:
                    l.close()
            except Exception:
                pass

    # ---- yardimcilar -------------------------------------------------------
    def _sleep(self, seconds: float) -> bool:
        """Iptal edilebilir bekleme. Iptal edilirse False doner."""
        end = now_ts() + seconds
        while True:
            if self.cancel.is_set():
                return False
            left = end - now_ts()
            if left <= 0:
                return True
            time.sleep(min(0.05, left))

    def _send_hex(self, link: Link, hex_str: str, label: str) -> None:
        b = hexbytes(hex_str)
        if b:
            link.write(b)
            link.flush()
            self.sink(Event("log", f"{label} gonderildi ({len(b)} bayt)", "info"))

    def wait_boot(self) -> bool:
        h = self.cfg.hooks
        if not h.boot_banner_regex:
            return True
        self.sink(Event("phase", "Boot banner bekleniyor...", "info"))
        self._send_hex(self.core, h.boot_trigger_core_hex, "boot tetigi")
        line = self.reader.wait_regex(h.boot_banner_regex, h.boot_timeout_ms / 1000.0,
                                      self.cancel)
        ok = line is not None
        self.sink(Event("phase", f"Boot {'tespit edildi' if ok else 'TESPIT EDILEMEDI'}",
                        "ok" if ok else "warn", {"line": line}))
        return ok

    def init_sequences(self) -> None:
        self._send_hex(self.core, self.cfg.hooks.core_init_hex, "core init")
        self._send_hex(self.stream, self.cfg.hooks.stream_init_hex, "stream init")

    def send_sample(self, values: Optional[Sequence[int]] = None,
                    expect_result: bool = True,
                    truncate: int = 0, extra_bytes: int = 0,
                    timeout_ms: Optional[float] = None,
                    payload: Optional[bytes] = None
                    ) -> Tuple[Optional[ParsedResult], float, float]:
        """
        Tek cerceve gonderir. (sonuc, tx_ms, latency_ms) doner.
        payload verilirse int listesinden yeniden kodlama yapilmaz (hizli yol).
        """
        if payload is None:
            payload = self.builder.encode_payload(values or [])
        frame = self.builder.build(payload, self.frame_index)
        self.frame_index += 1
        if truncate:
            frame = frame[:max(0, len(frame) - truncate)]
        if extra_bytes:
            frame = frame + bytes(self.rng.randint(0, 255) for _ in range(extra_bytes))
        self._send_hex(self.core, self.cfg.hooks.pre_frame_core_hex, "pre-frame")
        self.reader.clear()
        t0, t1 = write_framed(self.stream, frame, self.cfg.framing)
        tx_ms = (t1 - t0) * 1000.0
        if not expect_result:
            return None, tx_ms, float("nan")
        to = (timeout_ms if timeout_ms is not None else self.cfg.result.timeout_ms) / 1000.0
        r = self.reader.wait_result(to, self.cancel)
        lat = (r.t_rx - t1) * 1000.0 if r else float("nan")
        if self.cfg.framing.inter_frame_delay_ms:
            self._sleep(self.cfg.framing.inter_frame_delay_ms / 1000.0)
        return r, tx_ms, lat

    # ---- A: toplu kosum ----------------------------------------------------
    def run_batch(self, samples: List[Sample]) -> List[SampleRecord]:
        recs: List[SampleRecord] = []
        consec_to = 0
        w = self.cfg.run.warmup_frames
        if w:
            self.sink(Event("phase", f"Isinma: {w} cerceve", "info"))
            for i in range(w):
                if self.cancel.is_set():
                    break
                sw = samples[i % len(samples)]
                self.send_sample(payload=sw.payload(self.cfg.payload.encoding,
                                                    self.cfg.payload.length))
        n_gold = sum(1 for s in samples if s.golden)
        if n_gold == 0:
            self.sink(Event("phase",
                            "UYARI: veri setinde 'golden' sutunu yok. Bu yarismada "
                            "olculen sey modelin dogrulugu degil, RTL'in golden modele "
                            "sadakatidir; golden sutunu olmadan uyum orani "
                            "HESAPLANAMAZ.", "warn"))
        elif n_gold < len(samples):
            self.sink(Event("phase", f"UYARI: {len(samples)-n_gold} ornekte 'golden' "
                                     f"degeri yok; bunlar uyum oranina dahil edilmez",
                            "warn"))
        self.sink(Event("phase", f"Toplu kosum basliyor: {len(samples)} ornek", "info"))
        for i, s in enumerate(samples):
            if self.cancel.is_set():
                self.sink(Event("phase", "Kullanici tarafindan iptal edildi", "warn"))
                break
            if self._fake is not None:
                self._fake.truth_hint = s.golden or s.truth
                self._fake.golden_scores_hint = list(s.meta.get("golden_scores") or []) or None
            res, tx_ms, lat = None, 0.0, float("nan")
            tries = 0
            pl = s.payload(self.cfg.payload.encoding, self.cfg.payload.length)
            for attempt in range(self.cfg.run.retries_per_sample + 1):
                tries = attempt
                res, tx_ms, lat = self.send_sample(payload=pl)
                if res or self.cancel.is_set():
                    break
            timed_out = res is None
            consec_to = consec_to + 1 if timed_out else 0
            rec = SampleRecord(
                index=i, name=s.name, truth=s.truth, golden=s.golden,
                golden_scores=list(s.meta.get("golden_scores") or []),
                golden_probs=list(s.meta.get("golden_probs") or []),
                predicted=res.label if res else None,
                scores=res.scores if res else [],
                latency_ms=None if timed_out else lat,
                tx_ms=tx_ms, timeout=timed_out, retries=tries,
                raw=res.raw if res else "",
            )
            recs.append(rec)
            ref = s.golden          # KARSILASTIRMA REFERANSI: golden model
            self.sink(Event("sample", f"[{i+1}/{len(samples)}] {s.name}: "
                                      f"{rec.predicted or 'TIMEOUT'}"
                                      f"{'' if ref is None else ' (golden: %s)' % ref}",
                            "error" if timed_out else
                            ("ok" if (ref is None or rec.predicted == ref) else "warn"),
                            {"record": rec.__dict__}))
            self.sink(Event("progress", "", "info",
                            {"done": i + 1, "total": len(samples)}))
            if consec_to >= self.cfg.run.stop_on_consecutive_timeouts:
                self.sink(Event("error",
                                f"{consec_to} ardisik zaman asimi - kosum durduruldu",
                                "error"))
                break
            if self.cfg.run.inter_sample_delay_ms:
                self._sleep(self.cfg.run.inter_sample_delay_ms / 1000.0)
        if self.cancel.is_set():
            self.sink(Event("phase", f"Durduruldu - {len(recs)} ornek islendi, "
                                     f"rapor bu kadariyla uretilecek", "warn"))
        return recs

    # ---- F: saglamlik ------------------------------------------------------
    def run_robustness(self, probe: Sample,
                       selected: Optional[List[str]] = None) -> List[ScenarioOutcome]:
        n = self.cfg.payload.length
        probe_pl = probe.payload(self.cfg.payload.encoding, n)
        if self._fake is not None:
            self._fake.truth_hint = None
        out: List[ScenarioOutcome] = []
        names = selected or list(ALL_SCENARIOS)

        def probe_ok(tag: str, timeout_mult: float = 1.0) -> Tuple[bool, Optional[str]]:
            r, _, _ = self.send_sample(payload=probe_pl,
                                       timeout_ms=self.cfg.result.timeout_ms * timeout_mult)
            return (r is not None), (r.label if r else None)

        for nm in names:
            if self.cancel.is_set():
                break
            self.sink(Event("phase", f"Senaryo: {nm}", "info"))
            try:
                out.append(self._scenario(nm, n, probe, probe_ok, probe_pl))
            except Exception as e:
                out.append(ScenarioOutcome(nm, False, f"istisna: {e}"))
            status = "ATLANDI" if out[-1].skipped else ("GECTI" if out[-1].passed else "KALDI")
            level = "warn" if out[-1].skipped else ("ok" if out[-1].passed else "error")
            self.sink(Event("scenario", f"{nm}: {status} - {out[-1].detail}",
                            level, {"outcome": out[-1].__dict__}))
        return out

    def _scenario(self, nm: str, n: int, probe: Sample, probe_ok,
                  probe_pl: bytes) -> ScenarioOutcome:
        rng = self.rng

        if nm in ("silence_zeros", "silence_dither", "saturate_max",
                  "saturate_min", "alternating"):
            kind = {"silence_zeros": "zeros", "silence_dither": "dither",
                    "saturate_max": "max", "saturate_min": "min",
                    "alternating": "alternating"}[nm]
            v = synth_vector(kind, n, rng)
            r, _, lat = self.send_sample(v)
            if r is None:
                return ScenarioOutcome(nm, False, "sonuc gelmedi (zaman asimi)")
            ok2, _ = probe_ok(nm)
            return ScenarioOutcome(
                nm, ok2,
                f"cikti={r.label}, gecikme={lat:.1f} ms, sonraki gecerli cerceve "
                f"{'yanitladi' if ok2 else 'YANITLAMADI'}",
                {"label": r.label, "latency_ms": lat, "scores": r.scores})

        if nm == "back_to_back":
            saved = self.cfg.framing.inter_frame_delay_ms
            self.cfg.framing.inter_frame_delay_ms = 0.0
            got = 0
            k = 5
            try:
                for _ in range(k):
                    if self.cancel.is_set():
                        break
                    r, _, _ = self.send_sample(payload=probe_pl)
                    got += 1 if r else 0
            finally:
                self.cfg.framing.inter_frame_delay_ms = saved
            return ScenarioOutcome(nm, got == k,
                                   f"araliksiz {k} cerceveden {got} tanesi yanitlandi",
                                   {"sent": k, "received": got})

        if nm == "truncated_frame":
            self.send_sample(payload=probe_pl, expect_result=False, truncate=64)
            self._sleep(0.3)
            self.reader.clear()
            ok, lab = probe_ok(nm, timeout_mult=2.0)
            return ScenarioOutcome(nm, ok,
                                   f"kesik cerceve sonrasi kurtarma "
                                   f"{'basarili' if ok else 'BASARISIZ'} (cikti={lab})")

        if nm == "oversized_frame":
            self.send_sample(payload=probe_pl, expect_result=False, extra_bytes=32)
            self._sleep(0.3)
            self.reader.clear()
            ok, lab = probe_ok(nm, timeout_mult=2.0)
            return ScenarioOutcome(nm, ok,
                                   f"fazladan bayt sonrasi kurtarma "
                                   f"{'basarili' if ok else 'BASARISIZ'} (cikti={lab})")

        if nm == "peripheral_interleave":
            h = self.cfg.hooks
            if not h.interleave_core_hex:
                return ScenarioOutcome(
                    nm, False,
                    "ATLANDI (opsiyonel): hooks.interleave_core_hex tanimlanmamis; "
                    "cevre birimi araya girme testi uygulanmadi.",
                    skipped=True)
            r1, _, _ = self.send_sample(payload=probe_pl)
            self._send_hex(self.core, h.interleave_core_hex, "interleave")
            resp = None
            if h.interleave_expect_regex:
                resp = self.reader.wait_regex(h.interleave_expect_regex, 3.0, self.cancel)
            else:
                self._sleep(0.5)
            self.reader.clear()
            r2, _, _ = self.send_sample(payload=probe_pl)
            same = (r1 and r2 and r1.label == r2.label)
            ok = bool(r2) and bool(same) and (h.interleave_expect_regex == "" or resp is not None)
            return ScenarioOutcome(
                nm, ok,
                f"cevre birimi kullanimindan sonra reset'siz donus "
                f"{'basarili' if ok else 'BASARISIZ'}; "
                f"once={r1.label if r1 else None}, sonra={r2.label if r2 else None}",
                {"peripheral_response": resp})

        if nm == "determinism":
            k = 10
            labels, lats = [], []
            for _ in range(k):
                if self.cancel.is_set():
                    break
                r, _, lat = self.send_sample(payload=probe_pl)
                labels.append(r.label if r else None)
                if r:
                    lats.append(lat)
            uniq = set(labels)
            ok = len(uniq) == 1 and None not in uniq
            jit = (max(lats) - min(lats)) if len(lats) > 1 else 0.0
            return ScenarioOutcome(nm, ok,
                                   f"{k} tekrarda {len(uniq)} farkli sonuc; "
                                   f"gecikme jitter={jit:.2f} ms",
                                   {"labels": labels, "jitter_ms": jit})

        if nm == "recovery_after_idle":
            if not self._sleep(3.0):
                return ScenarioOutcome(nm, False, "iptal edildi")
            self.reader.clear()
            ok, lab = probe_ok(nm, timeout_mult=2.0)
            return ScenarioOutcome(nm, ok,
                                   f"3 s bosta bekledikten sonra "
                                   f"{'yanit verdi' if ok else 'YANIT VERMEDI'} ({lab})")

        return ScenarioOutcome(nm, False, "bilinmeyen senaryo")


# =============================================================================
# Raporlama
# =============================================================================

def build_report(outdir: Path, cfg: HarnessConfig, cfg_path: Optional[Path],
                 recs: List[SampleRecord], scen: List[ScenarioOutcome],
                 meta: Dict[str, Any]) -> Dict[str, Any]:
    outdir.mkdir(parents=True, exist_ok=True)
    classes = cfg.result.classes

    # Kosumda gercekten kullanilan etkin ICD her durumda kaydedilir.
    config_used_path = outdir / "config_used.json"
    config_used_path.write_text(
        json.dumps(cfg.to_dict(), indent=2, ensure_ascii=False), encoding="utf-8")
    config_used_sha = sha256_file(config_used_path)

    # Ornek bazli skor hatalari (yalnizca bilgi amacli).
    score_err_by_index: Dict[int, float] = {}
    for r in recs:
        hw_scores = list(r.scores)
        if (len(hw_scores) == len(classes) == len(DEFAULT_CLASSES) and
                set(classes) == set(DEFAULT_CLASSES)):
            hw_scores = [r.scores[classes.index(c)] for c in DEFAULT_CLASSES]
        e = score_vector_error_pct(hw_scores, r.golden_scores, r.golden_probs)
        if e is not None:
            score_err_by_index[r.index] = e

    # --- CSV: ornek bazli
    with (outdir / "samples.csv").open("w", newline="", encoding="utf-8") as fh:
        w = csv.writer(fh)
        w.writerow(["index", "name", "golden_ref", "predicted", "matches_golden",
                    "truth_info", "matches_truth_info", "golden_scores", "scores",
                    "score_error_pct", "latency_ms", "tx_ms", "timeout", "retries", "raw"])
        for r in recs:
            corr = "" if not r.golden else int(r.predicted == r.golden)
            corr_t = "" if not r.truth else int(r.predicted == r.truth)
            w.writerow([r.index, r.name, r.golden or "", r.predicted or "", corr,
                        r.truth or "", corr_t,
                        ";".join(str(int(x) if float(x).is_integer() else x) for x in r.golden_scores),
                        ";".join(str(int(x) if float(x).is_integer() else x) for x in r.scores),
                        "" if r.index not in score_err_by_index else f"{score_err_by_index[r.index]:.4f}",
                        "" if r.latency_ms is None else f"{r.latency_ms:.3f}",
                        f"{r.tx_ms:.3f}", int(r.timeout), r.retries, r.raw])

    with (outdir / "robustness.csv").open("w", newline="", encoding="utf-8") as fh:
        w = csv.writer(fh)
        w.writerow(["scenario", "result", "detail"])
        for s in scen:
            status = "SKIP" if s.skipped else ("PASS" if s.passed else "FAIL")
            w.writerow([s.name, status, s.detail])

    # --- metrikler
    answered = [r for r in recs if not r.timeout]
    lat = [r.latency_ms for r in answered if r.latency_ms is not None]
    tx = [r.tx_ms for r in recs]

    # ==== BIRINCIL OLCUT: golden model ile uyum (RTL sadakati) ====
    ref_all = [r for r in recs if r.golden]
    ref_ans = [r for r in ref_all if not r.timeout]
    match = [r for r in ref_ans if r.predicted == r.golden]
    mismatch = [r for r in ref_ans if r.predicted != r.golden]
    ref_timeouts = [r for r in ref_all if r.timeout]
    agree = (len(match) / len(ref_ans) * 100.0) if ref_ans else None
    agree_strict = (len(match) / len(ref_all) * 100.0) if ref_all else None

    # ==== BILGI AMACLI: gercek etikete gore dogruluk ====
    t_ans = [r for r in answered if r.truth]
    acc_hw = (sum(1 for r in t_ans if r.predicted == r.truth) / len(t_ans) * 100.0) \
        if t_ans else None
    t_gold = [r for r in recs if r.truth and r.golden]
    acc_sw = (sum(1 for r in t_gold if r.golden == r.truth) / len(t_gold) * 100.0) \
        if t_gold else None

    # ==== BILGI AMACLI: UART skorlarinin golden skorlarla sayisal uyumu ====
    score_errors = list(score_err_by_index.values())
    score_error_mean = statistics.mean(score_errors) if score_errors else None
    score_error_max = max(score_errors) if score_errors else None

    cm = {t: {p: 0 for p in classes + ["TIMEOUT"]} for t in classes}
    for r in ref_all:
        if r.golden in cm:
            key = r.predicted if r.predicted in classes else "TIMEOUT"
            cm[r.golden][key] += 1

    speed_ratio = None
    if cfg.run.software_reference_ms and lat:
        speed_ratio = cfg.run.software_reference_ms / statistics.median(lat)

    evaluated_scen = [x for x in scen if not x.skipped]
    skipped_scen = [x for x in scen if x.skipped]
    summary = {
        "harness_version": HARNESS_VERSION,
        "primary_metric": "golden_agreement_pct",
        "team": cfg.team_name, "team_id": cfg.team_id,
        "timestamp": iso_now(),
        "config_file": str(cfg_path) if cfg_path else None,
        "config_sha256": config_used_sha,
        "total_samples": len(recs),
        "answered": len(answered),
        "timeouts": len(recs) - len(answered),
        "with_golden_ref": len(ref_all),
        "golden_agreement_pct": agree,
        "golden_agreement_strict_pct": agree_strict,
        "mismatch_count": len(mismatch),
        "ref_timeout_count": len(ref_timeouts),
        "accuracy_info_hw_pct": acc_hw,
        "accuracy_info_sw_pct": acc_sw,
        "score_comparison_samples": len(score_errors),
        "score_error_mean_pct": score_error_mean,
        "score_error_max_pct": score_error_max,
        "latency_ms": {
            "n": len(lat),
            "min": min(lat) if lat else None,
            "median": statistics.median(lat) if lat else None,
            "p95": pct(lat, 95) if lat else None,
            "max": max(lat) if lat else None,
        },
        "tx_ms_median": statistics.median(tx) if tx else None,
        "speedup_ratio": speed_ratio,
        "software_reference_ms": cfg.run.software_reference_ms,
        "robustness_passed": sum(1 for x in evaluated_scen if x.passed),
        "robustness_total": len(evaluated_scen),
        "robustness_skipped": len(skipped_scen),
        "confusion_matrix": cm,
        "meta": meta,
    }
    (outdir / "summary.json").write_text(
        json.dumps(summary, indent=2, ensure_ascii=False), encoding="utf-8")

    # --- Markdown rapor
    L: List[str] = []
    A = L.append
    A(f"# Demo Degerlendirme Raporu - {cfg.team_name}")
    A("")
    A(f"- Tarih: {summary['timestamp']}")
    A(f"- Harness surumu: {HARNESS_VERSION}")
    A(f"- Konfigurasyon kaynagi: `{cfg_path or 'varsayilan sablon'}`")
    A(f"- Etkin konfigurasyon: `config_used.json` (SHA256 `{config_used_sha[:16]}`)")
    A(f"- Veri seti: {meta.get('dataset', '-')} | seed: {meta.get('seed', '-')}")
    A(f"- Arayuzler: stream `{cfg.stream_port.port}@{cfg.stream_port.baudrate}`, "
      f"core `{cfg.core_port.port}@{cfg.core_port.baudrate}`")
    A("")
    A("## 1. Ozet - RTL / Golden Model Uyumu")
    A("")
    A("> **Olculen sey modelin dogrulugu degil, tasarimin golden modele sadakatidir.**")
    A("> Birincil olcut, donanimin urettigi sinifin golden modelin ayni vektor icin")
    A("> urettigi sinifla ayni olmasidir. Gercek etiket (truth) yalnizca bilgi")
    A("> amaciyla raporlanir ve puanlamada kullanilmaz.")
    A("")
    if not ref_all:
        A("**UYARI: veri setinde 'golden' sutunu yok - uyum orani hesaplanamadi.**")
        A("")
    A("| Metrik | Deger |")
    A("|---|---|")
    A(f"| Gonderilen ornek | {summary['total_samples']} |")
    A(f"| Golden referansi olan | {len(ref_all)} |")
    A(f"| Yanitlanan | {len(ref_ans)} |")
    A(f"| **Golden ile uyum** | "
      f"{'-' if agree is None else f'{agree:.2f} %'}  "
      f"({len(match)}/{len(ref_ans)}) |")
    A(f"| Uyusmazlik | {len(mismatch)} |")
    A(f"| Zaman asimi (referansli ornek) | {len(ref_timeouts)} |")
    A(f"| Uyum (zaman asimlari da hata sayilirsa) | "
      f"{'-' if agree_strict is None else f'{agree_strict:.2f} %'} |")
    if score_error_mean is not None:
        A(f"| **Golden skor hata orani (MAE)** | {score_error_mean:.4f} % |")
        A(f"| Skor karsilastirilan ornek | {len(score_errors)} |")
        A(f"| En yuksek ornek-bazli skor hatasi | {score_error_max:.4f} % |")
    if lat:
        A(f"| Gecikme (medyan / p95 / max) | {statistics.median(lat):.2f} / "
          f"{pct(lat,95):.2f} / {max(lat):.2f} ms |")
    if speed_ratio is not None:
        A(f"| Olculen hizlanma (yazilim / donanim) | {speed_ratio:.1f}x |")
    robust_text = f"{summary['robustness_passed']} / {summary['robustness_total']}"
    if summary['robustness_skipped']:
        robust_text += f" (+{summary['robustness_skipped']} opsiyonel atlandi)"
    A(f"| Saglamlik senaryolari | {robust_text} |")
    A("")
    if score_error_mean is not None:
        A("> Skor hata orani yalnizca ek bilgidir ve puanlamada kullanilmaz. UART'tan")
        A("> gelen dort skor, manifest'teki golden skorlarla ayni sinif sirasinda")
        A("> karsilastirilir. Deger 0'a yaklastikca sayisal uyum daha iyidir.")
        A("")
    A("> Not: gecikme, cerceve yaziminin bittigi an ile sonuc satirinin son baytinin")
    A("> alindigi an arasidir; UART aktarim ve ISR suresini icerir. Saf hizlandirici")
    A("> cevrim sayisi icin RTL simulasyon capraz kontrolu esastir.")
    A("")
    A("## 2. Uyum Matrisi (satir = golden referans, sutun = donanim ciktisi)")
    A("")
    if ref_all:
        A("| golden \\ donanim | " + " | ".join(classes + ["TIMEOUT"]) + " |")
        A("|" + "---|" * (len(classes) + 2))
        for t in classes:
            row = " | ".join(
                (f"**{cm[t][pp]}**" if pp == t else str(cm[t][pp]))
                for pp in classes + ["TIMEOUT"])
            A(f"| **{t}** | {row} |")
        A("")
        A("Kosegen = golden ile ayni sinif. Kosegen disi her hucre, RTL'in golden")
        A("modelden ayristigi bir ornektir.")
    else:
        A("_Golden referansi olan ornek yok._")
    A("")
    if acc_hw is not None or acc_sw is not None:
        A("### Bilgi amacli: gercek etikete (truth) gore dogruluk")
        A("")
        A("_Bu bolum puanlamada KULLANILMAZ; veri setinin zorlugu hakkinda fikir verir._")
        A("")
        A("| | Dogruluk |")
        A("|---|---|")
        if acc_hw is not None:
            A(f"| Donanim | {acc_hw:.2f} % |")
        if acc_sw is not None:
            A(f"| Golden model (yazilim) | {acc_sw:.2f} % |")
        if acc_hw is not None and acc_sw is not None:
            A(f"| Fark | {acc_hw - acc_sw:+.2f} puan |")
        A("")
    A("## 3. Saglamlik Senaryolari (Secenek F)")
    A("")
    A("| Senaryo | Sonuc | Aciklama |")
    A("|---|---|---|")
    for x in scen:
        status = "SKIP" if x.skipped else ("PASS" if x.passed else "FAIL")
        A(f"| {x.name} | {status} | {x.detail} |")
    A("")
    A("## 4. Golden Modelden Ayrisan Ornekler")
    A("")
    bad = [r for r in recs if (r.golden and r.timeout) or
           (r.golden and r.predicted != r.golden)]
    if not bad and not ref_all:
        bad = [r for r in recs if r.timeout]
    if bad:
        A("| # | ornek | golden | donanim | truth (bilgi) | skor hata (%) | gecikme (ms) |")
        A("|---|---|---|---|---|---|---|")
        for r in bad[:50]:
            serr = score_err_by_index.get(r.index)
            A(f"| {r.index} | {r.name} | {r.golden or '-'} | "
              f"{r.predicted or 'TIMEOUT'} | {r.truth or '-'} | "
              f"{'-' if serr is None else f'{serr:.4f}'} | "
              f"{'-' if r.latency_ms is None else f'{r.latency_ms:.1f}'} |")
        if len(bad) > 50:
            A("")
            A(f"_...ve {len(bad)-50} kayit daha (samples.csv)._")
    else:
        A("_Yok._")
    A("")
    A("## 5. Dosyalar")
    A("")
    A("- `samples.csv` - ornek bazli ham kayit ve skor hata bilgisi")
    A("- `robustness.csv` - senaryo sonuclari")
    A("- `summary.json` - makine okunabilir ozet")
    A("- `transcript.log` - core UART ham ciktisi")
    A("- `config_used.json` - kosumda gercekten kullanilan etkin ICD")
    A("")
    (outdir / "report.md").write_text("\n".join(L), encoding="utf-8")
    return summary


# =============================================================================
# CLI
# =============================================================================

CONFIG_TEMPLATE: Dict[str, Any] = {
    "_OKUBENI": [
        "TEKNOFEST Cip Tasarim Yarismasi - Mikrodenetleyici kategorisi",
        "ARAYUZ TANIM DOKUMANI (ICD). Bu dosyayi takiminiz doldurur ve demo gunu teslim eder.",
        "",
        "Alt cizgi ile baslayan ('_bilgi', '_alanlar', '_ornekler') anahtarlar",
        "aciklama amaclidir, program tarafindan yok sayilir. Silmeniz gerekmez.",
        "",
        "Doldurduktan sonra kontrol edin:  python demo_harness.py validate -c bu_dosya.json",
        "Bos birakilan alan varsayilan degerini alir; varsayilanlar asagida yazilidir.",
    ],

    "team": {
        "_alanlar": {
            "name": "Takim adi. Metin. Rapor basligi ve cikti klasoru adi olur. Ornek: 'Bogazici RISC-V'",
            "id":   "Basvuru/KYS takim numarasi. Metin. Ornek: '2026-MCU-041'",
            "notes": "Juriye iletmek istediginiz serbest not. Ornek: 'Kart: Nexys A7, sistem saati 50 MHz'",
        },
        "name": "TAKIM ADINI YAZIN",
        "id": "",
        "notes": "",
    },

    "stream": {
        "_bilgi": "UART-stream: cikarim verisinin YZ hizlandiriciya suruldugu arayuz.",

        "port": {
            "_alanlar": {
                "port": "Isletim sistemindeki port adi. Windows: 'COM3'. Linux: '/dev/ttyUSB0'. macOS: '/dev/tty.usbserial-A1'. Juri demo gunu bunu kendi makinesine gore degistirir; siz kendi kullandiginizi yazin.",
                "baudrate": "Bit hizi (bps). Tamsayi. Yaygin: 115200, 230400, 460800, 921600, 1000000, 3000000. Sartname UART'in 1 Mbps'i desteklemesini ister; stream tarafinda 1000000 onerilir.",
                "bytesize": "Veri biti sayisi. 5 | 6 | 7 | 8. Neredeyse her zaman 8.",
                "parity": "Eslik biti. 'N' (yok) | 'E' (cift) | 'O' (tek) | 'M' (mark) | 'S' (space). Varsayilan 'N'.",
                "stopbits": "Stop biti. 1 | 1.5 | 2. Varsayilan 1.",
                "rtscts": "Donanimsal RTS/CTS akis kontrolu. true | false. Tasariminizda CTS yoksa false.",
                "dsrdtr": "DSR/DTR akis kontrolu. true | false. Genelde false.",
                "xonxoff": "Yazilimsal XON/XOFF akis kontrolu. true | false. Ikili veri gonderildigi icin false olmali.",
                "write_timeout_s": "Yazma zaman asimi (saniye). Ondalik. Ornek: 5.0",
                "read_timeout_s": "Okuma zaman asimi (saniye). Ondalik. Stream tarafinda kullanilmaz. Ornek: 0.05",
                "dtr": "Port acilirken DTR hattinin degeri. true | false | null. Karti resetliyorsa false yazin, aksi halde null birakin.",
                "rts": "Port acilirken RTS hattinin degeri. true | false | null. Ayni sekilde.",
                "open_settle_ms": "Port acildiktan sonra beklenecek sure (ms). Tamsayi. USB-UART kopru cipleri icin 200 iyi bir baslangictir; kartiniz aciliste resetleniyorsa 1500-2000 yazin.",
                "flush_input_on_open": "Port acilirken bekleyen giris tamponu bosaltilsin mi. true | false. VARSAYILAN true: eski cop veriyi atar. Kartiniz boot banner'ini harness baglanmadan ONCE yazdiriyorsa false yapin, yoksa banner bosaltilir ve yakalanamaz.",
            },
            "port": "COM3",
            "baudrate": 1000000,
            "bytesize": 8,
            "parity": "N",
            "stopbits": 1,
            "rtscts": False,
            "dsrdtr": False,
            "xonxoff": False,
            "write_timeout_s": 5.0,
            "read_timeout_s": 0.05,
            "dtr": None,
            "rts": None,
            "open_settle_ms": 200,
            "flush_input_on_open": True,
        },

        "framing": {
            "_bilgi": [
                "Bir cerceve su sirayla olusturulur:",
                "  [preamble] [index] [length] [payload] [checksum] [trailer]",
                "Kullanmadiginiz alani bos birakin (hex icin \"\", boyut icin 0).",
                "Hicbir cerceveleme kullanmiyorsaniz (ham 1960 bayt): preamble_hex=\"\",",
                "index_field_size=0, length_field_size=0, checksum=\"none\", trailer_hex=\"\".",
            ],
            "_alanlar": {
                "preamble_hex": "Cerceve basi senkron deseni, hex metin. Bosluk/0x kullanmayin. Yok ise \"\". Ornek: \"AA55\" | \"5A\" | \"DEADBEEF\"",
                "index_field_size": "Cerceve sira numarasi alaninin bayt sayisi. 0 (yok) | 1 | 2 | 4. Harness her cerceveyi 0'dan baslayarak numaralandirir.",
                "length_field_size": "Uzunluk alaninin bayt sayisi. 0 (yok) | 1 | 2 | 4. 1960 bayt icin en az 2 gerekir.",
                "length_counts": "Uzunluk alani neyi sayar. 'payload' (yalniz veri) | 'payload_plus_checksum' (veri + checksum).",
                "endian": "index/length/checksum alanlarinin bayt sirasi. 'little' | 'big'.",
                "checksum": "Saglama turu. 'none' | 'sum8' (bayt toplaminin dusuk 8 biti) | 'xor8' | 'crc16_ccitt' (poly 0x1021, init 0xFFFF) | 'crc32' (zlib/IEEE).",
                "checksum_covers": "Saglamanin kapsadigi alan. 'payload' | 'header_payload' (preamble+index+length dahil).",
                "trailer_hex": "Cerceve sonu deseni, hex metin. Yok ise \"\". Ornek: \"0D0A\" | \"55AA\"",
                "chunk_size": "Cerceveyi kac baytlik parcalar halinde yazalim. Tamsayi. 0 = tek seferde. Akis kontrolu yoksa ve RX FIFO'nuz kucukse 64 veya 32 yazin. Ornek: 256",
                "inter_chunk_delay_ms": "Parcalar arasi bekleme (ms). Ondalik. Varsayilan 0. FIFO tasiyorsa 1-5 arasi deneyin.",
                "inter_frame_delay_ms": "Iki cerceve arasi bekleme (ms). Ondalik. Cihaziniz sonuc yazdiktan sonra toparlanma suresi istiyorsa artirin. Ornek: 20",
                "drain_after_write": "Yazimdan sonra cikis tamponunun bosalmasini bekle. true | false. Gecikme olcumunun dogru olmasi icin true birakin.",
            },
            "preamble_hex": "AA55",
            "index_field_size": 0,
            "length_field_size": 2,
            "length_counts": "payload",
            "endian": "little",
            "checksum": "crc16_ccitt",
            "checksum_covers": "payload",
            "trailer_hex": "",
            "chunk_size": 256,
            "inter_chunk_delay_ms": 0,
            "inter_frame_delay_ms": 20,
            "drain_after_write": True,
        },

        "payload": {
            "_alanlar": {
                "length": "Bir cikarim vektorunun eleman sayisi. Tamsayi. Bu demo paketi icin 1960. Girdi arayuzunuz bu uzunlukla uyumlu olmalidir.",
                "encoding": "Her elemanin tel uzerindeki bicimi. 'int8' (ikiye tumleyen, -128..127 -> 0x80..0x7F) | 'uint8_offset128' (deger+128, yani 0..255) | 'uint8_raw' (0..255 dogrudan). TFLite int8 nicemleme kullanir; cogu takim icin 'int8' dogrudur.",
                "pad_value": "Vektor kisa gelirse doldurma degeri. Tamsayi -128..127. Ornek: 0",
            },
            "length": 1960,
            "encoding": "int8",
            "pad_value": 0,
        },
    },

    "core": {
        "_bilgi": "Genel amacli UART: cekirdegin kesme rutininde yazdirdigi cikarim sonucu buradan okunur.",

        "port": {
            "_alanlar": {
                "port": "Port adi. Ornek: 'COM4' | '/dev/ttyUSB1'. Stream ile AYNI fiziksel port OLAMAZ.",
                "baudrate": "Bit hizi. Ornek: 115200 | 921600",
                "read_timeout_s": "Okuma tamponu yoklama araligi (saniye). 0.05 iyi bir deger.",
                "_diger": "bytesize, parity, stopbits, rtscts, dsrdtr, xonxoff, dtr, rts, open_settle_ms alanlari stream ile ayni anlama gelir.",
            },
            "port": "COM4",
            "baudrate": 115200,
            "bytesize": 8,
            "parity": "N",
            "stopbits": 1,
            "rtscts": False,
            "dsrdtr": False,
            "xonxoff": False,
            "read_timeout_s": 0.05,
            "write_timeout_s": 5.0,
            "dtr": None,
            "rts": None,
            "open_settle_ms": 200,
            "flush_input_on_open": True,
        },

        "result": {
            "_bilgi": [
                "Cikarim sonucunun nasil okunacagi. Dort mod var; SADECE kullandiginiz",
                "modun alanlarini doldurun, digerleri yok sayilir.",
                "  'regex_line'   -> ASCII satir, duzenli ifade ile ayristirilir  (EN YAYGIN)",
                "  'json_line'    -> her sonuc bir satirlik JSON nesnesi",
                "  'csv_line'     -> virgulle ayrilmis satir",
                "  'binary_fixed' -> sabit uzunlukta ikili kayit",
            ],
            "_alanlar": {
                "mode": "'regex_line' | 'json_line' | 'csv_line' | 'binary_fixed'",
                "line_terminator": "Satir sonu karakteri. '\\n' | '\\r\\n' | '\\r'. Metin modlari icin.",
                "encoding": "Metin kodlamasi. 'ascii' | 'utf-8'. Varsayilan 'ascii'.",
                "regex": "[regex_line] Sonuc satirini yakalayan duzenli ifade. ZORUNLU olarak (?P<label>...) grubunu icermeli; varsa (?P<scores>...) grubu skorlari verir. Ornek cikti 'RESULT: yes scores=-12,3,120,-8' icin varsayilan ifade calisir.",
                "json_label_key": "[json_line] Etiketin bulundugu anahtar. Ornek: 'label' | 'class' | 'pred'",
                "json_scores_key": "[json_line] Skor dizisinin anahtari. Ornek: 'scores' | 'logits'",
                "csv_label_index": "[csv_line] Etiketin kacinci sutunda oldugu (0'dan baslar). Ornek: 0",
                "csv_scores_start": "[csv_line] Skorlarin basladigi sutun indeksi. Ornek: 1",
                "binary_preamble_hex": "[binary_fixed] Kayit basi deseni, hex. Ornek: '5A5A'. Yoksa \"\" (o zaman kayitlar birbirini takip eder).",
                "binary_label_size": "[binary_fixed] Etiket alaninin bayt sayisi. 1 | 2 | 4",
                "binary_score_count": "[binary_fixed] Kac skor var. 0 (skor yok) | 4",
                "binary_score_size": "[binary_fixed] Her skorun bayt sayisi. 1 | 2 | 4",
                "binary_score_signed": "[binary_fixed] Skorlar isaretli mi. true | false",
                "binary_endian": "[binary_fixed] 'little' | 'big'",
                "label_map": "Cihazin yazdigi etiketi sinif adina cevirir. Cihaz sayi yaziyorsa: {\"0\":\"silence\",\"1\":\"unknown\",\"2\":\"yes\",\"3\":\"no\"}. Cihaz zaten 'yes'/'no' yaziyorsa bos birakin: {}. Kisaltma kullaniyorsaniz: {\"Y\":\"yes\",\"N\":\"no\",\"S\":\"silence\",\"U\":\"unknown\"}",
                "classes": "Sinif adlari, model cikis sirasiyla. Sartname EK-1'e gore: [\"silence\",\"unknown\",\"yes\",\"no\"]. Sirayi degistirdiyseniz burada da degistirin; sayisal etiketler bu siraya gore cozulur.",
                "timeout_ms": "Bir cerceve gonderildikten sonra sonuc icin beklenecek sure (ms). Tamsayi. Ornek: 5000. Cikarimini + UART yazimini rahatca kapsayacak sekilde secin.",
                "ignore_regex": "Sonuc olmayan satirlari elemek icin duzenli ifade. Bos birakilabilir. Ornek: '^(BOOT|INFO|DBG|>)' -> bu on eklerle baslayan satirlar sonuc sayilmaz.",
            },
            "mode": "regex_line",
            "line_terminator": "\n",
            "encoding": "ascii",
            "regex": "RESULT\\s*[:=]\\s*(?P<label>[A-Za-z_0-9]+)(?:.*?scores\\s*[:=]\\s*(?P<scores>[-+0-9.,;\\s]+))?",
            "json_label_key": "label",
            "json_scores_key": "scores",
            "csv_label_index": 0,
            "csv_scores_start": 1,
            "binary_preamble_hex": "",
            "binary_label_size": 1,
            "binary_score_count": 0,
            "binary_score_size": 1,
            "binary_score_signed": True,
            "binary_endian": "little",
            "label_map": {"0": "silence", "1": "unknown", "2": "yes", "3": "no"},
            "classes": ["silence", "unknown", "yes", "no"],
            "timeout_ms": 5000,
            "ignore_regex": "^(BOOT|INFO|DBG)",
        },
    },

    "hooks": {
        "_bilgi": [
            "Tasarim degisikligi GEREKTIRMEYEN kancalar. Hepsi istege baglidir;",
            "kullanmadiginizi \"\" birakin. Hex alanlarina gonderilecek ham baytlari",
            "hex metin olarak yazin (ornek: 'AT+RUN\\r\\n' yerine '41542B52554E0D0A').",
        ],
        "_alanlar": {
            "boot_banner_regex": "Kart aciliste/boot sonrasi bir mesaj yazdiriyorsa onu yakalayan ifade. Harness kosuma baslamadan once bunu bekler. Ornek: 'BOOT OK' | '^MCU ready' . Banner yoksa \"\" birakin. DIKKAT: banner harness baglanmadan once yazildiysa yakalanamaz; ya kartinizi harness baslatildiktan sonra resetleyin, ya 'boot_trigger_core_hex' tanimlayin, ya da port ayarlarinda 'flush_input_on_open' degerini false yapin.",
            "boot_trigger_core_hex": "Banner beklemeden hemen once core UART'a gonderilecek baytlar; kart bir komutla kimlik/banner yazdiriyorsa buraya yazin. Ornek: '' | '76' ('v' = version). Yoksa \"\".",
            "boot_timeout_ms": "Banner icin beklenecek azami sure (ms). Ornek: 10000",
            "core_init_hex": "Kosumun basinda core UART'a bir kez gonderilecek baytlar. Ornek: cihaz 's' komutuyla akis moduna geciyorsa '73'. Yoksa \"\".",
            "stream_init_hex": "Kosumun basinda stream UART'a bir kez gonderilecek baytlar. Yoksa \"\".",
            "pre_frame_core_hex": "HER cerceveden once core UART'a gonderilecek baytlar (ornek: 'bir sonraki cikarima hazirlan' komutu). Yoksa \"\".",
            "interleave_core_hex": "OPSIYONEL saglamlik testi. Iki cikarim arasinda bir cevre birimini calistiran komut. Kullanmak isterseniz ham baytlari hex olarak yazin. Bos birakilirsa peripheral_interleave senaryosu ATLANDI olarak raporlanir ve saglamlik basari oranina dahil edilmez. Ornek: cihaz 'g' ile GPIO testi kosuyorsa '67'.",
            "interleave_expect_regex": "Yukaridaki komuta beklenen yanit. Ornek: 'GPIO OK'. Yanit yoksa \"\" birakin (o zaman sadece cikarimin devam etmesi kontrol edilir).",
            "reset_hex": "Yazilimsal reset komutu. Harness normal akista KULLANMAZ, yalnizca kayit amaclidir. Yoksa \"\".",
        },
        "boot_banner_regex": "",
        "boot_timeout_ms": 10000,
        "boot_trigger_core_hex": "",
        "core_init_hex": "",
        "stream_init_hex": "",
        "pre_frame_core_hex": "",
        "interleave_core_hex": "",
        "interleave_expect_regex": "",
        "reset_hex": "",
    },

    "run": {
        "_alanlar": {
            "warmup_frames": "Olcume dahil edilmeyen isinma cercevesi sayisi. Tamsayi. Ornek: 1",
            "retries_per_sample": "Zaman asiminda ayni ornegin kac kez daha denenecegi. Tamsayi. 0 = tekrar yok. Ornek: 1",
            "inter_sample_delay_ms": "Ornekler arasi ek bekleme (ms). Ondalik. Varsayilan 0.",
            "stop_on_consecutive_timeouts": "Bu kadar ardisik zaman asiminda kosum durur. Tamsayi. Ornek: 10",
            "software_reference_ms": "Ayni kartta, hizlandirici KULLANILMADAN, yalnizca CV32E40P uzerinde yazilimla yapilan tek cikarimin olculen suresi (ms). Ondalik veya null. Girilirse rapor hizlanma orani hesaplar. Ornek: 85.0",
        },
        "warmup_frames": 1,
        "retries_per_sample": 1,
        "inter_sample_delay_ms": 0,
        "stop_on_consecutive_timeouts": 10,
        "software_reference_ms": None,
    },

    "_ornekler": {
        "_bilgi": "Cikti formatiniza en yakin ornegi 'core.result' bolumune kopyalayin.",
        "A_ascii_satir": {
            "cihaz_ciktisi": "RESULT: yes scores=-12,3,120,-8",
            "mode": "regex_line",
            "regex": "RESULT\\s*[:=]\\s*(?P<label>[A-Za-z_0-9]+)(?:.*?scores\\s*[:=]\\s*(?P<scores>[-+0-9.,;\\s]+))?",
            "label_map": {},
        },
        "B_sayisal_etiket": {
            "cihaz_ciktisi": "INF 2 120",
            "mode": "regex_line",
            "regex": "INF\\s+(?P<label>\\d+)\\s+(?P<scores>[-0-9\\s]+)",
            "label_map": {"0": "silence", "1": "unknown", "2": "yes", "3": "no"},
        },
        "C_json": {
            "cihaz_ciktisi": "{\"label\":\"no\",\"scores\":[-5,0,10,118]}",
            "mode": "json_line",
            "json_label_key": "label",
            "json_scores_key": "scores",
        },
        "D_csv": {
            "cihaz_ciktisi": "2,-12,3,120,-8",
            "mode": "csv_line",
            "csv_label_index": 0,
            "csv_scores_start": 1,
            "label_map": {"0": "silence", "1": "unknown", "2": "yes", "3": "no"},
        },
        "E_ikili": {
            "cihaz_ciktisi": "5A 5A 02 F4 03 78 F8  (preamble + etiket + 4 adet int8 skor)",
            "mode": "binary_fixed",
            "binary_preamble_hex": "5A5A",
            "binary_label_size": 1,
            "binary_score_count": 4,
            "binary_score_size": 1,
            "binary_score_signed": True,
        },
        "F_cerceveleme_ornekleri": {
            "ham_1960_bayt": {"preamble_hex": "", "length_field_size": 0, "checksum": "none"},
            "basit_baslik":  {"preamble_hex": "AA55", "length_field_size": 2, "checksum": "none"},
            "crc_korumali":  {"preamble_hex": "AA55", "length_field_size": 2, "checksum": "crc16_ccitt", "checksum_covers": "payload"},
        },
    },
}


# --- Konfigurasyon dogrulama --------------------------------------------------

_ALLOWED = {
    "parity": {"N", "E", "O", "M", "S"},
    "stopbits": {1, 1.5, 2},
    "bytesize": {5, 6, 7, 8},
    "endian": {"little", "big"},
    "checksum": {"none", "sum8", "xor8", "crc16_ccitt", "crc32"},
    "checksum_covers": {"payload", "header_payload"},
    "length_counts": {"payload", "payload_plus_checksum"},
    "encoding": {"int8", "uint8_offset128", "uint8_raw"},
    "mode": {"regex_line", "json_line", "csv_line", "binary_fixed"},
}


def validate_config(d: Dict[str, Any]) -> Tuple[List[str], List[str]]:
    """(hatalar, uyarilar) doner. Hata varsa kosum baslatilmamalidir."""
    err: List[str] = []
    warn: List[str] = []

    def g(path: str, default=None):
        cur: Any = d
        for k in path.split("."):
            if not isinstance(cur, dict) or k not in cur:
                return default
            cur = cur[k]
        return cur

    for side in ("stream", "core"):
        pfx = f"{side}.port"
        if not str(g(f"{pfx}.port", "")).strip():
            err.append(f"{pfx}.port bos - seri port adi girilmeli (or. COM3 / /dev/ttyUSB0)")
        if int(g(f"{pfx}.baudrate", 0) or 0) <= 0:
            err.append(f"{pfx}.baudrate pozitif bir tamsayi olmali")
        if g(f"{pfx}.parity", "N") not in _ALLOWED["parity"]:
            err.append(f"{pfx}.parity gecersiz - {sorted(_ALLOWED['parity'])}")
        if float(g(f"{pfx}.stopbits", 1)) not in _ALLOWED["stopbits"]:
            err.append(f"{pfx}.stopbits gecersiz - 1 | 1.5 | 2")
        if int(g(f"{pfx}.bytesize", 8)) not in _ALLOWED["bytesize"]:
            err.append(f"{pfx}.bytesize gecersiz - 5 | 6 | 7 | 8")

    if g("stream.port.port") and g("stream.port.port") == g("core.port.port"):
        err.append("stream ve core ayni porta atanmis - iki ayri fiziksel arayuz gerekli")

    f = g("stream.framing", {}) or {}
    for key in ("endian", "checksum", "checksum_covers", "length_counts"):
        v = f.get(key, {"endian": "little", "checksum": "none",
                        "checksum_covers": "payload", "length_counts": "payload"}[key])
        if v not in _ALLOWED[key]:
            err.append(f"stream.framing.{key} gecersiz: {v!r} - {sorted(_ALLOWED[key])}")
    for key in ("preamble_hex", "trailer_hex"):
        try:
            hexbytes(f.get(key, ""))
        except ValueError:
            err.append(f"stream.framing.{key} gecerli bir hex metin degil: {f.get(key)!r}")
    if int(f.get("index_field_size", 0)) not in (0, 1, 2, 4):
        err.append("stream.framing.index_field_size 0 | 1 | 2 | 4 olmali")
    lfs = int(f.get("length_field_size", 0))
    if lfs not in (0, 1, 2, 4):
        err.append("stream.framing.length_field_size 0 | 1 | 2 | 4 olmali")

    pl = g("stream.payload", {}) or {}
    n = int(pl.get("length", DEFAULT_PAYLOAD_LEN))
    if n <= 0:
        err.append("stream.payload.length pozitif olmali")
    if pl.get("encoding", "int8") not in _ALLOWED["encoding"]:
        err.append(f"stream.payload.encoding gecersiz - {sorted(_ALLOWED['encoding'])}")
    if lfs and n >= 256 ** lfs:
        err.append(f"stream.framing.length_field_size={lfs} bayt, {n} baytlik payload'i "
                   f"ifade edemez (en az {2 if n < 65536 else 4} olmali)")
    if n != DEFAULT_PAYLOAD_LEN:
        warn.append(f"stream.payload.length={n} (Micro Speech icin beklenen {DEFAULT_PAYLOAD_LEN})")

    r = g("core.result", {}) or {}
    mode = r.get("mode", "regex_line")
    if mode not in _ALLOWED["mode"]:
        err.append(f"core.result.mode gecersiz - {sorted(_ALLOWED['mode'])}")
    classes = r.get("classes") or []
    if not classes:
        err.append("core.result.classes bos olamaz")
    if mode == "regex_line":
        try:
            rx = re.compile(r.get("regex", ""))
            if "label" not in rx.groupindex:
                err.append("core.result.regex icinde (?P<label>...) grubu yok")
            if "scores" not in rx.groupindex:
                warn.append("core.result.regex icinde (?P<scores>...) yok - skorlar raporlanmaz")
        except re.error as e:
            err.append(f"core.result.regex derlenemedi: {e}")
    if mode == "binary_fixed":
        try:
            hexbytes(r.get("binary_preamble_hex", ""))
        except ValueError:
            err.append("core.result.binary_preamble_hex gecerli hex degil")
        if not r.get("binary_preamble_hex") and not r.get("binary_score_count"):
            warn.append("binary_fixed modunda preamble yok - senkronizasyon kaybi riski")
    lm = r.get("label_map") or {}
    unknown = [v for v in lm.values() if v not in classes]
    if unknown:
        err.append(f"core.result.label_map degerleri classes icinde degil: {unknown}")
    if int(r.get("timeout_ms", 0)) <= 0:
        err.append("core.result.timeout_ms pozitif olmali")
    for key in ("ignore_regex",):
        if r.get(key):
            try:
                re.compile(r[key])
            except re.error as e:
                err.append(f"core.result.{key} derlenemedi: {e}")

    h = g("hooks", {}) or {}
    for key in ("core_init_hex", "stream_init_hex", "pre_frame_core_hex",
                "interleave_core_hex", "reset_hex", "boot_trigger_core_hex"):
        try:
            hexbytes(h.get(key, ""))
        except ValueError:
            err.append(f"hooks.{key} gecerli bir hex metin degil: {h.get(key)!r}")
    for key in ("boot_banner_regex", "interleave_expect_regex"):
        if h.get(key):
            try:
                re.compile(h[key])
            except re.error as e:
                err.append(f"hooks.{key} derlenemedi: {e}")
    if not str(g("team.name", "")).strip() or g("team.name") == "TAKIM ADINI YAZIN":
        warn.append("team.name doldurulmamis")
    if g("run.software_reference_ms") is None:
        warn.append("run.software_reference_ms bos - yazilim/donanim hizlanma orani hesaplanamaz")
    bd = int(g("stream.port.baudrate", 0) or 0)
    if bd and bd < 921600:
        warn.append(f"stream baud={bd}: 1960 baytlik vektor ~{1960*10/bd*1000:.0f} ms surer; "
                    f"sartname UART'in 1 Mbps'i desteklemesini ister")
    return err, warn


class ConsoleSink:
    COLORS = {"info": "", "ok": "\033[92m", "warn": "\033[93m", "error": "\033[91m"}
    RESET = "\033[0m"

    def __init__(self, verbose: bool = False, color: bool = True):
        self.verbose, self.color = verbose, color and sys.stdout.isatty()
        self.transcript: List[str] = []

    def __call__(self, e: Event) -> None:
        if e.kind == "log" and e.data.get("src") == "core":
            self.transcript.append(f"{datetime.now().strftime('%H:%M:%S.%f')[:-3]}  {e.message}")
            if not self.verbose:
                return
        if e.kind == "progress":
            return
        c = self.COLORS.get(e.level, "") if self.color else ""
        r = self.RESET if self.color else ""
        prefix = {"phase": "==", "scenario": "F ", "sample": "  ",
                  "error": "!!", "log": "<<"}.get(e.kind, "  ")
        print(f"{c}{prefix} {e.message}{r}", flush=True)


def collect_samples(args, cfg: HarnessConfig, sink) -> Tuple[List[Sample], Dict[str, Any]]:
    n = cfg.payload.length
    meta: Dict[str, Any] = {"seed": args.seed}
    if args.manifest:
        src: VectorSource = ManifestSource(Path(args.manifest), n, args.file_encoding)
        meta["dataset"] = str(args.manifest)
    elif args.data_dir:
        src = DirectorySource(Path(args.data_dir), n, args.file_encoding)
        meta["dataset"] = str(args.data_dir)
    else:
        rng = random.Random(args.seed)
        classes = cfg.result.classes
        samples = [Sample(f"synthetic_{i:04d}", synth_vector("random", n, rng),
                          truth=classes[i % len(classes)]) for i in range(args.count or 20)]
        meta["dataset"] = "synthetic (kuru kosum)"
        return samples, meta
    samples = list(src.samples())
    rng = random.Random(args.seed)
    rng.shuffle(samples)
    if args.count:
        samples = samples[:args.count]
    meta["dataset_size"] = len(samples)
    return samples, meta


def cmd_run(args) -> int:
    cfg_path = Path(args.config) if args.config else None
    cfg = HarnessConfig.load(cfg_path) if cfg_path else HarnessConfig.from_dict(CONFIG_TEMPLATE)
    if args.team:
        cfg.team_name = args.team
    if args.stream_port:
        cfg.stream_port.port = args.stream_port
    if args.core_port:
        cfg.core_port.port = args.core_port
    if args.stream_baud:
        cfg.stream_port.baudrate = args.stream_baud
    if args.core_baud:
        cfg.core_port.baudrate = args.core_baud

    errs, warns = validate_config(cfg.raw or CONFIG_TEMPLATE)
    if args.dry_run:
        errs = [e for e in errs if "port" not in e]
    for w in warns:
        print(f"UYARI: {w}")
    if errs:
        for e in errs:
            print(f"HATA : {e}", file=sys.stderr)
        if not args.force:
            print("\nKonfigurasyon hatalari giderilmeden kosum baslatilmaz "
                  "(gozardi etmek icin --force).", file=sys.stderr)
            return 2

    sink = ConsoleSink(verbose=args.verbose)
    samples, meta = collect_samples(args, cfg, sink)
    if not samples:
        print("Hata: ornek bulunamadi.", file=sys.stderr)
        return 2

    stamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    safe = re.sub(r"[^A-Za-z0-9_-]+", "_", cfg.team_name)
    outdir = Path(args.outdir) / f"{safe}_{stamp}"

    runner = DemoRunner(cfg, sink, dry_run=args.dry_run)
    recs: List[SampleRecord] = []
    scen: List[ScenarioOutcome] = []
    try:
        runner.connect()
        runner.wait_boot()
        runner.init_sequences()
        if not args.only_robustness:
            recs = runner.run_batch(samples)
        if not args.no_robustness:
            probe = next((s for s in samples if s.golden or s.truth), samples[0])
            scen = runner.run_robustness(probe, args.scenarios)
    except KeyboardInterrupt:
        sink(Event("phase", "Kullanici kesintisi", "warn"))
    except Exception as e:
        sink(Event("error", f"Kosum hatasi: {e}", "error"))
    finally:
        runner.disconnect()

    outdir.mkdir(parents=True, exist_ok=True)
    (outdir / "transcript.log").write_text("\n".join(sink.transcript), encoding="utf-8")
    meta["dry_run"] = args.dry_run
    summary = build_report(outdir, cfg, cfg_path, recs, scen, meta)

    print("")
    print(f"Rapor: {outdir / 'report.md'}")
    ag = summary["golden_agreement_pct"]
    robust_cli = f"{summary['robustness_passed']}/{summary['robustness_total']}"
    if summary.get("robustness_skipped"):
        robust_cli += f" (+{summary['robustness_skipped']} opsiyonel atlandi)"
    print(f"Golden ile uyum: {'-' if ag is None else f'{ag:.2f} %'}"
          f"  |  uyusmazlik: {summary['mismatch_count']}"
          f"  |  zaman asimi: {summary['timeouts']}"
          f"  |  saglamlik: {robust_cli}")
    if not args.only_robustness and summary["with_golden_ref"] == 0:
        print("UYARI: 'golden' sutunu olmadan RTL uyumu olculemez.")
    return 0


def cmd_template(args) -> int:
    p = Path(args.output)
    p.write_text(json.dumps(CONFIG_TEMPLATE, indent=2, ensure_ascii=False), encoding="utf-8")
    print(f"Sablon yazildi: {p}")
    return 0


def list_serial_ports() -> List[Tuple[str, str]]:
    """[(device, description)] doner. pyserial yoksa bos liste."""
    try:
        from serial.tools import list_ports  # type: ignore
    except ImportError:
        return []
    return [(p.device, p.description or "") for p in list_ports.comports()]


def cmd_ports(_) -> int:
    try:
        from serial.tools import list_ports  # type: ignore
    except ImportError:
        print("pyserial kurulu degil.", file=sys.stderr)
        return 1
    for p in list_ports.comports():
        print(f"{p.device:20s} {p.description} [{p.hwid}]")
    return 0


def cmd_probe(args) -> int:
    """Bilinmeyen bir takim ciktisini dinler; ICD doldurmak icin."""
    cfg = HarnessConfig.load(Path(args.config)) if args.config else HarnessConfig.from_dict(CONFIG_TEMPLATE)
    if args.core_port:
        cfg.core_port.port = args.core_port
    if args.core_baud:
        cfg.core_port.baudrate = args.core_baud
    link = SerialLink(cfg.core_port, "core")
    link.open()
    print(f"Dinleniyor: {link.name} ({args.seconds} s). Ctrl-C ile cikis.")
    t_end = time.time() + args.seconds
    buf = bytearray()
    try:
        while time.time() < t_end:
            d = link.read(4096)
            if d:
                buf += d
                sys.stdout.write(d.decode("utf-8", "replace"))
                sys.stdout.flush()
            else:
                time.sleep(0.01)
    except KeyboardInterrupt:
        pass
    finally:
        link.close()
    if args.save:
        Path(args.save).write_bytes(bytes(buf))
        print(f"\nHam veri kaydedildi: {args.save} ({len(buf)} bayt)")
    return 0


def cmd_validate(args) -> int:
    path = Path(args.config)
    try:
        d = json.loads(path.read_text(encoding="utf-8"))
    except json.JSONDecodeError as e:
        print(f"HATA : JSON okunamadi ({path}): {e}", file=sys.stderr)
        return 2
    errs, warns = validate_config(d)
    for w in warns:
        print(f"UYARI: {w}")
    for e in errs:
        print(f"HATA : {e}", file=sys.stderr)
    if errs:
        print(f"\n{len(errs)} hata, {len(warns)} uyari. Dosya kullanima HAZIR DEGIL.",
              file=sys.stderr)
        return 1
    print(f"\nGecerli. ({len(warns)} uyari)")
    return 0


def cmd_gui(args) -> int:
    try:
        from demo_gui import launch  # type: ignore
    except ImportError:
        sys.path.insert(0, str(Path(__file__).resolve().parent))
        try:
            from demo_gui import launch  # type: ignore
        except ImportError as e:
            print(f"GUI yuklenemedi: {e}\n"
                  f"demo_gui.py dosyasinin demo_harness.py ile ayni klasorde "
                  f"oldugundan emin olun.", file=sys.stderr)
            return 1
    return launch(args.config)


def main(argv: Optional[List[str]] = None) -> int:
    ap = argparse.ArgumentParser(
        description="TEKNOFEST Cip Tasarim Yarismasi - FPGA demo harness")
    ap.add_argument("--version", action="version", version=HARNESS_VERSION)
    sub = ap.add_subparsers(dest="cmd", required=True)

    r = sub.add_parser("run", help="Toplu kosum + saglamlik senaryolari")
    r.add_argument("-c", "--config", help="Takim ICD json dosyasi")
    r.add_argument("--team", help="Takim adini gecersiz kil")
    r.add_argument("--manifest", help="CSV manifest (file,truth[,golden,golden_scores])")
    r.add_argument("--data-dir", help="*.bin vektor klasoru")
    r.add_argument("--file-encoding", default="int8",
                   choices=["int8", "uint8_offset128", "uint8_raw"])
    r.add_argument("-n", "--count", type=int, default=0, help="Ornek sayisi (0=hepsi)")
    r.add_argument("--seed", type=int, default=1337, help="Alt kume secim tohumu")
    r.add_argument("-o", "--outdir", default="results")
    r.add_argument("--stream-port"); r.add_argument("--core-port")
    r.add_argument("--stream-baud", type=int); r.add_argument("--core-baud", type=int)
    r.add_argument("--no-robustness", action="store_true")
    r.add_argument("--only-robustness", action="store_true")
    r.add_argument("--scenarios", nargs="*", help="Yalnizca bu senaryolar")
    r.add_argument("--dry-run", action="store_true", help="Donanimsiz simulasyon")
    r.add_argument("--force", action="store_true",
                   help="Konfigurasyon hatalarina ragmen kosumu baslat")
    r.add_argument("-v", "--verbose", action="store_true")
    r.set_defaults(func=cmd_run)

    t = sub.add_parser("template", help="Bos ICD sablonu uret")
    t.add_argument("-o", "--output", default="team_config.json")
    t.set_defaults(func=cmd_template)

    p = sub.add_parser("ports", help="Seri portlari listele")
    p.set_defaults(func=cmd_ports)

    pr = sub.add_parser("probe", help="Core UART'i dinle (ICD doldurmak icin)")
    pr.add_argument("-c", "--config")
    pr.add_argument("--core-port"); pr.add_argument("--core-baud", type=int)
    pr.add_argument("--seconds", type=float, default=20.0)
    pr.add_argument("--save")
    pr.set_defaults(func=cmd_probe)

    v = sub.add_parser("validate", help="Doldurulmus ICD dosyasini kontrol et")
    v.add_argument("-c", "--config", required=True)
    v.set_defaults(func=cmd_validate)

    g = sub.add_parser("gui", help="Grafik arayuzu baslat")
    g.add_argument("-c", "--config", help="Acilista yuklenecek ICD")
    g.set_defaults(func=cmd_gui)

    args = ap.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
