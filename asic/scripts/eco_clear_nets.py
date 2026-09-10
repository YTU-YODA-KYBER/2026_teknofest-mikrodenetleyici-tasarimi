#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  eco_clear_nets.py -- verilen aglarin mevcut ayrintili rotasini ODB'den siler.
#
#  NEDEN: Post-route ECO'dan sonra DetailedRouting ZATEN YOLLANMIS bir veri
#  tabani uzerinde artimli calisir. TritonRoute bazi aglari kismen sokup
#  yeniden yollar ve eski dogleg parcalari ULASILAMAZ ADA olarak kalir; sonuc
#  [DRT-0206] checkConnectivity hatasidir (ornek: "netNNNN 1 pin not visited").
#
#  Bu betik yalniz ADI VERILEN aglarin dbWire'ini yok eder. Netlist, yerlesim,
#  guide'lar ve diger tum aglar dokunulmaz kalir; DRT o aglari guide'lardan
#  sifirdan yollar. Hicbir kontrol esigi veya kisit degismez.
#
#  Kullanim:
#    openroad -exit -no_splash -python scripts/eco_clear_nets.py \
#        --in <giris.odb> --out <cikis.odb> --nets net11187 net22751
#    (--nets yerine --from-drt-log <log> verilirse adlar logdan cikarilir)
# ---------------------------------------------------------------------------
import argparse
import re
import sys

import odb

# TritonRoute'un checkConnectivity hata satiri:
#   Error: net11187 1 pin not visited #guides = 23
_NOT_VISITED = re.compile(r"^Error:\s+(\S+)\s+\d+\s+pin not visited", re.M)
_BREAK = re.compile(r"^Error:\s+checkConnectivity break, net\s+(\S+)", re.M)


def nets_from_log(path):
    text = open(path, errors="replace").read()
    names = set(_NOT_VISITED.findall(text)) | set(_BREAK.findall(text))
    return sorted(names)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--in", dest="odb_in", required=True)
    ap.add_argument("--out", dest="odb_out", required=True)
    ap.add_argument("--nets", nargs="*", default=[])
    ap.add_argument("--from-drt-log", default=None)
    args = ap.parse_args()

    names = list(args.nets)
    if args.from_drt_log:
        names += nets_from_log(args.from_drt_log)
    names = sorted(set(names))
    if not names:
        print("eco_clear_nets: temizlenecek ag yok", file=sys.stderr)
        return 1

    db = odb.dbDatabase.create()
    odb.read_db(db, args.odb_in)
    block = db.getChip().getBlock()

    cleared = missing = already = 0
    for name in names:
        net = block.findNet(name)
        if net is None:
            print(f"  ! ag bulunamadi: {name}")
            missing += 1
            continue
        wire = net.getWire()
        if wire is None:
            already += 1
            continue
        length = wire.getLength()
        odb.dbWire.destroy(wire)
        print(f"  - {name}: {length} DBU rota silindi")
        cleared += 1

    print(f"eco_clear_nets: {cleared} ag temizlendi, "
          f"{already} zaten rotasiz, {missing} bulunamadi")
    odb.write_db(db, args.odb_out)
    print(f"eco_clear_nets: yazildi -> {args.odb_out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
