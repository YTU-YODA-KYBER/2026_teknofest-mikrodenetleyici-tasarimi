#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  gen_versions.py -- asic/environment/versions.txt dosyasini uretir
#
#  Sartname Bolum 1.4 bu dosyada su bilgileri zorunlu tutuyor:
#    LibreLane surumu / commit kimligi / akis adi, PDK adi, Open PDKs commit'i,
#    standart hucre kutuphanesi, OpenRAM surumu (veya kullanilmadigi ifadesi)
#    ve akisi calistirmak icin gerekli komutlar.
#
#  Arac surumleri ortamdan OKUNUR, elle yazilmaz -- boylece dosya her zaman
#  fiilen kullanilan araci gosterir.
# ---------------------------------------------------------------------------
import json
import os
import pathlib
import re
import subprocess
import sys

ASIC = pathlib.Path(__file__).resolve().parent.parent


def sh(cmd, pat=None, first_line=True):
    try:
        out = subprocess.run(cmd, shell=True, capture_output=True, text=True,
                             timeout=90).stdout.strip()
    except Exception:
        return "(alinamadi)"
    if not out:
        return "(alinamadi)"
    if pat:
        m = re.search(pat, out)
        if m:
            return m.group(1) if m.groups() else m.group(0)
    return out.splitlines()[0].strip() if first_line else out


def flake_lock():
    p = ASIC / "environment" / "flake.lock"
    if not p.is_file():
        return {}
    d = json.load(open(p))
    out = {}
    for name, node in d.get("nodes", {}).items():
        loc = node.get("locked", {})
        if loc.get("rev"):
            out[name] = (f"{loc.get('owner','')}/{loc.get('repo','')}", loc["rev"])
    return out


