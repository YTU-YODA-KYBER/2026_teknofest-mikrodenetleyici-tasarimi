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


# LibreLane'in uretmedigi, takim tarafindan yazilan raporlar. Bunlar toplama
# oncesi temizlikten MUAFTIR (bkz. Collector._clean docstring'i).
HAND_MAINTAINED = {
    "reports/timing/frekans_kalibrasyonu.md",
    "reports/timing/frekans_kalibrasyonu.json",
    # Sartname Tablo 8 bu dizini listeliyor; waiver kullanilmadigini aciklayan
    # not LibreLane ciktisi degildir, temizlikten muaftir.
    "reports/lint/waivers",
}


class Collector:
    def __init__(self, run_dir: pathlib.Path):
        self.run = run_dir
        self.copied, self.missing_req, self.missing_opt = [], [], []

    def clear_generated_destinations(self):
        """Onceki kosumun dosyalarinin yeni kosumu sahte tamamlamasini onle.

        Elle tutulan strateji/dogrulama notlari ile asic_sim loglari korunur;
        yalniz LibreLane'den yeniden uretilebilen hedefler temizlenir. Akis bu
        betikten once basariyla tamamlandigi icin eksik yeni kaynak varsa eski
        tape-out dosyasina geri dusmek yerine collector acikca hata verir.

        HAND_MAINTAINED: LibreLane'in URETMEDIGI, takimin yazdigi raporlar
        temizlenen dizinlerin ICINDE durabilir (or. frekans kalibrasyonu
        reports/timing/ altindadir cunku sartname Bolum 5.5 zamanlama
        raporlarini oraya istiyor). Bunlar silinmez.
        """
        for rel in (
            "reports/lint", "reports/pdn", "reports/routing", "reports/timing",
            "reports/drc", "reports/lvs", "reports/antenna", "reports/signoff",
            "reports/power",
            "results/gds", "results/lef", "results/def", "results/netlist",
            "results/sdc", "results/spef", "results/spice", "results/odb",
            "results/sdf", "results/lib", "results/mag", "results/images",
            "results/config", "results/metrics",
        ):
            p = ASIC / rel
            if p.is_symlink():
                raise RuntimeError(f"Guvenlik: toplanacak hedef symlink olamaz: {p}")
            if p.is_dir():
                for child in p.iterdir():
                    if str(child.relative_to(ASIC)) in HAND_MAINTAINED:
                        continue
                    if child.is_dir() and not child.is_symlink():
                        shutil.rmtree(child)
                    else:
                        child.unlink()
        for rel in (
            "reports/general/flow.log", "reports/general/warning.log",
            "reports/general/error.log", "reports/general/resolved.json",
            "reports/general/metrics.csv", "reports/general/metrics.json",
            "reports/synthesis/stat.rpt", "reports/synthesis/stat.json",
            "reports/synthesis/latch.rpt", "reports/synthesis/pre_synth_chk.rpt",
            "reports/synthesis/chk.rpt",
        ):
            p = ASIC / rel
            if p.is_file() or p.is_symlink():
                p.unlink()

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
        self.clear_generated_destinations()
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
            # SENTEZ SONRASI NETLIST (sartname Tablo 17: <tasarim_adi>_synth.v)
            #
            # LibreLane'in final/ agacinda YOKTUR:
            #   final/nl/  = post-PnR netlist
            #   final/pnl/ = powered post-PnR netlist
            # Sentez netlisti yalnizca bu adim klasorunde durur; run/ teslimde
            # bosaltildigi icin buradan alinmazsa KALICI OLARAK KAYBOLUR.
            self.copy(str(synth / "*.nl.v"), "results/netlist",
                      rename="top_module_synth.v")
        else:
            self.missing_req.append("reports/synthesis/*")

        # ---------- 5.4 Fiziksel tasarim (Tablo 12) ----------
        wl = self.step("*-odb-reportwirelength")
        if wl:
            self.copy(str(wl / "*wire_lengths*"), "reports/routing")
        drt = self.step("*-openroad-detailedrouting")
        if drt:
            self.copy(str(drt / "drt-run-*" / "*.drc"), "reports/routing")
            self.copy(str(drt / "reports" / "*"), "reports/routing", required=False)
        else:
            self.missing_req.append("reports/routing/* (DetailedRouting adimi yok)")
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
            self.copy(str(mdrc / "reports" / "*.rpt"), "reports/drc")
            self.copy(str(mdrc / "reports" / "*.lyrdb"), "reports/drc")
        else:
            self.missing_req.append("reports/drc/*magic* (Magic.DRC adimi yok)")
        kdrc = self.step("*-klayout-drc")
        if kdrc:
            self.copy(str(kdrc / "reports" / "*.lyrdb"), "reports/drc")
            self.copy(str(kdrc / "reports" / "*.json"), "reports/drc")
        else:
            self.missing_req.append("reports/drc/*klayout* (KLayout.DRC adimi yok)")
        lvs = self.step("*-netgen-lvs")
        if lvs:
            self.copy(str(lvs / "reports" / "*.rpt"), "reports/lvs")
            self.copy(str(lvs / "reports" / "*.json"), "reports/lvs")
        else:
            self.missing_req.append("reports/lvs/* (Netgen.LVS adimi yok)")
        for pat in ("*-openroad-checkantennas-1", "*-openroad-checkantennas"):
            ant = self.step(pat)
            if ant:
                self.copy(str(ant / "*.rpt"), "reports/antenna", required=False)
                self.copy(str(ant / "reports" / "*"), "reports/antenna")
                break
        else:
            self.missing_req.append("reports/antenna/* (CheckAntennas adimi yok)")
        dp = self.step("*-odb-reportdisconnectedpins")
        if dp:
            self.copy(str(dp / "*disconnected*"), "reports/signoff")
        else:
            self.missing_req.append("reports/signoff/*disconnected* (adim yok)")
        pdn = self.step("*-openroad-generatepdn")
        if pdn:
            self.copy(str(pdn / "*grid-errors*"), "reports/pdn")
        else:
            self.missing_req.append("reports/pdn/*grid-errors* (GeneratePDN adimi yok)")
        xor_ = self.step("*-klayout-xor")
        if xor_:
            self.copy(str(xor_ / "*.xml"), "reports/signoff")
        else:
            self.missing_req.append("reports/signoff/*.xml (KLayout.XOR adimi yok)")
        man = self.step("*-misc-reportmanufacturability")
        if man:
            self.copy(str(man / "*.rpt"), "reports/signoff")
        else:
            self.missing_req.append("reports/signoff/*manufacturability* (adim yok)")

        # ---------- 5.7 Guc ve IR-drop (Tablo 15) ----------
        if sta:
            for sub in sorted(p for p in sta.iterdir() if p.is_dir()):
                self.copy(str(sub / "power.rpt"), f"reports/power/{sub.name}",
                          required=True)
        ir = self.step("*-openroad-irdropreport")
        if ir:
            self.copy(str(ir / "*.rpt"), "reports/power")
            self.copy(str(ir / "*.csv"), "reports/power")
        else:
            self.missing_req.append("reports/power/irdrop* (IRDropReport adimi yok)")

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
            self.copy(str(final / sub / "*"), dst,
                      required=sub in ("gds", "lef", "def", "nl", "pnl",
                                       "sdc", "spef", "spice"))
        # Iki bagimsiz stream-out gorunumu teslime onerilir; ana GDS zorunlu
        # kalmaya devam eder, bunlar ek capraz-kontrol ciktisidir.
        self.copy(str(final / "mag_gds" / "*"), "results/gds", required=False)
        self.copy(str(final / "klayout_gds" / "*"), "results/gds", required=False)
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

    # Teslim edilen ciktilari HANGI kosumun urettigi, Final Ciktilar Bolum 6
    # geregi README'de beyan edilmek zorundadir. Elle yazilan bir etiket
    # kaciniLmaz olarak bayatlar (bu depoda birden fazla kez yasandi), bu
    # yuzden etiketi kosum dizininden TURETIP dosyaya yaziyoruz;
    # verify_deliverables.py README ile tutarliligini denetler.
    c.run_all()
    # run_all() onceki kosumdan kalan results/config/ icerigini temizler.
    # Etiketi temizlikten SONRA yaz; aksi halde dosya yazildigi anda silinir.
    tag_file = ASIC / "results" / "config" / "run_tag.txt"
    tag_file.parent.mkdir(parents=True, exist_ok=True)
    tag_file.write_text(a.run_dir.resolve().name + "\n")
    print(f"  Kosum etiketi kaydedildi: {a.run_dir.resolve().name}")
    rc = c.report()
    return 0 if a.allow_missing else rc


if __name__ == "__main__":
    sys.exit(main())
