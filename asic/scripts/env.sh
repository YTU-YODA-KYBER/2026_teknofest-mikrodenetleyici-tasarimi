# ---------------------------------------------------------------------------
#  ASIC akisi calisma ortami degiskenleri.   Kullanim:  . scripts/env.sh
#
#  Butun yollar disaridan ezilebilir; asagidakiler bu makinedeki degerlerdir.
#  Yarismaya teslim edilen dosyalarda makineye ozgu mutlak yol yoktur, bu
#  dosya yalnizca yerel kolaylik icindir (bkz. asic/README.md 9.3).
# ---------------------------------------------------------------------------

# Nix ortami
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# PDK kokU (ciel varsayilani ~/.ciel; /home bolumu kucuk oldugu icin tasindi)
export PDK_ROOT="${PDK_ROOT:-/usr/asic_flow/pdk}"

# Nix/ciel onbellekleri de /home disinda tutulsun
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-/usr/asic_flow/cache}"

# Yarismanin referans Open PDKs commit kimligi (2026 Final Ciktilar, Bolum 1.2)
export SKY130_OPEN_PDKS_COMMIT="8afc8346a57fe1ab7934ba5a6056ea8b43078e71"
