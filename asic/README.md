# asic — ASIC Fiziksel Tasarım Akışı

**YTU YODA KYBER — TEKNOFEST 2026 Çip Tasarım Yarışması (Mikrodenetleyici Kategorisi)**

FPGA'de doğruladığımız SoC'nin **LibreLane 3.0.6 Classic** akışıyla **SKY130**
teknolojisinde fiziksel tasarıma dönüştürülmüş hâli. Bu klasör akışın bütün
girdilerini (RTL listesi, yapılandırma, kısıtlar, makro görünümleri), akışı
yeniden çalıştıran otomasyonu ve üretilen bütün rapor + nihai çıktıları içerir.

Tasarım, şartname Bölüm 2 uyarınca **üst seviye bir ASIC bloğu** olarak
teslim edilir: I/O pad ring, bond pad, ESD hücresi ve seal ring kapsam dışıdır;
tasarımın bütün giriş/çıkışları nihai LEF ve DEF görünümlerinde makro pinleridir.

```bash
cd asic
nix develop ./environment     # LibreLane 3.0.6 ortamına gir
make asic_run                 # akışı baştan sona çalıştır
make asic_verify              # teslim paketini denetle
```

---

## Klasör yapısı

| Dosya / klasör | Ne işe yarar | Nasıl elde edildi |
|---|---|---|
| [`config.yaml`](config.yaml) | LibreLane Classic akışının ana tasarım yapılandırması | Elle yazıldı; `VERILOG_FILES` bloğu `filelist.f`'ten otomatik eşitlenir |
| [`filelist.f`](filelist.f) | ASIC akışında derlenen bütün RTL kaynakları, derleme sırasına göre | `scripts/gen_filelist.py` üretir (`make filelist`) |
| [`Makefile`](Makefile) | `asic_run` / `asic_verify` / `asic_package` / `asic_clean` otomasyonu | Elle yazıldı |
| [`constraints/design.sdc`](constraints/design.sdc) | Zamanlama kısıtları (PnR + signoff, tek dosya) | Elle yazıldı |
| [`constraints/macro_placement.cfg`](constraints/macro_placement.cfg) | 15 SRAM makrosunun floorplan koordinatları | `scripts/gen_macro_placement.py` üretir |
| [`environment/`](environment/) | Nix ortam tanımı (`flake.nix`, `flake.lock`) + `versions.txt` | flake elle yazıldı, kilit `nix flake lock` ile, `versions.txt` `scripts/gen_versions.py` ile |
| [`macros/`](macros/) | Kullanılan SRAM makrolarının GDSII/LEF/Liberty/Verilog/SPICE görünümleri | Referans SKY130 PDK kurulumundan kopyalandı (`*.bb.v` kara kutu modelleri takım tarafından türetildi) |
| [`scripts/`](scripts/) | Akışı çalıştıran ve girdi üreten yardımcı betikler | Elle yazıldı — aşağıda tek tek açıklanıyor |
| [`../asic_rtl/`](../asic_rtl/) | **ASIC'e özgü RTL** (bu klasörün dışında): SRAM makro sarmalayıcıları, mask ROM'lar, yamalı kopyalar | Kısmen elle, kısmen `scripts/gen_rom.py` + `scripts/patch_rtl.py` ile üretilir |
| [`reports/`](reports/) | Şartname Bölüm 5'te istenen bütün raporlar | Akış çalıştıktan sonra `scripts/collect.py` toplar |
| [`results/`](results/) | Şartname Bölüm 6'da istenen nihai çıktılar (GDSII, LEF, DEF, netlistler, SPEF…) | Aynı akıştan, `scripts/collect.py` toplar |
| [`checksums/SHA256SUMS`](checksums/) | Teslim edilen dosyaların SHA-256 özetleri | `scripts/gen_checksums.py` üretir |
| [`licenses/`](licenses/) | Üçüncü taraf lisans metinleri | İlgili projelerin kaynaklarından |
| [`THIRD_PARTY.md`](THIRD_PARTY.md) | Üçüncü taraf RTL/IP/makro/araç listesi ve yapılan değişiklikler | Elle yazıldı |
| `run/` | LibreLane'in geçici çalışma alanı | Akış üretir; teslimde boştur (`make asic_package`) |

### `scripts/` içindekiler

