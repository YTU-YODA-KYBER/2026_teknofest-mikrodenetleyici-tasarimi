#!/usr/bin/env python3
# =====================================================================
#  tflite_parse.py -- .tflite dosyasini SAF PYTHON ile ayristirir
#
#  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim (Mikrodenetleyici)
#
#  NEDEN ELLE YAZILDI
#  ------------------
#  .tflite bir FlatBuffer'dir; normalde tensorflow ya da flatbuffers
#  paketiyle okunur. Bu makinede ikisi de yok ve deponun uslubu
#  bagimliliksiz script (bkz. scripts/wav_to_yz.py). FlatBuffer okuma
#  tarafi zaten basit: tablo -> vtable -> alan ofseti. Sadece bizim
#  ihtiyacimiz olan alt kume implement edildi.
#
#  NE CIKARIR
#  ----------
#  Model  -> operator_codes, subgraphs, buffers
#  Tensor -> shape, tip, buffer no, isim, quantization{scale[], zp[]}
#  Operator -> opcode, girisler, cikislar, builtin_options (Conv2D / FC)
#
#  KULLANIM
#  --------
#      python3 tflite_parse.py model.tflite            # ozet dokum
#      python3 tflite_parse.py model.tflite --dump     # tam dokum
#
#  Baska scriptlerden:
#      from tflite_parse import parse_model
#      m = parse_model("micro_speech_quantized.tflite")
# =====================================================================
"""TFLite FlatBuffer okuyucu (bagimliliksiz)."""

import argparse
import struct
import sys

# ---------------------------------------------------------------------
#  FlatBuffer temel okuma
#
#  Bicim (flatbuffers "binary wire format"):
#    - Dosya basi: uint32 root_offset, ardindan 4 baytlik file identifier
#    - Tablo P'de: int32 soffset -> vtable = P - soffset
#    - vtable: uint16 vtable_bayt_boyu, uint16 tablo_bayt_boyu,
#              ardindan her alan icin uint16 ofset (0 = alan yok)
#    - Alan degeri: skalarlar P+ofset'te dogrudan; vektor/tablo/string
#      icin P+ofset'te uint32 GORECELI isaretci durur (hedef = konum+deger)
#    - Vektor V'de: uint32 uzunluk, ardindan elemanlar
# ---------------------------------------------------------------------


class Buf:
    """Bayt dizisi uzerinde konumlu okuma yardimcilari."""

    def __init__(self, data):
        self.d = data

    def u8(self, p):   return self.d[p]
    def i8(self, p):   return struct.unpack_from("<b", self.d, p)[0]
    def u16(self, p):  return struct.unpack_from("<H", self.d, p)[0]
    def u32(self, p):  return struct.unpack_from("<I", self.d, p)[0]
    def i32(self, p):  return struct.unpack_from("<i", self.d, p)[0]
    def i64(self, p):  return struct.unpack_from("<q", self.d, p)[0]
    def f32(self, p):  return struct.unpack_from("<f", self.d, p)[0]

    def indirect(self, p):
        """P'deki goreceli isaretciyi mutlak konuma cevirir."""
        return p + self.u32(p)


class Table:
    """Tek bir FlatBuffer tablosu. Alanlara `slot` numarasiyla erisilir.

    Slot numaralari .fbs semasindaki alan sirasidir (0'dan baslar).
    Bir union alani IKI slot tuketir: once tip (ubyte), sonra deger.
    """

    def __init__(self, buf, pos):
        self.buf = buf
        self.pos = pos
        self.vt = pos - buf.i32(pos)
        self.vt_bytes = buf.u16(self.vt)

    def _off(self, slot):
        """Alanin tablo icindeki ofseti; 0 = alan dosyada yok (varsayilan)."""
        vo = 4 + 2 * slot
        if vo >= self.vt_bytes:
            return 0
        return self.buf.u16(self.vt + vo)

    # --- skalarlar ---------------------------------------------------
    def scalar(self, slot, reader, default=0):
        o = self._off(slot)
        return reader(self.pos + o) if o else default

    def u8f(self, slot, d=0):   return self.scalar(slot, self.buf.u8, d)
    def i8f(self, slot, d=0):   return self.scalar(slot, self.buf.i8, d)
    def u32f(self, slot, d=0):  return self.scalar(slot, self.buf.u32, d)
    def i32f(self, slot, d=0):  return self.scalar(slot, self.buf.i32, d)

    # --- bilesik alanlar ---------------------------------------------
    def table(self, slot):
        o = self._off(slot)
        return Table(self.buf, self.buf.indirect(self.pos + o)) if o else None

    def string(self, slot):
        o = self._off(slot)
        if not o:
            return None
        p = self.buf.indirect(self.pos + o)
        n = self.buf.u32(p)
        return self.buf.d[p + 4:p + 4 + n].decode("utf-8", "replace")

    def _vec(self, slot):
        """(ilk_eleman_konumu, eleman_sayisi) dondurur; alan yoksa (0, 0)."""
        o = self._off(slot)
        if not o:
            return 0, 0
        p = self.buf.indirect(self.pos + o)
        return p + 4, self.buf.u32(p)

    def vec_scalar(self, slot, reader, size):
        start, n = self._vec(slot)
        return [reader(start + i * size) for i in range(n)]

    def vec_i32(self, slot):  return self.vec_scalar(slot, self.buf.i32, 4)
    def vec_i64(self, slot):  return self.vec_scalar(slot, self.buf.i64, 8)
    def vec_f32(self, slot):  return self.vec_scalar(slot, self.buf.f32, 4)

    def vec_bytes(self, slot):
        start, n = self._vec(slot)
        return bytes(self.buf.d[start:start + n])

    def vec_table(self, slot):
        """Tablo vektoru: her eleman goreceli isaretcidir."""
        start, n = self._vec(slot)
        return [Table(self.buf, self.buf.indirect(start + i * 4))
                for i in range(n)]


