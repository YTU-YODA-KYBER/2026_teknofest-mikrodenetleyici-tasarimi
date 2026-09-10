#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
TEKNOFEST Cip Tasarim Yarismasi - FPGA Demo Harness / Grafik Arayuz

Baslatma:
    python demo_harness.py gui              (onerilen)
    python demo_gui.py [icd.json]

Cekirdek mantik demo_harness.DemoRunner icindedir; bu dosya yalnizca
gorsel katmandir. Kosum ayri bir is parcaciginda calisir, olaylar bir
kuyruk uzerinden ana dongude islenir (Tk thread-safe degildir).

Gereksinim: tkinter (Windows/macOS Python kurulumlarinda gomulu gelir;
Debian/Ubuntu'da:  sudo apt install python3-tk)
"""

from __future__ import annotations

import json
import queue
import re
import subprocess
import sys
import threading
import time
from datetime import datetime
from pathlib import Path
from typing import Any, Callable, Dict, List, Optional

try:
    import tkinter as tk
    from tkinter import filedialog, messagebox, ttk
except ImportError:  # pragma: no cover
    print("tkinter bulunamadi. Ubuntu/Debian: sudo apt install python3-tk",
          file=sys.stderr)
    raise

import demo_harness as H

GUI_VERSION = "1.2.0-yarismaci"


# =============================================================================
# Konfigurasyon <-> arayuz baglama
# =============================================================================

def dget(d: Dict[str, Any], path: str, default=None):
    cur: Any = d
    for k in path.split("."):
        if not isinstance(cur, dict) or k not in cur:
            return default
        cur = cur[k]
    return cur


def dset(d: Dict[str, Any], path: str, value: Any) -> None:
    keys = path.split(".")
    cur = d
    for k in keys[:-1]:
        cur = cur.setdefault(k, {})
    cur[keys[-1]] = value


class Field:
    """Tek bir ICD alanini bir Tk degiskenine baglar."""

    def __init__(self, path: str, label: str, kind: str = "str",
                 values: Optional[List[Any]] = None, width: int = 22,
                 help_key: Optional[str] = None):
        self.path, self.label, self.kind = path, label, kind
        self.values, self.width = values, width
        self.help_key = help_key or path
        self.var: Any = None
        self.widget: Any = None

    def build(self, parent: tk.Widget, row: int, cfg: Dict[str, Any],
              on_help: Callable[[str], None]) -> None:
        raw = dget(cfg, self.path)
        lbl = ttk.Label(parent, text=self.label)
        lbl.grid(row=row, column=0, sticky="w", padx=(4, 6), pady=2)
        if self.kind == "bool":
            self.var = tk.BooleanVar(value=bool(raw))
            self.widget = ttk.Checkbutton(parent, variable=self.var)
        elif self.kind == "tribool":
            self.var = tk.StringVar(value={None: "null", True: "true", False: "false"}
                                    .get(raw, "null"))
            self.widget = ttk.Combobox(parent, textvariable=self.var, width=self.width - 2,
                                       values=["null", "true", "false"], state="readonly")
        elif self.values is not None:
            self.var = tk.StringVar(value="" if raw is None else str(raw))
            self.widget = ttk.Combobox(parent, textvariable=self.var, width=self.width - 2,
                                       values=[str(v) for v in self.values])
        else:
            self.var = tk.StringVar(value=self._fmt(raw))
            self.widget = ttk.Entry(parent, textvariable=self.var, width=self.width)
        self.widget.grid(row=row, column=1, sticky="we", pady=2)
        btn = ttk.Label(parent, text=" ? ", foreground="#0a58ca", cursor="hand2")
        btn.grid(row=row, column=2, sticky="w")
        btn.bind("<Button-1>", lambda _e: on_help(self.help_key))

    @staticmethod
    def _fmt(v: Any) -> str:
        if v is None:
            return ""
        if isinstance(v, (dict, list)):
            return json.dumps(v, ensure_ascii=False)
        if isinstance(v, str):
            return v.replace("\n", "\\n").replace("\r", "\\r")
        return str(v)

    def read(self) -> Any:
        v = self.var.get()
        if self.kind == "bool":
            return bool(v)
        if self.kind == "tribool":
            return {"null": None, "true": True, "false": False}[v]
        s = str(v).strip()
        if self.kind == "int":
            return int(float(s)) if s else 0
        if self.kind == "float":
            return float(s) if s else 0.0
        if self.kind == "float_or_none":
            return float(s) if s else None
        if self.kind == "json":
            return json.loads(s) if s else ({} if "map" in self.path else [])
        if self.kind == "escaped":
            return s.replace("\\r", "\r").replace("\\n", "\n")
        return s


PORT_FIELDS = [
    ("port", "Port adi", "str", None),
    ("baudrate", "Baud (bps)", "int", [115200, 230400, 460800, 921600, 1000000, 3000000]),
    ("bytesize", "Veri biti", "int", [8, 7, 6, 5]),
    ("parity", "Parity", "str", ["N", "E", "O", "M", "S"]),
    ("stopbits", "Stop biti", "float", [1, 1.5, 2]),
    ("rtscts", "RTS/CTS", "bool", None),
    ("dsrdtr", "DSR/DTR", "bool", None),
    ("xonxoff", "XON/XOFF", "bool", None),
    ("dtr", "DTR (acilista)", "tribool", None),
    ("rts", "RTS (acilista)", "tribool", None),
    ("open_settle_ms", "Acilis beklemesi (ms)", "int", None),
    ("flush_input_on_open", "Acilista tamponu bosalt", "bool", None),
]

FRAMING_FIELDS = [
    ("preamble_hex", "Preamble (hex)", "str", ["", "AA55", "5A", "DEADBEEF"]),
    ("index_field_size", "Index alani (bayt)", "int", [0, 1, 2, 4]),
    ("length_field_size", "Length alani (bayt)", "int", [0, 1, 2, 4]),
    ("length_counts", "Length neyi sayar", "str", ["payload", "payload_plus_checksum"]),
    ("endian", "Bayt sirasi", "str", ["little", "big"]),
    ("checksum", "Checksum", "str", ["none", "sum8", "xor8", "crc16_ccitt", "crc32"]),
    ("checksum_covers", "Checksum kapsami", "str", ["payload", "header_payload"]),
    ("trailer_hex", "Trailer (hex)", "str", ["", "0D0A", "55AA"]),
    ("chunk_size", "Parca boyutu (bayt)", "int", [0, 32, 64, 256, 1024]),
    ("inter_chunk_delay_ms", "Parca arasi (ms)", "float", None),
    ("inter_frame_delay_ms", "Cerceve arasi (ms)", "float", None),
    ("drain_after_write", "Yazim sonrasi bosalt", "bool", None),
]

PAYLOAD_FIELDS = [
    ("length", "Vektor uzunlugu", "int", [1960]),
    ("encoding", "Kodlama", "str", ["int8", "uint8_offset128", "uint8_raw"]),
    ("pad_value", "Doldurma degeri", "int", None),
]

RESULT_FIELDS = [
    ("mode", "Ayristirma modu", "str", ["regex_line", "json_line", "csv_line", "binary_fixed"]),
    ("line_terminator", "Satir sonu", "escaped", ["\\n", "\\r\\n", "\\r"]),
    ("encoding", "Metin kodlamasi", "str", ["ascii", "utf-8"]),
    ("regex", "Regex (label/scores)", "str", None),
    ("json_label_key", "JSON etiket anahtari", "str", None),
    ("json_scores_key", "JSON skor anahtari", "str", None),
    ("csv_label_index", "CSV etiket sutunu", "int", None),
    ("csv_scores_start", "CSV skor baslangici", "int", None),
    ("binary_preamble_hex", "Ikili preamble (hex)", "str", None),
    ("binary_label_size", "Ikili etiket (bayt)", "int", [1, 2, 4]),
    ("binary_score_count", "Ikili skor sayisi", "int", [0, 4]),
    ("binary_score_size", "Ikili skor (bayt)", "int", [1, 2, 4]),
    ("binary_score_signed", "Skorlar isaretli", "bool", None),
    ("binary_endian", "Ikili bayt sirasi", "str", ["little", "big"]),
    ("label_map", "Etiket eslesmesi (JSON)", "json", None),
    ("classes", "Siniflar (JSON dizi)", "json", None),
    ("timeout_ms", "Sonuc zaman asimi (ms)", "int", None),
    ("ignore_regex", "Yok sayilacak satirlar", "str", None),
]

HOOK_FIELDS = [
    ("boot_banner_regex", "Boot banner regex", "str", None),
    ("boot_timeout_ms", "Boot zaman asimi (ms)", "int", None),
    ("boot_trigger_core_hex", "Boot tetigi (hex)", "str", None),
    ("core_init_hex", "Core init (hex)", "str", None),
    ("stream_init_hex", "Stream init (hex)", "str", None),
    ("pre_frame_core_hex", "Cerceve oncesi (hex)", "str", None),
    ("interleave_core_hex", "Cevre birimi komutu (hex)", "str", None),
    ("interleave_expect_regex", "Beklenen yanit regex", "str", None),
    ("reset_hex", "Reset komutu (hex)", "str", None),
]

RUN_FIELDS = [
    ("warmup_frames", "Isinma cercevesi", "int", None),
    ("retries_per_sample", "Ornek basi tekrar", "int", None),
    ("inter_sample_delay_ms", "Ornek arasi (ms)", "float", None),
    ("stop_on_consecutive_timeouts", "Ardisik zaman asimi limiti", "int", None),
    ("software_reference_ms", "Yazilim referansi (ms)", "float_or_none", None),
    ("speedup_threshold", "Hizlanma esigi (x)", "float", None),
]


def collect_help(cfg: Dict[str, Any]) -> Dict[str, str]:
    """Sablondaki '_alanlar' aciklamalarini duz bir sozluge cikarir."""
    out: Dict[str, str] = {}

    def walk(node: Any, prefix: str) -> None:
        if not isinstance(node, dict):
            return
        for k, v in node.items():
            if k == "_alanlar" and isinstance(v, dict):
                for fk, fv in v.items():
                    out[f"{prefix}.{fk}".lstrip(".")] = fv if isinstance(fv, str) else str(fv)
            elif k == "_bilgi":
                txt = v if isinstance(v, str) else "\n".join(v)
                out[prefix.lstrip(".") + "._bilgi"] = txt
            elif isinstance(v, dict) and not k.startswith("_"):
                walk(v, f"{prefix}.{k}".lstrip("."))
    walk(H.CONFIG_TEMPLATE, "")
    return out


# =============================================================================
# Ana pencere
# =============================================================================

class App(tk.Tk):
    POLL_MS = 60

    def __init__(self, config_path: Optional[str] = None):
        super().__init__()
        self.title(f"TEKNOFEST Cip Tasarim Yarismasi - FPGA Demo Test Araci [YARISMACI] "
                   f"(harness {H.HARNESS_VERSION} / gui {GUI_VERSION})")
        self.geometry("1180x780")
        self.minsize(1000, 680)

        self.cfg: Dict[str, Any] = json.loads(json.dumps(H.CONFIG_TEMPLATE))
        self.cfg_path: Optional[Path] = None
        self.help_texts = collect_help(self.cfg)
        self.fields: List[Field] = []

        self.evq: "queue.Queue[H.Event]" = queue.Queue()
        self.worker: Optional[threading.Thread] = None
        self.runner: Optional[H.DemoRunner] = None
        self.cancel = threading.Event()
        self.last_outdir: Optional[Path] = None
        self.counters = {"done": 0, "total": 0, "correct": 0, "timeout": 0, "labeled": 0}
        # --- gorunum tamponlari (arayuzu akici tutmak icin) ---
        self._pending_rows: List[tuple] = []      # tabloya toplu eklenecek satirlar
        self._pending_log: List[tuple] = []       # canli log satirlari
        self._row_count = 0                       # tabloya eklenmis satir sayisi
        self._last_ui = 0.0                       # son arayuz tazeleme zamani
        self._prog = (0, 0)
        self._log_lines = 0
        self._raw_lines = 0

        self._build_style()
        self._build_toolbar()
        self._build_tabs()
        self._build_statusbar()

        if config_path:
            self.load_config(Path(config_path))
        self.after(self.POLL_MS, self._drain_events)
        self.protocol("WM_DELETE_WINDOW", self._on_close)

    # ---- gorunum -----------------------------------------------------------
    def _build_style(self) -> None:
        st = ttk.Style(self)
        try:
            st.theme_use("clam")
        except tk.TclError:
            pass
        st.configure("Head.TLabel", font=("TkDefaultFont", 11, "bold"))
        st.configure("Big.TLabel", font=("TkDefaultFont", 15, "bold"))
        st.configure("Run.TButton", font=("TkDefaultFont", 10, "bold"))

    def _build_toolbar(self) -> None:
        bar = ttk.Frame(self, padding=(8, 6))
        bar.pack(fill="x")
        ttk.Button(bar, text="ICD Ac", command=self.on_open).pack(side="left")
        ttk.Button(bar, text="Kaydet", command=self.on_save).pack(side="left", padx=4)
        ttk.Button(bar, text="Farkli Kaydet", command=self.on_save_as).pack(side="left")
        ttk.Button(bar, text="Bos Sablon", command=self.on_new).pack(side="left", padx=4)
        ttk.Separator(bar, orient="vertical").pack(side="left", fill="y", padx=10)
        ttk.Button(bar, text="Dogrula", command=self.on_validate).pack(side="left")
        ttk.Separator(bar, orient="vertical").pack(side="left", fill="y", padx=10)
        self.lbl_cfg = ttk.Label(bar, text="(kaydedilmemis sablon)", foreground="#555")
        self.lbl_cfg.pack(side="left")

    def _build_tabs(self) -> None:
        self.nb = ttk.Notebook(self)
        self.nb.pack(fill="both", expand=True, padx=8, pady=(0, 4))
        self.tab_icd = ttk.Frame(self.nb)
        self.tab_run = ttk.Frame(self.nb)
        self.tab_res = ttk.Frame(self.nb)
        self.tab_log = ttk.Frame(self.nb)
        self.nb.add(self.tab_icd, text="  1. Arayuz (ICD)  ")
        self.nb.add(self.tab_run, text="  2. Kosum  ")
        self.nb.add(self.tab_res, text="  3. Sonuclar  ")
        self.nb.add(self.tab_log, text="  4. Kayit / Probe  ")
        self._build_icd_tab()
        self._build_run_tab()
        self._build_res_tab()
        self._build_log_tab()

    def _group(self, parent: tk.Widget, title: str, prefix: str,
               spec: List[tuple], col: int, row: int = 0) -> ttk.LabelFrame:
        fr = ttk.LabelFrame(parent, text=title, padding=(6, 4))
        fr.grid(row=row, column=col, sticky="nsew", padx=6, pady=6)
        fr.columnconfigure(1, weight=1)
        for i, (key, label, kind, values) in enumerate(spec):
            f = Field(f"{prefix}.{key}", label, kind, values, help_key=f"{prefix}.{key}")
            f.build(fr, i, self.cfg, self.show_help)
            self.fields.append(f)
        return fr

    def _build_icd_tab(self) -> None:
        outer = ttk.Frame(self.tab_icd)
        outer.pack(fill="both", expand=True)
        canvas = tk.Canvas(outer, highlightthickness=0)
        sb = ttk.Scrollbar(outer, orient="vertical", command=canvas.yview)
        inner = ttk.Frame(canvas)
        inner.bind("<Configure>",
                   lambda _e: canvas.configure(scrollregion=canvas.bbox("all")))
        canvas.create_window((0, 0), window=inner, anchor="nw")
        canvas.configure(yscrollcommand=sb.set)
        canvas.pack(side="left", fill="both", expand=True)
        sb.pack(side="right", fill="y")
        canvas.bind_all("<MouseWheel>",
                        lambda e: canvas.yview_scroll(int(-e.delta / 120), "units"))
        canvas.bind_all("<Button-4>", lambda _e: canvas.yview_scroll(-1, "units"))
        canvas.bind_all("<Button-5>", lambda _e: canvas.yview_scroll(1, "units"))

        top = ttk.Frame(inner, padding=(6, 6))
        top.grid(row=0, column=0, columnspan=2, sticky="we")
        ttk.Label(top, text="Takim adi:").pack(side="left")
        self.var_team = tk.StringVar(value=dget(self.cfg, "team.name", ""))
        ttk.Entry(top, textvariable=self.var_team, width=32).pack(side="left", padx=6)
        ttk.Label(top, text="Takim no:").pack(side="left")
        self.var_team_id = tk.StringVar(value=dget(self.cfg, "team.id", ""))
        ttk.Entry(top, textvariable=self.var_team_id, width=16).pack(side="left", padx=6)
        ttk.Button(top, text="Portlari Tara", command=self.refresh_ports).pack(side="left", padx=12)

        inner.columnconfigure(0, weight=1)
        inner.columnconfigure(1, weight=1)
        self._group(inner, "UART-stream / port (hizlandiriciya veri)", "stream.port",
                    PORT_FIELDS, col=0, row=1)
        self._group(inner, "Core UART / port (sonuc okuma)", "core.port",
                    PORT_FIELDS, col=1, row=1)
        self._group(inner, "Cerceveleme (stream)", "stream.framing",
                    FRAMING_FIELDS, col=0, row=2)
        self._group(inner, "Sonuc ayristirma (core)", "core.result",
                    RESULT_FIELDS, col=1, row=2)
        self._group(inner, "Payload", "stream.payload", PAYLOAD_FIELDS, col=0, row=3)
        self._group(inner, "Kancalar (hooks)", "hooks", HOOK_FIELDS, col=1, row=3)
        self._group(inner, "Kosum parametreleri", "run", RUN_FIELDS, col=0, row=4)

        hint = ttk.LabelFrame(inner, text="Yardim", padding=(8, 6))
        hint.grid(row=4, column=1, sticky="nsew", padx=6, pady=6)
        self.txt_help = tk.Text(hint, height=12, wrap="word", relief="flat",
                                background="#f6f7f9")
        self.txt_help.pack(fill="both", expand=True)
        self.txt_help.insert("1.0", "Herhangi bir alanin yanindaki  ?  isaretine tiklayin.\n\n"
                                    "Alanlarin tamami sartname EK-2 ve EK-3'e gore "
                                    "hazirlanmistir; kullanmadiginiz alanlari bos "
                                    "(hex icin bos metin, boyut icin 0) birakin.")
        self.txt_help.configure(state="disabled")

    def _build_run_tab(self) -> None:
        f = ttk.Frame(self.tab_run, padding=8)
        f.pack(fill="both", expand=True)
        f.columnconfigure(0, weight=1)
        f.columnconfigure(1, weight=1)

        ds = ttk.LabelFrame(f, text="Veri seti", padding=8)
        ds.grid(row=0, column=0, sticky="nsew", padx=4, pady=4)
        ds.columnconfigure(1, weight=1)
        self.var_src = tk.StringVar(value="manifest")
        ttk.Radiobutton(ds, text="Manifest CSV (file,truth[,golden,golden_scores])",
                        variable=self.var_src, value="manifest").grid(row=0, column=0,
                                                                      columnspan=3, sticky="w")
        self.var_manifest = tk.StringVar()
        ttk.Entry(ds, textvariable=self.var_manifest).grid(row=1, column=0, columnspan=2,
                                                          sticky="we", pady=2)
        ttk.Button(ds, text="...", width=3,
                   command=lambda: self._pick_file(self.var_manifest)).grid(row=1, column=2)
        ttk.Radiobutton(ds, text="Klasor (yes_0001.bin ...)",
                        variable=self.var_src, value="dir").grid(row=2, column=0,
                                                                 columnspan=3, sticky="w",
                                                                 pady=(8, 0))
        self.var_dir = tk.StringVar()
        ttk.Entry(ds, textvariable=self.var_dir).grid(row=3, column=0, columnspan=2,
                                                     sticky="we", pady=2)
        ttk.Button(ds, text="...", width=3,
                   command=lambda: self._pick_dir(self.var_dir)).grid(row=3, column=2)
        ttk.Radiobutton(ds, text="Sentetik (yalniz prova)", variable=self.var_src,
                        value="synthetic").grid(row=4, column=0, columnspan=3,
                                                sticky="w", pady=(8, 0))
        row = ttk.Frame(ds)
        row.grid(row=5, column=0, columnspan=3, sticky="we", pady=(10, 0))
        ttk.Label(row, text="Ornek sayisi (0=hepsi):").pack(side="left")
        self.var_count = tk.StringVar(value="200")
        ttk.Entry(row, textvariable=self.var_count, width=7).pack(side="left", padx=6)
        ttk.Label(row, text="Seed:").pack(side="left", padx=(10, 0))
        self.var_seed = tk.StringVar(value="1337")
        ttk.Entry(row, textvariable=self.var_seed, width=8).pack(side="left", padx=6)
        row2 = ttk.Frame(ds)
        row2.grid(row=6, column=0, columnspan=3, sticky="we", pady=(6, 0))
        ttk.Label(row2, text="Dosya kodlamasi:").pack(side="left")
        self.var_fenc = tk.StringVar(value="int8")
        ttk.Combobox(row2, textvariable=self.var_fenc, width=18, state="readonly",
                     values=["int8", "uint8_offset128", "uint8_raw"]).pack(side="left", padx=6)
        ttk.Label(row2, text="Cikti klasoru:").pack(side="left", padx=(12, 0))
        self.var_out = tk.StringVar(value="results")
        ttk.Entry(row2, textvariable=self.var_out, width=14).pack(side="left", padx=6)

        sc = ttk.LabelFrame(f, text="Saglamlik senaryolari (Secenek F)", padding=8)
        sc.grid(row=0, column=1, sticky="nsew", padx=4, pady=4)
        self.scen_vars: Dict[str, tk.BooleanVar] = {}
        for i, name in enumerate(H.ALL_SCENARIOS):
            v = tk.BooleanVar(value=True)
            self.scen_vars[name] = v
            cb = ttk.Checkbutton(sc, text=name, variable=v)
            cb.grid(row=i, column=0, sticky="w")
            ttk.Label(sc, text=H.SCENARIO_HELP.get(name, ""), foreground="#555",
                      wraplength=430).grid(row=i, column=1, sticky="w", padx=8)
        btns = ttk.Frame(sc)
        btns.grid(row=len(H.ALL_SCENARIOS), column=0, columnspan=2, sticky="w", pady=(8, 0))
        ttk.Button(btns, text="Tumu",
                   command=lambda: [v.set(True) for v in self.scen_vars.values()]).pack(side="left")
        ttk.Button(btns, text="Hicbiri",
                   command=lambda: [v.set(False) for v in self.scen_vars.values()]).pack(side="left", padx=4)

        ctl = ttk.LabelFrame(f, text="Kontrol", padding=8)
        ctl.grid(row=1, column=0, columnspan=2, sticky="nsew", padx=4, pady=4)
        self.var_dry = tk.BooleanVar(value=False)
        ttk.Checkbutton(ctl, text="Kuru kosum (donanimsiz prova)",
                        variable=self.var_dry).pack(side="left")
        self.var_only_f = tk.BooleanVar(value=False)
        ttk.Checkbutton(ctl, text="Yalniz senaryolar",
                        variable=self.var_only_f).pack(side="left", padx=12)
        self.btn_start = ttk.Button(ctl, text="BASLAT", style="Run.TButton",
                                    command=self.on_start)
        self.btn_start.pack(side="left", padx=20)
        self.btn_stop = ttk.Button(ctl, text="DURDUR", command=self.on_stop, state="disabled")
        self.btn_stop.pack(side="left")
        self.btn_report = ttk.Button(ctl, text="Raporu Ac", command=self.on_open_report,
                                     state="disabled")
        self.btn_report.pack(side="right")

        mon = ttk.LabelFrame(f, text="Canli izleme", padding=8)
        mon.grid(row=2, column=0, columnspan=2, sticky="nsew", padx=4, pady=4)
        f.rowconfigure(2, weight=1)
        self.pb = ttk.Progressbar(mon, mode="determinate")
        self.pb.pack(fill="x")
        stat = ttk.Frame(mon)
        stat.pack(fill="x", pady=6)
        self.lbl_prog = ttk.Label(stat, text="0 / 0", style="Big.TLabel")
        self.lbl_prog.pack(side="left")
        self.lbl_acc = ttk.Label(stat, text="golden uyumu: -", style="Big.TLabel")
        self.lbl_acc.pack(side="left", padx=24)
        self.lbl_to = ttk.Label(stat, text="zaman asimi: 0", style="Big.TLabel")
        self.lbl_to.pack(side="left")
        self.txt_live = tk.Text(mon, height=12, wrap="none", background="#111",
                                foreground="#ddd", insertbackground="#ddd")
        self.txt_live.pack(fill="both", expand=True)
        for tag, col in (("ok", "#7ddc7d"), ("warn", "#e6c86e"),
                         ("error", "#f08a8a"), ("info", "#cfd4da")):
            self.txt_live.tag_configure(tag, foreground=col)

    def _build_res_tab(self) -> None:
        f = ttk.Frame(self.tab_res, padding=8)
        f.pack(fill="both", expand=True)
        top = ttk.Frame(f)
        top.pack(fill="x", pady=(0, 4))
        self.lbl_res = ttk.Label(top, text="Karsilastirma referansi: GOLDEN model "
                                           "(truth yalniz bilgi amaclidir)",
                                 foreground="#555")
        self.lbl_res.pack(side="left")
        self.var_only_bad = tk.BooleanVar(value=False)
        ttk.Checkbutton(top, text="Yalniz ayrisanlari goster",
                        variable=self.var_only_bad,
                        command=self._apply_filter).pack(side="right")

        cols = ("idx", "ornek", "golden", "donanim", "uyum", "truth", "gecikme")
        self.tree = ttk.Treeview(f, columns=cols, show="headings", height=18)
        widths = (50, 230, 100, 100, 60, 100, 95)
        assert len(cols) == len(widths), "sutun ve genislik sayisi eslesmeli"
        self._tree_cols = cols
        for c, w in zip(cols, widths):
            self.tree.heading(c, text=c)
            self.tree.column(c, width=w, anchor="w")
        self.tree.tag_configure("bad", background="#ffe6e6")
        self.tree.tag_configure("to", background="#ffd6d6")
        sb = ttk.Scrollbar(f, orient="vertical", command=self.tree.yview)
        self.tree.configure(yscrollcommand=sb.set)
        self.tree.pack(side="left", fill="both", expand=True)
        sb.pack(side="left", fill="y")

        right = ttk.LabelFrame(f, text="Senaryo sonuclari", padding=6)
        right.pack(side="left", fill="both", expand=True, padx=(8, 0))
        self.txt_scen = tk.Text(right, wrap="word", height=18)
        self.txt_scen.pack(fill="both", expand=True)
        self.txt_scen.tag_configure("pass", foreground="#12742f")
        self.txt_scen.tag_configure("fail", foreground="#b02a2a")
        self.txt_scen.tag_configure("skip", foreground="#7a6a00")

    def _build_log_tab(self) -> None:
        f = ttk.Frame(self.tab_log, padding=8)
        f.pack(fill="both", expand=True)
        bar = ttk.Frame(f)
        bar.pack(fill="x")
        ttk.Label(bar, text="Core UART ham cikti").pack(side="left")
        ttk.Button(bar, text="Temizle",
                   command=lambda: self.txt_raw.delete("1.0", "end")).pack(side="right")
        ttk.Button(bar, text="Kaydet...", command=self.on_save_transcript).pack(side="right", padx=6)
        ttk.Separator(bar, orient="vertical").pack(side="right", fill="y", padx=8)
        ttk.Button(bar, text="Probe (20 s dinle)", command=self.on_probe).pack(side="right")
        self.txt_raw = tk.Text(f, wrap="none", background="#0f1115", foreground="#d6d6d6",
                               insertbackground="#d6d6d6")
        self.txt_raw.pack(fill="both", expand=True, pady=6)

    MAX_TREE_ROWS = 2000        # tabloda tutulacak azami satir (tamami CSV'de)
    MAX_LOG_LINES = 800         # canli log tamponu
    MAX_RAW_LINES = 3000        # ham UART tamponu
    UI_REFRESH_S = 0.10         # arayuz tazeleme araligi

    def _reset_view_state(self) -> None:
        self._pending_rows.clear()
        self._pending_log.clear()
        self._row_count = 0
        self._log_lines = 0
        self._trimmed_note = False

    def _build_statusbar(self) -> None:
        self.status = tk.StringVar(value="Hazir.")
        ttk.Label(self, textvariable=self.status, relief="sunken", anchor="w",
                  padding=(6, 3)).pack(fill="x", side="bottom")

    # ---- konfigurasyon -----------------------------------------------------
    def collect_config(self) -> Dict[str, Any]:
        cfg = json.loads(json.dumps(self.cfg))
        dset(cfg, "team.name", self.var_team.get().strip() or "TAKIM")
        dset(cfg, "team.id", self.var_team_id.get().strip())
        errors = []
        for fld in self.fields:
            try:
                dset(cfg, fld.path, fld.read())
            except (ValueError, json.JSONDecodeError) as e:
                errors.append(f"{fld.label} ({fld.path}): {e}")
        if errors:
            raise ValueError("\n".join(errors))
        return cfg

    def apply_config(self, cfg: Dict[str, Any]) -> None:
        self.cfg = cfg
        self.var_team.set(dget(cfg, "team.name", ""))
        self.var_team_id.set(dget(cfg, "team.id", ""))
        for fld in self.fields:
            raw = dget(cfg, fld.path)
            if fld.kind == "bool":
                fld.var.set(bool(raw))
            elif fld.kind == "tribool":
                fld.var.set({None: "null", True: "true", False: "false"}.get(raw, "null"))
            else:
                fld.var.set(Field._fmt(raw))

    def load_config(self, path: Path) -> None:
        try:
            self.apply_config(json.loads(path.read_text(encoding="utf-8")))
        except Exception as e:
            messagebox.showerror("ICD okunamadi", str(e))
            return
        self.cfg_path = path
        self.lbl_cfg.configure(text=str(path))
        self.status.set(f"Yuklendi: {path}")

    def on_open(self) -> None:
        p = filedialog.askopenfilename(title="ICD sec",
                                       filetypes=[("JSON", "*.json"), ("Tumu", "*.*")])
        if p:
            self.load_config(Path(p))

    def on_new(self) -> None:
        self.apply_config(json.loads(json.dumps(H.CONFIG_TEMPLATE)))
        self.cfg_path = None
        self.lbl_cfg.configure(text="(kaydedilmemis sablon)")

    def on_save(self) -> None:
        if not self.cfg_path:
            return self.on_save_as()
        self._write_config(self.cfg_path)

    def on_save_as(self) -> None:
        p = filedialog.asksaveasfilename(defaultextension=".json",
                                         initialfile="team_config.json",
                                         filetypes=[("JSON", "*.json")])
        if p:
            self.cfg_path = Path(p)
            self._write_config(self.cfg_path)
            self.lbl_cfg.configure(text=p)

    def _write_config(self, path: Path) -> None:
        try:
            cfg = self.collect_config()
        except ValueError as e:
            messagebox.showerror("Alan hatasi", str(e))
            return
        path.write_text(json.dumps(cfg, indent=2, ensure_ascii=False), encoding="utf-8")
        self.cfg = cfg
        self.status.set(f"Kaydedildi: {path}")

    def on_validate(self) -> None:
        try:
            cfg = self.collect_config()
        except ValueError as e:
            messagebox.showerror("Alan hatasi", str(e))
            return
        errs, warns = H.validate_config(cfg)
        msg = ""
        if errs:
            msg += "HATALAR:\n" + "\n".join(f"  - {e}" for e in errs) + "\n\n"
        if warns:
            msg += "UYARILAR:\n" + "\n".join(f"  - {w}" for w in warns)
        if not msg:
            messagebox.showinfo("Dogrulama", "Konfigurasyon gecerli, uyari yok.")
        elif errs:
            messagebox.showerror("Dogrulama", msg)
        else:
            messagebox.showwarning("Dogrulama", msg)

    def show_help(self, key: str) -> None:
        txt = self.help_texts.get(key)
        if not txt and key.startswith("core.port."):
            # core.port alanlari stream.port ile ayni anlama gelir
            txt = self.help_texts.get(key.replace("core.port.", "stream.port.", 1))
        if not txt:
            section = key.rsplit(".", 1)[0]
            txt = self.help_texts.get(section + "._bilgi", "Bu alan icin aciklama bulunamadi.")
        self.txt_help.configure(state="normal")
        self.txt_help.delete("1.0", "end")
        self.txt_help.insert("1.0", f"{key}\n\n{txt}")
        self.txt_help.configure(state="disabled")

    def refresh_ports(self) -> None:
        ports = H.list_serial_ports()
        if not ports:
            messagebox.showwarning("Port yok",
                                   "Seri port bulunamadi (veya pyserial kurulu degil).")
            return
        names = [d for d, _ in ports]
        for fld in self.fields:
            if fld.path.endswith("port.port") and isinstance(fld.widget, ttk.Combobox):
                fld.widget.configure(values=names)
        for fld in self.fields:
            if fld.path.endswith("port.port") and not isinstance(fld.widget, ttk.Combobox):
                pass
        self.status.set("Portlar: " + ", ".join(f"{d} ({t})" for d, t in ports))
        messagebox.showinfo("Bulunan portlar",
                            "\n".join(f"{d}   {t}" for d, t in ports))

    # ---- kosum -------------------------------------------------------------
    def _pick_file(self, var: tk.StringVar) -> None:
        p = filedialog.askopenfilename(filetypes=[("CSV", "*.csv"), ("Tumu", "*.*")])
        if p:
            var.set(p)
            self.var_src.set("manifest")

    def _pick_dir(self, var: tk.StringVar) -> None:
        p = filedialog.askdirectory()
        if p:
            var.set(p)
            self.var_src.set("dir")

    def on_start(self) -> None:
        if self.worker and self.worker.is_alive():
            return
        try:
            cfgd = self.collect_config()
        except ValueError as e:
            messagebox.showerror("Alan hatasi", str(e))
            return
        errs, warns = H.validate_config(cfgd)
        if self.var_dry.get():
            errs = [e for e in errs if "port" not in e]
        if errs:
            messagebox.showerror("Konfigurasyon hatali",
                                 "\n".join(f"- {e}" for e in errs))
            return
        if warns and not messagebox.askyesno(
                "Uyarilar", "\n".join(f"- {w}" for w in warns) + "\n\nDevam edilsin mi?"):
            return

        scen = [k for k, v in self.scen_vars.items() if v.get()]

        self.tree.delete(*self.tree.get_children())
        self.txt_live.delete("1.0", "end")
        self.txt_scen.delete("1.0", "end")
        self._reset_view_state()
        self.counters = {"done": 0, "total": 0, "correct": 0,
                         "timeout": 0, "labeled": 0}
        self.pb.configure(mode="indeterminate", maximum=100, value=0)
        self.pb.start(30)
        self.cancel = threading.Event()
        self.btn_start.configure(state="disabled")
        self.btn_stop.configure(state="normal")
        self.btn_report.configure(state="disabled")
        self.nb.select(self.tab_run)
        self.status.set("Veri seti yukleniyor...")

        # Veri seti okuma binlerce kucuk dosya acabilir; ARKA PLANDA yapilir,
        # yoksa arayuz yuklemenin tamami boyunca donar.
        self.worker = threading.Thread(
            target=self._load_then_run,
            args=(cfgd, meta_scen := scen, self.var_dry.get(), self.var_only_f.get()),
            daemon=True)
        self.worker.start()

    def _load_then_run(self, cfgd, scen, dry, only_f) -> None:
        sink = self.evq.put
        try:
            samples, meta = self._load_samples_bg(cfgd, sink)
        except Exception as e:
            sink(H.Event("error", f"Veri seti okunamadi: {e}", "error"))
            sink(H.Event("done", "", "warn", {}))
            return
        if not samples:
            sink(H.Event("error", "Hic ornek bulunamadi.", "error"))
            sink(H.Event("done", "", "warn", {}))
            return
        sink(H.Event("loaded", f"{len(samples)} ornek yuklendi", "ok",
                     {"total": len(samples)}))
        self._run_worker(cfgd, samples, meta, scen, dry, only_f)

    def _load_samples_bg(self, cfgd: Dict[str, Any], sink):
        """Arka planda veri setini okur, ilerleme olayi gonderir."""
        import random as _random
        n = int(dget(cfgd, "stream.payload.length", H.DEFAULT_PAYLOAD_LEN))
        count = int(self.var_count.get() or 0)
        seed = int(self.var_seed.get() or 0)
        src = self.var_src.get()
        enc = self.var_fenc.get()
        meta: Dict[str, Any] = {"seed": seed}

        if src == "synthetic":
            rng = _random.Random(seed)
            classes = dget(cfgd, "core.result.classes", H.DEFAULT_CLASSES)
            samples = [H.Sample(f"synthetic_{i:04d}", H.synth_vector("random", n, rng),
                                truth=classes[i % len(classes)],
                                golden=classes[i % len(classes)])
                       for i in range(count or 20)]
            meta["dataset"] = "synthetic"
            meta["dataset_size"] = len(samples)
            return samples, meta

        if src == "manifest":
            path = Path(self.var_manifest.get())
            if not path.is_file():
                raise FileNotFoundError(f"Manifest bulunamadi: {path}")
            rows = self._read_manifest_rows(path)
            base = path.parent
            meta["dataset"] = str(path)
        else:
            root = Path(self.var_dir.get())
            if not root.is_dir():
                raise NotADirectoryError(f"Klasor bulunamadi: {root}")
            files = sorted(root.glob("*.bin"))
            rows = [{"file": f.name, "name": f.stem,
                     "truth": (f.stem.split("_")[0].lower()
                               if "_" in f.stem else ""), "golden": ""}
                    for f in files]
            base = root
            meta["dataset"] = str(root)

        # Once secimi yap, SONRA dosyalari oku: 50 ornek istenirken 20 000
        # dosyayi diskten okumanin anlami yok.
        _random.Random(seed).shuffle(rows)
        if count:
            rows = rows[:count]

        samples: List[H.Sample] = []
        total = len(rows)
        for i, row in enumerate(rows, 1):
            if self.cancel.is_set():
                break
            fp = (base / row["file"]).resolve()
            try:
                vals = H._read_vector(fp, n, enc)
            except Exception as e:
                sink(H.Event("log", f"atlandi: {row['file']} ({e})", "warn"))
                continue
            samples.append(H.Sample(
                name=row.get("name") or Path(row["file"]).stem, values=vals,
                truth=(row.get("truth") or "").strip().lower() or None,
                golden=(row.get("golden") or "").strip().lower() or None,
                meta={"path": str(fp),
                      "golden_scores": H.parse_number_list(row.get("golden_scores") or ""),
                      "golden_probs": H.parse_number_list(row.get("golden_probs") or "")}))
            if i % 50 == 0 or i == total:
                sink(H.Event("loading", f"Veri seti yukleniyor: {i}/{total}", "info",
                             {"done": i, "total": total}))
        meta["dataset_size"] = len(samples)
        return samples, meta

    @staticmethod
    def _read_manifest_rows(path: Path) -> List[Dict[str, str]]:
        import csv as _csv
        with path.open(newline="", encoding="utf-8") as fh:
            return [dict(r) for r in _csv.DictReader(fh)]

    def _build_samples(self, cfgd: Dict[str, Any]):
        n = int(dget(cfgd, "stream.payload.length", H.DEFAULT_PAYLOAD_LEN))
        try:
            count = int(self.var_count.get() or 0)
            seed = int(self.var_seed.get() or 0)
        except ValueError:
            messagebox.showerror("Hata", "Ornek sayisi ve seed tamsayi olmali.")
            return None, None
        src = self.var_src.get()
        meta: Dict[str, Any] = {"seed": seed}
        try:
            if src == "manifest":
                p = Path(self.var_manifest.get())
                if not p.is_file():
                    messagebox.showerror("Hata", "Manifest dosyasi bulunamadi.")
                    return None, None
                samples = list(H.ManifestSource(p, n, self.var_fenc.get()).samples())
                meta["dataset"] = str(p)
            elif src == "dir":
                p = Path(self.var_dir.get())
                if not p.is_dir():
                    messagebox.showerror("Hata", "Klasor bulunamadi.")
                    return None, None
                samples = list(H.DirectorySource(p, n, self.var_fenc.get()).samples())
                meta["dataset"] = str(p)
            else:
                import random
                rng = random.Random(seed)
                classes = dget(cfgd, "core.result.classes", H.DEFAULT_CLASSES)
                samples = [H.Sample(f"synthetic_{i:04d}",
                                    H.synth_vector("random", n, rng),
                                    truth=classes[i % len(classes)])
                           for i in range(count or 20)]
                meta["dataset"] = "synthetic"
        except Exception as e:
            messagebox.showerror("Veri seti okunamadi", str(e))
            return None, None
        if src != "synthetic":
            import random
            random.Random(seed).shuffle(samples)
            if count:
                samples = samples[:count]
        if not samples:
            messagebox.showerror("Hata", "Hic ornek bulunamadi.")
            return None, None
        meta["dataset_size"] = len(samples)
        return samples, meta

    def _run_worker(self, cfgd, samples, meta, scen, dry, only_f) -> None:
        cfg = H.HarnessConfig.from_dict(cfgd)
        sink = self.evq.put
        runner = H.DemoRunner(cfg, sink, dry_run=dry, cancel=self.cancel)
        self.runner = runner
        recs: List[H.SampleRecord] = []
        outs: List[H.ScenarioOutcome] = []
        transcript: List[str] = []
        try:
            runner.connect()
            runner.wait_boot()
            runner.init_sequences()
            if not only_f:
                recs = runner.run_batch(samples)
            if scen and not self.cancel.is_set():
                probe = next((s for s in samples if s.truth), samples[0])
                outs = runner.run_robustness(probe, scen)
        except Exception as e:
            sink(H.Event("error", f"Kosum hatasi: {e}", "error"))
        finally:
            try:
                if runner.reader:
                    transcript = [f"{datetime.fromtimestamp(t).strftime('%H:%M:%S.%f')[:-3]}  {l}"
                                  for t, l in runner.reader.raw_lines]
            except Exception:
                pass
            runner.disconnect()
        try:
            stamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            safe = re.sub(r"[^A-Za-z0-9_-]+", "_", cfg.team_name)
            outdir = Path(self.var_out.get() or "results") / f"{safe}_{stamp}"
            outdir.mkdir(parents=True, exist_ok=True)
            (outdir / "transcript.log").write_text("\n".join(transcript), encoding="utf-8")
            meta["dry_run"] = dry
            summary = H.build_report(outdir, cfg, self.cfg_path, recs, outs, meta)
            sink(H.Event("done", f"Rapor: {outdir / 'report.md'}", "ok",
                         {"outdir": str(outdir), "summary": summary}))
        except Exception as e:
            sink(H.Event("error", f"Rapor uretilemedi: {e}", "error"))
            sink(H.Event("done", "", "warn", {}))

    def on_stop(self) -> None:
        self.cancel.set()
        self.btn_stop.configure(state="disabled")
        self.status.set("Durduruluyor - bekleyen yanit iptal ediliyor, "
                        "rapor o ana kadarki verilerle uretilecek...")
        self.txt_live.insert("end", "\n[DURDURULDU - kullanici]\n", "warn")
        self.txt_live.see("end")

    def on_open_report(self) -> None:
        if not self.last_outdir:
            return
        p = self.last_outdir / "report.md"
        try:
            if sys.platform.startswith("win"):
                subprocess.Popen(["cmd", "/c", "start", "", str(p)], shell=False)
            elif sys.platform == "darwin":
                subprocess.Popen(["open", str(p)])
            else:
                subprocess.Popen(["xdg-open", str(p)])
        except Exception:
            messagebox.showinfo("Rapor", str(p))

    def on_save_transcript(self) -> None:
        p = filedialog.asksaveasfilename(defaultextension=".log",
                                         initialfile="transcript.log")
        if p:
            Path(p).write_text(self.txt_raw.get("1.0", "end"), encoding="utf-8")

    def on_probe(self) -> None:
        """Core UART'i kisa sure dinler; ICD doldururken formati gormek icin."""
        try:
            cfgd = self.collect_config()
        except ValueError as e:
            messagebox.showerror("Alan hatasi", str(e))
            return
        cfg = H.HarnessConfig.from_dict(cfgd)
        self.nb.select(self.tab_log)

        def work():
            link = H.SerialLink(cfg.core_port, "core")
            try:
                link.open()
            except Exception as e:
                self.evq.put(H.Event("error", f"Port acilamadi: {e}", "error"))
                return
            self.evq.put(H.Event("phase", f"Dinleniyor: {link.name} (20 s)", "info"))
            t_end = time.time() + 20
            while time.time() < t_end:
                try:
                    d = link.read(4096)
                except Exception as e:
                    self.evq.put(H.Event("error", str(e), "error"))
                    break
                if d:
                    self.evq.put(H.Event("raw", d.decode("utf-8", "replace")))
                else:
                    time.sleep(0.01)
            link.close()
            self.evq.put(H.Event("phase", "Dinleme bitti.", "ok"))

        threading.Thread(target=work, daemon=True).start()

    # ---- olay dongusu ------------------------------------------------------
    def _drain_events(self) -> None:
        """Kuyrugu bosaltir ama arayuzu saniyede ~10 kez tazeler."""
        n = 0
        while n < 5000:                      # kuyrugun birikmesine izin verme
            try:
                e = self.evq.get_nowait()
            except queue.Empty:
                break
            n += 1
            self._handle(e)
        if (self._pending_rows or self._pending_log or n) and \
                (time.time() - self._last_ui) >= self.UI_REFRESH_S:
            self._flush_view()
            self._last_ui = time.time()
        self.after(self.POLL_MS, self._drain_events)

    def _flush_view(self) -> None:
        """Biriken satirlari TEK seferde tabloya/loga yazar."""
        if self._pending_rows:
            rows, self._pending_rows = self._pending_rows, []
            for tag, vals in rows:
                self.tree.insert("", "end", tags=(tag,), values=vals)
            self._row_count += len(rows)
            # Tablo sinirsiz buyurse Tk yavaslar; en eski satirlari at.
            extra = self._row_count - self.MAX_TREE_ROWS
            if extra > 0:
                kids = self.tree.get_children()
                self.tree.delete(*kids[:extra])
                self._row_count -= extra
                if not self._trimmed_note:
                    self._trimmed_note = True
                    self._append_log(f"(tabloda son {self.MAX_TREE_ROWS} satir "
                                     f"gosteriliyor; tamami samples.csv'de)", "warn")
            self.tree.yview_moveto(1.0)      # satir basina degil, toplu kaydir

        if self._pending_log:
            chunk, self._pending_log = self._pending_log, []
            for msg, lvl in chunk:
                self.txt_live.insert("end", msg + "\n", lvl)
            self._log_lines += len(chunk)
            if self._log_lines > self.MAX_LOG_LINES:
                cut = self._log_lines - self.MAX_LOG_LINES
                self.txt_live.delete("1.0", f"{cut + 1}.0")
                self._log_lines -= cut
            self.txt_live.see("end")

        d, t = self._prog
        if t:
            self.pb.configure(value=d, maximum=max(1, t))
            self.lbl_prog.configure(text=f"{d} / {t}")
        if self.counters["labeled"]:
            ag = 100.0 * self.counters["correct"] / self.counters["labeled"]
            self.lbl_acc.configure(text=f"golden uyumu: {ag:.1f} %")
        elif self.counters["done"]:
            self.lbl_acc.configure(text="golden uyumu: - (referans yok)")
        self.lbl_to.configure(text=f"zaman asimi: {self.counters['timeout']}")

    def _append_log(self, msg: str, level: str = "info") -> None:
        if msg:
            self._pending_log.append((msg, level))

    def _apply_filter(self) -> None:
        """Yalniz ayrisan / zaman asimina ugrayan satirlari goster."""
        if not self.var_only_bad.get():
            for iid in getattr(self, "_hidden_rows", []):
                try:
                    self.tree.reattach(iid, "", "end")
                except tk.TclError:
                    pass
            self._hidden_rows = []
            return
        hidden = []
        for iid in self.tree.get_children():
            if not self.tree.item(iid, "tags"):
                self.tree.detach(iid)
                hidden.append(iid)
        self._hidden_rows = hidden

    def _handle(self, e: H.Event) -> None:
        if e.kind == "raw":
            self._raw_append(e.message)
            return
        if e.kind == "log" and e.data.get("src") == "core":
            self._raw_append(f"{datetime.now().strftime('%H:%M:%S.%f')[:-3]}  "
                             f"{e.message}\n")
            return
        if e.kind == "progress":
            self._prog = (e.data.get("done", 0), e.data.get("total", 1))
            return
        if e.kind == "loading":
            self._prog = (e.data.get("done", 0), e.data.get("total", 1))
            self.status.set(e.message)
            return
        if e.kind == "loaded":
            total = e.data.get("total", 0)
            self.pb.stop()
            self.pb.configure(mode="determinate", maximum=max(1, total), value=0)
            self.counters["total"] = total
            self._prog = (0, total)
            self.status.set(f"Kosum basladi ({total} ornek)...")
            self._append_log(e.message, "ok")
            return
        if e.kind == "sample":
            self._add_sample(e)
            return                      # her ornek icin ayrica log satiri yazma
        if e.kind == "scenario":
            o = e.data.get("outcome", {})
            if o.get("skipped"):
                tag, label = "skip", "SKIP"
            else:
                tag, label = ("pass", "PASS") if o.get("passed") else ("fail", "FAIL")
            self.txt_scen.insert("end", f"[{label}] {o.get('name')}\n    {o.get('detail')}\n\n", tag)
            self.txt_scen.see("end")
        elif e.kind == "done":
            self._flush_view()
            self._finish(e)
            return
        self._append_log(e.message, e.level)

    def _raw_append(self, text: str) -> None:
        self.txt_raw.insert("end", text)
        self._raw_lines += text.count("\n")
        if self._raw_lines > self.MAX_RAW_LINES:
            cut = self._raw_lines - self.MAX_RAW_LINES
            self.txt_raw.delete("1.0", f"{cut + 1}.0")
            self._raw_lines -= cut
        self.txt_raw.see("end")

    def _add_sample(self, e: H.Event) -> None:
        r = e.data.get("record", {})
        # KARSILASTIRMA REFERANSI: golden model. truth yalniz bilgi amaclidir.
        golden, pred, truth = r.get("golden"), r.get("predicted"), r.get("truth")
        self.counters["done"] += 1
        if r.get("timeout"):
            self.counters["timeout"] += 1
        if golden:
            self.counters["labeled"] += 1
            if pred == golden:
                self.counters["correct"] += 1
        tag = "to" if r.get("timeout") else ("bad" if (golden and pred != golden) else "")
        lat = r.get("latency_ms")
        self._pending_rows.append((tag, (
            r.get("index"), r.get("name"), golden or "-", pred or "TIMEOUT",
            "" if not golden else ("=" if pred == golden else "FARK"),
            truth or "-", "-" if lat is None else f"{lat:.1f}")))
        # Ayrisan ve zaman asimina ugrayanlari log'a da dus (goz kacirmamak icin)
        if tag:
            self._append_log(
                f"[{r.get('index')}] {r.get('name')}: golden={golden or '-'} "
                f"donanim={pred or 'TIMEOUT'}",
                "error" if tag == "to" else "warn")

    def _finish(self, e: H.Event) -> None:
        try:
            self.pb.stop()
            self.pb.configure(mode="determinate")
        except tk.TclError:
            pass
        self.btn_start.configure(state="normal")
        self.btn_stop.configure(state="disabled")
        od = e.data.get("outdir")
        if od:
            self.last_outdir = Path(od)
            self.btn_report.configure(state="normal")
        s = e.data.get("summary", {})
        if e.message:
            self.txt_live.insert("end", f"\n{e.message}\n", "ok")
            self.txt_live.see("end")
        if s:
            ag = s.get("golden_agreement_pct")
            agt = "-" if ag is None else f"{ag:.2f} %"
            msg = (f"GOLDEN ILE UYUM: {agt}\n"
                   f"Uyusmazlik: {s.get('mismatch_count')}\n"
                   f"Zaman asimi: {s.get('timeouts')}\n"
                   f"Saglamlik: {s.get('robustness_passed')}/{s.get('robustness_total')}"
                   f" (+{s.get('robustness_skipped', 0)} opsiyonel atlandi)\n")
            if not s.get("with_golden_ref"):
                msg = ("UYARI: veri setinde 'golden' sutunu yok, RTL uyumu "
                       "olculemedi.\n\n") + msg
            if s.get("score_error_mean_pct") is not None:
                msg += (f"\n(bilgi) golden skor hata orani: "
                        f"{s['score_error_mean_pct']:.4f} %\n")
            if s.get("accuracy_info_hw_pct") is not None:
                msg += (f"\n(bilgi) truth'a gore dogruluk: "
                        f"{s['accuracy_info_hw_pct']:.2f} % - puanlamada kullanilmaz\n")
            if s.get("speedup_ratio") is not None:
                msg += f"Olculen hizlanma: {s['speedup_ratio']:.1f}x\n"
            msg += f"\nRapor: {od}"
            self.status.set(f"Bitti. Golden uyumu {agt} - {od}")
            messagebox.showinfo("Kosum tamamlandi", msg)
            self.nb.select(self.tab_res)
        else:
            self.status.set("Kosum sonlandi.")

    def _on_close(self) -> None:
        if self.worker and self.worker.is_alive():
            if not messagebox.askyesno("Cikis", "Kosum devam ediyor. Yine de kapatilsin mi?"):
                return
            self.cancel.set()
            time.sleep(0.3)
        self.destroy()


def launch(config_path: Optional[str] = None) -> int:
    App(config_path).mainloop()
    return 0


if __name__ == "__main__":
    sys.exit(launch(sys.argv[1] if len(sys.argv) > 1 else None))