| Betik | Ne yapar |
|---|---|
| `env.sh` | PDK_ROOT ve Nix ortam değişkenlerini ayarlar (yerel kolaylık) |
| `run_flow.py` | LibreLane Classic akışını `asic/run/<etiket>` altında çalıştırır |
| `gen_filelist.py` | `filelist.f`'i RTL ağacından üretir ve `config.yaml` ile eşitler |
| `gen_rom.py` | Hex dosyalarından sentezlenebilir **mask ROM** RTL'i üretir |
| `patch_rtl.py` | Üçüncü taraf ve proje RTL'inin yamalı kopyalarını üretir (orijinallere dokunmadan) |
| `gen_macro_placement.py` | SRAM makro yerleşimini sentezlenmiş netlist'ten üretir |
| `gen_versions.py` | `environment/versions.txt`'i kurulu ortamdan okuyarak yazar |
| `run_asic_sim.py` | ASIC yapılandırmasını (SRAM makroları + mask ROM'lar) mevcut testbench'lerle XSim'de koşturur |
| `collect.py` | Akış çıktılarını `reports/` ve `results/` ağacına taşır |
| `gen_readme_results.py` | Bu dosyadaki *Signoff sonuç özeti* bölümünü `metrics.json`'dan doldurur |
| `verify_deliverables.py` | Zorunlu rapor/çıktıların varlığını denetler, signoff metriklerini özetler |
| `gen_checksums.py` | SHA-256 özetlerini üretir |
| `filelist.py` | `filelist.f` ayrıştırıcısı (diğer betikler kullanır) |

---

## Tasarım özeti

| | |
|---|---|
| **En üst seviye modül** | `top_module` |
| **Amaç** | RISC-V CV32E40P çekirdekli, AXI4-Lite çevre birimli ve konuşma tanıma YZ hızlandırıcılı mikrodenetleyici |
| **Saat portu** | `clk_i` — tek saat alanı, **50 MHz (20 ns)** |
| **Reset portu** | `rst_ni` — asenkron, aktif-LOW |
| **Temel arayüzler** | 32-bit GPIO giriş/çıkış, 8+8 bit 7-segment sürücü, 2× UART (TX/RX), I2C (SCL + çift yönlü SDA), QSPI (SCLK, CS, çift yönlü IO0–IO3) |
| **Bloklar** | CV32E40P (RV32IMC, FPU=0) · OBI↔AXI4 köprüsü · AXI4 ara bağlantı · komut ayırıcı · Boot ROM · Instruction RAM · Data RAM · YZ RAM · GPIO · Timer · I2C · QSPI · UART_GU · UART_YZ · YZ hızlandırıcı |

Blokların işlevsel açıklaması ve bellek haritası:
[`../FPGA/README.md`](../FPGA/README.md).

FPGA gerçeklemesiyle **aynı RTL** kullanılır; farklar teknolojiye bağlı
olanlarla sınırlıdır (bkz. *RTL ve akış girdileri*). Davranışı etkileyen tek
fark YZ hızlandırıcının MAC yolunun boru hattına alınmasıdır: çıkarım sonucu
bit-exact aynı kalır, çevrim sayısı %1,1 artar (bkz. *Bilinen sorunlar*, madde 2).

---

## Akışın çalıştırılması

### Ön koşullar

- Linux (Ubuntu 22.04+), en az 8 GB RAM (bu tasarım için **16 GB önerilir**)
- Nix (flake desteği açık) + LibreLane binary cache
- SKY130 PDK, `ciel` ile kurulmuş

Kurulum komutlarının tamamı [`environment/versions.txt`](environment/versions.txt)
dosyasının sonundadır. Özeti:

```bash
# 1) Nix + LibreLane binary cache (bir kez)
curl --proto '=https' --tlsv1.2 -fsSL https://artifacts.nixos.org/nix-installer \
  | sh -s -- install --no-confirm --extra-conf "
      extra-substituters = https://nix-cache.fossi-foundation.org
      extra-trusted-public-keys = nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs=
      extra-experimental-features = nix-command flakes"

# 2) PDK (bir kez)
export PDK_ROOT=<pdk dizini>
cd asic
nix develop ./environment --command \
  ciel enable --pdk-family sky130 8afc8346a57fe1ab7934ba5a6056ea8b43078e71

# 3) Akış
nix develop ./environment
make asic_run
```

### `make asic_run` ne yapıyor?

1. `asic/run/` temizlenir (`asic_clean`).
2. **Girdiler üretilir** (`prepare`):
   - `gen_rom.py` → Boot ROM ve YZ ağırlık ROM'larının RTL'i (hex içeriği gömülü)
   - `patch_rtl.py` → yamalı RTL kopyaları
   - `gen_filelist.py` → `filelist.f` + `config.yaml` eşitlemesi
3. `run_flow.py` LibreLane Classic akışını `asic/run/rtl2gds/` altında çalıştırır.
4. `collect.py` raporları `asic/reports/`, nihai çıktıları `asic/results/` altına taşır.
5. `gen_checksums.py` SHA-256 özetlerini yazar.

Başarısızlık durumunda sıfırdan farklı çıkış kodu döner; kullanıcı etkileşimi
veya grafik arayüz gerekmez, makineye özgü mutlak yol kullanılmaz.

Ek hedefler:

| Hedef | Ne yapar |
|---|---|
| `make asic_verify` | Şartname Bölüm 5 ve 6'daki zorunlu rapor/çıktıları tek tek arar, signoff metriklerini özetler |
| `make asic_package` | Teslim öncesi hazırlık: `run/` boşaltılır, SHA-256 özetleri yenilenir, denetim koşulur |
| `make asic_clean` | Yalnızca `asic/run/` altındaki yeniden üretilebilir dosyaları siler |
| `make prepare` | Üretilen RTL'i (mask ROM'lar, yamalı kopyalar) ve `filelist.f`'i yeniler |

**Yaklaşık çalışma süresi:** 20 çekirdek / 16 GB RAM'de tam akış birkaç saat
(en uzun adım detaylı yollama). Disk: çalışma dizini birkaç GB.

> `asic/run/` teslimde boştur. İçeriği silindikten sonra akış yukarıdaki
> komutla yeniden çalıştırılabilir; kalıcı hiçbir girdi orada tutulmaz.

---

## Araç ve ortam bilgileri

| | |
|---|---|
| LibreLane sürümü | **3.0.6** |
| LibreLane commit | `ba7193bff33d68941683b2963b90aa30cea117d1` |
| Kullanılan akış | **Classic** — özel akış veya özel adım **yoktur** |
| PDK | `sky130A`, Open PDKs commit `8afc8346a57fe1ab7934ba5a6056ea8b43078e71` |
| Standart hücre kütüphanesi | `sky130_fd_sc_hd` |
| OpenRAM | **Kullanılmadı** — SRAM makroları referans PDK kurulumundan hazır alındı |
| Ortam | Nix flake — [`environment/flake.nix`](environment/flake.nix) + [`flake.lock`](environment/flake.lock) |

Bütün araç sürümleri (Yosys, OpenROAD, OpenSTA, Magic, KLayout, Netgen,
Verilator, ciel, Nix) kurulu ortamdan okunarak
[`environment/versions.txt`](environment/versions.txt) dosyasına yazılır.

### Referans yapılandırmadan sapmalar

Şartnamenin zorunlu tuttuğu araç, sürüm, PDK, kütüphane ve akışın tamamı
kullanılmıştır. Varsayılandan farklı ayarlanan **tek** LibreLane parametresi
grubu şudur:

