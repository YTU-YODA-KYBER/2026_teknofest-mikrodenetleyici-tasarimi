# ---------------------------------------------------------------------------
#  YTU YODA KYBER - TEKNOFEST 2026 Cip Tasarim Yarismasi (Mikrodenetleyici)
#  ASIC fiziksel tasarim akisi calisma ortami.
#
#  Yarismanin referans akis araci LibreLane 3.0.6'ya pinlenmistir; bu dosya ve
#  yanindaki flake.lock, akista kullanilan butun araclarin (Yosys, OpenROAD,
#  Magic, KLayout, Netgen, Verilator, OpenSTA, ciel) surumlerini sabitler.
#
#  Kullanim (asic/ dizininden):
#     nix develop ./environment      -> ortama gir
#     make asic_run                  -> akisi calistir
#
#  NOT: PDK surumu bu dosyayla degil, `ciel` ile ayrica sabitlenir.
#       Referans Open PDKs commit'i asic/environment/versions.txt icindedir.
# ---------------------------------------------------------------------------
{
  description = "YODA KYBER ASIC akisi - LibreLane 3.0.6 / SKY130A";

  inputs = {
    librelane.url = "github:librelane/librelane/3.0.6";
  };

  outputs = { self, librelane, ... }: {
    # LibreLane'in kendi cikti agacini oldugu gibi disari veriyoruz; boylece
    # `nix develop ./environment` referans ortamin BIREBIR aynisini kurar.
    devShells = librelane.devShells;
    packages  = librelane.packages;
    overlays  = librelane.overlays;
  };
}
