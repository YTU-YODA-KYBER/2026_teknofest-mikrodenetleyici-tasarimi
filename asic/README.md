# asic — ASIC Fiziksel Tasarım Akışı

**YTU YODA KYBER — TEKNOFEST 2026 Çip Tasarım Yarışması (Mikrodenetleyici Kategorisi)**

FPGA'de doğruladığımız SoC'nin **LibreLane 3.0.6 Classic** akışıyla **SKY130**
teknolojisinde fiziksel tasarıma dönüştürülmüş hâli. Bu klasör akışın bütün
girdilerini (RTL listesi, yapılandırma, kısıtlar, makro görünümleri), akışı
yeniden çalıştıran otomasyonu ve üretilen bütün rapor + nihai çıktıları içerir.

Tasarım, şartname Bölüm 2 uyarınca **üst seviye bir ASIC bloğu** olarak
teslim edilir: I/O pad ring, bond pad, ESD hücresi ve seal ring kapsam dışıdır;
tasarımın bütün giriş/çıkışları nihai LEF ve DEF görünümlerinde makro pinleridir.

> **Teslim durumu:** Son toplanan `i2c_20260907_final` fiziksel sonucu güncel
> I2C entegrasyonunu içeren RTL'i temsil eder ve
> yollama/Magic/KLayout DRC, LVS, XOR, PDN ve dokuz köşede setup/hold
> kontrollerini sıfır ihlalle geçmiştir; ancak **1.067 net / 1.122 pin anten
> ihlali** vardır. Bu nedenle Final Çıktılar §2'de DRC, LVS, anten ve zamanlama
> kontrollerinin birlikte sağlanması olarak tanımlanan **“üretime hazır” koşulu
> tam karşılanmamaktadır**.

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
| [`experiments/`](experiments/) | Fiziksel tasarım kararlarının dayandığı **tanısal yapılandırma katmanları**. İkisi (`grt_layer_met3_009.yaml`, `antenna_jumper.yaml`) resmî üç fazlı `make asic_run` zincirinin parçasıdır; geri kalanı araştırma kaydıdır | Elle yazıldı; her birinin izole ettiği değişken ve ölçülen sonuç [`experiments/README.md`](experiments/README.md)'de |
| [`reports/synthesis/strateji_denemeleri.md`](reports/synthesis/strateji_denemeleri.md) | Sentez ve fiziksel tasarım denemelerinin ölçüm kaydı; hangi ayarın ne kadar etki ettiği | Elle yazıldı, sayılar akış loglarından |
| [`reports/synthesis/deney_arsivi/`](reports/synthesis/deney_arsivi/) | 25 koşumun ham kanıtı: `resolved.json`, GRT/DRT log özetleri, `or_metrics_out.json`, DRC dökümü | Koşum dizinlerinden arşivlendi |
| [`reports/timing/frekans_kalibrasyonu.md`](reports/timing/) | Beyan edilen saat frekansının **ölçüm** kaydı | `scripts/calibrate_clock.py` üretir |
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
| `gen_macro_keepout.py` | 15 makronun çevresindeki met1 keep-out'ları `macro_placement.cfg`'den türetip `config.yaml`'daki `ROUTING_OBSTRUCTIONS` bloğuna yazar (`--check` ile bayatlık denetimi) |
| `calibrate_clock.py` | Beyan edilecek saat periyodunu **ölçerek** seçer: tek bir CTS veritabanı üzerinde `ResizerTimingPostCTS` adımını farklı `CLOCK_PERIOD` değerleriyle koşup çok-corner setup sonucunu karşılaştırır |
| `gen_versions.py` | `environment/versions.txt`'i kurulu ortamdan okuyarak yazar |
| `run_asic_sim.py` | ASIC yapılandırmasını (SRAM makroları + mask ROM'lar) mevcut testbench'lerle XSim'de koşturur |
| `collect.py` | Akış çıktılarını `reports/` ve `results/` ağacına taşır |
| `gen_readme_results.py` | Bu dosyadaki *Signoff sonuç özeti* bölümünü `metrics.json`'dan doldurur |
| `verify_deliverables.py` | Zorunlu rapor/çıktıların varlığını denetler, signoff metriklerini özetler |
| `gen_checksums.py` | SHA-256 özetlerini üretir |
| `filelist.py` | `filelist.f` ayrıştırıcısı (diğer betikler kullanır) |

Ek olarak [`experiments/`](experiments/) dizini, alınan fiziksel tasarım
kararlarının dayandığı **tanısal yapılandırma katmanlarını** içerir. Bunların
büyük çoğunluğu araştırma amaçlıdır ve teslim akışında kullanılmaz; her
birinin izole ettiği değişken ve ölçülen sonuç
[`experiments/README.md`](experiments/README.md) dosyasındadır.

> **İSTİSNA — iki overlay resmî teslim akışının parçasıdır.** `make asic_run`
> üç fazlıdır ve `config.yaml`'a ek olarak şu ikisini kullanır:
> `experiments/grt_layer_met3_009.yaml` (faz 2 ve 3) ve
> `experiments/antenna_jumper.yaml` (faz 3). Bunlar araştırma overlay'leri
> arasından **ölçümle seçilip** resmî Makefile zincirine alınmıştır; gerekçeleri
> madde 3 ve 8'dedir. `scripts/verify_deliverables.py` her ikisinin fiilen
> kullanıldığını ve `flow.log`'da tam üç başlangıç bulunduğunu denetler.

---

## Tasarım özeti

| | |
|---|---|
| **En üst seviye modül** | `top_module` |
| **Amaç** | RISC-V CV32E40P çekirdekli, AXI4-Lite çevre birimli ve konuşma tanıma YZ hızlandırıcılı mikrodenetleyici |
| **Saat portu** | `clk_i` — tek saat alanı, **28 MHz (35,714286 ns)** — beyan edilen ASIC hedefi. Nihai post-route STA dokuz signoff corner'ının tamamında **kapanmıştır**: setup ve hold ihlalli uç sayısı 0 |
| **Reset portu** | `rst_ni` — asenkron, aktif-LOW |
| **Temel arayüzler** | 32-bit GPIO giriş/çıkış, 8+8 bit 7-segment sürücü, 2× UART (TX/RX), I2C (SCL + çift yönlü SDA), QSPI (SCLK, CS, çift yönlü IO0–IO3) |
| **Bloklar** | CV32E40P (RV32IMC, FPU=0) · OBI↔AXI4 köprüsü · AXI4 ara bağlantı · komut ayırıcı · Boot ROM · Instruction RAM · Data RAM · YZ RAM · GPIO · Timer · I2C · QSPI · UART_GU · UART_YZ · YZ hızlandırıcı |

Blokların işlevsel açıklaması ve bellek haritası:
[`../FPGA/README.md`](../FPGA/README.md).

FPGA gerçeklemesiyle **aynı RTL** kullanılır; farklar teknolojiye bağlı
olanlarla sınırlıdır (bkz. *RTL ve akış girdileri*). Davranışa dokunan
değişiklikler **dört tanedir** ve her biri *Bilinen sorunlar* bölümünde
gerekçesiyle belgelenmiştir:

| # | Değişiklik | Etkisi |
|---|---|---|
| Madde 2 | YZ hızlandırıcının MAC yolu boru hattına alındı (SKY130'da DSP48 yok) | Çıkarım sonucu **bit-exact aynı**; çevrim sayısı 45.517 → 46.018 (%+1,1) |
| Madde 7 | I-RAM'in veri okuma yolu bağlandı | Orijinalde CPU `0x1000_0000`'dan veri okursa **kilitleniyordu**; bu bir düzeltmedir |
| Madde 0.3 | SRAM aynı-adres okuma/yazma semantiği | FPGA read-first yerine "son geçerli veriyi tut"; OpenRAM'de o durum zaten **tanımsız** |
| UART RX | İki UART alıcısındaki 16× alt sayaç kaldırıldı | Her veri biti, TX bit süresiyle aynı `UART_CPB` aralığında bit merkezinden bir kez örneklenir |

Bunların dışında ASIC'e özgü olan her şey (SRAM makro sarmalayıcıları, mask
ROM'lar, tri-state stub'ı, reset senkronizatörü, sürülmeyen AXI yanıt kodlarının
açıkça atanması) **işlevsel olarak nötrdür**; beş regresyonun tamamı geçer.

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

#### Ortam değişkenleri

| Değişken | Zorunlu mu | Ne işe yarar |
|---|---|---|
| `PDK_ROOT` | Hayır | PDK dizini. Tanımlı değilse `ciel` varsayılanı kullanılır. |
| `ASIC_RUN_ROOT` | Hayır | LibreLane çalışma alanının kökü. **Varsayılan `asic/run/`** (göreli). Diski dolan makinelerde başka bir diske yönlendirmek için kullanılır; depoda hiçbir mutlak yol tutulmaz. |
| `VIVADO_ROOT` | Yalnızca `make asic_sim` için | `make asic_sim` beş işlevsel regresyonu **Vivado XSim** ile koşar; Vivado kurulum dizini bu değişkenle verilir. `make asic_run` Vivado'ya **ihtiyaç duymaz.** |

> `make asic_run` yalnızca Nix ortamına ve PDK'ya bağlıdır. Vivado gerektiren tek hedef `make asic_sim`'dir ve zorunlu ASIC akışının parçası değildir.

### `make asic_run` ne yapıyor?

1. **Ortam denetimi** (`check_env`): `librelane` ve Python paketi bulunabiliyor mu.
2. **Girdiler üretilir** (`prepare`):
   - `gen_rom.py --all` → Boot ROM ve YZ ağırlık ROM'larının RTL'i (hex içeriği gömülü)
   - `patch_rtl.py` → yamalı RTL kopyaları
   - `gen_filelist.py` → `filelist.f` + `config.yaml` eşitlemesi
   - `gen_macro_keepout.py` → `config.yaml`'daki `ROUTING_OBSTRUCTIONS` bloğu
3. `run_flow.py` LibreLane Classic akışını `asic/run/<etiket>/` altında çalıştırır.
4. `collect.py` raporları `asic/reports/`, nihai çıktıları `asic/results/` altına taşır.
5. `gen_versions.py` ve `gen_readme_results.py` sürüm bilgisini ve bu dosyadaki
   *Signoff sonuç özeti* bölümünü akışın kendi metriklerinden tazeler.
6. `gen_checksums.py` SHA-256 özetlerini yazar.
7. `asic_verify` teslim paketini denetler (üretilen dosyaların bayat olmadığı
   dâhil) ve eksik zorunlu kalem varsa **sıfırdan farklı çıkış kodu** döner.

Kullanıcı etkileşimi veya grafik arayüz gerekmez, makineye özgü mutlak yol
kullanılmaz. Koşum etiketi `RUN_TAG` ile değiştirilebilir
(`make asic_run RUN_TAG=final`); varsayılan `rtl2gds`.

Ek hedefler:

| Hedef | Ne yapar |
|---|---|
| `make asic_verify` | Şartname Bölüm 5 ve 6'daki zorunlu rapor/çıktıları tek tek arar, signoff metriklerini özetler; önce `verify_generated` koşar |
| `make verify_generated` | Üretilen RTL'in, mask ROM'ların ve makro keep-out'larının kaynaklarıyla **hâlâ uyumlu** olduğunu doğrular (bayat çıktı senteze giremez) |
| `make asic_package` | Teslim öncesi hazırlık: `run/` boşaltılır, SHA-256 özetleri yenilenir, denetim koşulur |
| `make asic_sim` | ASIC yapılandırmasının beş işlevsel regresyonunu XSim'de koşar (SRAM ve AXI assertion'ları açık) |
| `make asic_clean` | Yalnızca `asic/run/` altındaki yeniden üretilebilir dosyaları siler |
| `make prepare` | Üretilen RTL'i, mask ROM'ları, `filelist.f`'i ve keep-out'ları yeniler |

**Ölçülen çalışma süresi ve kaynak.** Teslim koşumunun gerçek duvar süresi,
üç fazın tamamı dahil, bu makinede (20 iş parçacığı / 15 GB RAM)
**yaklaşık 3,5–4,5 saat**tir. Ölçülen tekil adım süreleri: global yerleştirme
~11–15 dk, global routing ~2–3 dk, post-GRT resizer ~34 dk, detaylı yollama
~17–21 dk, Magic DRC ~29 dk, dokuz köşe post-PnR STA ~13 dk.

> Daha önceki bir README sürümü **8–12 saat** diyordu; o değer eski
> floorplan ve eski anten-onarım zincirine aitti ve ölçümle aşılmıştır.
> Süre, DRT'nin kaç iterasyonda yakınsadığına duyarlıdır: teslim koşumu
> 8 iterasyonda bitmiştir, diyot denemesinde (`deney_arsivi/diode28_rejected`)
> 17 iterasyona ve 1 sa 2 dk'ya çıkmıştır.

**Bellek uyarısı:** Magic DRC tek başına ~14 GiB tepe kullanır; bu makinede
akış sırasında ikinci bir ağır iş çalıştırılmamalıdır. Disk: tek tam koşum
için **~14 GB** boş alan gerekir.

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
kullanılmıştır. Varsayılandan farklı ayarlanan parametrelerin **tamamı**
aşağıdadır; her birinin gerekçesi ve dayandığı ölçüm de verilmiştir. Ayrıntılı
gerekçeler [`config.yaml`](config.yaml) içindeki yorum bloklarında, deneme
kayıtları
[`reports/synthesis/strateji_denemeleri.md`](reports/synthesis/strateji_denemeleri.md)
dosyasındadır.

#### Sentez ön ucu

