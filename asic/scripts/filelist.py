#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  filelist.py -- asic/filelist.f ayristirici (diger betikler bunu kullanir)
#
#  filelist.f, ASIC akisinin TEK dogruluk kaynagidir; LibreLane yapilandirmasi
#  (config.yaml -> VERILOG_FILES) ve simulasyon betikleri dosya listesini
#  buradan turetir. Boylece sartnamenin "LibreLane yapilandirmasinda kullanilan
#  RTL kaynaklari ile filelist.f icerigi birbiriyle uyumlu olmalidir" sarti
#  yapisal olarak saglanir.
# ---------------------------------------------------------------------------
import pathlib

ASIC_DIR = pathlib.Path(__file__).resolve().parent.parent


def parse(path=None):
    """filelist.f -> (include dizinleri, kaynak dosyalar) -- ikisi de mutlak yol."""
    fl = pathlib.Path(path) if path else (ASIC_DIR / "filelist.f")
    base = fl.parent
    incdirs, files = [], []
    for raw in fl.read_text().splitlines():
        line = raw.split("#", 1)[0].strip()
        if not line:
            continue
        if line.startswith("+incdir+"):
            incdirs.append((base / line[len("+incdir+"):]).resolve())
        elif line.startswith("+") or line.startswith("-"):
            continue                      # baska secenekler kullanilmiyor
        else:
            p = (base / line).resolve()
            if not p.is_file():
                raise SystemExit(f"HATA: filelist.f icindeki dosya yok: {line}")
            files.append(p)
    return incdirs, files


if __name__ == "__main__":
    inc, src = parse()
    print(f"include dizini : {len(inc)}")
    for i in inc:
        print(f"   {i}")
    print(f"kaynak dosya   : {len(src)}")
