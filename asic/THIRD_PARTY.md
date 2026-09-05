# Üçüncü Taraf Bileşenler ve Lisanslar

**YTU YODA KYBER — TEKNOFEST 2026 Çip Tasarım Yarışması (Mikrodenetleyici Kategorisi)**

Bu dosya, ASIC fiziksel tasarım akışında kullanılan üçüncü taraf RTL, IP, fiziksel
makro, PDK ve araçları listeler (şartname Bölüm 9.13 ve Bölüm 10).

> Projenin kendi kodu (çevre birimleri, AXI4 ara bağlantı, OBI↔AXI sarmalayıcı,
> bellek denetleyicileri, YZ hızlandırıcı, ASIC bellek sarmalayıcıları ve
> otomasyon betikleri) **YTU YODA KYBER** takımına aittir ve depo kökündeki
> `LICENSE` dosyasındaki MIT lisansı altındadır.

---

## 1. RTL / IP bileşenleri

### 1.1 CV32E40P RISC-V çekirdeği

| | |
|---|---|
| **Konum** | `FPGA/main_codes/rtl/desgin_sources/CPU/cv32e40p_rtl/` |
| **Kaynak** | https://github.com/openhwgroup/cv32e40p (özgün: ETH Zürich / Bologna Üniversitesi, PULP platform) |
| **Lisans** | Solderpad Hardware License v0.51 (SHL-0.51) — http://solderpad.org/licenses/SHL-0.51 |
| **Yapılandırma** | `COREV_PULP=0`, `COREV_CLUSTER=0`, **`FPU=0`**, `ZFINX=0`, `NUM_MHPMCOUNTERS=1` |
| **Takım değişikliği** | **Yok.** Dosyalar olduğu gibi kullanılır. |

`FPU=0` olduğu için `cv32e40p_fp_wrapper.sv` ve `vendor/fpnew/` ağacı hiçbir zaman
elaborate edilmez; bu dosyalar `asic/filelist.f` içinde **yer almaz**.

Kayıt dosyası olarak **flip-flop tabanlı** varyant (`cv32e40p_register_file_ff.sv`)
kullanılır; latch tabanlı varyant ASIC akışına girmez.

### 1.2 pulp-platform `common_cells`

| | |
|---|---|
| **Konum** | `.../CPU/cv32e40p_rtl/vendor/pulp_platform_common_cells/` |
| **Kaynak** | https://github.com/pulp-platform/common_cells |
| **Lisans** | Solderpad Hardware License v0.51 (SHL-0.51) |
| **Kullanılan dosyalar** | `cf_math_pkg.sv`, `fifo_v3.sv`, `lzc.sv`, `rr_arb_tree.sv` |
| **Takım değişikliği** | **Yok.** |

### 1.3 OBI ↔ AXI4-Lite köprüsü (`obi` / `axi` paketleri)

| | |
|---|---|
| **Konum** | `.../CPU/openhw_obi_to_axi/` (`obi_to_axi.sv`, `obi_pkg.sv`, `axi_pkg.sv`) |
| **Kaynak** | ETH Zürich / Bologna Üniversitesi — PULP platform OBI/AXI kütüphaneleri |
| **Lisans** | Solderpad Hardware License v0.51 (`SPDX-License-Identifier: SHL-0.51`) |
| **Takım değişikliği** | **VAR** — bkz. aşağıda |

`obi_to_axi.sv` için ASIC akışında **yamalı bir kopya** kullanılır
(`asic_rtl/patched/obi_to_axi_asic.sv`,
`asic/scripts/patch_rtl.py` tarafından üretilir). Orijinal dosyaya dokunulmamıştır.
İki değişiklik yapılmıştır ve **ikisi de üretilen donanımı değiştirmez**:

1. **Sıfır genişlikli parça-seçim.** `AxiDataWidth == ObiCfg.DataWidth` (bu tasarımda
   ikisi de 32) olduğunda `$clog2(1) = 0` olur; sıfır genişlikli parça-seçim
   SystemVerilog'da geçersizdir (LRM 11.5.1). İlgili `if` dalı bu yapılandırmada
   hiç alınmaz. Genişlik ifadesi en az 1 olacak şekilde sarmalanmıştır.
2. **Sürülmeyen `obi_rsp_o.r.r_optional`.** Bu alan yalnızca `UseAtop` /
   `RUserWidth` generate dallarında sürülüyordu; ikisi de kapalı olduğu için hiçbir
   sürücüsü yoktu. Kapalı durum için açık bir `else` dalı eklenerek `'0` bağlanmıştır.

---

## 2. Fiziksel makrolar

### 2.1 SKY130 SRAM makroları