| Parametre | Değer | Gerekçe |
|---|---|---|
| `USE_SLANG` | `true` | Yosys'in yerleşik Verilog ön ucu tasarımdaki SystemVerilog'u okuyamıyor: `cf_math_pkg.sv`'de fonksiyon içi `automatic` değişken bildirimi ve `unsigned'()` cast'ı, `fpnew_pkg.sv`'de struct tipinin paketlenmiş dizisi. `USE_SLANG` LibreLane'in **standart** bir yapılandırma parametresidir; özel adım veya özel akış değildir. |
| `SLANG_ARGUMENTS` | `--keep-hierarchy` | yosys-slang, modül sınırı korunmadığında `inout` port bağlantılarını işleyemiyor (QSPI/I2C'nin 5 tri-state pini ve `top_module`'ün çift yönlü portları). Hiyerarşi daha sonra `SYNTH_HIERARCHY_MODE: flatten` ile düzlenir. |

Hiçbir zorunlu adım kapatılmamış, hiçbir kontrol seviyesi veya hata eşiği
gevşetilmemiştir.

---

## RTL ve akış girdileri

| | |
|---|---|
| Dosya listesi | [`filelist.f`](filelist.f) — bütün yollar `asic/` dizinine görelidir |
| Include dizini | `../FPGA/main_codes/rtl/include/CPU` |
| Derleme tanımı / makro | **Yok** (`VERILOG_DEFINES` boş) |
| Ana RTL kaynakları | [`../FPGA/main_codes/rtl/desgin_sources/`](../FPGA/main_codes/rtl/desgin_sources/) |
| ASIC'e özgü RTL | [`../asic_rtl/`](../asic_rtl/) |
| Üçüncü taraf RTL/IP | [`THIRD_PARTY.md`](THIRD_PARTY.md) |

En üst seviye modül adı `top_module`'dür ve `config.yaml`, `filelist.f` ile
RTL'de aynıdır.

### Temel ilke: FPGA klasöründeki RTL değiştirilmedi

`FPGA/main_codes/rtl/desgin_sources/` altındaki dosyalara **dokunulmamıştır**;
FPGA/Vivado akışı hiç etkilenmez. ASIC'e özgü her şey ayrı bir ağaçta
([`../asic_rtl/`](../asic_rtl/)) durur ve fark yalnızca `filelist.f`'in hangi
dosyayı seçtiğinden ibarettir. Tasarımın büyük kısmı (CV32E40P, ara bağlantı,
çevre birimleri, üst modül) doğrudan FPGA ağacından okunur:

| Fark | Ayrıntı |
|---|---|
| `fpga_top.sv` **listede yok** | Xilinx `clk_wiz_0` (MMCM) IP'sine bağlı; ASIC'te üst modül doğrudan `top_module`'dür ve saat `clk_i` pininden gelir |
| fpnew ağacı + `cv32e40p_fp_wrapper.sv` **listede yok** | `FPU=0`; elaborate edilmeyen generate bloğunda kalırlar |
| Bellek modülleri **değiştirildi** | FPGA BRAM tanımları yerine SRAM makro sarmalayıcıları ve mask ROM'lar (aşağıda) |
| Xilinx `IOBUF` **eklendi** | `asic_rtl/tech/xilinx_iobuf_stub.sv` — primitifin teknolojiden bağımsız karşılığı; Yosys `$_TBUF_` üretir, PDK'nın `tribuff_map.v` haritası `sky130_fd_sc_hd__ebufn_2` hücresine çevirir |
| 9 dosya **yamalı kopya** | `scripts/patch_rtl.py` orijinali okuyup `asic_rtl/patched/` altına yamalı sürümünü üretir; gerekçeler *Bilinen sorunlar* bölümünde. En önemlisi YZ hızlandırıcının MAC boru hattıdır. |

### Üretilen RTL

`scripts/gen_rom.py` ve `scripts/patch_rtl.py` her `make asic_run` çalışmasında
çıktılarını yeniden üretir; dolayısıyla üretilen RTL kaynağıyla her zaman
tutarlıdır. Yama uygulanamazsa (üst akış dosyası değişmişse) betik hata verir,
sessizce eski hâli kullanmaz.

---

## SRAM ve fiziksel makrolar

Şartname Bölüm 1.3 en az bir SRAM makrosu zorunlu tutuyor. Bu tasarımda
**15 SRAM makrosu** vardır; hepsi tasarımın işlevsel veri yoluna bağlıdır,
sentezde optimize edilip atılmaz ve nihai netlist, DEF ile GDSII'de bulunur.

### Bellekler nasıl gerçeklendi?

ASIC'te bellekler ikiye ayrılır:

- **Değişken bellekler** (çalışma sırasında yazılır) → **SRAM makrosu**
- **Kalıcı bellekler** (güç verildiğinde hazır olmalı) → **mask ROM**
  (standart hücrelerden örülür; SRAM makrosu silikonda ilklendirilemez)

| Blok | Kapasite | Gerçekleme | Makro |
|---|---:|---|---:|
| Boot ROM | 1 KB | mask ROM — `boot.hex` içeriği gömülü | — |
| Instruction RAM | 8 KB | `sky130_sram_2kbyte_1rw1r_32x512_8` | 4 |
| Data RAM | 8 KB | `sky130_sram_2kbyte_1rw1r_32x512_8` | 4 |
| YZ girdi RAM'i | 9.216 B | 4× 2 KB + 1× `sky130_sram_1kbyte_1rw1r_32x256_8` | 5 |
| YZ konvolüsyon tamponu | 4.096 B | `sky130_sram_2kbyte_1rw1r_32x512_8` | 2 |
| YZ FC ağırlık ROM'u | 16.000 B | mask ROM | — |
| YZ konvolüsyon ağırlık ROM'u | 640 B | mask ROM | — |
| YZ bias / skor kayıtları | 176 B | flip-flop | — |
| | | **TOPLAM** | **15** |

Boot ROM, Instruction RAM ve Data RAM boyutları şartname değerleriyle birebir
aynıdır. **YZ hızlandırıcının toplam belleği 30.128 B**'tır — 30.720 B (30 KB)
sınırının %98,1'i. Makro granülariteleri 2048 ve 1024 bayt olduğu için sınıra
tam oturan bir kombinasyon yoktur; 30.128 B, sınırın altındaki **en büyük
ulaşılabilir** değerdir. FPGA'daki 9.904 baytlık girdi RAM'i yerine 9.216 bayt
kullanılmasının işlevsel etkisi yoktur: girdi her zaman 1960 bayttır
(`yz_bram_axi_ctrl.sv` sayacı 1959'da sarar) ve hızlandırıcı yalnızca bu aralığı okur.

### Makro bilgileri

| | `sky130_sram_2kbyte_1rw1r_32x512_8` | `sky130_sram_1kbyte_1rw1r_32x256_8` |
|---|---|---|
| Kapasite / organizasyon | 2 KB, 512 kelime × 32 bit | 1 KB, 256 kelime × 32 bit |
| Port yapısı | 1RW + 1R, 8-bit yazma granülaritesi | aynı |
| Boyut (LEF) | 683,10 × 416,54 µm | 479,78 × 397,50 µm |
| Adet | 14 | 1 |
| Kaynak | `sky130A/libs.ref/sky130_sram_macros/` | aynı |
| Görünümler | [`macros/sky130_sram_2kbyte_1rw1r_32x512_8/`](macros/sky130_sram_2kbyte_1rw1r_32x512_8/) | [`macros/sky130_sram_1kbyte_1rw1r_32x256_8/`](macros/sky130_sram_1kbyte_1rw1r_32x256_8/) |
| Güç / toprak pinleri | `vccd1` / `vssd1` | aynı |
| Tasarım güç ağlarına bağlantı | `VPWR` / `VGND` — PDN met4 dikey şeritleri makronun met3 yatay güç şeritlerini dik keser | aynı |

Instance adları [`constraints/macro_placement.cfg`](constraints/macro_placement.cfg)
içinde tam hâliyle listelenmiştir (ör.
`instr_bram_ctrl_inst.instr_ram.u_mem.g_2k[0].u_cell.u_sram`).

> **Liberty modeli hakkında (şartname Bölüm 3.3).** Referans PDK bu makrolar
> için yalnızca **`TT_1p8V_25C`** zamanlama modelini içeriyor; `ss_100C_1v60`
> ve `ff_n40C_1v95` corner'larına birebir karşılık gelen model yok. Zorunlu üç
> signoff corner'ının tamamında bu tek model kullanılmıştır. Bunun anlamı,
> yavaş ve hızlı corner'larda **standart hücre** gecikmeleri corner'a göre
> ölçeklenirken **SRAM erişim gecikmesinin tipik değerde sabit kalmasıdır**.
> SRAM erişim süresi 20 ns'lik periyoda kıyasla küçük olduğu için
> (`clk1 → dout1` ≈ 0,38–0,53 ns) bu varsayımın zamanlama sonucuna etkisi
> sınırlıdır; yine de yavaş corner sonuçları bu ölçüde iyimser kabul edilmelidir.

### SRAM'in işlevsel doğrulamada kullanılması

`asic_rtl/testbench/tb_asic_mem_equiv.sv`, SRAM makrolarının davranışsal
OpenRAM modellerini doğrudan sürerek ASIC bellek sarmalayıcılarının orijinal
FPGA modülleriyle **birebir eşdeğer** olduğunu kanıtlar: rastgele okuma/yazma
dizileri, bütün ROM adreslerinin taranması ve okuma gecikmesinin doğrulanması.

```bash
# XSim ile (Vivado ortamı gerekir)
xvlog --relax  $PDK_ROOT/sky130A/libs.ref/sky130_sram_macros/verilog/sky130_sram_{2kbyte_1rw1r_32x512_8,1kbyte_1rw1r_32x256_8}.v
xvlog -sv --relax -d SRAM_SIM  <asic_rtl/mem/*.sv, asic_rtl/gen/*, tb_asic_mem_equiv.sv>
xelab --relax -debug off tb_asic_mem_equiv -s tb_mem && xsim tb_mem -runall
```

Sonuç: **12.592 kontrolün tamamı geçti** (0 fark).

Ayrıca mevcut **sistem seviyesi testbench'leri** de ASIC yapılandırmasıyla
(SRAM makroları + mask ROM'lar) koşturulmuştur:

```bash
cd asic
python3 scripts/run_asic_sim.py mem    # bellek eşdeğerliği
python3 scripts/run_asic_sim.py boot   # Boot ROM -> QSPI flash -> Instruction RAM
python3 scripts/run_asic_sim.py yz     # YZ hızlandırıcı çıkarımı
```

| Test | Ne sürüyor | Sonuç |
|---|---|---|
| `tb_asic_mem_equiv` | Bütün SRAM makroları ve mask ROM'lar | 12.592/12.592 kontrol geçti |
| `boot_test` | Boot ROM (mask ROM) + Instruction RAM ve Data RAM SRAM'leri | **BAŞARILI**, 15 AXI arayüzünde 0 ihlal |
| `ai_accel_test` | YZ girdi RAM'i + konvolüsyon tamponu SRAM'leri, ağırlık mask ROM'ları | **BAŞARILI**, 15 AXI arayüzünde 0 ihlal |

Bu, şartname Bölüm 1.3'ün "zorunlu SRAM makrosu tasarımın işlevsel veri yoluna
bağlanmalı ve işlevsel doğrulama testlerinde kullanılmalıdır" şartını sistem
seviyesinde karşılar.

> **XSim notu:** PDK'nın OpenRAM davranışsal modelleri `mem` dizisini
> bildiriminden önce kullanıyor; XSim bunu varsayılan ayarda hata sayar.
> Modele dokunmamak için derleme `--relax` ile yapılır (`run_asic_sim.py`
> bunu kendisi ekler).

---

## Zamanlama kısıtları ve istisnaları

Kısıt dosyası: [`constraints/design.sdc`](constraints/design.sdc) — hem PnR
(`PNR_SDC_FILE`) hem nihai signoff STA (`SIGNOFF_SDC_FILE`) aynı dosyayı kullanır.

| Kısıt | Değer / durum |
|---|---|
| Birincil saat | `clk_i`, periyot **20 ns (50 MHz)** |
| Generated clock | **Yok** — tasarımda üretilmiş/bölünmüş saat yok |
| Birden fazla saat alanı | **Yok** — tek saat alanı |
| Asenkron saat grubu | **Yok** |
| Giriş gecikmesi | Periyodun `IO_DELAY_CONSTRAINT` oranı kadar, saat dışı bütün girişlere |
| Çıkış gecikmesi | Aynı değer, bütün çıkışlara (çift yönlü pinler dâhil) |
| Saat belirsizliği | PDK/LibreLane değeri, açıkça uygulanır |
| Giriş geçiş süresi | `set_driving_cell` ile, `SYNTH_DRIVING_CELL` |
| Çıkış yükü | `set_load`, `OUTPUT_CAP_LOAD` |
| Tasarım kuralları | `set_max_fanout`, `set_max_transition`, `set_max_capacitance` |
| **False path** | **Yalnızca bir tane:** `set_false_path -from [get_ports rst_ni]` |
| **Multicycle path** | **Yok** |

### Neden `rst_ni` false path?

`rst_ni` bütün tasarımda `always_ff @(posedge clk_i or negedge rst_ni)`
biçiminde kullanılan **asenkron, aktif-LOW** reset girişidir. Asenkron
uygulandığı için assert yolu zamanlanamaz. Recovery/removal kontrolü ise
resetin **ASIC bloğunun dışında** `clk_i`'ye senkronize edilerek bırakıldığı
varsayımına dayanır — FPGA gerçeklemesinde bu iki aşamalı senkronizatör
`fpga_top.sv` içindeydi ve blok kapsamı dışında kalır. Bu, gerçekte
zamanlanması gereken bir yolun gizlenmesi değildir; blok arayüzüne ilişkin
bir varsayımdır ve *Bilinen sorunlar* bölümünde de kayıtlıdır.

### `I2C_SCL` ve `QSPI_SCLK` neden generated clock değil?

İkisi de saat gibi görünen çıkış pinleridir ama tasarım içinde **saat olarak
kullanılmazlar**: `clk_i` ile sürülen birer flip-flop çıkışıdır
(`I2C_Master_AXI4_Lite.sv:113`, `QSPI_Master_AXI4_Lite.sv:172`). Bu yüzden
normal çıkış olarak `set_output_delay` ile kısıtlanmışlardır.

### Bilinen kısıt eksiklikleri

Tasarımın **bütün senkron yolları** kısıtlanmıştır. Çevre birimi arayüzleri
(UART, I2C, QSPI, GPIO) harici cihazlarla asenkron protokoller üzerinden
haberleşir; bunlar için gerçek bir harici zamanlama sözleşmesi tanımlanmamış,
bunun yerine hepsine periyodun aynı oranında tek tip giriş/çıkış gecikmesi
verilmiştir. Kart seviyesinde tape-out yapılacaksa bu gecikmelerin gerçek
hedef sisteme göre yeniden belirlenmesi gerekir.

---

## Fiziksel tasarım yapılandırması

| | |
|---|---|
| Die alanı | **3500 × 3210 µm = 11,235 mm²** (`FP_SIZING: absolute`) |
| Core alanı | LibreLane varsayılan iç boşluğuyla die'dan türetilir |
| Floorplan en/boy oranı | 3500 / 3210 = 1,090 |
| Makro alanı | 4,174 mm² — die'ın **%37,2**'si |
| Standart hücrelere kalan | 7,061 mm² |
| Hedef yerleştirme yoğunluğu | `PL_TARGET_DENSITY_PCT: 35` |
| Makro halo | 20 µm (yatay ve dikey) |
| Giriş/çıkış pini yerleşimi | `IO_PIN_PLACEMENT_MODE: matching` (LibreLane varsayılanı) |
| Yönlendirme katmanları | met1 … met5 (li1 yollamaya kapalı, PDK varsayılanı) |
| Güç ve toprak ağları | `VPWR` / `VGND` |
| Güç dağıtım ağı | LibreLane/SKY130 varsayılan çok katmanlı PDN; makrolar `PDN_CONNECT_MACROS_TO_GRID` ile şebekeye bağlanır |
| Makro güç bağlantıları | `vccd1` → `VPWR`, `vssd1` → `VGND` |
| Makro yerleşimi | Elle — [`constraints/macro_placement.cfg`](constraints/macro_placement.cfg) |
| Clock tree synthesis | `OpenROAD.CTS`, `CTS_APPLY_NDR: none` (`CTS_OBSTRUCTION_AWARE` varsayılan hâlinde bırakıldı) |
| Yönlendirme katman payı | `GRT_LAYER_ADJUSTMENTS: [0, 0,55, 0,5, 0,1, 0,05, 0,05]` |
| Azami fan-out | `MAX_FANOUT_CONSTRAINT: 25` |
| Otomasyon dosyaları | [`Makefile`](Makefile) + [`scripts/`](scripts/) |

### Makro yerleşimi

15 SRAM makrosu **3 sütun × 5 satırlık** bir ızgaraya yerleştirilir; koordinatlar
`scripts/gen_macro_placement.py` tarafından sentezlenmiş netlist'ten üretilir,
elle yazılmaz (`--grid {4x4,3x5}` ile ızgara seçilir).

- **Yön hepsi `N` — makrolar döndürülmez.** SRAM'lerin güç pinleri met3 üzerinde
  **yatay** şeritlerdir; PDN'in met4 **dikey** şeritleri bunları dik keserek
  bağlanır. 90° döndürülürse ikisi paralel kalır ve makro güç bağlantısı
  güvenilmez hâle gelir.
- **Sütun arası 400 µm, satır arası 200 µm.** Gerekçesi aşağıdaki bölümdedir.
- **Banka yerleşimi.** IMEM ve DMEM'in dörder bankası 2×2 küme olarak bitişik
  tutulur — her belleğin 32-bit veri yolu, adresi ve bayt maskesi tek bir AXI
  denetleyicisinde toplandığı için bankalar die'a yayılırsa bu yollar cipin
  üstünden geçen bir tel yıldızına döner. 3 sütunlu ızgarada bir belleğin dikey
  yığın olması kaçınılmazdır; bunun için YZ girdi RAM'i seçilmiştir, çünkü
  hızlandırıcı oraya çevrim başına tek kelime erişir ve CPU'nun kritik yolunda
  değildir. Konvolüsyon tamponunun iki bankası üst satırda yan yanadır.

### Die alanı ve kanal genişliği nasıl belirlendi?

Belirleyici olan sentez alanı değil, **global routing tıkanmasıydı.** İlk sekiz
denemede yollama yakınsamadı; die boyutu, hücre dolgusu, yerleştirme yoğunluğu
ve makro aralığı tek tek denendi ve **die büyütmek ölçüm bazında ters etki
yaptı** (3600 × 3200 denemesi 257.887 overflow ile 3400 × 2900'ün 133.432'sinden
kötüydü). Yön veren ölçüm, en iyi denemenin nihai tıkanma raporu oldu:

```
Layer      Resource      Demand     Usage (%)   Total Overflow
met1         888056      601397       67.72%           19359
met2        1026462      635853       61.95%           29847
met3         929323      423739       45.60%           13036
met4         628088      178356       28.40%            9149
met5         116039       26994       23.26%            1518
Total       3587968     1866339       52.02%           72909
```

Ortalama kaynak kullanımı yalnızca **%52**'dir — yani genel bir kaynak darlığı
yoktur. Sorun **yereldir**, ve die büyütmenin neden yardım etmediğini de bu
açıklar.

Yerel darlığın sebebi SRAM makrolarının LEF'indeki engel (`OBS`) tanımlarında
bulundu. `sky130_sram_2kbyte_1rw1r_32x512_8.lef` üzerinde ölçülen değerler:

| Katman | Yön | Makro üzerinde durum |
|---|---|---|
| met1 | yatay | tek `RECT` ile **tamamen kapalı** |
| met2 | **dikey** | tek `RECT` ile **tamamen kapalı** |
| met3 | yatay | 61 `RECT`, alanın %98,1'i kapalı; kesintisiz geçiş yolu **yok** |
| met4 | **dikey** | 143 `RECT`, alanın %98,8'i kapalı; kesintisiz geçiş yolu **yok** |
| met5 | yatay | engel tanımı **yok** — tamamen serbest |

SKY130'da dikey yönlü iki katman met2 ve met4'tür; **ikisi de makro üzerinden
geçemez.** Dolayısıyla cipin bir yanından diğerine giden her dikey tel yalnızca
makrolar *arasındaki* sütun kanallarından geçebilir. Yatay tarafta ise met5 makro
üzerinde serbesttir, yani kaçış yolu vardır. met2'nin neden en kötü katman
olduğunu bu asimetri açıklar.

Makronun 125 sinyal pininin dağılımı da aynı yöndedir: **73 alt, 35 üst**
kenarda, yalnızca 10 sol + 7 sağ. Yani satır kanalları pin kaçışı için, sütun
kanalları ise die'ı boydan boya kesen dikey trafik için gereklidir.

Buna göre ızgara 4×4'ten **3 sütun × 5 satıra** alındı:

| | 4×4 (1–9. denemeler) | 3×5 (kullanılan) |
|---|---:|---:|
| İç dikey kanal (met2/met4) | 3 × 120 = **360 µm** | 2 × 400 = **800 µm** |
| İç yatay kanal (met1/met3) | 3 × 250 = 750 µm | 4 × 200 = 800 µm |
| Die | 3500 × 3000 = 10,500 mm² | 3500 × 3210 = 11,235 mm² |
| Makro alanı oranı | %39,8 | %37,2 |

Die yalnızca **yükseklikte** 210 µm büyütülmüştür; böylece sütun kanalları
genişlerken satır kanalları daralmamıştır. Genişlik sabit tutulmuştur çünkü
sabit die genişliğinde toplam dikey kanal payı `3500 − 3 × 683,1 = 1450,7 µm`
olarak sütun sayısıyla belirlenir; kazanç sütun sayısını 4'ten 3'e indirmekten
gelir, die'ı genişletmekten değil.

Yollamayı rahatlatan iki ayar daha kullanılmıştır:

- **`GRT_LAYER_ADJUSTMENTS: [0, 0,55, 0,5, 0,1, 0,05, 0,05]`.** met1/met2'nin
  kaynağı bilerek kısılır, met3–met5 serbest bırakılır; böylece yollama üst
  katmanlara itilir. Tek başına overflow'u 133.432'den 72.909'a indirmiştir.
- **`CTS_APPLY_NDR: none`.** CTS varsayılan olarak saat ağlarına genişletilmiş
  tel/aralık kuralı (NDR) uygular. Bu tasarımda saat ağacı ≈1.270 net içerir ve
  NDR'li bu ağlar met1/met2 kaynağını tüketir. Daha önemlisi: global router
  tıkanmayı çözemeyince NDR'leri tek tek devre dışı bırakıp 50 iterasyonluk turu
  her seferinde baştan başlatır (`GRT-0273` → `GRT-0102` döngüsü). Bir koşumda
  bu döngüye beş kez girdi ve GRT 6,8 saat sürdü. NDR'yi baştan kapatmak hem
  kaynağı serbest bırakır hem bu döngüyü ortadan kaldırır.
  `CTS_OBSTRUCTION_AWARE` bilerek **açılmamıştır** — denendiğinde saat ağacını
  makroların etrafından dolaştırıp toplam tel uzunluğunu artırdı.

Denemelerin tam listesi ve ölçümleri
[`reports/synthesis/strateji_denemeleri.md`](reports/synthesis/strateji_denemeleri.md)
dosyasındadır.

Standart hücre alanı sentezde **0,770 mm²**'dir (67.985 hücre); zamanlama
optimizasyonu sonrasında **1,155 mm²**'ye (183.080 hücre) çıkar. Artışın büyük
kısmı resizer'ın eklediği **23.269 zamanlama onarım tamponudur** (0,225 mm²);
bunlara 1.984 saat tamponu + 288 saat eviricisi ve 89.569 tap hücresi eklenir.
Bu yüzden die, sentez sonrası değil **optimizasyon sonrası** alana göre
boyutlandırılmıştır. (Sayılar bu koşumun `37-openroad-resizertimingpostcts`
adımının metriklerindendir; nihai değerler aşağıdaki signoff özetindedir.)

---

## Lint sonuçları ve istisnaları

| | |
|---|---|
| Lint aracı / adım | Verilator — `Verilator.Lint` |
| Tam çıktı | [`reports/lint/verilator_lint.log`](reports/lint/) |
| Lint waiver dosyası | **Kullanılmadı** |
| Kapatılan uyarı | LibreLane varsayılanları dışında **yok** |

LibreLane'in varsayılan olarak kapattığı uyarılar `DECLFILENAME`, `EOFNEWLINE`
(genel) ile kara kutu modelleri için `UNDRIVEN`, `UNUSEDSIGNAL`'dir. Bu
varsayılanlar **değiştirilmemiştir**; ek olarak hiçbir uyarı bastırılmamıştır.

`LINTER_ERROR_ON_LATCH` ve `LINTER_ERROR_ON_MULTIDRIVEN` varsayılan olarak
açıktır ve açık bırakılmıştır.

Kalan lint uyarıları ağırlıklı olarak `WIDTHEXPAND` / `WIDTHTRUNC` türündedir;
büyük çoğunluğu CV32E40P çekirdeğinden ve üçüncü taraf paketlerden gelir
(genişliği açıkça daraltılmış sabit atamalar). Bunlar kabul edilmiştir:
davranışları FPGA gerçeklemesinde doğrulanmış, üçüncü taraf koda dokunmama
ilkesiyle de tutarlıdır.

---

## Bilinen sorunlar ve kabul edilmiş istisnalar

### 1. RTL'de sürülmeyen sinyaller — düzeltildi (yamalı kopya ile)

Yosys'in sentez öncesi yapısal kontrolü ilk koşuda **91 bit sürülmeyen sinyal**
buldu ve akış bu yüzden durdu. Üç kök neden vardı; üçünde de ilgili sinyalin
**değeri zaten sabitti**, RTL bu sabiti açıkça yazmıyordu (Vivado sessizce 0'a
bağlıyordu):

| Kaynak | Bit | Sorun | Yama |
|---|---:|---|---|
| `GPIO`, `Timer`, `QSPI`, `UART_GU`, `UART_YZ` | 20 | `RRESP`/`BRESP` yalnızca reset dalında 0 atanmış | Reset ataması kaldırılıp `assign … = 2'b00;` (OKAY) |
| `instr_bram_axi_ctrl` | 2 | `axi_instr_bram_rresp` aynı durumda | Aynı |
| `cv32e40p_obi_to_axi_wrapper` | 67 | Komut (fetch) portunun kullanılmayan AXI **yazma** kanalı çıkışları hiç atanmamış | Pasif değerlere açık `assign` |
| `obi_to_axi` | 2 | `obi_rsp_o.r.r_optional`, ilgili özellikler kapalı olduğu için hiçbir generate dalında sürülmüyor | Kapalı durum için `else` dalı, `'0` |

Yamalardan sonra sonuç **0 sürülmeyen sinyal**'dir. Yamalar
`scripts/patch_rtl.py` tarafından üretilir, orijinal dosyalara dokunulmaz.

> **Öneri:** Bu düzeltmeler ana RTL'e de alınmalıdır. `RRESP`/`BRESP` sürmeyen
> bir AXI4-Lite slave, araç değiştiğinde farklı davranabilir.

### 2. YZ hızlandırıcının MAC yolu boru hattına alındı

Bu, ASIC varyantında **davranışı etkileyen tek değişikliktir**; bu yüzden ayrıca
belgelenmiştir.

Orijinal RTL çarpma ile birikimi tek çevrimde yapıyor:

```verilog
acc[ci] <= acc[ci] + ($signed({1'b0, ram_rdata}) - INPUT_ZP) * $signed(w_dout[8*ci +: 8]);
```

FPGA'da bu ifade **DSP48E1** hard-makrolarına gidiyordu; SKY130'da böyle bir
blok olmadığı için standart hücre çarpanı + 32-bit toplayıcı zincirine dönüşüyor
ve 20 ns'lik periyodu aşıyor. İlk ASIC koşusunda tasarımın **bütün setup
ihlalleri (254 uç) tam olarak bu yollardaydı**; başlangıç noktası her seferinde
YZ girdi RAM'i veya konvolüsyon tamponu SRAM'inin çıkışıydı.

Bu yüzden çarpma ile birikim ayrı evrelere alındı (`prod` / `v_s3`, FC tarafında
`f_prod` / `f_v3`); boşaltma sayaçları 2'den 3 çevrime çıkarıldı.

**Sonuç bit-exact'tir.** Üç referans ses örneğinde sınıf ve dört FC skorunun
tamamı birebir aynı; tek fark çevrim sayısıdır: 45.517 → 46.018 (**+%1,1**).
Tap başına 1 çevrimlik verim değişmedi; yazılıma göre hızlanma 276,9× yerine
274,0× olur. Kanıt: [`reports/general/yz_boru_hatti_esdegerlik.md`](reports/general/yz_boru_hatti_esdegerlik.md)
ve [`../asic_rtl/README.md`](../asic_rtl/README.md).

> FPGA gerçeklemesi bu değişiklikten **etkilenmez**: yama yalnızca
> `asic_rtl/patched/conv_accelerator_asic.v` dosyasını üretir, orijinal
> `FPGA/main_codes/rtl/desgin_sources/AI_Accelerator/conv_accelerator.v`
> dosyasına dokunulmaz.

### 3. `obi_to_axi.sv` — sıfır genişlikli parça-seçim

`AxiDataWidth == ObiCfg.DataWidth` (ikisi de 32) olduğunda `$clog2(1) = 0`
olur ve sıfır genişlikli parça-seçim SystemVerilog'da geçersizdir (LRM 11.5.1).
İlgili `if` dalı bu yapılandırmada hiç alınmaz. Yamalı kopyada genişlik ifadesi
en az 1 olacak şekilde sarmalanmıştır; üretilen donanım değişmez.

### 4. Reset senkronizatörü blok dışındadır

`top_module` içinde reset senkronizatörü yoktur; `rst_ni`'nin harici olarak
`clk_i`'ye senkronize edilerek bırakıldığı varsayılır (bkz. *Zamanlama
kısıtları*). Blok bağımsız bir çip olarak üretilecekse bir reset senkronizatörü
eklenmesi gerekir.

### 5. SRAM Liberty modeli tek corner

Bkz. *SRAM ve fiziksel makrolar* bölümündeki not. Yavaş/hızlı corner
sonuçları SRAM gecikmesi açısından tipik değere dayanır.

### 6. Aynı adrese eşzamanlı okuma/yazma

OpenRAM 1RW+1R makrolarında aynı adrese aynı çevrimde yazıp okumak tanımsızdır
ve davranışsal model bu durumda uyarı basar.

Sistem simülasyonlarında bu uyarı **YZ girdi RAM'inde, yalnızca DMA yükleme
sırasında** görülür: `bram_yz`'nin okuma portu her çevrim etkindir ve
hızlandırıcı boştayken okuma adresi 0'dır; DMA da yüklemeye adres 0'dan başlar.
Okunan değer o sırada **hiçbir yerde kullanılmaz** (hızlandırıcı `S_IDLE`
durumundadır), dolayısıyla işlevsel etkisi yoktur — sistem testleri hem boot
hem YZ senaryosunda 0 protokol ihlaliyle geçmiştir.

Instruction RAM ve Data RAM'de bu durum oluşmaz: CPU veri portu OBI üzerinden
tek kanallıdır ve aynı çevrimde hem okuma hem yazma üretemez. Eşdeğerlik
testbench'i de çakışan erişimi bilerek üretmez.

### 7. DDK tarafından kabul edilmiş istisnalar

**Yok** — bu teslimde önceden onay alınmış bir istisna bulunmamaktadır.

---

## Güç ve IR-drop analizi

| | |
|---|---|
| Analizde kullanılan saat frekansı | 50 MHz (20 ns) |
| Kullanılan corner'lar | `tt_025C_1v80`, `ss_100C_1v60`, `ff_n40C_1v95` |
| Besleme gerilimi | Corner'a göre 1,80 V / 1,60 V / 1,95 V |
| Switching activity girdisi | **Kullanılmadı** |
| Switching activity dosyası | Yok |
| Özel gerilim kaynağı konum dosyası | **Kullanılmadı** |
| Güç sonuçlarının niteliği | **TAHMİNÎ** |

Açık bir switching activity (VCD/SAIF) girdisi verilmediği için OpenSTA'nın
varsayılan geçiş aktivitesi varsayımları geçerlidir; bu nedenle bütün güç
sonuçları **tahminî** olarak işaretlenmelidir. Aynı şekilde IR-drop analizi
özel bir gerilim kaynağı konum dosyası olmadan, PDN'in standart besleme
noktalarıyla yapılmıştır.

Raporlar: [`reports/power/`](reports/power/) — corner başına `power.rpt`,
genel `irdrop.rpt` ve düğüm bazlı `net-*.csv`.

---

<!-- SONUC-OZETI-BASI -->
## Signoff sonuç özeti

*(Akış tamamlandığında `scripts/collect.py` çıktısından doldurulacaktır.)*
<!-- SONUC-OZETI-SONU -->

---

## Rapor ve çıktı konumları

Bütün raporlar ve çıktılar **tek bir LibreLane çalışmasından** üretilmiştir;
akış sonrasında elle düzenlenmemiştir.

| Şartname maddesi | Konum | İçerik |
|---|---|---|
| 5.1 Genel akış | [`reports/general/`](reports/general/) | `flow.log`, `warning.log`, `error.log`, `resolved.json`, `metrics.csv`, `metrics.json` |
| 5.2 Lint | [`reports/lint/`](reports/lint/) | `verilator_lint.log` |
| 5.3 Sentez | [`reports/synthesis/`](reports/synthesis/) | `stat.rpt`, `stat.json`, `latch.rpt`, `pre_synth_chk.rpt`, `chk.rpt` |
| 5.4 Fiziksel tasarım | [`reports/routing/`](reports/routing/) | `wire_lengths.csv`, detaylı yollama DRC işaretleri |
| 5.5 Zamanlama | [`reports/timing/`](reports/timing/) | `summary.rpt` + corner başına alt dizin |
| 5.6 Fiziksel signoff | [`reports/drc/`](reports/drc/), [`reports/lvs/`](reports/lvs/), [`reports/antenna/`](reports/antenna/), [`reports/pdn/`](reports/pdn/), [`reports/signoff/`](reports/signoff/) | Magic/KLayout DRC, Netgen LVS, anten, PDN grid hataları, bağlantısız pinler, XOR farkı, üretilebilirlik özeti |
| 5.7 Güç ve IR-drop | [`reports/power/`](reports/power/) | corner başına `power.rpt`, `irdrop.rpt`, `net-*.csv` |
| 6.1 Zorunlu görünümler | [`results/gds/`](results/gds/), [`results/lef/`](results/lef/), [`results/def/`](results/def/) | `top_module.gds`, `top_module.lef`, `top_module.def` |
| 6.2 Zorunlu ek çıktılar | [`results/netlist/`](results/netlist/), [`results/sdc/`](results/sdc/), [`results/spef/`](results/spef/), [`results/spice/`](results/spice/), [`results/config/`](results/config/), [`results/metrics/`](results/metrics/) | Sentez sonrası ve post-PnR netlistler, SDC, SPEF, SPICE, çözümlenmiş yapılandırma, metrikler |
| 6.3 Önerilen ek çıktılar | [`results/odb/`](results/odb/), [`results/sdf/`](results/sdf/), [`results/lib/`](results/lib/), [`results/mag/`](results/mag/), [`results/images/`](results/images/), [`checksums/`](checksums/) | OpenROAD veritabanı, SDF, Liberty, Magic layout, yerleşim görüntüsü, SHA-256 özetleri |

Nihai GDSII dosyası `results/gds/top_module.gds`'tir ve **Magic** tarafından
üretilmiştir; KLayout'un ürettiği ikinci GDSII görünümü ile arasındaki geometrik
fark [`reports/signoff/`](reports/signoff/) altındaki XOR raporundadır.

LibreLane çalışma etiketi: **`rtl2gds`**.

---

## Üçüncü taraf bileşenler ve lisanslar

Ayrıntılı liste, sürümler, lisanslar ve takım tarafından yapılan değişikliklerin
özeti: [`THIRD_PARTY.md`](THIRD_PARTY.md). Lisans metinleri:
[`licenses/`](licenses/).
