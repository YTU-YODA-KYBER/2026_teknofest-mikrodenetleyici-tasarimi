#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  collect.py -- LibreLane calisma dizinindeki ciktilari sartnamenin istedigi
#                asic/reports/ ve asic/results/ agacina tasir.
#
#  Kaynak : asic/run/<etiket>/            (gecici, yeniden uretilebilir)
#  Hedef  : asic/reports/**, asic/results/**   (teslim edilen kalici cikti)
#
#  Eslemeler sartname Tablo 9-18'e gore yapilir. Bir kaynak bulunamazsa betik
#  bunu EKSIK olarak bildirir ve (zorunlu bir cikti ise) sifirdan farkli kodla
#  biter -- boylece eksik teslim sessizce gecmez.
# ---------------------------------------------------------------------------
import argparse
import glob
import json
import os
import pathlib
import shutil
import sys

ASIC = pathlib.Path(__file__).resolve().parent.parent


class Collector:
    def __init__(self, run_dir: pathlib.Path):
        self.run = run_dir
        self.copied, self.missing_req, self.missing_opt = [], [], []

    # -- yardimcilar --------------------------------------------------------
    def step(self, pattern: str):
        """Adim dizinini ada gore bulur (or. '*-yosys-synthesis')."""
        hits = sorted(self.run.glob(pattern))
        return hits[-1] if hits else None

    def copy(self, src, dst_rel: str, required=True, rename=None):
        dst = ASIC / dst_rel
        srcs = []
        if src is None:
            srcs = []
        elif isinstance(src, (list, tuple)):
            srcs = [pathlib.Path(s) for s in src]
        elif "*" in str(src):
            srcs = [pathlib.Path(p) for p in sorted(glob.glob(str(src)))]
        elif pathlib.Path(src).exists():
            srcs = [pathlib.Path(src)]
        if not srcs:
            (self.missing_req if required else self.missing_opt).append(
                f"{dst_rel}  <- {src}")
            return False
        dst.mkdir(parents=True, exist_ok=True)
        for s in srcs:
            if s.is_dir():
                shutil.copytree(s, dst / s.name, dirs_exist_ok=True)
                self.copied.append(f"{dst_rel}/{s.name}/")
            else:
                name = rename or s.name
                shutil.copy2(s, dst / name)
                self.copied.append(f"{dst_rel}/{name}")
        return True

    def copy_tree_of_corners(self, step_dir, dst_rel, required=True):
        """STA/guc adimlarinda her corner icin ayri alt dizin uretilir."""
        if step_dir is None:
            self.missing_req.append(f"{dst_rel} (adim bulunamadi)")
            return
        n = 0
        for sub in sorted(p for p in step_dir.iterdir() if p.is_dir()):
            self.copy(str(sub), dst_rel, required=False)
            n += 1
        if n == 0 and required:
            self.missing_req.append(f"{dst_rel} (corner dizini yok)")

    # -- ana esleme ---------------------------------------------------------
    def run_all(self):
        R = self.run

        # ---------- 5.1 Genel akis raporlari (Tablo 9) ----------
        for f in ("flow.log", "warning.log", "error.log", "resolved.json"):
            self.copy(R / f, "reports/general")
        final = R / "final"
        self.copy(final / "metrics.csv", "reports/general")
        self.copy(final / "metrics.json", "reports/general")

        # ---------- 5.2 Lint (Tablo 10) ----------
        lint = self.step("*-verilator-lint")
        if lint:
            self.copy(lint / "verilator-lint.log", "reports/lint",
                      rename="verilator_lint.log")
        else:
            self.missing_req.append("reports/lint/verilator_lint.log")

        # ---------- 5.3 Sentez (Tablo 11) ----------
        synth = self.step("*-yosys-synthesis")
        if synth:
            for f in ("stat.rpt", "stat.json", "latch.rpt",
                      "pre_synth_chk.rpt", "chk.rpt"):
                self.copy(synth / "reports" / f, "reports/synthesis")
        else:
            self.missing_req.append("reports/synthesis/*")

        # ---------- 5.4 Fiziksel tasarim (Tablo 12) ----------
        wl = self.step("*-odb-reportwirelength")
        if wl:
            self.copy(str(wl / "*wire_lengths*"), "reports/routing")
        drt = self.step("*-openroad-detailedrouting")
        if drt:
            self.copy(str(drt / "*.drc"), "reports/routing", required=False)
            self.copy(str(drt / "reports" / "*"), "reports/routing", required=False)
        grt = self.step("*-openroad-globalrouting")
        if grt:
            self.copy(str(grt / "reports" / "*"), "reports/routing", required=False)

        # ---------- 5.5 Zamanlama (Tablo 13) ----------
        sta = self.step("*-openroad-stapostpnr")
        if sta:
            self.copy(sta / "summary.rpt", "reports/timing")
            self.copy_tree_of_corners(sta, "reports/timing")
        else:
            self.missing_req.append("reports/timing/* (STAPostPNR adimi yok)")

        # ---------- 5.6 Fiziksel signoff (Tablo 14) ----------
        mdrc = self.step("*-magic-drc")
        if mdrc:
            self.copy(str(mdrc / "*.rpt"), "reports/drc", required=False)
            self.copy(str(mdrc / "*.lyrdb"), "reports/drc", required=False)
        kdrc = self.step("*-klayout-drc")
        if kdrc:
            self.copy(str(kdrc / "*.lyrdb"), "reports/drc", required=False)
            self.copy(str(kdrc / "*.json"), "reports/drc", required=False)
        lvs = self.step("*-netgen-lvs")
        if lvs:
            self.copy(str(lvs / "*.rpt"), "reports/lvs", required=False)
            self.copy(str(lvs / "*.json"), "reports/lvs", required=False)
        for pat in ("*-openroad-checkantennas-1", "*-openroad-checkantennas"):
            ant = self.step(pat)
            if ant:
                self.copy(str(ant / "*.rpt"), "reports/antenna", required=False)
                self.copy(str(ant / "reports" / "*"), "reports/antenna", required=False)
                break
        dp = self.step("*-odb-reportdisconnectedpins")
        if dp:
            self.copy(str(dp / "*disconnected*"), "reports/signoff", required=False)
        pdn = self.step("*-openroad-generatepdn")
        if pdn:
            self.copy(str(pdn / "*grid-errors*"), "reports/pdn", required=False)
        xor_ = self.step("*-klayout-xor")
        if xor_:
            self.copy(str(xor_ / "*.xml"), "reports/signoff", required=False)
        man = self.step("*-misc-reportmanufacturability")
        if man:
            self.copy(str(man / "*.rpt"), "reports/signoff", required=False)

        # ---------- 5.7 Guc ve IR-drop (Tablo 15) ----------
        if sta:
            for sub in sorted(p for p in sta.iterdir() if p.is_dir()):
                self.copy(str(sub / "power.rpt"), f"reports/power/{sub.name}",
                          required=False)
        ir = self.step("*-openroad-irdropreport")
        if ir:
            self.copy(str(ir / "*.rpt"), "reports/power", required=False)
            self.copy(str(ir / "*.csv"), "reports/power", required=False)

        # ---------- 6.1 + 6.2 + 6.3 Nihai ciktilar (Tablo 16-18) ----------
        # LibreLane final/ dizinini tur bazinda duzenler.
        m = {
            "gds": "results/gds", "lef": "results/lef", "def": "results/def",
            "nl": "results/netlist", "pnl": "results/netlist",
            "sdc": "results/sdc", "spef": "results/spef", "spice": "results/spice",
            "odb": "results/odb", "sdf": "results/sdf", "lib": "results/lib",
            "mag": "results/mag", "json_h": "results/netlist",
        }
        for sub, dst in m.items():
            self.copy(str(final / sub / "*"), dst, required=sub in ("gds", "lef", "def", "nl"))
        self.copy(str(final / "*.png"), "results/images", required=False)
        self.copy(str(final / "*" / "*.png"), "results/images", required=False)
        self.copy(R / "resolved.json", "results/config")
        self.copy(final / "metrics.csv", "results/metrics")
        self.copy(final / "metrics.json", "results/metrics")

        # KLayout render goruntusu ayri adimda uretilir
        ren = self.step("*-klayout-render")
        if ren:
            self.copy(str(ren / "*.png"), "results/images", required=False)

    # -- ozet ---------------------------------------------------------------
    def report(self):
        print(f"\n{'='*70}")
        print(f"  Toplanan dosya : {len(self.copied)}")
        if self.missing_opt:
            print(f"  Eksik (istege bagli): {len(self.missing_opt)}")
            for m in self.missing_opt[:10]:
                print(f"     - {m}")
        if self.missing_req:
            print(f"  EKSIK (ZORUNLU): {len(self.missing_req)}")
            for m in self.missing_req:
                print(f"     ! {m}")
        print(f"{'='*70}\n")
        return 1 if self.missing_req else 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--run-dir", required=True, type=pathlib.Path)
    ap.add_argument("--allow-missing", action="store_true",
                    help="eksik zorunlu cikti olsa da 0 ile bit (ara kosular icin)")
    a = ap.parse_args()
    if not a.run_dir.is_dir():
        sys.exit(f"HATA: calisma dizini yok: {a.run_dir}")
    c = Collector(a.run_dir)
    c.run_all()
    rc = c.report()
    return 0 if a.allow_missing else rc


if __name__ == "__main__":
    sys.exit(main())
