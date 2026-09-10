#!/usr/bin/env bash
set -euo pipefail

ASIC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ASIC_DIR"

timestamp() {
    date --iso-8601=seconds
}

echo "[$(timestamp)] fp_banked OpenROAD akışının tamamlanması bekleniyor."
while pgrep -f 'scripts/run_flow.py --tag fp_banked' >/dev/null \
    || pgrep -f '/bin/openroad .*run/fp_banked/' >/dev/null; do
    sleep 15
done

echo "[$(timestamp)] fp_banked tamamlandı; zorunlu 1 KiB TT pilotu başlatılıyor."
exec python3 scripts/recharacterize_sram.py \
    --phase pilot \
    --parallel-corners 2 \
    --sim-threads 4 \
    --openram-dir /tmp/openram-char.uPnbHR/OpenRAM
