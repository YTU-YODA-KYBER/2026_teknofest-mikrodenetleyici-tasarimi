#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  gen_checksums.py -- teslim edilen zorunlu ciktilarin SHA-256 ozetlerini uretir
#  Cikti: asic/checksums/SHA256SUMS   (sartname Bolum 6.3, Tablo 18)
#
#  Kapsam: asic/results/ ve asic/reports/ altindaki butun dosyalar ile
#          asic/ kokundeki yapilandirma/otomasyon girdileri.
#  Yollar asic/ dizinine gorelidir; `sha256sum -c SHA256SUMS` ile dogrulanabilir.
# ---------------------------------------------------------------------------
import hashlib
import pathlib

ASIC = pathlib.Path(__file__).resolve().parent.parent
ROOTS = ["results", "reports", "macros", "constraints", "environment", "scripts"]
FILES = ["config.yaml", "filelist.f", "Makefile", "README.md", "THIRD_PARTY.md"]


def sha256(p: pathlib.Path) -> str:
    h = hashlib.sha256()
    with open(p, "rb") as f:
        for blk in iter(lambda: f.read(1 << 20), b""):
            h.update(blk)
    return h.hexdigest()


def main():
    out = ASIC / "checksums" / "SHA256SUMS"
    out.parent.mkdir(parents=True, exist_ok=True)

    targets = []
    for r in ROOTS:
        d = ASIC / r
        if d.is_dir():
            targets += [p for p in sorted(d.rglob("*"))
                        if p.is_file() and "__pycache__" not in p.parts]
    for f in FILES:
        p = ASIC / f
        if p.is_file():
            targets.append(p)

    lines = [f"{sha256(p)}  {p.relative_to(ASIC)}" for p in sorted(set(targets))]
    out.write_text("\n".join(lines) + "\n")
    total = sum(p.stat().st_size for p in set(targets))
    print(f"checksums/SHA256SUMS: {len(lines)} dosya, {total/1e6:.1f} MB")


if __name__ == "__main__":
    main()