# ---------------------------------------------------------------------
#  TFLite sema sabitleri (schema_v3)
# ---------------------------------------------------------------------
TENSOR_TYPE = {
    0: "FLOAT32", 1: "FLOAT16", 2: "INT32", 3: "UINT8", 4: "INT64",
    5: "STRING", 6: "BOOL", 7: "INT16", 8: "COMPLEX64", 9: "INT8",
    10: "FLOAT64", 11: "COMPLEX128", 12: "UINT64", 13: "RESOURCE",
    14: "VARIANT", 15: "UINT32", 16: "UINT16", 17: "INT4",
}

BUILTIN_OP = {
    0: "ADD", 1: "AVERAGE_POOL_2D", 2: "CONCATENATION", 3: "CONV_2D",
    4: "DEPTHWISE_CONV_2D", 9: "FULLY_CONNECTED", 17: "MAX_POOL_2D",
    18: "MUL", 19: "RELU", 22: "RESHAPE", 25: "SOFTMAX", 34: "PAD",
    40: "MEAN", 114: "QUANTIZE", 6: "DEQUANTIZE",
}

PADDING = {0: "SAME", 1: "VALID"}
ACTIVATION = {0: "NONE", 1: "RELU", 2: "RELU_N1_TO_1", 3: "RELU6"}


# ---------------------------------------------------------------------
#  Yuksek seviye model modeli (duz sozluk/nesne)
# ---------------------------------------------------------------------
class Tensor:
    def __init__(self, t, buffers):
        self.shape = t.vec_i32(0)
        self.type = TENSOR_TYPE.get(t.u8f(1), f"?{t.u8f(1)}")
        self.buffer_idx = t.u32f(2)
        self.name = t.string(3) or ""
        self.data = buffers[self.buffer_idx]

        q = t.table(4)
        if q is not None:
            self.scale = q.vec_f32(2)
            self.zero_point = q.vec_i64(3)
            self.quantized_dimension = q.i32f(6, 0)
        else:
            self.scale, self.zero_point, self.quantized_dimension = [], [], 0

    @property
    def count(self):
        n = 1
        for s in self.shape:
            n *= s
        return n

    def __repr__(self):
        q = ""
        if self.scale:
            q = (f" scale[{len(self.scale)}]={self.scale[0]:.8g}"
                 f" zp={self.zero_point[0] if self.zero_point else 0}")
        return (f"{self.name!r} {self.type} {self.shape}"
                f" buf={self.buffer_idx}({len(self.data)}B){q}")


