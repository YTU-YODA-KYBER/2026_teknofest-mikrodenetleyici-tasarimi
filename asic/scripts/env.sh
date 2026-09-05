# ---------------------------------------------------------------------------
#  ASIC akisi calisma ortami degiskenleri.   Kullanim:  . scripts/env.sh
#
#  Bu dosyada MAKINEYE OZGU MUTLAK YOL YOKTUR (sartname Bolum 3). PDK_ROOT ve
#  XDG_CACHE_HOME disaridan verilir; verilmezse betik uyarir ve ciel
#  varsayilanini onerir.
# ---------------------------------------------------------------------------

# Nix ortami
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# PDK koku. Sartname Bolum 3 teslim edilen dosyalarda makineye ozgu MUTLAK
# YOL bulunmasini yasakliyor; bu yuzden burada bir varsayilan GOMULMEZ.
# Degeri disaridan verin:   export PDK_ROOT=/yol/pdk
if [ -z "${PDK_ROOT:-}" ]; then
    echo "env.sh: PDK_ROOT tanimli degil. Ornek:" >&2
    echo "  export PDK_ROOT=\$HOME/.ciel   # ciel varsayilani" >&2
fi

# Onbellek dizini de istege bagli olarak disaridan verilebilir:
#   export XDG_CACHE_HOME=/yol/cache

# Yarismanin referans Open PDKs commit kimligi (2026 Final Ciktilar, Bolum 1.2)
export SKY130_OPEN_PDKS_COMMIT="8afc8346a57fe1ab7934ba5a6056ea8b43078e71"
