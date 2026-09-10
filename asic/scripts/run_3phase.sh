#!/usr/bin/env bash
# ---------------------------------------------------------------------------
#  run_3phase.sh -- Makefile'daki uc fazli asic_run akisini, ek overlay'lerle
#  tekrarlanabilir bicimde kosar. Deney kosumlari icindir; teslim kosumu
#  `make asic_run` ile yapilir.
#
#  Bitince run/<etiket>.DONE dosyasina "ok" veya duserse faz adi yazilir.
#  (pgrep ile beklemeyin: desen kendi komut satirini eslestirip sonsuz doner.)
#
#  Kullanim (once: nix develop ./environment):
#      scripts/run_3phase.sh <etiket> [ek-overlay.yaml ...]
# ---------------------------------------------------------------------------
set -u
cd "$(dirname "$0")/.." || exit 1
: "${PDK_ROOT:?PDK_ROOT tanimli degil}"

TAG="${1:?kullanim: $0 <etiket> [overlay.yaml ...]}"; shift
EXTRA=(); for o in "$@"; do EXTRA+=(--config "$o"); done
M="run/${TAG}.DONE"; rm -f "$M"
BASE=(--config config.yaml)
MET=(--config experiments/grt_layer_met3_009.yaml)
ANT=(--config experiments/antenna_jumper.yaml)

echo "### FAZ 1/3: baslangic -> STAMidPNR-2   $(date +%H:%M)"
python3 scripts/run_flow.py --tag "$TAG" --overwrite "${BASE[@]}" "${EXTRA[@]}" \
    --to OpenROAD.STAMidPNR-2 || { echo faz1 > "$M"; exit 1; }
S=$(ls -d run/"$TAG"/*-openroad-stamidpnr-2 2>/dev/null | tail -1)
[ -f "$S/state_out.json" ] || { echo faz1state > "$M"; exit 1; }

echo "### FAZ 2/3: GlobalRouting -> ResizerTimingPostGRT   $(date +%H:%M)"
python3 scripts/run_flow.py --tag "$TAG" "${BASE[@]}" "${MET[@]}" "${EXTRA[@]}" \
    --from OpenROAD.GlobalRouting --to OpenROAD.ResizerTimingPostGRT \
    --initial-state "$S/state_out.json" || { echo faz2 > "$M"; exit 1; }
R=$(ls -d run/"$TAG"/*-openroad-resizertimingpostgrt 2>/dev/null | tail -1)
[ -f "$R/state_out.json" ] || { echo faz2state > "$M"; exit 1; }

echo "### FAZ 3/3: RepairAntennas -> son   $(date +%H:%M)"
python3 scripts/run_flow.py --tag "$TAG" "${BASE[@]}" "${MET[@]}" "${ANT[@]}" "${EXTRA[@]}" \
    --from OpenROAD.RepairAntennas \
    --initial-state "$R/state_out.json" || { echo faz3 > "$M"; exit 1; }

echo "### BITTI $(date +%H:%M)"; echo ok > "$M"