| | |
|---|---|
| **Makrolar** | `sky130_sram_2kbyte_1rw1r_32x512_8` (×14), `sky130_sram_1kbyte_1rw1r_32x256_8` (×1) |
| **Kaynak** | Referans SKY130 PDK kurulumu — `sky130A/libs.ref/sky130_sram_macros/` (üretici: OpenRAM / VLSIDA, https://github.com/VLSIDA/sky130_sram_macros) |
| **Sürüm** | Open PDKs commit `8afc8346a57fe1ab7934ba5a6056ea8b43078e71` ile gelen sürüm |
| **Lisans** | Apache License 2.0 (OpenRAM ve üretilen makrolar) |
| **Takım değişikliği** | **Yok.** GDSII, LEF, Liberty, Verilog ve SPICE görünümleri PDK'dan olduğu gibi `asic/macros/` altına kopyalanmıştır. |

Takım tarafından **yalnızca** her makro için bir *kara kutu* arayüz modeli
(`*.bb.v`) eklenmiştir; bu dosya Verilator lint adımında makronun port listesini
tanıtmak içindir, sentez veya simülasyona girmez. Port listesi PDK'daki işlevsel
modelden birebir türetilmiş ve otomatik olarak doğrulanmıştır.

> **Not (şartname Bölüm 1.2 / 3.3):** PDK bu makrolar için yalnızca
> `TT_1p8V_25C` Liberty modelini içerir. Zorunlu üç signoff corner'ının
> (`tt_025C_1v80`, `ss_100C_1v60`, `ff_n40C_1v95`) tamamında bu tek model
> kullanılmıştır. Ayrıntı ve varsayımlar: `asic/README.md` Bölüm 9.5.

### 2.2 SKY130 standart hücre kütüphanesi ve PDK

| | |
|---|---|
| **PDK** | SkyWater SKY130 / `sky130A`, standart hücre kütüphanesi `sky130_fd_sc_hd` |
| **Kaynak** | https://github.com/google/skywater-pdk · https://github.com/RTimothyEdwards/open_pdks · https://github.com/fossi-foundation/ciel |
| **Sürüm** | Open PDKs commit `8afc8346a57fe1ab7934ba5a6056ea8b43078e71` |
| **Lisans** | Apache License 2.0 |
| **Takım değişikliği** | **Yok.** |

---

## 3. Araçlar

| Bileşen | Sürüm / commit | Kaynak | Lisans |
|---|---|---|---|
| LibreLane | 3.0.6 (`ba7193bff33d68941683b2963b90aa30cea117d1`) | https://github.com/librelane/librelane | Apache-2.0 |
| nix-eda | `8f990fb77529c09e540e453cd836af9930ec58db` | https://github.com/fossi-foundation/nix-eda | MIT |
| ciel | `afcb23d368614ffa1e7e96584ed33f839c71c576` | https://github.com/fossi-foundation/ciel | Apache-2.0 |
| Yosys + yosys-slang | LibreLane 3.0.6 ortamı | https://github.com/YosysHQ/yosys · https://github.com/povik/yosys-slang | ISC · MIT |
| OpenROAD / OpenSTA | LibreLane 3.0.6 ortamı | https://github.com/The-OpenROAD-Project | BSD-3-Clause |
| Magic / Netgen | LibreLane 3.0.6 ortamı | http://opencircuitdesign.com | GPL-2.0 / custom |
| KLayout | LibreLane 3.0.6 ortamı | https://www.klayout.de | GPL-3.0 |
| Verilator | LibreLane 3.0.6 ortamı | https://verilator.org | LGPL-3.0 / Artistic-2.0 |

Kesin sürümler: `asic/environment/versions.txt` ve `asic/environment/flake.lock`.

---

## 4. ASIC akışına girmeyen üçüncü taraf bileşenler

Aşağıdakiler depoda bulunur ama `asic/filelist.f` içinde **yer almaz**:

| Bileşen | Neden akış dışı |
|---|---|
| `vendor/fpnew/` + `cv32e40p_fp_wrapper.sv` | FPU=0; elaborate edilmeyen generate bloğunda kalır |
| `testbench/Peripherals/QSPI/Micron_sim_model.v` | Micron N25Q flash simülasyon modeli — yalnızca doğrulama, sentezlenmez |
| `for_FPU/` ağacı | Ana akışta kullanılmayan FPU deneme kopyası |
| Xilinx `clk_wiz_0` IP (`fpga_top.sv`) | FPGA'ya özgü MMCM; ASIC'te saat doğrudan `clk_i` pininden gelir |

---

## 5. Lisans metinleri

İlgili lisans metinleri `asic/licenses/` altındadır. Depoya kopyalanan üçüncü
taraf bileşenlerdeki mevcut lisans ve telif bildirimleri **korunmuştur**;
`asic/scripts/patch_rtl.py` tarafından üretilen yamalı kopyalar da kaynak
dosyanın lisans başlığını olduğu gibi taşır.
