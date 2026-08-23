#!/bin/bash
set -e   # herhangi bir komut hata verirse dur

ELF=${1:-build/test.elf}

spike \
  --isa=rv32imc_zicsr_zifencei \
  --priv=m \
  -m0x10000000:0x2000,0x20000000:0x2000 \
  --pc=0x10000000 \
  --log-commits \
  --log=build/spike.log \
  --instructions=193 \
  --disable-dtb \
  "$ELF"

echo "--- spike.log ilk 15 satır ---"
head -15 build/spike.log