def main():
    lock = flake_lock()
    ll_repo, ll_rev = lock.get("librelane", ("librelane/librelane", "(bilinmiyor)"))
    pdk_commit = os.environ.get(
        "SKY130_OPEN_PDKS_COMMIT", "8afc8346a57fe1ab7934ba5a6056ea8b43078e71")
    pdk_root = os.environ.get("PDK_ROOT", "(tanimsiz)")

    tools = [
        ("LibreLane", sh("librelane --version", r"LibreLane v?([\w.]+)")),
        ("Yosys",     sh("yosys -V", r"Yosys ([\w.+]+)")),
        ("yosys-slang", "LibreLane 3.0.6 ortamiyla birlikte gelen surum (USE_SLANG=true)"),
        ("OpenROAD",  sh("openroad -version")),
        ("OpenSTA",   sh("sta -version")),
        ("Magic",     sh("magic --version")),
        ("KLayout",   sh("klayout -v", r"([\d.]+)")),
        ("Netgen",    sh("netgen -batch quit 2>&1 | head -3", r"Netgen ([\d.]+)")),
        ("Verilator", sh("verilator --version", r"Verilator ([\d.]+)")),
        ("ciel",      sh("ciel --version")),
        ("Nix",       sh("nix --version")),
    ]

    lines = []
    A = lines.append
    A("===========================================================================")
    A(" YTU YODA KYBER -- TEKNOFEST 2026 Cip Tasarim Yarismasi (Mikrodenetleyici)")
    A(" ASIC fiziksel tasarim akisi -- arac, PDK ve ortam surumleri")
    A("")
    A(" Bu dosya asic/scripts/gen_versions.py tarafindan uretilir; arac surumleri")
    A(" fiilen kurulu ortamdan okunur.")
    A("===========================================================================")
    A("")
    A("--- AKIS ARACI (sartname Bolum 1.1) ---------------------------------------")
    A(f"LibreLane surumu          : 3.0.6")
    A(f"LibreLane commit kimligi  : {ll_rev}")
    A(f"LibreLane deposu          : github.com/{ll_repo}  (etiket: 3.0.6)")
    A(f"Kullanilan LibreLane akisi: Classic")
    A( "Ozel akis / ozel adim     : YOK -- yalnizca standart Classic akisi kullanildi")
    A("")
    A("--- PDK (sartname Bolum 1.2) ----------------------------------------------")
    A( "PDK ailesi / varyanti     : sky130 / sky130A")
    A(f"Open PDKs commit kimligi  : {pdk_commit}")
    A( "Standart hucre kutuphanesi: sky130_fd_sc_hd")
    A( "PDK paket yoneticisi      : ciel")
    # Sartname Bolum 3/8: teslim edilen dosyalarda makineye ozgu MUTLAK YOL
    # olamaz. Bu yuzden yerel PDK_ROOT degeri YAZILMAZ; yalnizca degiskenin
    # tanimli olup olmadigi ve PDK'nin dogru commit'te oldugu raporlanir.
    A(f"PDK_ROOT                  : ortam degiskeninden alinir "
      f"({'tanimli' if pdk_root != '(tanimsiz)' else 'TANIMSIZ'})")
    A( "Kurulum komutu            : ciel enable --pdk-family sky130 \\")
    A(f"                              {pdk_commit}")
    A("")
    A("--- SRAM (sartname Bolum 1.3) ---------------------------------------------")
    A( "OpenRAM surumu            : OpenRAM kullanilmadi")
    A( "                            Kullanilan SRAM makrolari referans SKY130 PDK")
    A( "                            kurulumu icinde hazir gelen, onaylanmis")
    A( "                            makrolardir (Tablo 5):")
    A( "                              sky130_sram_2kbyte_1rw1r_32x512_8   x14")
    A( "                              sky130_sram_1kbyte_1rw1r_32x256_8   x1")
    A("")
    A("--- ORTAM (sartname Bolum 1.4) --------------------------------------------")
    A( "Ortam yonetimi            : Nix (flake)")
    A( "Ortam tanimi              : asic/environment/flake.nix + flake.lock")
    for name, rev in sorted(lock.items()):
        A(f"  {name:24s}: {rev[0]} @ {rev[1]}")
    A("")
    A("--- ARAC SURUMLERI (ortamdan okundu) --------------------------------------")
    for n, v in tools:
        A(f"{n:26s}: {v}")
    A("")
    A("--- AKISI CALISTIRMA KOMUTLARI --------------------------------------------")
    A( "  # 1) Nix ve LibreLane ortamini hazirla (bir kez):")
    A( "  curl --proto '=https' --tlsv1.2 -fsSL https://artifacts.nixos.org/nix-installer \\")
    A( "     | sh -s -- install --no-confirm --extra-conf \"")
    A( "         extra-substituters = https://nix-cache.fossi-foundation.org")
    A( "         extra-trusted-public-keys = nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs=")
    A( "         extra-experimental-features = nix-command flakes\"")
    A("")
    A( "  # 2) PDK'yi kur:")
    A(f"  export PDK_ROOT=<pdk dizini>")
    A( "  nix develop ./environment --command \\")
    A(f"     ciel enable --pdk-family sky130 {pdk_commit}")
    A("")
    A( "  # 3) Akisi calistir (asic/ dizininden):")
    A( "  nix develop ./environment")
    A( "  make asic_run")
    A("")
    A( "  # Ek hedefler:")
    A( "  make asic_verify    # teslim paketini denetle")
    A( "  make asic_clean     # asic/run/ altini temizle")
    A("")

    metin = "\n".join(lines)
    # Sartname bu dosyayi iki yerde listeler: Tablo 8 asic/environment/,
    # Tablo 9 genel akis raporlari arasinda. Ikisine de yazilir.
    for out in (ASIC / "environment" / "versions.txt",
                ASIC / "reports" / "general" / "versions.txt"):
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(metin)
        print(f"{out} yazildi ({len(lines)} satir)")


if __name__ == "__main__":
    sys.exit(main())
