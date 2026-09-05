#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fpga_dir="$(cd "${script_dir}/.." && pwd)"

if [[ -z "${VIVADO_ROOT:-}" ]]; then
    echo "HATA: VIVADO_ROOT tanimli degil." >&2
    echo "Ornek: export VIVADO_ROOT=/opt/Xilinx/Vivado/2025.2" >&2
    exit 1
fi
if [[ ! -f "${VIVADO_ROOT}/settings64.sh" ]]; then
    echo "HATA: Vivado ortam betigi bulunamadi: ${VIVADO_ROOT}/settings64.sh" >&2
    exit 1
fi

# shellcheck disable=SC1090
source "${VIVADO_ROOT}/settings64.sh"

echo "==> FPGA firmware'i derleniyor"
make -s -C "${fpga_dir}/firmware" all

echo "==> Vivado batch final build baslatiliyor"
cd "${fpga_dir}"
mkdir -p Vivado_projects
exec vivado -mode batch -nojournal \
    -log Vivado_projects/fpga_build.log \
    -source scripts/build_fpga.tcl