class Operator:
    def __init__(self, op, opcodes):
        self.opcode_index = op.u32f(0)
        self.opcode = opcodes[self.opcode_index]
        self.inputs = op.vec_i32(1)
        self.outputs = op.vec_i32(2)
        self.options = {}

        opts = op.table(4)          # slot 3 = union tipi, slot 4 = deger
        if opts is None:
            return
        if self.opcode == "CONV_2D":
            self.options = {
                "padding": PADDING.get(opts.u8f(0), "?"),
                "stride_w": opts.i32f(1),
                "stride_h": opts.i32f(2),
                "activation": ACTIVATION.get(opts.u8f(3), "?"),
                "dilation_w": opts.i32f(4, 1),
                "dilation_h": opts.i32f(5, 1),
            }
        elif self.opcode == "DEPTHWISE_CONV_2D":
            self.options = {
                "padding": PADDING.get(opts.u8f(0), "?"),
                "stride_w": opts.i32f(1),
                "stride_h": opts.i32f(2),
                "depth_multiplier": opts.i32f(3),
                "activation": ACTIVATION.get(opts.u8f(4), "?"),
            }
        elif self.opcode == "FULLY_CONNECTED":
            self.options = {
                "activation": ACTIVATION.get(opts.u8f(0), "?"),
                "weights_format": opts.u8f(1),
                "keep_num_dims": bool(opts.u8f(2)),
            }
        elif self.opcode == "SOFTMAX":
            self.options = {"beta": opts.scalar(0, opts.buf.f32, 1.0)}


class Model:
    def __init__(self, tensors, operators, inputs, outputs, version, desc):
        self.tensors = tensors
        self.operators = operators
        self.inputs = inputs
        self.outputs = outputs
        self.version = version
        self.description = desc

    def op(self, name):
        """Verilen tipteki TEK operatoru dondurur (yoksa/birden fazlaysa hata)."""
        hits = [o for o in self.operators if o.opcode == name]
        if len(hits) != 1:
            raise SystemExit(f"HATA: modelde {len(hits)} adet {name} var, 1 bekleniyordu")
        return hits[0]


def parse_model(path):
    data = open(path, "rb").read()
    if data[4:8] != b"TFL3":
        raise SystemExit(f"HATA: {path}: TFL3 imzasi yok "
                         f"(bulunan: {data[4:8]!r}) -- bu bir .tflite degil")

    buf = Buf(data)
    root = Table(buf, buf.indirect(0))

    version = root.u32f(0)
    opcode_tabs = root.vec_table(1)
    subgraphs = root.vec_table(2)
    description = root.string(3)
    buffer_tabs = root.vec_table(4)

    # Buffer 0 semaya gore daima bostur; veri tasimayan tensorler onu gosterir.
    buffers = [b.vec_bytes(0) for b in buffer_tabs]

    opcodes = []
    for oc in opcode_tabs:
        # builtin_code (slot 3, int32) yeni alan; eski dosyalarda 0 gelir ve
        # gercek deger deprecated_builtin_code'dadir (slot 0, byte).
        code = oc.i32f(3, 0) or oc.i8f(0, 0)
        opcodes.append(oc.string(1) or BUILTIN_OP.get(code, f"OP_{code}"))

    if len(subgraphs) != 1:
        raise SystemExit(f"HATA: {len(subgraphs)} subgraph var, 1 bekleniyordu")
    sg = subgraphs[0]

    tensors = [Tensor(t, buffers) for t in sg.vec_table(0)]
    operators = [Operator(o, opcodes) for o in sg.vec_table(3)]

    return Model(tensors, operators, sg.vec_i32(1), sg.vec_i32(2),
                 version, description)


# ---------------------------------------------------------------------
#  Dokum
# ---------------------------------------------------------------------
def dump(m, full=False):
    print(f"surum      : {m.version}")
    print(f"aciklama   : {m.description}")
    print(f"tensor     : {len(m.tensors)}")
    print(f"operator   : {len(m.operators)}")
    print(f"giris/cikis: {m.inputs} / {m.outputs}\n")

    for i, o in enumerate(m.operators):
        print(f"[{i}] {o.opcode}  {o.options if o.options else ''}")
        for tag, idxs in (("  giris ", o.inputs), ("  cikis ", o.outputs)):
            for ti in idxs:
                if ti < 0:                    # -1 = opsiyonel girdi yok (orn. bias)
                    print(f"{tag} (yok)")
                    continue
                print(f"{tag} #{ti:<3} {m.tensors[ti]}")
        print()

    if not full:
        return

    print("--- tum tensorler ---")
    for i, t in enumerate(m.tensors):
        print(f"#{i:<3} {t}")
        if t.scale and len(t.scale) > 1:
            print(f"      per-channel scale ({len(t.scale)} kanal, "
                  f"quantized_dim={t.quantized_dimension}):")
            print("      " + ", ".join(f"{s:.8g}" for s in t.scale))


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("model", help=".tflite dosyasi")
    ap.add_argument("--dump", action="store_true", help="tum tensorleri de bas")
    args = ap.parse_args()

    dump(parse_model(args.model), full=args.dump)
    return 0


if __name__ == "__main__":
    sys.exit(main())