| Parametre | Değer | Gerekçe |
|---|---|---|
| `USE_SLANG` | `true` | Yosys'in yerleşik Verilog ön ucu tasarımdaki SystemVerilog'u okuyamıyor: `cf_math_pkg.sv`'de fonksiyon içi `automatic` değişken bildirimi ve `unsigned'()` cast'ı, `fpnew_pkg.sv`'de struct tipinin paketlenmiş dizisi. `USE_SLANG` LibreLane'in **standart** bir yapılandırma parametresidir; özel adım veya özel akış değildir. |
| `SLANG_ARGUMENTS` | `--keep-hierarchy` | yosys-slang, modül sınırı korunmadığında `inout` port bağlantılarını işleyemiyor (QSPI/I2C'nin 5 tri-state pini ve `top_module`'ün çift yönlü portları). Hiyerarşi daha sonra `SYNTH_HIERARCHY_MODE: flatten` ile düzlenir. |

#### Yollama ve fiziksel tasarım

| Parametre | Varsayılan | Değer | Gerekçe |
|---|---|---|---|
| `RT_MAX_LAYER` | `met5` (PDK) | `met4` | SRAM makro LEF'i met1/met2'yi tek `RECT` ile (%99,5), met3'ü 61 `RECT` ile (%96,7) ve met4'ü 143 `RECT` ile (%97,8) kapatır; hiçbirinde kesintisiz geçiş yolu yoktur. met5 tamamen boştur ama oraya çıkmak `via4` gerektirir ve met4 makro üzerinde kapalıdır — yani met5'e ancak makro **dışından** girilebilir. Global router bu erişim kısıtını kaba ızgarada göremeyip gerçeklenemeyen yollar planlıyordu: met5 toplam talebin **%1,4**'ünü taşırken detaylı yollamadaki DRC ihlallerinin **~%67**'sini (6.056 kısa devre + 2.677 aralık) tek başına üretiyordu. Kontrollü deney: `RT_MAX_LAYER: met5` ile toplam aşım **94.692**, `met4` ile aynı veritabanında çok daha düşük. |
| `RT_CLOCK_MIN_LAYER` | (okunmuyor) | `met2` | PDK `met3` tavsiye eder (`sky130A/libs.tech/openlane/config.tcl:158`) ama LibreLane 3.0.6'da bu değişken `pdk=True` **değildir**, yani PDK değeri okunmaz ve etkin değer `met1` kalır. Ölçüm: saat `met1` → GRT tur sayısı 2; `met3` → 8+ tur, GRT 9,5 saatte bitmedi (makrolar met3/met4'ün %97'sini kapattığı için 13 NDR'li saat neti garantili tıkanık bölgeden geçiyor); **`met2` uzlaşma noktasıdır** — en dolu katmanı saat ağacına kapatır, makroların kapattığı katmanlara da kilitlemez. |
| `GRT_ADJUSTMENT` | `0.30` | `0.10` | Listedeki `0` değeri "ceza yok" **anlamına gelmez**: OpenROAD önce bu genel değeri bütün katmanlara uygular, sonra yalnızca sıfırdan farklı katman değerleri onu ezer. Genel değer %30'da kaldığı için boş duran met3/met4 de farkında olmadan %30 kısılıyordu. %10'a indirmek toplam aşımı 192.800 → 5.114 yaptı. **Daha da indirmek (%5) GERİ ALINDI** — aşağıdaki uyarıya bakın. |
| `GRT_LAYER_ADJUSTMENTS` | `[0,0,0,0,0,0]` | `[0, 0.3, 0.25, 0, 0, 0]` → teslim akışında met3 fazından itibaren **`[0, 0.3, 0.25, 0.09, 0, 0]`** | Yük alt iki katmanda sıkışıyordu; met1/met2 kapasitesi ek olarak derate edilerek yollar boş duran üst katmanlara itilir. Güncel I2C entegrasyonunun bit-özdeş netlistinde %10 post-GRT yeniden yollaması 15 aşımla durdu; %9 aynı faz-1 durumundan iki GRT'yi de sıfır aşımla geçip tam signoff'u tamamladı. |
| `GRT_OVERFLOW_ITERS` | `50` | **`30`** | Varsayılan 50, NDR kapatma döngüsünde bir GRT turunu saatlerce uzatıyordu. 20; i=8/i=20 maliyet fazlarını korur, i=35/i=50 fazlarını atlar. Bu değer sonradan **30**'a çıkarıldı (post-GRT onarım marjı sıfırlanınca artımlı GRT'ye tur payı bırakmak için; bkz. `config.yaml`). Nihai koşumun detaylı yollama sonucu **0 ihlaldir**; süre–aşım takası açıkça kabul edilmiştir. |
| `ROUTING_OBSTRUCTIONS` | (yok) | **kullanılmadı** | Makro kenarlarına 10 µm met1 keep-out denendi. GRT aşımını düşürdü ama detaylı yollamayı kötüleştirdi (aşağıdaki uyarı). `scripts/gen_macro_keepout.py` korunmuştur; `make keepout MODE=on` ile geri açılabilir. |
| `MAX_FANOUT_CONSTRAINT` | `10` (PDK) | `25` | Varsayılan, `repair_design`'ın 23.137 tampon eklemesine yol açıyordu (standart hücre alanının ~%17'si); her tampon ek net ve ek yollama talebi demektir. Ölçülen etki: aşım 133k → 73k, tampon 23.137 → 15.853. |
| `DESIGN_REPAIR_MAX_SLEW_PCT` | `20` | `0` | `repair_design` varsayılan olarak kütüphane sınırının %20 **altına** kadar onarım yapar. Bu marj tek başına 4.144 nete 15.783 tampon eklettiriyordu. Marj sıfırlanınca onarım o aşamada görülen gerçek ihlallere iner; bu bir sign-off garantisi değildir. Nihai STA **818 max-slew** ve **21 max-cap** ihlali raporlamıştır. |
| `DESIGN_REPAIR_MAX_CAP_PCT` | `20` | `0` | Aynı gerekçe. |
| `PL_RESIZER_HOLD_SLACK_MARGIN` | `0.10` | `0.02` | Post-CTS ölçümünde 0,10 marj 6.783 hold tamponu, 0,02 hedefi ~911 tampon gerektiriyordu. Bu ölçümler 38 ns dönemine aittir ve **tarihseldir**. Nihai 28 MHz koşumunda dokuz köşede post-route hold ihlali ve TNS **0**, en kötü hold payı **+0,109632 ns**'dir. Eski değerler: hold WNS −1,751 ns, TNS −260,481 ns, 2.672 ihlalli uçtur. |
| `PL_TARGET_DENSITY_PCT` | (dinamik) | `35` | Makro yoğun floorplan'da yerel yığılmayı dağıtmak için; `25` denendi ve daha kötü çıktı (aşım 258k). |
| `SIGNAL_WIRE_RC_LAYERS` | (türetilir) | `[met1..met4]` | Boş bırakılırsa LibreLane listeyi `get_layers -constrained` ile türetir, ama o proc'ta `-constrained` bayrağı **üst sınırda ters çalışır** (`scripts/openroad/common/io.tcl`): met4'ten *sonra* eklemeye başlar ve **met5 listeye girer**. Ölçümle doğrulandı: sinyal RC 4,402703e-04 (met5 dâhil, %19 iyimser) → 5,247619e-04 (doğru). |
| `CLOCK_WIRE_RC_LAYERS` | (türetilir) | `[met2, met3, met4]` | Saat ağacı met2'den başladığı için (`RT_CLOCK_MIN_LAYER`) RC tahminine met2 de girmelidir. Önceki `[met3, met4]` değeri saat direncini yaklaşık 2,57 kat iyimser alıyordu. |
| `EXTRA_EXCLUDED_CELLS` | (yok) | 6 `clkdlybuf` hücresi | PDK'nın `drc_exclude.cells` listesi yalnızca `clkdlybuf4s15_1`/`4s18_1`'i dışlar; `no_synth.cells` hepsini dışlar ama o **yalnızca sentezi** bağlar, PnR resizer'ını bağlamaz. Sonuç: OpenROAD'ın "en düşük sürüş gücü" seçimi bu **gecikme** hücrelerine düşüyordu (DEF'te 1.955 adet, kritik yolda 0,355–0,575 ns; aynı işi `buf_1/buf_2` 0,05–0,10 ns'de yapar). `dlygate4sd3_1` **bilerek** dışlanmadı — o hold onarımının doğru hücresidir. |
| `PL_MAX_PHI_COEFFICIENT` | (OpenROAD varsayılanı 1,05) | `1.02` | **Bu satır olmadan global yerleştirme yakınsamıyor.** Routability fazı "could not reach target" deyip bıraktıktan sonra düz Nesterov çözücüsü ıraksıyor: HPWL 4,6e6 → **1,8e8** (39 kat), aşım 0,37–0,41 arasında salınıyor, 5000+ iterasyonda hiçbir yere varmıyor. µ_k üst sınırını 1,02'ye çekmek yoğunluk kuvvetinin tel uzunluğu terimini ezmesini engelliyor (OpenROAD dokümanında değişkenin tanımı zaten *"Useful if global placement diverges"*). Ölçüm: varsayılan → yakınsamadı; 1,02 → `[GPL-1001]` iterasyon 5481'de bitti, **aşım 0,0999** (hedef 0,10'un altında), HPWL 6,06e6, ıraksama yok. |
| `DEDUPLICATE_CORNERS` | `true` | `true` | PnR/CTS/resizer sırasında aynı Liberty/RC kümesini tekrar yükleyen eşdeğer etiketleri tekilleştirir. Ayrı `OpenROAD.STAPostPNR` adımı `STA_CORNERS` listesindeki dokuz koşulun tamamını yine ayrı ayrı raporlar. |
| `STA_THREADS` | makinenin iş parçacığı sayısı | `1` | Dokuz OpenSTA sürecinin aynı anda açılması 16 GiB makinede yaklaşık 14 GiB RAM + 5,3 GiB swap tüketip akış sürücüsünü sonlandırdı. Corner'lar bağımsızdır; seri çalıştırma yalnız süreyi etkiler, sonucu değiştirmez. |

#### Varsayılanda bırakılan ama ölçümle doğrulanan ayar

`PL_ROUTABILITY_DRIVEN: true` açıkça yazılmıştır. `false` deneyi HPWL'yi %22
kısaltırken yerel yığılma yüzünden toplam aşımı 90'dan 113.525'e çıkarmıştır;
bu nedenle LibreLane varsayılanı korunmuştur.

#### Akışın fiziksel kontrol kapıları

| Parametre | Varsayılan | Değer | Ne yapar / ne yapmaz |
|---|---|---|---|
| `GRT_ALLOW_CONGESTION` | `false` | **`false`** | Nihai ana global routing sert aşım kapısını geçmiştir; kaba yollama aşımını görmezden gelme seçeneği açılmamıştır. |
| Fiziksel signoff hata kapıları | `true` | **DRC/LVS/XOR/PDN/illegal-overlap için `true`** | `ERROR_ON_TR_DRC`, `ERROR_ON_MAGIC_DRC`, `ERROR_ON_KLAYOUT_DRC`, `ERROR_ON_LVS_ERROR`, `ERROR_ON_XOR_ERROR`, `ERROR_ON_PDN_VIOLATIONS` ve `ERROR_ON_ILLEGAL_OVERLAPS` açıktır. Yalnız açıklanmış SRAM pinleri için `ERROR_ON_DISCONNECTED_PINS: false` ve raporlama amaçlı `ERROR_ON_LONG_WIRE: false` bırakılmıştır. |

Sentez öncesi gerçek RTL hata kapıları (`ERROR_ON_UNMAPPED_CELLS`,
`ERROR_ON_SYNTH_CHECKS`, `ERROR_ON_NL_ASSIGN_STATEMENTS`,
`ERROR_ON_LINTER_ERRORS`) `true` bırakılmıştır. Anten zincirinde
`RUN_ANTENNA_REPAIR: true`, `GRT_ANTENNA_REPAIR_ITERS: 1` ve
`GRT_ANTENNA_REPAIR_JUMPER_ONLY: true` ile GRT jumper onarımı açıktır;
`DIODE_ON_PORTS: "none"` ve `DRT_ANTENNA_REPAIR_ITERS: 0` ile port diyodu ve
DRT-içi onarım kapalıdır. Bu takas aşağıdaki anten bölümünde ölçümle açıklanır.

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
| 11 dosya **yamalı kopya** | `scripts/patch_rtl.py` orijinali okuyup `asic_rtl/patched/` altına yamalı sürümünü üretir; gerekçeler *Bilinen sorunlar* bölümünde. En önemlisi YZ hızlandırıcının MAC boru hattıdır. |

### Üretilen RTL ve bayatlık koruması

ASIC'e özgü RTL üç sınıfa ayrılır; hepsi `asic_rtl/` altındadır ve
`FPGA/` klasöründeki hiçbir kaynak dosyaya dokunulmaz:

| Sınıf | Konum | Üreten | Ne |
|---|---|---|---|
| Yamalı kopyalar | `asic_rtl/patched/` | `scripts/patch_rtl.py` | 11 dosya, 58 metin değişikliği (sürülmeyen AXI yanıt kodları, bias literalleri, SRAM read-enable, I-RAM okuma arbitresi ve OBI sıfır-genişlik korumaları) |
| Mask ROM'lar | `asic_rtl/gen/` | `scripts/gen_rom.py` | `boot_rom`, `weights_rom_p8`, `fc_weights_rom_p4` — içerik hex kaynağından RTL'e gömülür |
| Elle yazılan ASIC bileşenleri | `asic_rtl/mem/`, `asic_rtl/tech/` | — | SRAM makro sarmalayıcıları, `xilinx_iobuf_stub.sv`, `axi_read_arbiter2.sv` |

**Her ikisi de bayatlığa karşı korunur.** `make prepare` çıktıları yeniden
üretir; `make verify_generated` (ve dolayısıyla `make asic_verify`) üretimi
bellekte tekrarlayıp diskteki dosyayla **metin bazında** karşılaştırır:

```bash
python3 scripts/patch_rtl.py --check          # yamalı kopyalar kaynak RTL ile uyumlu mu
python3 scripts/gen_rom.py --all --check      # mask ROM'lar kaynak hex ile uyumlu mu
python3 scripts/gen_macro_keepout.py --check  # keep-out'lar makro yerleşimiyle uyumlu mu
```

`patch_rtl.py` bunu kaynak dosyanın SHA256'sını yamalı kopyanın başlığına
yazarak yapar. `gen_rom.py` bir dönem bu korumadan **yoksundu**: firmware
yeniden derlenip (`boot.hex` değişip) `make roms` unutulduğunda **bayat bir
boot ROM sessizce senteze girebiliyordu**. Artık ROM başlıkları da kaynak
hex'in SHA256'sını taşır ve aynı kontrol onlara da uygulanır.

Yama uygulanamazsa (üst akış dosyası değişmişse) betikler hata verir, sessizce
eski hâli kullanmaz.

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
> SRAM erişim süresi 35,714 ns'lik periyoda kıyasla küçük olduğu için
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
| Birincil saat | `clk_i`, periyot **35,714286 ns (28 MHz)** |
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

`rst_ni` **asenkron, aktif-LOW** reset girişidir ve asenkron uygulandığı için
assert yolu zamanlanamaz.

**Senkronizatör ASIC bloğunun İÇİNDEDİR.** ASIC top yaması
(`asic_rtl/patched/Top_module_asic.sv:91-98`) iki floplu bir reset
senkronizatörü ekler:

```systemverilog
(* async_reg = "true", keep = "true" *) logic [1:0] rst_sync_q;
always_ff @(posedge clk_i or negedge rst_ni)
    if (!rst_ni) rst_sync_q <= 2'b00;
    else         rst_sync_q <= {rst_sync_q[0], 1'b1};
assign rst_sys_ni = rst_sync_q[1];
```

Bütün alt bloklar `rst_ni`'yi değil bu senkronizatörün çıkışı `rst_sys_ni`'yi
kullanır. Dolayısıyla `rst_ni` portunun tek fanout'u bu iki flopun asenkron
reset pinleridir.

**Kısıtın tam kapsamı budur:** `set_false_path -from [get_ports rst_ni]`
yalnızca harici asenkron reset portundan bu iki flopun asenkron reset
pinlerine giden yolları kapsar. Başka hiçbir veri yolu, saat alanı veya
multicycle yol kesilmez; `rst_sys_ni` üzerinden dağılan **iç reset ağacının
recovery/removal, slew ve fanout kontrolleri gerçek STA'da görünür kalır.**

Kesilen tek şey, ilk senkronizatör kademesinin recovery/removal davranışıdır.
Bu bir arayüz/MTBF varsayımıdır: harici reset kaynağının deassertion'ının
`clk_i` ile ilişkisiz olduğu kabul edilir ve metastabilite iki kademeli
senkronizatörle söndürülür. Gerçek bir tape-out'ta bu varsayım reset
kaynağıyla birlikte yeniden doğrulanmalıdır.

> **Tarihsel düzeltme:** Bu README'nin önceki bir sürümü senkronizatörün
> **ASIC bloğunun dışında**, FPGA'nın `fpga_top.sv` dosyasında kaldığını
> söylüyordu. O ifade ASIC top yaması eklenmeden önceki duruma aitti ve
> yukarıdaki RTL ile çelişiyordu; düzeltilmiştir.

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
| Die alanı | **4200 × 3600 µm = 15,120 mm²** (`FP_SIZING: absolute`, `DIE_AREA`) |
| Core alanı | LibreLane varsayılan iç boşluğuyla die'dan türetilir |
| Floorplan en/boy oranı | 4200 / 3600 = 1,167 |
| Makro alanı | 4,174 mm² — die'ın **%27,6**'sı |
| Standart hücrelere kalan | 10,946 mm² |
| Hedef yerleştirme yoğunluğu | `PL_TARGET_DENSITY_PCT: 35` |
| Global yerleştirme modu | `PL_ROUTABILITY_DRIVEN: true` (LibreLane varsayılanı; tersi ölçülüp elendi — aşağıda) |
| Makro halo | 20 µm (`FP_MACRO_HORIZONTAL_HALO` / `FP_MACRO_VERTICAL_HALO`) |
| Giriş/çıkış pini yerleşimi | `IO_PIN_PLACEMENT_MODE: matching` (LibreLane varsayılanı) |
| Yönlendirme katmanları | **met1 … met4** (`RT_MAX_LAYER: met4`; li1 yollamaya kapalı, met5 sinyal yollamasına kapatıldı — gerekçesi aşağıda) |
| Saat ağı en alt katmanı | `RT_CLOCK_MIN_LAYER: met2` |
| Güç ve toprak ağları | `VPWR` / `VGND` |
| Güç dağıtım ağı | LibreLane/SKY130 varsayılan çok katmanlı PDN (stdcell ızgarası + 15 makro ızgarası) |
| Makro güç bağlantıları | `PDN_MACRO_CONNECTIONS: [".*u_sram VPWR VGND vccd1 vssd1"]` → `vccd1`→`VPWR`, `vssd1`→`VGND` |
| Makro yerleşimi | Elle — [`constraints/macro_placement.cfg`](constraints/macro_placement.cfg), `MACRO_PLACEMENT_CFG` |
| Makro çevresi keep-out | **kullanılmadı** (`ROUTING_OBSTRUCTIONS: null`) — denendi, detaylı yollamayı kötüleştirdi; aşağıdaki uyarıya bakın |
| Clock tree synthesis | `OpenROAD.CTS`; `CTS_APPLY_NDR: half` varsayılanı korunur, obstruction-aware seçenek kullanılmaz ve saat netleri `CTS_CLK_MAX_WIRE_LENGTH: 600` ile bölünür |
| Yollama katman payı | `GRT_ADJUSTMENT: 0.10`; `GRT_LAYER_ADJUSTMENTS` taban `[0, 0.3, 0.25, 0, 0, 0]`, teslim akışının met3 fazından itibaren `[0, 0.3, 0.25, 0.09, 0, 0]` |
| Global routing iterasyonu | `GRT_OVERFLOW_ITERS: 30` |
| Azami fan-out | `MAX_FANOUT_CONSTRAINT: 25` (PDK varsayılanı 10) |
| Tasarım onarım marjı | `DESIGN_REPAIR_MAX_SLEW_PCT: 0`, `DESIGN_REPAIR_MAX_CAP_PCT: 0` |
| Hold onarım marjı | `PL_RESIZER_HOLD_SLACK_MARGIN: 0.02` |
| Anten onarımı | **GRT jumper açık** — `RUN_ANTENNA_REPAIR: true`, `GRT_ANTENNA_REPAIR_ITERS: 1`, `GRT_ANTENNA_REPAIR_JUMPER_ONLY: true`; **diyot ve DRT-içi onarım kapalı** — `DIODE_ON_PORTS: "none"`, `DRT_ANTENNA_REPAIR_ITERS: 0`; ölçülen gerekçe *Bilinen sorunlar* 0.1 ve 0.29'da |
| Otomasyon dosyaları | [`Makefile`](Makefile) + [`scripts/`](scripts/) |

Bu tablodaki her satırın gerekçesi [`config.yaml`](config.yaml) içinde ilgili
ayarın hemen üstünde, ölçüm rakamlarıyla birlikte yorum olarak durur.

### Makro yerleşimi

15 SRAM makrosu die çevresine bir **halka (macro-ring)** olarak yerleştirilir;
standart hücrelere tek parça bir merkez kalır. Koordinatlar
`scripts/gen_macro_placement.py --grid ring` tarafından sentezlenmiş netlist'ten
üretilir, elle yazılmaz (`constraints/macro_placement.cfg`).

Eski 4×4 ve 3×5 iç ızgara düzenleri tarihsel deneylerdir; ikisi de bu halkadan
kötü ölçülmüştür (`reports/synthesis/strateji_denemeleri.md`).

| | |
|---|---|
| Alt sıra (y = 80 µm) | Instruction RAM 4 banka + Data RAM banka 0 |
| Sol sütun (x = 80 µm) | Data RAM banka 1–3 |
| Üst sıra (y = 3103,46 µm) | YZ RAM 4 × 2 KB + 1 × 1 KB |
| Sağ sütun (x = 3436,90 µm) | Konvolüsyon tamponu 2 banka |
| Sıra içi aralık | **80 µm** → alt sıra hizasında dikey kanal toplamı 784 µm (%18,7) |
| Serbest merkez | 2673,8 × 2606,9 µm ≈ 6,97 mm² |
| Makro boyutları | 2 KB: 683,10 × 416,54 µm — 1 KB: 479,78 × 397,50 µm |

- **Yön hepsi `N` — makrolar döndürülmez.** SRAM'lerin güç pinleri met3 üzerinde
  **yatay** şeritlerdir; PDN'in met4 **dikey** şeritleri bunları dik keserek
  bağlanır. 90° döndürülürse ikisi paralel kalır ve makro güç bağlantısı
  güvenilmez hâle gelir.
- **Banka yerleşimi: halka (ring).** `gen_macro_placement.py --grid ring`
  makroları die'ın çevresine dizer. IMEM'in dört bankası alt kenarda yan yanadır;
  DMEM'in üç bankası sol kenarda, dördüncüsü (`g_2k[0]`) sağ-alt köşededir.
  **Bilinen sınır:** her belleğin 32-bit veri yolu, adresi ve bayt maskesi tek
  bir AXI denetleyicisinde toplandığı için, bankaların die'a yayılması o yolları
  uzatır. Ölçülen etki: en kötü setup yolunda SRAM `dout` ile yakalama flop'u
  arasında ~60 repeater vardır (yalnızca 2 gerçek mantık kapısı). Bankaları
  mantıksal bellek başına kümelemek denenmemiştir; halka düzeni GRT taşması 0 /
  DRT ihlali 0 ölçüsüyle seçilmiştir ve değiştirmek bu iki ölçütü riske atar.

### Tarihsel makro çevresi met1 keep-out deneyi — reddedildi

Nihai akışta `ROUTING_OBSTRUCTIONS: null` ve keep-out kapalıdır. Deneysel
`ROUTING_OBSTRUCTIONS` bloğu **elle yazılmaz**; `scripts/gen_macro_keepout.py`
onu `constraints/macro_placement.cfg`'den türetir ve `config.yaml` içindeki
işaretli bloğa yazar (`make keepout`). `make verify_generated` bloğun bayat
olmadığını doğrular.

Gerekçe ölçümdür: detailed routing'i bitirebilen ilk koşumda geriye **7 DRC
ihlali** kalmıştı ve **7'sinin de katmanı met1**, **7'sinin de yeri tek bir
SRAM makrosunun OBS sınırının hemen dışıydı** (6 short + 1 metal spacing).
SRAM LEF'i met1'i makro üzerinde %99,5 kapattığı için global router makro
kenarına bitişik gcell'lere yol planlayabiliyor, detailed router o şekilleri
gerçekleştirince makronun engel dikdörtgenine değiyor. Makro kenarına 10 µm'lik
met1 keep-out koymak guide'ların o şeritte oluşmasını baştan engeller.

Keep-out 20 µm'lik makro halo'sunun **içinde** kaldığı için hiçbir standart
hücre yerleşimini engellemez; SRAM sinyal pinleri met4'te olduğu için pin
erişimini de kapatmaz. Ölçülen maliyet makro başına ~346 track (met1 kaynağının
%0,03'ü), 15 makro için ~%0,4.

### Yollama tıkanıklığı nasıl çözüldü?

Bu tasarımın en zor adımı global routing oldu. Belirleyici olan die boyutu
değil, **SRAM makrolarının katman engelleriydi**:

| Katman | Yön | Makro üzerinde |
|---|---|---|
| met1 | yatay | tek `RECT`, %99,5 kapalı |
| met2 | **dikey** | tek `RECT`, %99,5 kapalı |
| met3 | yatay | 61 `RECT`, %96,7 kapalı — kesintisiz geçiş yolu yok |
| met4 | **dikey** | 143 `RECT`, %97,8 kapalı — kesintisiz geçiş yolu yok |
| met5 | yatay | engel **yok** — tamamen serbest |

SKY130'da dikey yönlü iki katman met2 ve met4'tür; **ikisi de makro üzerinden
geçemez.** PDK varsayılanı `RT_MAX_LAYER: met5`'tir ve bu tasarımda **yanlış
sonuç verir**: met5'e çıkmak `via4` gerektirir, via4'ün altındaki met4 ise makro
üzerinde kapalıdır. Global router bu erişim kısıtını kaba ızgarada göremeyip
"met5 boş" diye oraya yol planlar, detailed router gerçekleştiremeyip şekilleri
üst üste bindirir (ölçüm: met5 toplam talebin %1,4'ünü taşırken DRC
ihlallerinin ~%67'sini üretiyordu).

### ⚠ GRT aşımı bu tasarımda **yanıltıcı bir vekil metriktir**

Bu, akışın en pahalı dersiydi ve ölçümle öğrenildi. Aşağıdaki tablo nihai
`ant28_m3a015_clean` koşumundan önceki tarihsel deneyleri gösterir; bazı global
routing aşımını düşüren ayarlar **detaylı yollamayı kötüleştirmiştir.** Aynı
netlist, aynı yerleştirme, aynı post-CTS veritabanı üzerinde:

| GRT ayarları | Anten zinciri | GRT toplam aşımı | DRT iter 0 | DRT sonucu |
|---|---|---:|---:|---:|
| `adj 0.05`, `[0,.25,.20]`, `i50`, + 15 makro met1 keep-out | açık | **39** | 233.380 | 3. iterasyonda hâlâ ~165.000 — **yakınsamadı** |
| `adj 0.10`, `[0,.30,.25]`, `i20`, keep-out yok | **açık** | ~16.100 | 186.694 | iniş −%17/−%2 — **yakınsamadı** |
| **`adj 0.10`, `[0,.30,.25]`, `i20`, keep-out yok** | **kapalı** | **15.218** | 89.218 | **24 ihlal** ✔ |
| (referans koşum, eski netlist) `adj 0.10` | kapalı | 5.114 | 68.149 | 7 ihlal |
| Tarihsel `rtl2gds` koşumu | **kapalı** | **16.108** | **85.188** | **14 ihlal** |

İkinci satır ikinci değişkeni izole eder: GRT ayarları özdeşken **anten
zincirini açmak** DRT'yi 89.218'den 186.694'e çıkarıyor ve iniş hızını
−%53'ten −%17'ye düşürüyor. Sebebi, `Odb.DiodesOnPorts` ve
`OpenROAD.RepairAntennas`'ın hücre ekleyip **artımlı GRT** koşması: detaylı
yollayıcı adım 39'un temiz guide'larını değil, o artımlı guide'ları tüketiyor.

GRT metriğinde **390 kat daha kötü** görünen yapılandırma, gerçek metrikte
**binlerce kat daha iyi** sonuç veriyor.

**Mekanizma:** `GRT_ADJUSTMENT` düşürülünce global router'a daha fazla *görünür*
kapasite verilir; o da daha sıkışık guide üretir. Kaba ızgarada "aşım yok"
görünür, ama detaylı yollayıcı o guide'ları gerçek geometride
gerçekleştiremez ve şekilleri üst üste bindirir.

**Bu yüzden benimsenen kural:** *bir GRT ayarı, detaylı yollamadan geçtiği
ölçülmeden `config.yaml`'a alınmaz.* Tablodaki ilk iki yapılandırma DRT'de
yakınsamadığı için reddedilmiş, 24/7/14 ihlalli sonuçlar da sonraki temiz
üç-fazlı akışla aşılmıştır.

> **Dürüstlük notu.** Bu karşılaştırmada ceza ayarları ve makro keep-out'ları
> **birlikte** değiştirildi; hangisinin tek başına zararlı olduğu izole
> **edilmedi**. Doğrulanan şey kombinasyondur. Keep-out üreteci
> (`scripts/gen_macro_keepout.py`) korunmuş, varsayılanı `off` yapılmıştır;
> `make keepout MODE=on` ile geri açılabilir.

### Kalan DRC ihlallerinin yapısı

> **GÜNCEL DURUM: detaylı yollama DRC'si SIFIRDIR.** Aşağıdaki 14 ihlallik
> anlatı, macro-ring yerleşimine ve düzeltilmiş GRT ayarlarına geçilmeden
> önceki 3400 × 2900 µm dönemine aittir ve **tarihsel kayıt** olarak
> korunmaktadır. Nihai koşumun gerçek sayıları için aşağıdaki otomatik üretilen
> *Sonuç özeti* bölümüne ve `results/metrics/metrics.json` içindeki
> `route__drc_errors` değerine bakınız.

Tarihsel kayıt — eski koşumda detaylı yollama 14 ihlalle bitmişti. Hepsi
`Short`, hepsi **met2**'de ve hepsi SRAM makrolarının üzerindeydi:

| Makro | İhlal |
|---|---:|
| `yz_bram_ctrl_inst.yz_ram … g_1k` | 12 |
| `conv_accelerator_inst.u_conv_buf_ram … g_2k[1]` | 2 |

İlk DRT iterasyonundaki 85.188 ihlal; 41.764, 36.852, 14.380, 7.981 … 24,
12, 10, 6 değerlerinden geçip 60. iterasyonda 14 ile bitmiştir. O tarihsel koşumun tel
uzunluğu 12.208.906 µm, via sayısı 909.353'tür. Ham işaretler
[`reports/routing/`](reports/routing/) altında teslim edilir.

Yukarıdaki kontrollü `drtfix_a` deneyi ise **tarihsel karşılaştırmadır**:
24 met2 short; conv `g_2k[0]` üzerinde 8, conv `g_2k[1]` üzerinde 14 ve YZ
`g_1k` üzerinde 2. Bu arşiv sonucu nihai koşumun 14 sayısı yerine
kullanılmamıştır.

> **Mekanizma hakkında dürüstlük notu.** Bu belgenin önceki sürümü "LEF'in açık
> kalan %0,5'inden router sıkışıyor" diyordu; bu açıklama **desteklenmiyor**.
> Makronun met2 `OBS` dikdörtgeni (0,62 , 0,62)–(682,48 , 415,92) alanın
> %99,52'sini kapatıyor ve DRC işaretleri doğrudan **bu dikdörtgenin içine**
> düşüyor; kalan %0,48 makro çevresindeki ince şerittir, içinden geçen
> kullanılabilir bir kanal değildir. Daha olası açıklama, kaba ızgaradaki
> guide'ın OBS içine taşması / makro erişim modellemesidir. Bu ayrım pratikte
> önemli: tam ayak izine ikinci bir met2 obstruction eklemek geometrik olarak
> **etkisiz** olabilir; anlamlı deney, ayak izinin **dışına** taşan bir
> halo/GCell yasak bölgesidir.

Hedefli çözüm henüz DRT'de ölçülmemiştir. İki sorunlu makronun ayak izini 2 µm
dışarı taşıran, yalnız met2 engelleri
[`experiments/targeted_sram_met2_obstructions.yaml`](experiments/targeted_sram_met2_obstructions.yaml)
altında kontrollü deney olarak hazırlanmıştır; **kural gereği**, detaylı
yollamadan geçtiği ölçülmeden teslim yapılandırmasına alınmayacaktır.

Bu tarihsel koşumun fiziksel signoff sonuçları 14 işaretle tutarlıydı:

| Kontrol | Sonuç | Yorum |
|---|---:|---|
| Magic DRC | **0** | Temiz |
| KLayout DRC | **10** | Tamamı `m2.2` (met2 minimum 0,14 µm aralık); dokuzu yukarıdaki OpenROAD işaretleriyle aynı koordinatlarda, biri 1 KB SRAM hücre hiyerarşisi içinde |
| Magic illegal overlap | **187** | Tamamı `obsm2`–`metal2`; iki işaretli SRAM makrosunun ayak izi içinde |
| Netgen LVS | **0** | Netlistler benzersiz eşleşiyor; cihaz/net/pin farklarının tamamı 0 |
| Magic ↔ KLayout XOR | **0** | İki bağımsız stream-out arasında geometrik fark yok |
| Bağlantısız pin | **480**, kritik **0** | SRAM makrolarının kullanılmayan sinyal/port pinleri; makro güç pinleri bağlı ve LVS temiz |

KLayout DRC’nin Magic GDS’yi doğrudan açtığı ilk deneme, referans SRAM GDS’leri
ek top-cell taşıdığı için PDK betiğinin `source($input)` aşamasında durdu.
Standart Classic `KLayout.StreamOut` görünümü üzerinde aynı DRC yeniden
çalıştırıldı; yukarıdaki 10 işaret bu başarılı koşudan gelir. Bu nedenle ana
GDS görünümü `PRIMARY_GDSII_STREAMOUT_TOOL: klayout` ile tek-top-cell KLayout
çıktısına alınmıştır. Magic stream-out yine Classic akış içinde üretilir ve iki
görünümün XOR sonucu 0 olarak doğrulanır. Böylece KLayout DRC ile önerilen
yerleşim PNG'si de kesintisiz ana akışta aynı birincil görünümü kullanır.

### Denenip ölçümle elenen yollar

| Denenen | Ölçülen sonuç |
|---|---|
| `RT_MAX_LAYER: met5` (PDK varsayılanı) | met5'te 6.056 short + 2.677 aralık ihlali; overflow 94.692 |
| Die'ı 3600 × 3200'e büyütme | overflow 257.887 (3400 × 2900'ün 133.432'sine karşı) — **ters etki** |
| Makro ızgarasını 3 sütun × 5 satıra alma | overflow 72.909 → **447.323**, tel +%34 — **ters etki** |
| `CTS_APPLY_NDR: none` | talep +%18, tel +%21, overflow 72.909 → **253.521** |
| `CTS_OBSTRUCTION_AWARE: true` | saat ağacı makroların etrafından dolaştı, tel uzunluğu arttı |
| Hücre dolgusu (`GPL/DPL_CELL_PADDING` 4/2) | tel 16,5 → 24,6 m, overflow 540k |
| `PL_TARGET_DENSITY_PCT: 25` | overflow 258k (35 daha iyi) |
| **`PL_ROUTABILITY_DRIVEN: false`** | HPWL %22 **kısaldı** ama overflow **90 → 113.525**; tile başına en kötü aşım 5/2 → 79/64. Sorun global kaynak değil **hotspot**: yönlendirilebilirlik geri beslemesi olmadan hücreler dar kanallarda yığılıyor. |
| `GRT_MACRO_EXTENSION: 1` | overflow 6.737 — keep-out yaklaşımından kötü |
| `MAX_FANOUT_CONSTRAINT: 25` | **işe yaradı** — overflow 133k → 73k, tampon 23.137 → 15.853 |
| `DESIGN_REPAIR_MAX_SLEW/CAP_PCT: 0` | **işe yaradı** — tampon 15.783 → 11.938 |

Denemelerin tam listesi, koşum etiketleri ve ham ölçüm dosyaları
[`reports/synthesis/strateji_denemeleri.md`](reports/synthesis/strateji_denemeleri.md)
ve [`reports/synthesis/deney_arsivi/`](reports/synthesis/deney_arsivi/)
altındadır.

> **MALİYETLİDİR; ÖLÇMEDEN ANA AKIŞA AÇILMAMALI:**
> `RUN_POST_GRT_DESIGN_REPAIR` ve `RUN_POST_GRT_RESIZER_TIMING`. Her biri
> **2'şer tam GRT** koşturur
> (`scripts/openroad/repair_design_postgrt.tcl:26-31` — koşul bloğu OpenROAD
> issue #5590 yüzünden yorum satırı yapılmış, yani bayrakla kapatılamıyor).
> İkisini birlikte açmak hem maliyeti hem yönlendirme değişkenlerini karıştırır.
> Nihai zincirde `RUN_POST_GRT_DESIGN_REPAIR: true` ve
> `GRT_DESIGN_REPAIR_MAX_WIRE_LENGTH: 250` kullanılır.
> `RUN_POST_GRT_RESIZER_TIMING` faz 2'de çalıştırılmış, faz 3'te jumper
> guide'larını yeniden silmemesi için `false` yapılmıştır.

### Alan dökümü

Standart hücre alanı sentez sonrası ve zamanlama optimizasyonu sonrası olmak
üzere iki farklı değerdir; die **optimizasyon sonrası** alana göre
boyutlandırılmıştır. Yerleştirme sonrası toplam örnek sayısının büyük kısmı
**tap ve dolgu hücreleridir** — bunlar tasarım mantığı değil, die alanının
doğrudan sonucudur (tap hücreleri `FP_TAPCELL_DIST` ile 25,6 µm'de bir
yerleştirilir ve sinyal pini taşımaz).

Güncel sayılar bu belgenin **Signoff sonuç özeti** bölümünde ve
[`reports/synthesis/stat.rpt`](reports/synthesis/stat.rpt) /
[`results/metrics/metrics.csv`](results/metrics/metrics.csv) dosyalarındadır;
`scripts/gen_readme_results.py` bunları her koşumdan sonra tazeler.

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

**Uyarıların gerçek dağılımı** (`reports/lint/verilator_lint.log`'dan sayıldı):

| Tür | Adet | Değerlendirme |
|---|---:|---|
| `TIMESCALEMOD` | 465 | Kara kutu makro modelleri ile RTL arasında `timescale` uyuşmazlığı. Sentezi ve ASIC davranışını etkilemez. |
| `UNUSEDSIGNAL` | 178 | Ağırlıklı olarak CV32E40P'nin kullanılmayan özellik dalları (FPU=0, PULP eklentileri kapalı). |
| `WIDTHTRUNC` | 58 | Genişlik daraltması |
| `WIDTHEXPAND` | 55 | Genişlik genişletmesi |
| `UNUSEDPARAM` | 50 | Kullanılmayan parametreler |
| `PINMISSING` / `PINCONNECTEMPTY` | 37 | Bilerek bağlanmamış portlar |
| `CASEINCOMPLETE` | 17 | `default` dalı olmayan `case` — hepsi `always_comb` içinde ve öncesinde varsayılan atama var (latch üretmez; `latch.rpt` 0) |
| `VARHIDDEN`, `BLKSEQ`, `ASCRANGE`, diğer | 38 | — |

> Bu belgenin önceki sürümü "uyarılar ağırlıklı olarak `WIDTHEXPAND`/`WIDTHTRUNC`
> ve büyük çoğunluğu üçüncü taraf" diyordu; **ikisi de yanlıştı.** Genişlik
> uyarıları toplamın yalnızca **%12,6**'sı ve bunların yaklaşık yarısı proje
> içi kodda.

**Hata sınıfı taraması:** log'da `LATCH`, `MULTIDRIVEN`, `UNDRIVEN` veya
range-select hatası **bulunmamaktadır** — sentezin `latch.rpt`'si de 0 satır,
`chk.rpt` "0 problems" veriyor. Yani lint uyarıları arasında yapısal donanım
hatası sınıfı yoktur.

**Kabul gerekçesi:** genişlik uyarılarının tamamı davranışı FPGA
gerçeklemesinde doğrulanmış, bilinçli daraltma/genişletmelerdir; üçüncü taraf
koda dokunmama ilkesi de korunmuştur. `TIMESCALEMOD` ve `UNUSEDSIGNAL`
gürültüsü ise kara kutu makro modellerinin ve kapalı IP özelliklerinin doğal
sonucudur.

---

## Bilinen sorunlar ve kabul edilmiş istisnalar

> Bu bölümde, akışın **kapatamadığı** ve teslimle birlikte kabul edilen bütün
> eksikler sayısıyla verilmiştir. Sayılar akışın kendi metriklerinden
> alınmıştır; nihai değerler aşağıdaki *Signoff sonuç özeti* tablosundadır.

| # | Konu | Durum | Sayı |
|---:|---|---|---|
| 1 | Yollama tıkanıklığı | Çözüldü | Faz-2 ilk GRT aşımı 0, DRT DRC 0 |
| 2 | Hold marjı hızlı köşede | Kapandı | +0,10963 ns, ihlal 0 |
| **3** | **Anten ihlalleri** | **Açık — kabul edildi** | **1.067 net / 1.122 pin** |
| **4** | **Max slew / max capacitance** | **Açık — kabul edildi** | **818 / 21** |
| 5 | Zamanlama | Kapandı | 9 köşede setup/hold 0/0 |
| 6 | Frekans seçimi | Ölçümle karar | 28 MHz |
| **7** | **480 bağlantısız pin** | **Açık — kabul edildi** | **kritik 0** |
| 8 | Tel bölme kampanyası | Uygulandı | anten −%35, max-cap −%98 |
| 9 | Anten kontrolünün kapsam sınırı | Yapısal sınır | 883 SRAM pini |
| 10 | SRAM makro `config/` dizini yok | Gerekçeli | şartname §1.3 |
| 11 | Diyot tabanlı anten onarımı | Ölçüldü, reddedildi | 9.587 diyot |
| 12 | SRAM okuma yolunda FPGA'dan sapma | ASIC'e özgü | — |
| 13 | YZ girdi RAM'i derinliği | Kabul | — |
| 14 | RTL'de sürülmeyen sinyaller | Düzeltildi | 91 bit → 0 |
| 15 | YZ MAC yolu boru hattına alındı | Düzeltildi | davranışı etkiler |
| 16 | `obi_to_axi.sv` sıfır genişlik | Düzeltildi | — |
| 17 | Reset senkronizatörü blok içinde | Tasarım kararı | — |
| **18** | **SRAM Liberty modeli tek corner** | **Açık — kabul edildi** | `TT_1p8V_25C` |
| 19 | Aynı adrese eşzamanlı okuma/yazma | Çözüldü | arbitrasyon |
| 20 | I-RAM veri okuma yolu | Düzeltildi | — |
| 21 | ASIC saat frekansının çevre birimlerine etkisi | Açıklama | 28 MHz türevleri |
| 22 | DDK tarafından kabul edilmiş istisnalar | **Yok** | — |

**Açık kalan dört kalem 3, 4, 7 ve 18'dir**; geri kalanı ya çözülmüş ya da
ASIC'e özgü bir tasarım kararının kaydıdır. Ayrıntılı ölçüm kayıtları
[`reports/synthesis/strateji_denemeleri.md`](reports/synthesis/strateji_denemeleri.md)
dosyasındadır.

### 1. Yollama tıkanıklığı — çözüldü, kalan aşım ölçülüyor

Bu, akışın en zor adımıydı ve uzun süre kapanmadı. Kök nedeni ve çözümü
*Fiziksel tasarım yapılandırması → Yollama tıkanıklığı nasıl çözüldü?*
bölümünde ölçüm tablosuyla anlatılmıştır. Özet: belirleyici bulgu
`GRT_LAYER_ADJUSTMENTS` listesindeki `0` değerinin "ceza yok" anlamına
gelmemesiydi. Nihai ayar genel ceza `0.10`, katman cezaları faz 1'de
`[0,.30,.25,0,0,0]`, faz 2 ve 3'te `[0,.30,.25,.10,0,0]`,
`GRT_OVERFLOW_ITERS: 30` ve **keep-out yok** biçimindedir.
Nihai koşumda detaylı yollama **0 ihlalle** kapanmıştır (`route__drc_errors: 0`)
ve bu sonuç `ERROR_ON_TR_DRC: true` sert kapısıyla doğrulanmıştır.
`0.05` + keep-out kombinasyonu daha küçük GRT sayısı üretse de DRT'de
yakınsamadığı için geri alınmıştır.

`GRT_ALLOW_CONGESTION: false`'tur: GRT'nin aşımı **kaba ızgara üzerinde bir
tahmindir**, gerçek yollamayı DRT yapar ve yerel tıkanmayı çözmekte GRT'den
çok daha yeteneklidir — bu yüzden GRT aşımı tek başına kabul ölçütü olarak
kullanılmaz. Belirleyici olan DRT'nin kendi DRC
sonucudur; o da bu belgedeki *Signoff sonuç özeti* tablosundadır.

### 2. Hold marjı hızlı köşede dardır — ihlal yok, pay küçük

Nihai koşumda dokuz signoff köşesinin **tamamında hold pozitiftir**, hold TNS
sıfırdır ve ihlalli uç yoktur. Ancak pay köşeye göre çok değişir:

| Köşe grubu | En kötü hold slack |
|---|---:|
| `*_ss_100C_1v60` (yavaş) | +0,918 … +1,032 ns |
| `*_tt_025C_1v80` (tipik) | +0,314 … +0,382 ns |
| **`*_ff_n40C_1v95` (hızlı)** | **+0,110 … +0,145 ns** |

En kötü değer `max_ff_n40C_1v95` köşesinde **+0,110 ns**, yani 35,714 ns'lik
periyodun **%0,31'i**. Bu bir **ihlal değildir**; kontrol geçmiştir.

Bu pay koşumdan koşuma oynar ve izlenmesi gereken bir kalemdir. Ölçülen
değerler: 25 MHz koşumunda (`final40c`) +0,057 ns, 30 MHz denemesinde
(`run/final30`) +0,073 ns, tel bölmesiz 28 MHz koşumunda (`final28`)
+0,086 ns, önceki teslim koşumlarında (`ant28_m3a015_clean`) +0,071 ns ve
(`uart28_m3a010_final`) +0,285 ns; güncel teslim koşumunda
(`i2c_20260907_final`) ise **+0,110 ns**. Yani hold payı
frekans arttıkça daralmamış, aksine genişlemiştir — beklenen bir sonuçtur,
çünkü hold aynı-kenar yollarına bakar ve periyottan bağımsızdır; değişim
resizer'ın daha gevşek bir setup hedefiyle daha az agresif çalışmasından
gelir. **Tek koşumdan kesin sebep atfedilmemiştir.**

Hold marjını artırmak için ilk aday `GRT_RESIZER_HOLD_SLACK_MARGIN` (şu an
0,45 ns) değerini yükseltmektir; bedeli ek gecikme hücresi ve alandır.

### 3. Anten ihlalleri

Nihai akışta **diyot ekleme** kapalıdır (`DIODE_ON_PORTS: "none"`,
`GRT_ANTENNA_REPAIR_JUMPER_ONLY: true`, `DRT_ANTENNA_REPAIR_ITERS: 0`) ve bu,
GRT-aşaması diyot deneyiyle doğrulanmış bilinçli bir takastır (§11).
Buna karşılık **jumper tabanlı** onarım akışın üçüncü fazında açıktır ve
ihlalleri %23,6 azaltır — ayrıntı bu bölümün sonundaki *Üç fazlı akış*
başlığındadır.

Tarihsel DRT-içi onarım deneyi bir dönem açıldı ve **çalıştı**: 36 port diyodu + 152 onarım diyoduyla
ihlaller **3.676 net / 5.489 pin → 22 net / 30 pin**'e indi. Ancak aynı koşumda
detaylı yollamanın yakınsamadığı görüldü. Kontrollü karşılaştırma — GRT
ayarları özdeş, tek fark anten zinciri:

| DRT iterasyonu | Anten **kapalı** | Anten **açık** |
|---|---:|---:|
| 0 | 89.218 | 186.694 |
| 1 | 41.952 (−%53) | 154.201 (−%17) |
| 2 | 38.028 (−%9) | 151.079 (−%2) |
| 3 | 14.862 (−%61) | — |
| son | **24 ihlal** | **yakınsamadı** |

**Mekanizma:** `Odb.DiodesOnPorts` ve `OpenROAD.RepairAntennas` hücre ekler,
yerleştirmeyi yeniden yasallaştırır ve **artımlı global routing** koşar. Detaylı
yollayıcının tükettiği guide'lar temiz global routing adımının değil, o artımlı
koşumların çıktısıdır ve belirgin şekilde daha kötüdür.

**Takas açıkça kabul edildi:** yakınsamayan bir detaylı yollama kullanılabilir
bir GDS bile üretmediği için bu tercih zorunluydu. Buna karşılık yollama DRC'si
**0**'dır. Şartname Bölüm 7 ihlalin teslimi geçersiz kılmadığını söylüyor.

**Nihai koşumda ölçülen anten ihlalleri: 1.067 net / 1.122 pin.**
(Oturum başında 2.904 net / 4.341 pindi. Azalmanın bir kısmı tel modeli
düzeltmesi ve SRAM boru hattından kendiliğinden geldi; kalanı aşağıdaki
jumper fazının ölçülen katkısıdır.)

Önceki `ant28` onarım girdisindeki aşım şiddeti dağılımı (1.927 kayıt):
medyan **1,51×**, kayıtların **%69'u 2× ve altında**, en kötü 14,34× idi.

#### Üç fazlı akış — met3 yönlendirme ve anten jumper'ları

`make asic_run` akışı **üç fazda** koşar ve bu, teslim edilen GDS'i üreten
resmî yoldur (tek fazlı bir koşum farklı anten sayıları verir):

```
Faz 1:  başlangıç → OpenROAD.STAMidPNR-2 (taban katman ayarı)
Faz 2:  OpenROAD.GlobalRouting → OpenROAD.ResizerTimingPostGRT
        (+ experiments/grt_layer_met3_009.yaml)
Faz 3:  OpenROAD.RepairAntennas → sonuna kadar
        (+ met3 %9 ve antenna_jumper overlay'leri, --overwrite VERİLMEZ)
```

**Neden üç faz?** LibreLane Classic'in adım sırası sabittir
(`flows/classic.py:79-87`): `RepairAntennas` → `ResizerTimingPostGRT` →
`DetailedRouting`. `RepairAntennas` jumper'ları **guide** olarak ekler;
`ResizerTimingPostGRT` ise `rsz_timing_postgrt.tcl:26-31`'de **koşulsuz** bir
`global_route` çalıştırır (OpenROAD #5590 nedeniyle `if` bloğu yorum satırına
alınmıştır). `GlobalRouter::saveGuides` her netin guide'ını `clearGuides()`
ile silip yeniden yazar. Jumper bir netlist hücresi değil, yalnızca guide
geometrisi olduğu için **%100'ü yok olur.** ODB denetimiyle ölçüldü
(`scripts/jumper_odb_audit.py`):

| Nokta | jumper guide | "onarıldı" bayrağı | sahipsiz bayrak |
|---|---:|---:|---:|
| `repair_antennas` sonrası | 1.661 | 1.422 | 0 |
| resizer sonrası | **0** | 1.422 | **1.422** |

Çözüm, jumper'ı resizer'ın **çıktısı** üzerine ekleyip `DetailedRouting`'i tek
kez koşmaktır. Faz 3 overlay'indeki `RUN_POST_GRT_RESIZER_TIMING: false`
resizer'ı devre dışı **bırakmaz** — resizer faz 2'de zaten koşmuştur; bu bayrak
yalnızca ikinci kez koşup jumper'ları yeniden silmesini engeller. Faz 2/3'e
`--overwrite` verilmez, çünkü `flow.py:599` `shutil.rmtree` çağırır ve faz 1'in
dizinlerini silerdi.

Met3 kaynak cezası baştan verilmez: `RepairDesignPostGPL` içindeki erken
global routing'i de etkiler. Güncel I2C entegrasyonunun bit-özdeş sentez
netlistinde %10 post-GRT yeniden yollaması 15 aşımla dururken %9 aynı faz-1
durumundan iki GRT'yi de sıfır aşımla geçip tam signoff'u tamamlamıştır. Bu
nedenle faz 1 taban ayarı kullanır; ölçülmüş met3 overlay'i
yalnız faz 2 ve 3'te uygulanır.

**Jumper'ın tek başına ölçülen kazancı:** anten 1.935 → 1.478 net (−%23,6),
2.364 → 1.883 pin (−%20,3). Buna **tel bölme** ve met3 yönlendirme eklenince
(§8 ve §3) önceki RTL'deki teslim değeri **926 net / 979 pin** olmuştu. Güncel
RTL (iki fiziksel UART) ve met3 %9 ile yapılan bağımsız temiz teslim koşumu
**979 net / 1.034 pin** ölçmüştür. Eklenen diyot hücresi **0**
(`antenna_diodes_count: 0`), yollama DRC **0**,
setup/hold değişmedi.

**Kalan ihlallerin çoğu jumper ile ulaşılamazdır:** jumper iki katman yukarı
çıkar (`RepairAntennas.cpp:1080-1103`). met1→met3 ve met2→met4 mümkündür;
**met3→met5 mümkün değildir**, çünkü `RT_MAX_LAYER: met4`'tür.

#### Bu, "üretime hazır" tanımını karşılıyor mu?

Final Çıktılar §2 "üretime hazır" ifadesini şöyle tanımlıyor: *"tasarımın …
**DRC, LVS, anten ve zamanlama** kontrollerini sağlaması ve gerekli fiziksel
tasarım görünümlerini üretmesi"*.

| Kontrol | Durum |
|---|---|
| DRC (OpenROAD DRT / Magic / KLayout) | **0 / 0 / 0** ✔ |
| LVS (Netgen) | **0** ✔ |
| XOR, illegal overlap, PDN | **0** ✔ |
| Zamanlama (setup/hold, 9 köşe) | ihlal **0**, TNS **0** ✔ |
| **Anten** | **1.067 net / 1.122 pin** ✘ |

Yani **anten kontrolü hariç** bütün üretilebilirlik kapıları temizdir; anten
nedeniyle tanım tam olarak karşılanmamaktadır ve bu açıkça beyan edilir.

Teslim edilen açık PDK akışında DRC ve LVS sayaçları sıfırdır; bu sonuç gerçek
bir foundry kabulünü tek başına garanti etmez. Anten kuralları (plazma
aşındırma sırasında kapı oksidinde yük birikmesi) için ek onarım gerekir.
**Katman atlatma (jumper) uygulanmıştır** ve önceki kontrollü kampanyada tel
bölme/met3 yönlendirmeyle birlikte ihlalleri 1.935 → 926'ya indirmiştir
(yukarıdaki *Üç fazlı akış* ve §8).
Kalan ihlallerin büyük kısmı `RT_MAX_LAYER: met4` nedeniyle jumper'la
ulaşılamaz. **Diyot tabanlı onarım da ölçülmüş ve reddedilmiştir** — gerekçesi
§11'dadır ve önceki README sürümlerindekinden farklıdır.

**Ölçüm adımı kapatılmadı:** `OpenROAD.CheckAntennas` koşmaya devam eder,
ihlaller sayılır ve *Signoff sonuç özeti* tablosunda **gerçek değerleriyle**
raporlanır.

> Denenmemiş ara yol: yalnızca `DIODE_ON_PORTS` açık, `RepairAntennas` kapalı.
> Port diyotları yalnız 36 port netini düzeltir, asıl kütle (3.676) için
> `RepairAntennas` gerekir — yani kazancı küçük, maliyeti bir artımlı GRT.
> Bu yüzden ölçülmedi.

> **SRAM makrolarında anten bilgisi yok.** `Odb.CheckMacroAntennaProperties`
> adımı şu uyarıyı verir: *"Cell 'sky130_sram_2kbyte_1rw1r_32x512_8' has (59)
> input pin(s) without antenna gate information"* ve *"(64) output pin(s)
> without antenna diffusion information"*. Referans PDK'nın SRAM LEF'i
> `ANTENNAGATEAREA` / `ANTENNADIFFAREA` özniteliklerini taşımaz; dolayısıyla
> makro pinlerine bağlanan netler anten kontrolünde **değerlendirilemez**.
> Bu, takımın değiştiremeyeceği bir referans makro eksikliğidir (şartname
> Bölüm 1.3: hazır makroların teslim edilen görünümleri değiştirilemez).

### 4. Max slew / max capacitance ihlalleri

Nihai koşumda `max_ss_100C_1v60` köşesinde **818 max-slew** ve **21 max-cap**
ihlali kalmıştır. (Oturum başında 32.763 / 2.858 idi.)

**Bunlar üretilebilirlik kuralı değildir.** DRC ve LVS gibi foundry kabul
kapıları değil, statik zamanlama analizinde uygulanan **tasarım kalitesi
hedefleridir** (`set_max_transition` / `set_max_capacitance`). İhlal eden bir
çip üretilebilir; etkisi gürültü payının ve zamanlama modeli doğruluğunun
azalmasıdır.

**818 ihlal tek bir eşiğe ait değildir — iki ayrı sınıftır.** Her pin kendi
kütüphanesindeki limite göre kontrol edilir:

| Sınıf | Uygulanan limit | Kaynağı | İhlal |
|---|---:|---|---:|
| SRAM makrosu giriş pinleri | **0,04 ns** | makronun kendi Liberty'si | **328** |
| Standart hücre pinleri | **0,75 ns** | PDK `sky130_fd_sc_hd/config.tcl:63` | **490** |

Nihai rapordaki **328 SRAM giriş pini** için uygulanan 0,04 ns sınırı takımın
tanımladığı veya gevşettiği bir eşik değil, referans SKY130 SRAM Liberty
görünümündeki `max_transition` değeridir. Ölçülen geçişler
**0,248609–0,327987 ns** aralığındadır. PDK, SRAM Liberty/LEF/GDS görünümleri
ve signoff eşiği değiştirilmemiş; 328 kaydın tamamı raporlarda görünür
bırakılmıştır. Bu sayı bir waiver veya gizlenmiş kontrol değil, referans makro
modelinin blok-seviyesi STA için çok sıkı transition sınırının açıkça
raporlanan sonucudur. Foundry görünümünü veya eşiği değiştirmeden mevcut
fiziksel/arayüz koşullarında kapanmamıştır; gerçek tape-out öncesinde makro
sağlayıcısının uygun PVT/transition modeliyle yeniden doğrulanmalıdır.

**406 standart hücre ihlalinin şiddet dağılımı** (0,75 ns eşiğine göre):

| Ölçülen slew | Pin sayısı |
|---|---:|
| 0,75 – 1,00 ns | **394** |
| > 1,00 ns | 12 |
| **> 1,50 ns** (kütüphanenin kendi `default_max_transition`'ı) | **12** |

Yani 406 ihlalin **394'ü 0,75–1,00 ns bandındadır** ve kütüphanenin
karakterize edildiği aralığın rahatça içindedir.

**Kütüphanenin kendi limitini aşan 12 kaydın TAMAMI dört QSPI çift yönlü
(`inout`) portunun ağındadır** — netlist izlemesiyle doğrulanmıştır
(`results/netlist/top_module.nl.v`):

| Pin | Slew | Hücre / rol |
|---|---:|---|
| `QSPI_IO0` / `IO3` / `IO1` / `IO2` | 2,295 / 2,134 / 2,079 / 2,014 ns | port pinlerinin kendisi |
| `_128391_` … `_128394_` | 1,724 – 1,966 ns | `ebufn_8` tristate sürücüler |
| `wire30089/A`, `load_slew30083/A`, `load_slew30085/A`, `hold30268/A` | 1,746 – 1,971 ns | aynı dört ağdaki tamponlar |

**Kütüphane limitini aşan tek bir saf-iç pin yoktur.** Bu ağların slew'i,
SDC'nin tüm çıkışlara uyguladığı harici yük modelinden
(`OUTPUT_CAP_LOAD = 33,442 fF`) türer; iç mantık kalitesinden değil. Gerçek
bir tape-out'ta bu değer pad ring ve kart yüküyle yeniden belirlenir
(pad ring şartname Bölüm 2 gereği kapsam dışıdır).

**Yine de dürüst uyarı:** karakterizasyon aralığının dışında kalan bir slew,
o hücrenin gecikmesinin Liberty'den **ekstrapole** edildiği anlamına gelir;
bu 12 arcta STA sonucu diğerleri kadar güvenilir değildir. Sayı gizlenmeden
beyan edilir.

> **İYİLEŞME KAYDI (§8).** Tel bölme kampanyasından önce bu sayılar
> 969 max-slew (641 std hücre) ve **613** max-cap idi; kütüphane limitini
> aşan pin sayısı 21'di ve en kötüleri **saat ağacı yaprak tamponlarının
> girişleriydi** (`clkbuf_leaf_1_clk_i/A` 2,366 ns). `CTS_CLK_MAX_WIRE_LENGTH`
> ve `GRT_DESIGN_REPAIR_MAX_WIRE_LENGTH` uygulandıktan sonra saat ağacı
> pinleri listeden tamamen çıkmıştır.

Eşik **bilinçli olarak gevşetilmemiştir.** 1,5 ns'ye çıkarmak raporlanan
standart hücre sayısını 406'dan 12'ye düşürürdü, fakat bu bir tasarım
iyileştirmesi değil bir ölçüt değişikliği olurdu; Final Çıktılar §1.1 başarısız
sonuçları gizlemek amacıyla eşik değiştirmeyi yasaklar. Ayrıca 0,75 değeri
LibreLane'in değil **PDK'nın** varsayılanıdır: `config.yaml` bu anahtarı hiç
tanımlamaz, değer `sky130_fd_sc_hd/config.tcl:63`'ten gelir.

Max-cap tarafında limit 0,20 pF, en kötü değer **0,331 pF**'tir (önceki
koşumda 0,902 pF idi).

### 5. Zamanlama

Belirleyici sonuç yalnızca parazitik çıkarım sonrasındaki `OpenROAD.STAPostPNR`
adımından gelir ve üç PVT × üç RC olmak üzere dokuz corner için *Signoff sonuç
özeti* tablosunda verilmiştir.

**Beyan edilen ASIC saat frekansı FPGA gerçeklemesininkinden düşüktür.**
Tarihsel olarak bunun sebebi SRAM okuma yoluydu: SKY130 SRAM makrosunun
Liberty'si `dout0`/`dout1` çıkışları için `timing_type : falling_edge` tanımlar
(OpenRAM'in sense amplifikatörü negatif kenarda ateşlenir). Sarmalayıcı normal
`posedge` kullandığı için SRAM'den çıkan veri, yükselen kenarda yakalanana
kadar **T/2** süresi bulur, T değil.

> **GÜNCELLEME (2026-09-03) — bu tavan ARTIK BAĞLAYICI DEĞİLDİR.** Konvolüsyon
> yoluna `scripts/patch_rtl.py` ile SRAM çıkış kayıt kademesi eklendikten
> sonra yarım çevrimli yollar rahatladı. 28 MHz signoff koşumunda
> `max_ss_100C_1v60` köşesindeki **negatif slack'li yol sayısı sıfırdır**;
> ayrıca 30 MHz denemesinde (`run/final30`) ölçülen 460 negatif yolun
> **hiçbiri yarım çevrimli değildi** — hepsi tam çevrimliydi. Yani frekans
> tavanını artık SRAM okuma yolları belirlemiyor.
>
> Taze koşumda en kötü yol tam çevrimlidir ve şudur:
> `id_stage_i.decoder_i.instr_rdata_i[18]` → **register-file okuma mux'ı** →
> forwarding → `alu_operand_a_ex[3]`. Yani ID kademesinde komut yazmacından
> rs1 adresi çözülüp 32 girişli yazmaç dosyası okuma mux'ından geçen yoldur.
> Bu, CV32E40P mimarisinin gerçek tek-çevrim yoludur.
>
> Aynı yolun ayrıştırılmış maliyeti (30 MHz denemesi, 83 kademe): **44 kademe
> gerçek mantık (23,618 ns), 39 kademe resizer tamponu (9,521 ns)** — yani
> gecikmenin %29'u sentezin ürettiği mantık değil, fiziksel onarım tamponudur.
> Bu, tasarımın **tel-baskın** olduğunu gösterir ve sentez tarafındaki
> kaldıraçların neden işe yaramadığını açıklar (bkz. §6).
>
> Bu tavan bağımsız denetimde yeniden doğrulanmıştır: güncel koşumda ilk 20
> setup yolunun 15'i YZ SRAM bankasından başlayıp konvolüsyon hızlandırıcısının
> çarpan girişinde bitmektedir
> (bağımsız iç denetim; ölçüm kaydı
> [`reports/synthesis/strateji_denemeleri.md`](reports/synthesis/strateji_denemeleri.md)).
>
> Makro değiştirilemez, fakat tavan **RTL tarafında** kaldırılabilir: SRAM
> çıkışı (`ram_rdata`) kendi ağırlık kelimesiyle birlikte bir kademe
> registerlanırsa yol yarım çevrimden tam çevrime döner. Maliyeti yaklaşık
> 72 flip-flop (~1.700 µm²) ve boru hattı bir kademe uzadığı için çıkarım başına
> +500 çevrimdir (46.018 → ~46.518, %1,09). Bu değişiklik **yapılmamıştır**;
> kaynak RTL'ye dokunduğu ve YZ'nin bit-exact referansını kaydırdığı için
> ayrıca değerlendirilmektedir.

> **GÜNCEL DEĞER: `CLOCK_PERIOD: 35.714285714285715` ns = 28 MHz.** Aşağıdaki 38 ns
> kalibrasyonu ve onu izleyen doğrulama tabloları, macro-ring yerleşimine ve
> düzeltilmiş post-GRT ayarlarına geçilmeden önceki döneme aittir ve **tarihsel
> kayıt** olarak korunmaktadır. Güncel değerler için aşağıdaki otomatik
> üretilen *Sonuç özeti* bölümüne bakınız.

#### Tarihsel periyot seçimi (40 ns) ve gerekçesi

SRAM'in yarım çevrimlik okuma yolu (yukarıda anlatılan `falling_edge` yayı)
**RTL tarafında kaldırıldı**: `scripts/patch_rtl.py` ASIC kopyasına bir kayıt
kademesi ekler, böylece SRAM çıkışı ile çarpan arasındaki yol yarım çevrimden
tam çevrime döner (maliyeti 112 flip-flop ve çıkarım başına +501 çevrim,
46.018 → 46.519, %1,09). Bu değişiklikten sonra 50 ns'de setup slack
+3,62 ns'den **+10,77 ns**'ye çıktı.

Kapanabilecek taban, **aynı yollanmış veritabanı ve aynı parazitikler**
üzerinde yalnız SDC periyodu değiştirilerek ölçüldü (yeniden sentez veya
yeniden yollama değildir):

| Periyot | Frekans | Setup WS (`max_ss_100C_1v60`) | Setup ihlalli uç | Hold WS |
|---:|---:|---:|---:|---:|
| 50 ns | 20,0 MHz | +10,771 ns | 0 | +0,1423 ns |
| 46 ns | 21,7 MHz | +7,708 ns | 0 | +0,1423 ns |
| 44 ns | 22,7 MHz | +5,708 ns | 0 | +0,1423 ns |
| 42 ns | 23,8 MHz | +3,708 ns | 0 | +0,1423 ns |
| **40 ns** | **25,0 MHz** | **+1,708 ns** | **0** | **+0,1423 ns** |
| 38 ns | 26,3 MHz | −0,292 ns | 13 | +0,1423 ns |

Taban ≈ 38,3 ns'dir; **40 ns seçilmiştir**. Ölçüm 50 ns'ye göre optimize
edilmiş bir rota üzerinde yapıldığı için bu pay muhafazakârdır — 40 ns hedefiyle
yapılan temiz koşumda resizer gerçek kritik yollara daha sıkı çalışır.

Hold slack her periyotta **değişmemiştir** (+0,1423 ns): aynı-kenar yolları
periyottan bağımsızdır, dolayısıyla hızlanma hold marjını tüketmez.

Ham raporlar: `reports/synthesis/deney_arsivi/periyot_taramasi_sramreg/`.

Tarihsel kayıt — o dönemde beyan edilen hedef **38 ns = 26,32 MHz**'di. Bu değer tek bir CTS veritabanı
üzerinde, dokuz corner yüklü post-CTS resizer ile yapılan beş periyotluk
kalibrasyondan seçilmiştir:

| Periyot | Frekans | Başlangıçta ihlalli uç | Onarım sonrası kalan |
|---:|---:|---:|---:|
| 25 ns | 40,00 MHz | 1.850 | 1.850 — kapanmıyor |
| 35 ns | 28,57 MHz | 515 | 1 |
| 36 ns | 27,78 MHz | 494 | 4 |
| 37 ns | 27,03 MHz | — | **denenmedi** |
| **38 ns** | **26,32 MHz** | **297** | **0** ← seçilen |
| 40 ns | 25,00 MHz | 66 | 0 |

Seçim kuralı "kalan ihlali **sıfır** olan en küçük **test edilmiş** periyot"tur.
**37 ns denenmemiştir**, dolayısıyla 38 ns mutlak minimum değil, ölçülen
aday kümesinin en küçüğüdür. Post-CTS onarım sonrası WNS bir
**pay ölçüsü değildir**: `repair_timing` slack'i maksimize etmez, `-setup_margin
0.05` ile verilen 50 ps'lik iç hedefe ulaşınca durur — bu yüzden 35 ns'de
+0,028 ns, 38 ns'de +0,058 ns çıkar, yani periyot 3 ns uzamasına rağmen "pay"
neredeyse aynıdır. Aynı sebeple `[WARNING RSZ-0062]` uyarısı tek başına
"kapanmadı" anlamına gelmez.

Yöntem, tam tablo ve onarım eforu ölçümleri:
[`reports/timing/frekans_kalibrasyonu.md`](reports/timing/frekans_kalibrasyonu.md);
ölçümü üreten betik `scripts/calibrate_clock.py`.

**O tarihsel RCX sonrası STA, post-CTS kalibrasyonunu doğrulamadı.** 38 ns ana
koşum ve aynı yönlendirilmiş tasarım üzerinde yapılan 40 ns tanı koşusunun
sonuçları:

| Periyot | En kötü setup WNS / TNS | Setup ihlalli uç | En kötü hold WNS / TNS | Hold ihlalli uç | Max slew / cap |
|---:|---:|---:|---:|---:|---:|
| **38 ns** | **−24,738 / −5.270,001 ns** | **2.445** | **−1,751 / −260,481 ns** | **2.672** | **38.890 / 3.809** |
| 40 ns (yalnız tanı) | −22,738 / −3.684,052 ns | 1.936 | −1,751 / −260,481 ns | 2.650 | 38.890 / 3.809 |

40 ns setup’a en fazla 2 ns kazandırmış ve en kötü hold'u hiç değiştirmemiştir;
bu nedenle o tarihsel aşamada frekansı 25 MHz'e indirmek çözüm olmamıştır.
Bu eski çalışmada `CLOCK_PERIOD` 38 ns olarak korunmuştu; **güncel teslim
config'i 35,714285714285715 ns (28 MHz)** ve güncel dokuz-köşe STA sonucu
setup/hold ihlali sıfırdır.

> **`set_multicycle_path` ile geçiştirilmemiştir.** RTL'de tüketici bir çevrim
> daha beklemez; böyle bir istisna STA'yı temiz gösterir ama silikon çalışmaz.
> Şartname Bölüm 3.2 de bunu açıkça yasaklıyor.

Hold ihlalleri **saati yavaşlatarak kurtarılamaz**; hold ihlali silikonda kalıcı
arızadır. `PL_RESIZER_HOLD_SLACK_MARGIN: 0.02` ile post-CTS hold onarımı
yapılır. `RUN_POST_GRT_RESIZER_TIMING` LibreLane varsayılanında kapalıdır
(aracın kendi açıklamasında *"experimental, may hang"* notu vardır). Bu akışta
**faz 2'de bilinçli olarak AÇIKTIR** (`config.yaml: RUN_POST_GRT_RESIZER_TIMING:
true`); jumper'ları silmemesi için **faz 3 overlay'inde kapatılır**
(`experiments/antenna_jumper.yaml`). Gerekçe §"Üç fazlı akış" bölümündedir.

### 6. Frekans seçimi: 30 MHz denendi ve düştü, 28 MHz ölçüyle seçildi

Bu bölüm, beyan edilen 28 MHz'in nasıl seçildiğini ölçümle belgeler.

**30 MHz tam akışla denendi ve DÜŞTÜ** (`run/final30`, `CLOCK_PERIOD 33,333333`).
Akış 78 adımın tamamını tamamladı, fizik temizdi (yollama/Magic/KLayout DRC,
LVS, XOR, PDN, hold — hepsi 0), fakat **setup ss köşelerinde kapanmadı**:

| Köşe | Setup WNS | Setup TNS | İhlalli uç |
|---|---:|---:|---:|
| `max_ss_100C_1v60` | **−2,0116 ns** | −494,33 ns | 460 |
| `nom_ss_100C_1v60` | −1,5145 ns | −273,51 ns | 416 |
| `min_ss_100C_1v60` | −1,0958 ns | −94,77 ns | 293 |

Toplam **1.169 setup ihlali**.

> **⚠ AKIŞIN TAMAMLANMASI ZAMANLAMANIN KAPANDIĞI ANLAMINA GELMEZ.**
> LibreLane'in `Checker.SetupViolations` adımı yalnızca
> `TIMING_VIOLATION_CORNERS = ['*tt*']` ile eşleşen köşeleri **hata** sayar;
> ss köşeleri yalnızca uyarı üretir. `Checker.MaxSlewViolations` ve
> `Checker.MaxCapViolations` ise `['']` ile tanımlıdır ve
> `librelane/steps/checker.py:531-538` içindeki `get_corner_wildcards()` boş
> jokeri elediği için eşleşen köşe kümesi boşalır — bu iki kontrol **hiçbir
> zaman akışı düşüremez**. Yalnızca `Checker.HoldViolations` (`['*']`) dokuz
> köşenin tamamını zorlar.
>
> Kanıtı `run/final30`'un kendisidir: 1.169 setup ihlaliyle "Flow complete."
> mesajı vermiştir. Bu nedenle bu projede zamanlama kararı **her zaman**
> `final/metrics.json` içindeki `timing__setup_vio__count` ve
> `timing__setup__ws__corner:*` alanlarından verilir, akışın çıkış kodundan
> değil.

**Ölçülen maksimum frekans.** Sabit netlist ve sabit rota üzerinde slack
periyoda birebir doğrusaldır. `final30`'un 460 negatif yolunun tamamı tam
çevrimli olduğu için sıfır-slack periyodu doğrudan hesaplanır:

| Gerçeklem | Hedef T | max_ss WS | **T₀ (sıfır slack)** | Fmax |
|---|---:|---:|---:|---:|
| `final40c` (25 MHz hedefiyle) | 40 ns | +0,4051 @ 33,333 | 32,93 ns | 30,37 MHz |
| `run/final30` (30 MHz hedefiyle) | 33,333 ns | −2,0116 | 35,35 ns | 28,29 MHz |
| `run/final30b` (30 MHz + tel bölme) | 33,333 ns | ≈ −2,42 | ≈ 35,75 ns | ≈ 27,97 MHz |
| `final28` (tel bölmesiz) | 35,714 ns | +2,5223 | 33,19 ns | 30,13 MHz |
| `uart28_m3a010_final` (önceki teslim) | 35,714 ns | +2,4497 | 33,26 ns | 30,06 MHz |
| **`rtl2gds_20260908_final` (bu teslim)** | **35,714 ns** | **+1,9960** ¹ | **32,75 ns** ¹ | **30,53 MHz** ¹ |

¹ Bu teslimde raporlanan `max_ss` WS (**+1,996 ns**) **yarım çevrimli** bir
yoldadır: başlangıç noktası SRAM'in `dout`u, Liberty'de `timing_type:
falling_edge` olduğu için düşen kenarda tetiklenir ve yakalama yükselen
kenardadır. Yarım çevrimli bir yolda periyodu ΔT kısaltmak pencereyi yalnızca
ΔT/2 daraltır, dolayısıyla T₀ hesabı bu yoldan **yapılamaz**. Bağlayıcı olan en
kötü **tam çevrimli** yoldur: `_127925_ → _121044_`, slack **+2,960 ns** →
T₀ = 35,714 − 2,960 = **32,75 ns → 30,53 MHz**. Aynı yolun yarım çevrimli
karşılığı 35,714 − 2×1,996 = 31,72 ns (31,5 MHz) verir, yani gevşek olan odur.

**Kritik gözlem:** 25 MHz hedefiyle koşulan `final40c`, 30 MHz hedefiyle
koşulan `final30`'dan **2,42 ns daha hızlı** bir fiziksel gerçeklem üretmiştir.
İki koşum arasındaki netlist farkı yalnızca frekanstan türeyen sabitlerdir
(boot ROM içeriği + I2C bölücüsü). Yani **koşumdan koşuma dağılım ~2,4 ns
mertebesindedir.**

**28 MHz'in gerekçesi bu dağılımdır.** Tel bölmesiz `final28` koşumunun
ölçülen T₀'ı 33,19 ns idi, yani o gerçeklem 30 MHz'i teknik olarak karşılardı
— fakat yalnızca **+0,14 ns** payla. 2,4 ns'lik koşum dağılımı karşısında bu
pay anlamsızdır.

**30 MHz İKİ KEZ DENENDİ VE İKİSİNDE DE DÜŞTÜ.** İkinci deneme
(`run/final30b`) tel bölme kaldıraçlarıyla yapıldı ve **daha kötü** sonuç
verdi: post-GRT resizer −3,312 yerine −3,756'da takıldı. Sebep §8'deki
takastır — tel bölme anteni düzeltir, zamanlamayı bozar.

30 MHz için denenip elenen kaldıraçların tam listesi:

| Kaldıraç | Sonuç |
|---|---|
| `SYNTH_STRATEGY: DELAY 0 / 2 / 4` | üçü de reddedildi (aşağıdaki sentez tablosu) |
| `PL_TARGET_DENSITY_PCT: 50` | Nesterov HPWL **%19,7 kötüleşti** — çürütüldü |
| `GRT_DESIGN_REPAIR_MAX_WIRE_LENGTH` | antene iyi, **zamanlamaya kötü** |
| `CTS_CLK_MAX_WIRE_LENGTH` | antene/slew'e iyi, **zamanlamaya kötü** |
| Die küçültme (4200×3000) | **denenmedi** — tek kalan yol |

`PL_TARGET_DENSITY_PCT: 50` sonucu sezgiye aykırıdır ve mekanizması
ölçülmüştür: yüksek hedef yoğunluk yerleştiriciyi önce sıkıştırır, bu yerel
tıkanıklık yaratır, yollanabilirlik sürücüsü hücreleri **+%217** şişirerek
patlatır (taban +%42) ve net sonuç gevşek hedefle başlamaktan **daha yayvan**
bir yerleşim olur.

Bu teslim (`i2c_20260907_final`) güncel RTL ile 28 MHz'i **+2,381 ns** payla
kapatır.
Anten, Final Çıktılar §2'nin açıkça saydığı DRC/LVS/anten/setup-hold kontrolleri
arasında karşılanmayan kalemdir. Max-slew ve max-cap sonuçları da §4'te
ayrıca ve gerçek sayılarıyla raporlanır.

**28 MHz ayrıca bölücüleri tam sayı yapar** (seçimin ikinci gerekçesi):

| f_sys | I2C: f/(2×400k) | UART: CPB | UART sapması |
|---:|---:|---:|---:|
| 25 MHz | 31,25 (kesirli) | 217 | %+0,006 |
| **28 MHz** | **35 (TAM)** | **243** | **%+0,023** |
| 30 MHz | 37,5 (kesirli) | 260 | %+0,160 |

I2C yarı-periyodu tam 35 çevrim olduğu için kesirli (Bresenham) dağıtım dalı
hiç tetiklenmez ve SCL **jitter'sız tam 400,000 kHz** olur. Ayrıntı: §21.1.

**Sentez tarafında aranan kaldıraçlar — üçü de ölçülüp elendi.** Kritik yolun
%29'u resizer tamponu olduğu için (§5) mantık derinliğini azaltmak denendi.
`SYNTH_STRATEGY` üç `DELAY` varyantı ölçüldü:

| Strateji | ABC kritik yol (`stime -p`, tel yükü YOK) | Sonuç |
|---|---:|---|
| `AREA 0` (kullanılan) | 19.198 ps | referans |
| `DELAY 0` | 21.852 ps (+%20,5) | RED |
| `DELAY 2` | 18.828 ps (+%3,8) | RED |
| `DELAY 4` | **9.394 ps (−%51,1)** | **RED — tam akışta düştü** |

`DELAY 4` ABC ölçütünde kritik yolu yarıya indiriyordu, fakat tam akış bunu
çürüttü: yerleştirmenin yollanabilirlik şişirmesi +%41,9'dan **+%166,7**'ye
çıktı, post-CTS gereken periyot 24,312'den 26,683 ns'ye **kötüleşti**, global
yollama talebi +%83,1 arttı ve toplam aşım 0'dan **102**'ye çıkarak
`[ERROR GRT-0116]` ile akışı öldürdü.

> **Ders:** `ABC: WireLoad = "none"` satırındaki `Delay`/`lev` sayısı tel
> gecikmesini **içermez** ve bu tel-baskın tasarım için kötü bir vekildir.
> `DELAY 4` mantığı sığlaştırırken genişletiyor; hücre sayısı %27,8 artarken
> yollama talebi %83,1 artıyor — asıl maliyet alan değil, **ağ sayısıdır**.
> Sentez stratejisi kararları en az `OpenROAD.GlobalRouting` adımına kadar
> koşulmadan verilmemelidir. Tam kayıt:
> [`reports/synthesis/strateji_denemeleri.md`](reports/synthesis/strateji_denemeleri.md)
> bölüm 11 ve 13.

### 7. 480 bağlantısız pin — açıklaması

`design__disconnected_pin__count` **480**, `design__critical_disconnected_pin__count`
**0**'dır. Sayı açıklanmadan bırakılmamalıdır:

**480 = 15 makro × 32 bit.** Netlist denetimiyle doğrulandı: her SRAM
örneğinde rw portunun okuma çıkışı `dout0[31:0]` Yosys'in kukla telleriyle
(`{_NC1, _NC2, …}`) bağlanmıştır; tasarım okumayı salt-okunur port `dout1`
üzerinden yapar. Yani bunlar **kullanılmayan ÇIKIŞ** pinleridir — sürülmeyen
bir giriş değil, kullanılmayan bir çıkış. İşlevsel veya elektriksel bir sorun
oluşturmazlar; `critical` sayacının 0 olmasının sebebi budur.

### 8. Tel bölme kampanyası — anten, max-cap ve slew birlikte düşürüldü

Bu bölüm önceki teslim koşumundaki (`run/ant28`) iki ayarın gerekçesini ve
ölçülen sonucunu belgeler. Onu izleyen eski teslim met3=%15 kullanmış;
güncel UART RTL'inde bu değer yollanamadığı için önce met3=%10'a geçilmiş;
güncel I2C entegrasyonu koşumunda ise post-GRT marjı için met3=%9 seçilmiştir.

**Kök neden.** Anten ihlali, bir kapıya bağlı **kesintisiz metal alanının**
kapı alanına oranıdır. Ölçüm, ihlallerin uzun netlerde yoğunlaştığını gösterdi:

| | Anten ihlal eden netler | Tüm netler |
|---|---:|---:|
| Medyan yollanmış uzunluk | **662,8 µm** | **15,0 µm** |

44 kat fark. Buna karşın **ihlalin şiddeti** ile uzunluk arasındaki korelasyon
yalnızca **r = 0,177**'dir — çünkü oranın paydası kapı alanıdır ve o hücreden
hücreye çok değişir. Yani uzunluk bir netin ihlal *edip etmeyeceğini* güçlü
belirler, *ne kadar kötü* olacağını belirlemez.

**Bulunan açık.** İki uzunluk sınırı da devre dışıydı:

| Ayar | Eskiden | Gerçek anlamı |
|---|---|---|
| `GRT_DESIGN_REPAIR_MAX_WIRE_LENGTH` | `0` | LibreLane: *"If set to 0, no buffers will be inserted"* — uzunluk tabanlı bölme **kapalı** |
| `CTS_CLK_MAX_WIRE_LENGTH` | `0` | **"kapalı" değil**: `repair_clock_nets`'e gider ve OpenROAD gecikme-optimal değeri kendisi hesaplar (**2936 µm**) |

Sonuç: güçlü bir sürücüyle 0,75 ns slew'i tutturan **uzun** bir net hiç
bölünmüyor ve devasa anten alanı biriktiriyordu. En uç örnek
`clknet_1_0_1_clk_i` idi: **6.326 µm**, tasarımdaki en uzun net, hem 3,30×
anten ihlali hem de beslediği yaprak tamponlarında 2,3 ns slew üretiyordu.

**Uygulanan.** `GRT_DESIGN_REPAIR_MAX_WIRE_LENGTH: 250` ve
`CTS_CLK_MAX_WIRE_LENGTH: 600`.

**Bu bir TAKASTIR, bedava değildir.** OpenROAD her iki adımda da uyardı:
`[WARNING RSZ-0065] max wire length less than 2936u increases wire delays.`
2936 µm gecikme-optimal tekrarlayıcı aralığıdır; altına inmek tampon
gecikmesini RC kazancından fazla artırır. Takas bilinçli olarak
üretilebilirlik lehine yapılmıştır.

**Ölçülen sonuç** (`final28` = aynı frekans, tel bölmesiz taban):

| Metrik | `final28` | **`ant28` (önceki teslim)** | Değişim |
|---|---:|---:|---:|
| Setup WS (`max_ss_100C_1v60`) | +2,5223 ns | **+0,8987 ns** | −1,624 ns |
| Hold WS (`min_ff_n40C_1v95`) | +0,0863 ns | +0,0717 ns | −0,015 ns |
| Setup / hold ihlalli uç (9 köşe) | 0 / 0 | **0 / 0** | — |
| **Anten ihlali (net)** | 1.478 | **955** | **−%35,4** |
| **Anten ihlali (pin)** | 1.883 | **1.013** | **−%46,2** |
| **Max cap ihlali** | 613 | **14** | **−%97,7** |
| Max slew — standart hücre | 641 | **403** | −%37,1 |
| Max slew — SRAM (yapısal) | 328 | 328 | değişmedi |
| Yollama / Magic / KLayout DRC | 0 | **0** | — |
| Toplam tel uzunluğu | 9.966.324 µm | 9.991.404 µm | +%0,25 |
| Eklenen onarım tamponu (adım 41) | 2.210 | **17.436** | +15.226 |
| GRT toplam aşım | 0 | **0** | — |

**Max cap'in %97,7 düşmesi öngörülmemişti** ama mekanizma açıktır: neti
bölmek net başına kapasitansı da böler. Tel bölme böylece üç problemi birden
iyileştirmiştir: anten, max-cap ve slew.

**Neden sıfır değil?** Üç bağımsız yapısal sebep:

1. **Kısa netler bölünemez.** İhlallerin %29,5'i zaten 400 µm'nin altındadır;
   bunlar uzun oldukları için değil **kapıları küçük** olduğu için ihlal eder.
2. **met3 jumper'la ulaşılamaz.** İhlallerin çoğunluğu met3'tedir; jumper iki
   katman yukarı çıkar (met1→met3 ✔, met2→met4 ✔) ama met3→met5 için
   `RT_MAX_LAYER` met4'tür. met5 ayrıca ölçülüp elenmiştir (via4 makro üstünde
   kapalıdır; açıldığında DRC ihlallerinin ~%67'sini tek başına üretiyordu).
3. **Diyot yolu ölçüldü ve reddedildi** (§11). GRT aşamasında ihlalleri
   %60 düşürüyor, fakat detaylı yollama kazancın çoğunu geri üretiyor ve
   max-slew'i iki katına çıkarıyor.

Modelleme dürüstlüğü için kayda geçirilmiştir: bölme öncesi model 250 µm için
~552 kalan pin öngörmüş, gerçek **1.013** çıkmıştır. Sebep, modelin detaylı
yollamanın **yeniden yollama sırasında ürettiği yeni ihlalleri** hesaba
katmamasıdır (jumper çıkışında 677 pin → DRT sonrası 1.013 pin).

Ardından met3 kaynak cezasını yalnız adım 39 ve sonrasında %15 yapmak, tam
temiz koşumda anteni **955/1.013 → 926/979** indirdi. Aynı değişiklik setup
payını **+0,8987 → +0,9975 ns** yükseltti; yollama DRC yine 0 kaldı. Ayrıntılı
tek-değişkenli kayıt `reports/synthesis/strateji_denemeleri.md` §23-25'tedir.

### 9. Anten kontrolünün kapsam sınırı — SRAM makro pinleri

`15-odb-checkmacroantennaproperties` adımı şu uyarıyı üretir:

> `Cell 'sky130_sram_2kbyte_1rw1r_32x512_8' has (59) input pin(s) without
> antenna gate information.`

Makro LEF'leri doğrudan sayıldığında: **14 × 59 + 1 × 57 = 883 makro giriş
pini** `ANTENNAGATEAREA` bilgisi taşımaz. OpenROAD bu pinler için anten oranı
hesaplayamaz ve dolayısıyla **ihlal raporlamaz**.

**Bunun doğru okunuşu bir sınırdır, bir kazanç değildir.** Raporlanan
1.067 net / 1.122 pin, yalnızca makro girişine giden netler bakımından **iyimser
olabilir**; kontrol kapsamı o netlerde eksiktir. Bu, "883 ek ihlal var"
anlamına **gelmez** — hesaplanamayan bir büyüklüğün varlığı, ihlal olduğunu
göstermez.

Makro LEF'i şartname §1.1 gereği değiştirilemediği için bu sınır
giderilemez; burada açıkça beyan edilir.

### 10. SRAM makro `config/` dizini teslimde neden yok

Final Çıktılar Tablo 8, `asic/macros/<makro>/config/` dizinini
"makronun OpenRAM veya diğer oluşturma araçlarına ait yapılandırma dosyaları"
için listeler. Bu dizin teslimde **yoktur** ve bu bilinçli bir karardır:

Kullanılan iki SRAM makrosu takım tarafından OpenRAM ile **üretilmemiştir**;
referans PDK'nın `sky130A/libs.ref/sky130_sram_macros/` paketinden alınmıştır.
O paket yalnızca `gds`, `lef`, `lib`, `mag`, `maglef`, `spice` ve `verilog`
görünümlerini dağıtır — **OpenRAM generation config'i ve çalışma logları
dağıtılmaz.** Takım geriye dönük veya yapay bir config dosyası üretmemiştir;
üretilseydi makronun gerçek üretim geçmişini temsil etmeyen bir belge olurdu.

Sağlanan GDS, LEF, Liberty, Verilog ve SPICE görünümleri **değiştirilmeden**
teslim edilmiştir; kaynak, sürüm ve lisans bilgileri
[`THIRD_PARTY.md`](THIRD_PARTY.md)'dedir.

### 11. Diyot tabanlı anten onarımı — ölçüldü ve reddedildi

Bu bölüm, önceki README sürümlerindeki **yanlış bir hükmü düzeltir**. Eskiden
"diyot tabanlı onarım ölçümle kapatıldı" deniyordu; o eleme aslında farklı bir
mekanizmaya aitti ve GRT aşamasındaki diyot yolu hiç ölçülmemişti.

**Eski kaydın düzeltilmesi.** Elemenin dayandığı deney diyotları **detaylı
yollama döngüsünün içinde** ekliyordu (`DRT_ANTENNA_REPAIR_ITERS > 0`).
Kayıtta "yaklaşık 2.930 diyot" yazıyordu; ham log ise şunu diyor:

```
[INFO ANT-0002] Found 2930 net violations.     <- bu NET sayısı
[INFO GRT-0015] Inserted 9587 diodes.          <- gerçek diyot sayısı
```

Yani 2.930 net sayısıdır; gerçekte 9.587 diyot yerleştirilmiştir.

**Fizik doğrudur.** İhlaller "Gate area" değil **"Side area"** kuralındandır ve
sınır, nete bağlı difüzyon alanının fonksiyonudur (SKY130 tech LEF,
met katmanları):

```
ANTENNADIFFSIDEAREARATIO PWL ( (0 400) (0.0125 400) (0.0225 2609) (22.5 11600) )
```

`sky130_fd_sc_hd__diode_2` hücresi `ANTENNADIFFAREA 0.434700` taşır; yani bir
diyot o netin sınırını 400'den ~2.800'e (**~7 kat**) çıkarır. Bu, tasarımın
kendi anten raporunda gözlemlenebilir: difüzyonu olan netlerin `Required`
değerleri 2.778–3.872 arasındadır (difüzyonsuzlar 400,00).

**GRT aşaması diyot yolu ölçüldü** (`deney_arsivi/diode28_rejected/`,
tel bölmesiz taban üzerinde, tek değişken `GRT_ANTENNA_REPAIR_JUMPER_ONLY:
true → false`):

| | yalnız jumper | jumper + diyot |
|---|---:|---:|
| Adım 44 (GRT) ihlalli net | 1.117 | **448 (−%60)** |
| **DRT sonrası ihlalli net** | **1.478** | **1.043** |
| DRT büyüme faktörü | 1,32× | **2,33×** |
| DRT iterasyon / süre | 8 / 17:34 | **17 / 1:01:36** |
| Setup WS (`max_ss`) | +2,5223 ns | +2,2007 ns |
| **Max slew** | 969 | **1.465** |
| Yollama DRC | 0 | 0 |

**Neden reddedildi.** Diyot GRT aşamasında beklendiği gibi çalışıyor, fakat
3.042 diyot detaylı yollamayı belirgin zorlaştırıyor (başlangıç DRC 131.148,
tabanın 2,5 katı) ve agresif yeniden yollama kazancın çoğunu geri üretiyor.
Sonuç, o tarihteki teslim koşumunun **926 netinden kötüdür** (1.043) ve
max-slew'i iki katına çıkarır. Güncel RTL'deki 1.067 değeriyle doğrudan
karşılaştırma tek değişkenli değildir. Diyot adayı kendi kontrollü tabanına
karşı gösterdiği yollama/slew bedeli nedeniyle reddedilmiştir.

**Kayda geçirilen modelleme dersi.** Deney öncesinde, mevcut P/R dağılımından
"net başına bir diyot ihlallerin ~%99'unu temizler" diye statik bir tahmin
yapılmıştı. Gerçek sonuç bunu çürüttü: tahmin, detaylı yollamanın **yeniden
yollama sırasında ürettiği yeni ihlalleri** hesaba katmıyordu. Anten
tahminlerinde DRT büyüme faktörü zorunludur ve diyot durumunda daha büyüktür.

### 12. SRAM okuma yolunda FPGA'dan sapan tek nokta

`sram32_bank` / `sram8_bank`, `RD_COLLISION_SAFE=1` ile örneklendiğinde
(`bram_yz` ve `conv_buf_ram`) aynı kelimeye aynı çevrimde yazma+okuma geldiğinde
o çevrimde makronun okuma portunu pasif bırakır ve çıkışta **son geçerli okuma
verisini** tutar. FPGA'daki BRAM read-first semantiği ise o adresin **yazma
öncesi değerini** döndürürdü.

Bu bilinçli bir seçimdir: OpenRAM makrosunda aynı adrese eşzamanlı yaz/oku
**tanımsızdır** (davranışsal model `WARNING: Writing and reading addr0=… and
addr1=… simultaneously!` basar ve veri bozulabilir). Tanımsız davranış yerine
deterministik bir davranış seçilmiştir. Yazılım sözleşmesi
zaten DMA ile çıkarımı örtüştürmez; `SRAM_ASSERTIONS` derleme bayrağı açıkken
regresyon bu durumu ayrıca denetler (`make asic_sim`).

> **Sınırlama:** `rbank_q`, `rlane_q`, `re_eff_q` ve `rdata_hold_q` **resetsizdir**.
> Dolayısıyla "X üretmez" garantisi ancak **ilk geçerli okumadan sonra** geçerlidir;
> güç verildiği andan ilk okumaya kadar `rdata` simülasyonda X, silikonda
> rastgeledir. Bu, tasarımdaki 4.431 resetsiz flip-flop'un genel durumuyla
> aynıdır ve tüketici bu aralıkta veriyi kullanmadığı için işlevsel
> etkisi bulunmamıştır — `tb_asic_mem_equiv` 12.592 kontrolün tamamını geçer.
> Kesin garanti isteniyorsa bu dört küçük kontrol kaydı resetlenebilir; maliyeti
> ihmal edilebilir, ama netlist değişeceği için yeniden doğrulama gerekir.

`bram_instr` / `bram_data` bu moddan **etkilenmez**: onların AXI denetleyicileri
aynı-adres çakışmasını zaten arbitre eder, dolayısıyla varsayılan
`RD_COLLISION_SAFE=0` ile kullanılırlar ve DMEM→CPU yarım çevrim kritik yoluna
hiçbir ek mantık girmez.

### 13. YZ girdi RAM'i derinliği

`yz_bram_axi_ctrl`'nin `DEPTH` parametresi FPGA'dan gelen **9.904** değerini
korur, ama ASIC'te fiziksel derinlik SRAM makro granülaritesi nedeniyle
**9.216 bayt**tır (4 × 2 KB + 1 × 1 KB). 9.216–9.903 aralığına yazma, adres
kod çözmede alt bankaya **alias** yapar. İşlevsel etkisi yoktur: model girdisi
her zaman 1.960 bayttır (`yz_bram_axi_ctrl.sv:55` sayacı 1959'da sarar) ve
hızlandırıcı yalnızca bu aralığı okur. Ayrıntılı bütçe tablosu
`asic_rtl/mem/bram_yz_asic.sv` başlığındadır.

### 14. RTL'de sürülmeyen sinyaller — düzeltildi (yamalı kopya ile)

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

### 15. YZ hızlandırıcının MAC yolu boru hattına alındı

Bu, ASIC varyantında **davranışı etkileyen tek değişikliktir**; bu yüzden ayrıca
belgelenmiştir.

Orijinal RTL çarpma ile birikimi tek çevrimde yapıyor:

```verilog
acc[ci] <= acc[ci] + ($signed({1'b0, ram_rdata}) - INPUT_ZP) * $signed(w_dout[8*ci +: 8]);
```

FPGA'da bu ifade **DSP48E1** hard-makrolarına gidiyordu; SKY130'da böyle bir
blok olmadığı için standart hücre çarpanı + 32-bit toplayıcı zincirine dönüşüyor
ve 38 ns'lik periyodu aşıyor. İlk ASIC koşusunda tasarımın **bütün setup
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

### 16. `obi_to_axi.sv` — sıfır genişlikli tür ve parça-seçim

`AxiDataWidth == ObiCfg.DataWidth` (ikisi de 32) olduğunda `$clog2(1) = 0`
olur; ayrıca bu konfigürasyonda `AxiUserWidth`, OBI `RUserWidth` ve tek OBI
kanalını sayan `$clog2(NumObiChans)` değeri de 0'dır. Sıfır genişlikli port,
register ve parça-seçimler SystemVerilog'da geçersizdir (LRM 11.5.1). İlgili
opsiyonel dallar bu yapılandırmada hiç alınmaz. Yamalı kopyada yalnız fiziksel
SV tür genişliği en az 1 olacak şekilde sarmalanmış, mantıksal parametreler
aynı bırakılmıştır. Ön-uç doğrulamasında yeni ve önceki sentez netlistlerinin
SHA256'sı birebir aynıdır; üretilen donanım değişmez.

### 17. Reset senkronizatörü blok İÇİNDEDİR

> Bu bölümün önceki sürümü "`top_module` içinde reset senkronizatörü yoktur"
> diyordu; **bu ifade yanlıştı** ve düzeltilmiştir.

ASIC top yaması (`scripts/patch_rtl.py`) iki kademeli, asenkron-assert /
senkron-deassert bir reset senkronizatörü **ekler**
(`asic_rtl/patched/Top_module_asic.sv`):

```systemverilog
(* async_reg = "true", keep = "true" *) logic [1:0] rst_sync_q;
always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) rst_sync_q <= 2'b00;
    else         rst_sync_q <= {rst_sync_q[0], 1'b1};
end
assign rst_sys_ni = rst_sync_q[1];
```

Harici `rst_ni`'nin tek fanout'u bu iki flopun asenkron reset pinidir; 14 alt
modülün tamamı `rst_sys_ni` kullanır. **Neden gerekliydi:** yamadan önce `rst_ni`
doğrudan 4.662 iç flopu sürüyordu ve pre-PnR STA'da TT'de 75 ns / SS'te 106 ns
slew ile −111 ns recovery slack üretiyordu; blanket bir false-path bu gerçek
problemi gizliyordu.

Bu yüzden SDC'deki `set_false_path -from [get_ports rst_ni]` yalnızca **harici
asenkron sınıra** uygulanır — iç reset ağacının (`rst_sys_ni`) recovery/removal
ve slew/fanout kontrolleri gerçek STA'da görünür kalır.

**Kalan sınırlama:** `clk_i` durursa deassert propagate olmaz. Bu, iki floplu
senkronizatörün standart davranışıdır.

### 18. SRAM Liberty modeli tek corner

Bkz. *SRAM ve fiziksel makrolar* bölümündeki not. Yavaş/hızlı corner
sonuçları SRAM gecikmesi açısından tipik değere dayanır.

### 19. Aynı adrese eşzamanlı okuma/yazma — arbitrasyona bağlandı

OpenRAM 1RW+1R makrolarında aynı adrese aynı çevrimde yazıp okumak
**tanımsızdır**; davranışsal model `WARNING: Writing and reading addr0=… and
addr1=… simultaneously!` basar ve okunan veri bozulabilir.

> Bu bölümün önceki sürümü iki hatalı iddia içeriyordu ve düzeltilmiştir:
> (1) durumun *yalnızca* YZ girdi RAM'inde oluştuğu — Data RAM'de de oluşuyordu;
> (2) "CPU veri portu aynı çevrimde hem okuma hem yazma üretemez" — **eşzamanlılık
> gerekmiyor**, çünkü okuma adresi `raddr_q` ile sabit tutulur, dolayısıyla
> önceki bir okumanın adresi hâlâ portta dururken oraya bir yazma düşebilir.
> Ayrıca OBI→AXI köprüsü `MaxRequests = 4` ile veri portunda dört işlemi aynı
> anda açık tutabilir: bir okuma `R_WAIT`'teyken aynı kelimeye yazma tamamlanırsa
> CPU **bozuk bir `lw` sonucu** alırdı. Mimari olarak erişilebilir bir yoldu.

Bugün dört bellek de korunmaktadır, ama iki farklı mekanizmayla:

| Bellek | Koruma | Nerede |
|---|---|---|
| Data RAM | Okumaya öncelik; yazma `awready`/`wready` kırılarak **kayıpsız** bekletilir | `data_bram_axi_ctrl_asic.sv:52-64` |
| Instruction RAM | Yazmaya öncelik (DMA geri baskılanamaz); `arready` bir çevrim düşürülür | `instr_bram_axi_ctrl_asic.sv:141-143` |
| YZ girdi RAM'i | `RD_COLLISION_SAFE` — çakışma çevriminde makro deselect edilir, çıkış son geçerli veriyi tutar | `sram32_bank.sv`, bkz. **0.3** |
| YZ konvolüsyon tamponu | Aynı | `conv_buf_ram_asic.sv` |

İlk ikisi denetleyici seviyesinde arbitre edildiği için `sram32_bank`'i
varsayılan `RD_COLLISION_SAFE=0` ile kullanır; böylece DMEM→CPU yarım çevrim
kritik yoluna ek mantık girmez.

**Regresyon bunu artık gerçekten denetliyor.** `sram32_bank` ve
`axi_read_arbiter2` içindeki assertion'lar `SRAM_ASSERTIONS` / `AXI_ASSERTIONS`
makrolarına bağlıdır ve bu makrolar bir dönem **hiçbir yerde tanımlanmadığı için
assertion'lar ölü koddu**. `scripts/run_asic_sim.py` artık ikisini de tanımlar;
ayrıca makronun `simultaneously!` uyarısı başarısızlık ölçütüne eklenmiştir.
`make asic_sim` beş testin tamamını bu denetimler açıkken koşar.

### 20. I-RAM veri okuma yolu bağlanmamıştı — düzeltildi (ASIC'e özgü)

Bu, ASIC varyantında düzeltilen **ikinci işlevsel hatadır** (birincisi madde 15,
üçüncüsü madde 12).

`AXI4_Interconnect.sv:201` Instruction RAM'i **Master 8** olarak `0x1000_0000`
tabanında çözer, ama orijinal `Top_module.sv:762-765` o portun okuma yanıtlarını
sabite bağlıyordu:

```systemverilog
.axi_m8_arready(0),
.axi_m8_rdata  (0),
.axi_m8_rresp  (0),
.axi_m8_rvalid (0),
```

Sonuç: CPU `0x1000_0000` aralığından **veri** okuduğunda (örneğin bootloader'ın
I-RAM'e yazdığını doğrulaması ya da I-RAM'de tutulan bir sabitin okunması)
`ARREADY` kalıcı olarak 0 kalır ve **AXI işlemi hiç tamamlanmaz — çekirdek
kilitlenir.** FPGA'da fark edilmemesinin sebebi, o senaryonun test edilen
yazılım akışında tetiklenmemesidir.

ASIC yaması iki şey yapar (`scripts/patch_rtl.py`):

1. **`instr_bram_axi_ctrl` gerçek bir okuma darbesi üretir.** Önceden SRAM okuma
   portu `ARVALID`'den bağımsız olarak her çevrim açıktı; DMA aynı adrese
   yazarken makro tanımsız çift-port durumuna giriyordu. Artık
   `mem_re = arvalid && arready`, ve `read_conflict = we && (waddr == raddr)`
   ile DMA yazmasına öncelik verilip `ARREADY` bir çevrim düşürülür.
2. **Tek AXI okuma portu iki mastera paylaştırılır.** I-RAM'in okuma portunu
   artık hem komut getirme (`Instruction_Splitter`) hem veri okuma
   (interconnect M8) kullanıyor; aralarına
   [`asic_rtl/tech/axi_read_arbiter2.sv`](../asic_rtl/tech/axi_read_arbiter2.sv)
   konur.

Arbiter'ın AXI4-Lite açısından kritik özellikleri:

- **`ARVALID`/`ARADDR` handshake'e kadar sabit tutulur.** Downstream `ARREADY`'yi
  düşük tutarsa arbiter `ARB_AR_WAIT` durumuna geçer ve payload'ı **kayıtlı**
  değerlerden sürer; daha yüksek öncelikli bir istek gelse bile mevcut işlem
  preempt edilmez. (Bu, ilk sürümdeki gerçek protokol ihlaliydi.)
- **Grant, AR handshake'inden R handshake'ine kadar kayıtlı tutulur**
  (`grant_m1_q`), dolayısıyla cevap hiçbir koşulda yanlış mastera dönmez.
- **Round-robin.** Önceki sürüm katı öncelikliydi (`select_m1 = m1_arvalid`);
  data okuma sürekli valid tutarsa komut getirme açlığa girebilirdi. Son grant
  kaydıyla bu **yapısal olarak** imkânsız hâle getirildi; tek istek varken
  davranış değişmez, dolayısıyla performans maliyeti yoktur.

Doğrulama: `asic_rtl/testbench/tb_instr_bram_collision.sv` — iki masterlı okuma
arbitrajı + DMA yazma çakışması. `AXI_ASSERTIONS` açıkken "iki master aynı
çevrimde kabul edildi" ve "cevap iki master'a birden yönlendirildi" durumları
`$error` ile yakalanır. `make asic_sim` içinde `instr_collision` testi olarak
koşar ve geçer.

### 21. ASIC saat frekansının çevre birimlerine etkisi

Beyan edilen ASIC hedefi (**28 MHz**) FPGA gerçeklemesininkinden (50 MHz)
düşüktür. Bu hedef nihai post-route STA'da dokuz köşenin tamamında
**kapanmıştır** (en kötü setup +2,522 ns, `max_ss_100C_1v60`).
Frekans-bağımlılık yüzeyi baştan sona tarandı; sonuç:

| Birim | Bölücü nerede | Etkilenir mi | Durum |
|---|---|---|---|
| **I2C** | **RTL parametresi** `CLK_FREQ_HZ` | **Evet** | ASIC top yamasında override edildi — aşağıda |
| UART (×2) | `UART_CPB` **yazmacı** | Yazılım | Boot ROM sabiti mask'te donuyor — aşağıda |
| Timer | `TIM_PRE` **yazmacı** | Yazılım | Çalışma anında yazılır, sorun yok |
| QSPI | bölücü **yazmacı** | Yazılım | Çalışma anında yazılır; yavaşlaması güvenli yöndedir |

#### 21.1 I2C SCL bölücüsü — düzeltildi

Ortak `I2C_Master_AXI4_Lite.sv` varsayılan olarak FPGA'nın **50 MHz** sistem
saatini kullanır. Tam sayı bölücüyle 400 kHz üretmek için gereken yarı-periyot
62,5 çevrim olduğundan, blok taban ve taban+1 sistem çevrimli yarı-periyotları
bir kalan akümülatörüyle dağıtır:

```
HALF_BASE = floor(f / 800000)       HALF_REM = f mod 800000
```

FPGA'da yarı-periyotlar sırayla 62 ve 63 çevrimdir; iki yarı-periyodun toplamı
125 çevrim, yani **2,500 µs** olur ve SCL **tam 400,000 kHz** üretilir. Protokol
FSM'inin ilerleme eşiği de sabit bir sayaç değerine değil, o anda etkin olan
yarı-periyodun orta noktasına bağlıdır.

ASIC top yaması (`scripts/patch_rtl.py`) örneklemeyi
`I2C_Master_AXI4_Lite #(.CLK_FREQ_HZ(28_000_000))` yapar. Değer **elle
yazılmaz**, `i2c_clk_freq_hz()` tarafından `config.yaml`'daki `CLOCK_PERIOD`'dan
türetilir. **28 MHz bu bölmeyi tam sayı yapar**:

```
28.000.000 / (2 × 400.000) = 35        HALF_BASE = 35,  HALF_REM = 0
```

`HALF_REM == 0` olduğu için kesirli dağıtım dalı hiç tetiklenmez; her
yarı-periyot tam 35 çevrimdir ve SCL **jitter'sız tam 400,000 kHz**'dir.
I2C bölücü düzeltmesi artık ASIC'e özgü yamalı bir kopyada değil, FPGA ve
ASIC'in kullandığı **ortak RTL'dedir**. Bu nedenle gereksiz
`I2C_Master_AXI4_Lite_asic.sv` kopyası kaynak listesinden çıkarılmıştır; ASIC'e
özgü tek fark, sistem saatinin üst modülde açıkça aktarılmasıdır. FPGA
yönlendirilmiş testinde yazma/okuma/NACK/bayrak senaryoları 10/10 ve 309 SCL
periyot ölçümü 309/309 geçmiştir; AXI4-Lite protokol ihlali yoktur.

#### 21.2 Boot ROM'daki UART bölücüsü — ÇÖZÜLDÜ

*(Bu madde önceki sürümlerde "bilinen sınırlama" olarak duruyordu; artık
çözülmüştür ve kayıt olarak burada tutulmaktadır.)*

**Sorun.** Firmware `UART_CPB = 434` sabitini yazıyordu; bu değer **50 MHz
varsayımından** gelir (50e6/434 = 115.207 baud). ASIC 28 MHz'de koştuğunda aynı
sabit **64.516 baud** verirdi. Sabiti 243 yapmak da çözüm değildi: aynı firmware
FPGA demosunda da kullanıldığı için bu sefer orası 205.761 baud'a kayardı.
`main_boot.c` Boot ROM'dadır ve Boot ROM bir **mask ROM**'dur, yani yanlış değer
silikonda kalıcı olurdu.

**Çözüm — bölücü artık saat frekansından türetiliyor.** `FPGA/firmware/soc.h`:

```c
#ifndef SYS_CLK_HZ
#define SYS_CLK_HZ   50000000UL      /* varsayilan: FPGA gerceklemesi */
#endif
#define UART_CPB_FOR(baud)  (((SYS_CLK_HZ) + (baud) / 2u) / (baud))
#define UART_CPB_115200     UART_CPB_FOR(115200u)
```

ASIC derlemesi `-DSYS_CLK_HZ` ile ezer (`FPGA/firmware/Makefile` hedefleri
`asic_boot`, `asic_app`, `asic_sim_boot`, `asic_sim_app`), ve
`scripts/gen_rom.py` mask ROM'u **`asic_boot.hex`**'ten üretir; FPGA akışı
`boot.hex`'i kullanmaya devam eder.

| Derleme | `UART_CPB_115200` | Gerçekleşen baud | Sapma |
|---|---:|---:|---:|
| Varsayılan (FPGA, 50 MHz) | 434 | 115.207 | %+0,01 |
| ASIC (`-DSYS_CLK_HZ=28000000`) | **243** | 115.226 | %+0,02 |

**Doğrulama.** FPGA'nın `boot.hex` dosyasının SHA-256'sı değişiklikten önce ve
sonra **birebir aynıdır** (`add3cd1f…`) — yani FPGA demosu kanıtlanabilir
şekilde etkilenmemiştir. `asic_boot.hex` ise ondan tam **3 bayt** farklıdır:
komut akışındaki `addi a4, x0, 434` → `addi a4, x0, 243` anlık sabiti
(`0x1b200713` → `0x0f300713`).

**Akışta frekansı sabit varsayan diğer üç yer de düzeltildi:**

1. `scripts/run_asic_sim.py` 434'ü üç yerde sabit yazıyordu (biri `$fatal`
   assertion'ı). Artık `uart_cpb_from_config()` ile `config.yaml`'daki
   `CLOCK_PERIOD`'dan firmware ile **aynı formülle** türetiliyor.
2. `boot_test.sv` sabit `localparam int CPB = 416` taşıyor ve UART'ı çevrim
   sayarak sürüyordu. Kaynak testbench değiştirilmedi; koşum anında çalışma
   dizinine hizalanmış bir kopya yazılır.
3. `boot` ve `yz` testleri ROM'u simülasyona özel imajla ezer
   (`sim_boot.hex` / `sim_app.hex`); bunların da ASIC frekansındaki varyantları
   üretilir.

`tb_asic_mem_equiv` eşdeğerlik testi bu değişikliği doğru şekilde yakaladı
(ASIC ROM'u ile FPGA hex'i arasındaki 2 kelimelik farkı raporladı); testin
**referansı** ASIC hex'ine çevrildi, eşik gevşetilmedi.

> İşlevsel doğrulama bundan **etkilenmez**: regresyon testbench'leri çevrim
> tabanlıdır; YZ çıkarımının çevrim sayısı ve sınıf kararları frekanstan
> bağımsızdır. Simülasyon loglarındaki "@50 MHz" ifadeleri o testbench'lerin
> kendi saat sabitidir, ASIC'in fiziksel periyodu değildir.

### 22. DDK tarafından kabul edilmiş istisnalar

**Yok** — bu teslimde önceden onay alınmış bir istisna bulunmamaktadır.

---

## Güç ve IR-drop analizi

| | |
|---|---|
| Analizde kullanılan saat frekansı | 28 MHz (35,714286 ns) |
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

Aşağıdaki sayılar akışın ürettiği
[`results/metrics/metrics.json`](results/metrics/metrics.json) ile corner bazlı
[`reports/power/`](reports/power/) raporlarından
`scripts/gen_readme_results.py` ile doldurulur; elle yazılmaz.

### Alan ve kaynak kullanımı

| Ölçüm | Değer |
|---|---|
| Die alanı | 15.120.000 µm² (15,120 mm²) |
| Core alanı | 14.982.400 µm² (14,982 mm²) |
| Standart hücre alanı | 1.669.790 µm² (1,670 mm²) |
| Makro alanı (15 SRAM) | 4.174.250 µm² (4,174 mm²) |
| Toplam yerleşim alanı (hücre + makro) | 14.281.000 µm² (14,281 mm²) |
| Core utilization | 0,3901 |
| Toplam hücre sayısı | 1.342.890 |
| SRAM makrosu sayısı | 15 |
| Toplam kablo uzunluğu | 10.265.434 µm (10,27 m) |

### Zamanlama (nihai post-PnR STA, parazitik çıkarım sonrası)

| Corner | Setup WNS | Setup TNS | Hold WNS | Hold TNS |
|---|---|---|---|---|
| `nom_tt_025C_1v80` | 9,302 ns | 0 ns | 0,729 ns | 0 ns |
| `nom_ss_100C_1v60` | 2,072 ns | 0 ns | 1,680 ns | 0 ns |
| `nom_ff_n40C_1v95` | 11,986 ns | 0 ns | 0,402 ns | 0 ns |
| `min_tt_025C_1v80` | 9,464 ns | 0 ns | 0,755 ns | 0 ns |
| `min_ss_100C_1v60` | 2,372 ns | 0 ns | 1,686 ns | 0 ns |
| `min_ff_n40C_1v95` | 12,121 ns | 0 ns | 0,403 ns | 0 ns |
| `max_tt_025C_1v80` | 9,232 ns | 0 ns | 0,714 ns | 0 ns |
| `max_ss_100C_1v60` | 1,996 ns | 0 ns | 1,683 ns | 0 ns |
| `max_ff_n40C_1v95` | 11,904 ns | 0 ns | 0,390 ns | 0 ns |
| **Tüm corner'lar (en kötü)** | 1,996 ns | 0 ns | 0,390 ns | 0 ns |

### Fiziksel signoff

| Kontrol | İhlal sayısı |
|---|---|
| Magic DRC | **0** |
| KLayout DRC | **0** |
| Netgen LVS | **0** |
| LVS cihaz sayısı farkı | **0** |
| LVS net sayısı farkı | **0** |
| Anten ihlali (net) | **979** |
| Anten ihlali (pin) | **1034** |
| Yollama DRC | **0** |
| Bağlantısız pin | **480** |
| Kritik bağlantısız pin | **0** |
| GDSII XOR farkı (Magic ↔ KLayout) | **0** |
| Setup ihlali olan uç | **0** |
| Hold ihlali olan uç | **0** |
| Max slew ihlali | **845** |
| Max cap ihlali | **22** |
| Geçersiz örtüşme (illegal overlap) | **0** |
| Güç dağıtım ağı ihlali | **0** |
| Çıkarılan latch | **0** |
| Lint hatası | **0** |
| Lint uyarısı | **881** |
| Sentez yapısal kontrol hatası | **0** |

### Güç (tahminî — açık switching activity girdisi kullanılmadı)

| Corner | Internal | Switching | Leakage | Toplam |
|---|---|---|---|---|
| `nom_tt_025C_1v80` | 0,03604 W | 0,00530 W | 0,00025867 W | 0,04160 W |
| `nom_ss_100C_1v60` | 0,03306 W | 0,00410 W | 0,00129676 W | 0,03845 W |
| `nom_ff_n40C_1v95` | 0,03818 W | 0,00630 W | 0,00026077 W | 0,04474 W |
| `min_tt_025C_1v80` | 0,03604 W | 0,00502 W | 0,00025867 W | 0,04132 W |
| `min_ss_100C_1v60` | 0,03306 W | 0,00388 W | 0,00129676 W | 0,03824 W |
| `min_ff_n40C_1v95` | 0,03816 W | 0,00598 W | 0,00026077 W | 0,04440 W |
| `max_tt_025C_1v80` | 0,03604 W | 0,00557 W | 0,00025867 W | 0,04187 W |
| `max_ss_100C_1v60` | 0,03306 W | 0,00431 W | 0,00129676 W | 0,03867 W |
| `max_ff_n40C_1v95` | 0,03819 W | 0,00662 W | 0,00026077 W | 0,04507 W |

### IR-drop (statik güç dağıtım ağı analizi)

| Ölçüm | Değer |
|---|---|
| En kötü düğüm gerilimi | 1,8000 V |
| En kötü gerilim düşüşü | 0,0005 V |
| Ortalama gerilim düşüşü | 0,0000 V |

<!-- SONUC-OZETI-SONU -->

---

## Rapor ve çıktı konumları

Bütün raporlar ve çıktılar aynı `i2c_20260907_final` etiketi altında yürütülen
**üç fazlı LibreLane checkpoint zincirinden** üretilmiştir; akış sonrasında
elle düzenlenmemiştir.

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
| Takım kayıtları (şartname 7) | [`reports/timing/frekans_kalibrasyonu.md`](reports/timing/), [`reports/synthesis/strateji_denemeleri.md`](reports/synthesis/), [`reports/synthesis/deney_arsivi/`](reports/synthesis/deney_arsivi/), [`experiments/README.md`](experiments/) | Beyan edilen frekansın ölçüm kaydı, fiziksel tasarım kararlarının deney kaydı ve bu deneylerin ham kanıtları |
| 6.3 Önerilen ek çıktılar | [`results/odb/`](results/odb/), [`results/sdf/`](results/sdf/), [`results/lib/`](results/lib/), [`results/mag/`](results/mag/), [`results/images/`](results/images/), [`checksums/`](checksums/) | OpenROAD veritabanı, SDF, Liberty, Magic layout, yerleşim görüntüsü, SHA-256 özetleri |

Nihai GDSII dosyası `results/gds/top_module.gds`'tir ve **KLayout** tarafından
üretilir; Magic'in ürettiği ikinci GDSII görünümü ile arasındaki geometrik fark
[`reports/signoff/`](reports/signoff/) altındaki XOR raporundadır.

LibreLane çalışma etiketi: **`i2c_20260907_final`** (28 MHz teslim koşumu,
üç fazlı). Etiket ayrıca [`results/config/run_tag.txt`](results/config/run_tag.txt)
dosyasında makinece okunabilir biçimde saklanır.

---

## Üçüncü taraf bileşenler ve lisanslar

Ayrıntılı liste, sürümler, lisanslar ve takım tarafından yapılan değişikliklerin
özeti: [`THIRD_PARTY.md`](THIRD_PARTY.md). Lisans metinleri:
[`licenses/`](licenses/).
