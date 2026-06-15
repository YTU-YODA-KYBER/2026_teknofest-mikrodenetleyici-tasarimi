# Firmware — Derleme Komutları

Yapmak istediğini bul, karşısındaki komutu çalıştır. Hepsi bu.

> Not: `riscv32-unknown-elf-gcc` (toolchain) kurulu ve PATH'te olmalı.

---

## Gerçek donanım (FPGA / Basys3)

| İstediğin | Komut |
|---|---|
| Her şeyi derle (bootloader + uygulama) | `make` |
| Sadece bootloader | `make boot` |
| Sadece uygulama | `make app` |
| LED animasyon demosu | `make circle` |
| QSPI flash yaz/oku testi | `make qspi_test` |

## Simülasyon (testbench)

| İstediğin | Komut |
|---|---|
| Bootloader'ı simülasyonda koştur | `make sim` |
| Uygulamayı simülasyonda koştur | `make sim_app` |
| LED demosunu simülasyonda koştur | `make sim_circle` |

## Diğer

| İstediğin | Komut |
|---|---|
| Boyut + sembol raporu | `make size` |
| Bootloader disassembly | `make disasm_boot` |
| Uygulama disassembly | `make disasm_app` |
| LED demo disassembly | `make disasm_circle` |
| Üretilen dosyaları sil | `make clean` |

---

**Çıktılar** ilgili `build_*/` klasörüne yazılır:

- `firmware.hex` → simülasyonda `$readmemh` ile belleğe yüklenir
- `app.bin` → gerçek QSPI flash'a programlanır (sadece `make app` üretir)

> Uyarı: `make clean` yalnızca `build_boot`, `build_app`, `build_boot_sim`,
> `build_app_sim` klasörlerini siler. `circle` ve `qspi_test` klasörlerini
> elle silmen gerekir: `rm -rf build_circle build_circle_sim build_qspi_test`
