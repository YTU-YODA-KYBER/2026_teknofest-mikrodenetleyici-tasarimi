#!/usr/bin/env bash
# ---------------------------------------------------------------------------
#  eco_resume_signoff.sh -- post-route ECO sonrasi ayrintili yollamayi bitirir
#  ve signoff zincirini (anten / TrDRC / baglanti / RCX / dokuz kose STA)
#  kosar.
#
#  SORUN: DetailedRouting, ECO'dan sonra ZATEN YOLLANMIS bir ODB uzerinde
#  artimli calisir. TritonRoute bazi aglari kismen sokup yeniden yollarken
#  eski parcalari ulasilamaz ada olarak birakir -> [DRT-0206].
#  ECO'nun kendisi hedefledigi 106+17 agin rotasini temizler, ama yan etkiyle
#  bozulan (ECO'nun hic dokunmadigi) aglar onceden bilinemez.
#
#  COZUM: DRT'yi kos; [DRT-0206] alirsak logdaki "pin not visited" aglarinin
#  rotasini eco_clear_nets.py ile temizleyip TEKRAR kos. Her tur ~6 dakika.
#  Netlist, yerlesim, guide, kisit ve esiklerin hicbiri degismez.
#
#  Kullanim (once: nix develop ./environment):
#     scripts/eco_resume_signoff.sh <baslangic.odb> <etiket-onek>
# ---------------------------------------------------------------------------
set -u -o pipefail

ODB_IN="${1:?kullanim: $0 <baslangic.odb> <etiket-onek>}"
TAG="${2:?kullanim: $0 <baslangic.odb> <etiket-onek>}"
MAX_TRY="${MAX_TRY:-5}"

cd "$(dirname "$0")/.." || exit 1
: "${PDK_ROOT:?PDK_ROOT tanimli degil (ornek: export PDK_ROOT=\$HOME/.ciel)}"

# Disk kisitli (~10 GB): her DRT denemesi ~1,5 GB uretir. Bu yuzden TEK bir
# etiket --overwrite ile yeniden kullanilir; yalniz loglar saklanir.
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
LOGKEEP="run/${TAG}_drt_loglari"
mkdir -p "$LOGKEEP"
cur="$ODB_IN"
dtag="${TAG}_drt"

for try in $(seq 1 "$MAX_TRY"); do
    echo "=============================================================="
    echo "[eco_resume] DRT denemesi $try/$MAX_TRY  (giris: $cur)"
    echo "=============================================================="
    python3 scripts/run_flow.py \
        --config config.yaml \
        --tag "$dtag" --overwrite \
        --initial-odb "$cur" \
        --standalone-step OpenROAD.DetailedRouting
    rc=$?

    step_dir="run/${dtag}/1-openroad-detailedrouting"
    log="${step_dir}/openroad-detailedrouting.log"

    if [ "$rc" -eq 0 ]; then
        echo "[eco_resume] DRT GECTI (deneme $try)."
        state="${step_dir}/state_out.json"
        [ -f "$state" ] || { echo "[eco_resume] HATA: $state yok"; exit 1; }

        echo "=============================================================="
        echo "[eco_resume] Signoff zinciri: RemoveRoutingObstructions -> STAPostPNR"
        echo "=============================================================="
        exec python3 scripts/run_flow.py \
            --config config.yaml \
            --tag "${TAG}_signoff" --overwrite \
            --initial-state "$state" \
            --from Odb.RemoveRoutingObstructions \
            --to OpenROAD.STAPostPNR
    fi

    if ! grep -q "DRT-0206" "$log" 2>/dev/null; then
        echo "[eco_resume] DRT, DRT-0206 DISINDA bir hatayla dustu. Log: $log"
        exit "$rc"
    fi

    cp -f "$log" "${LOGKEEP}/deneme${try}.log" 2>/dev/null

    echo "[eco_resume] DRT-0206. Ulasilamayan aglarin rotasi temizleniyor..."
    nxt="${WORK}/cleared_${try}.odb"
    openroad -exit -no_splash -python scripts/eco_clear_nets.py \
        --in "$cur" --out "$nxt" --from-drt-log "$log" || exit 1
    # onceki ara ODB'yi hemen birak (her biri ~700 MB)
    case "$cur" in "$WORK"/*) rm -f "$cur" ;; esac
    cur="$nxt"
done

echo "[eco_resume] $MAX_TRY denemede DRT kapanmadi."
echo "[eco_resume] Sonraki adim: tum sinyal rotasini temizleyip TAM yeniden yollama."
exit 1
