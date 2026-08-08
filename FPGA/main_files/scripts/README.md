# scripts/wav_to_yz.py — Ses Dosyasından YZ Girdisi Üretme

1 saniyelik bir WAV kaydını, YZ hızlandırıcısının beklediği **49×40 = 1960
baytlık** özellik haritasına çevirir ve `scripts/sound_outputs/<wav-adı>.hex`
olarak yazar. Bağımlılığı yoktur (sadece Python 3 standart kütüphanesi).

```bash
python3 scripts/wav_to_yz.py kayitlar/evet.wav
# -> scripts/sound_outputs/evet.hex

# karta gönder (SW1=1, YZ-UART modu) — dosya yolunu doğrudan ver
cd firmware && python3 scripts/send_data.py audio ../scripts/sound_outputs/evet.hex
```

`firmware/sound_samples/` klasörüne dokunulmaz; `send_data.py yes|no|sessizlik`
kısayolları eskisi gibi oradaki referans dosyaları gönderir.

## Ne yapıyor?

Modelin eğitildiği **TFLite Micro "micro_speech" ön işleme hattının**
(microfrontend) birebir Python portu:

```
16 kHz mono int16 (1 s)
  → Hann penceresi (30 ms pencere / 20 ms adım) → 49 kare
  → 512 noktalı int16 sabit-nokta FFT (kissfft, FIXED_POINT=16)
  → 40 kanallı mel filtre bankası + tam sayı karekök
  → gürültü azaltma → PCAN otomatik kazanç → tam sayı logaritma
  → int8 nicemleme, dosyaya uint8 (= int8 + 128) olarak yazılır
```

Son adımdaki +128 kayması (offset-binary) zorunludur: `conv_accelerator.v`
girdi zero-point'ini −128 kabul edip RAM'den okuduğu baytı doğrudan
`(q_in + 128)` olarak kullanır, ZP çıkarma yapmaz.

> Hat baştan sona sabit-nokta olduğu için float bir FFT (librosa/numpy) aynı
> sonucu **vermez**; kissfft'in yuvarlaması da portlanmıştır. Çıktı referans C
> koduyla bit-exact doğrulandı: sessiz bir WAV, depodaki
> `input_data_sessizlik.hex` ile birebir aynı çıkıyor.

## Girdi sesi

En temizi 16 kHz, mono, 16-bit PCM, tam 1 saniye. Diğer durumlar otomatik
çevrilir (uyarı basılır): stereo → mono, 8/24/32-bit → 16-bit, farklı frekans
→ 16 kHz doğrusal interpolasyon, kısa kayıt → sıfırla doldurulur, uzun kayıt →
ilk 1 saniye. Kaydı baştan dönüştürmek daha iyi:

```bash
ffmpeg -i giris.mp3 -ac 1 -ar 16000 -sample_fmt s16 -t 1 cikis.wav
```

## Seçenekler

| Seçenek | Ne işe yarar |
|---|---|
| `-o, --output <yol>` | Çıktı yolunu elle belirle (tek girdi ile) |
| `--offset <sn>` | 1 s'lik pencerenin başlangıcı |
| `--auto-align` | Uzun kayıtta en yüksek enerjili 1 s'yi otomatik seç |
| `--gain <dB>` | Dönüşümden önce kazanç uygula (kısık kayıtlar için) |
| `--preview` | Özellik haritasını ASCII spektrogram olarak bas |

Toplu dönüşüm: `python3 scripts/wav_to_yz.py *.wav`
Çıktının tümü 0 ise kayıt sessizdir (script uyarır); `--gain` ile dene.

---

# scripts/project_gen — Vivado Proje Oluşturma Scriptleri

Bu klasördeki TCL scriptleri, Vivado projesini elle uğraşmadan **otomatik
oluşturur**.

---

## Nasıl çalıştırılır?

Vivado'nun **Tcl Console**'unda iki adım:

**1.** Önce **kendi dosya yoluna göre** `main_files` klasörüne gir:
```tcl
cd /home/stradale/Documents/main_files/
```

**2.** İhtiyacına uygun scriptin yolunu(path) kopyalayıp `source` ile çalıştır:
```tcl
source /home/stradale/Documents/main_files/scripts/project_gen/Interconnect/create_Interconnect.tcl
```

Bu kadar — proje otomatik oluşur.

> Yol (`/home/stradale/Documents/...`) sana göre değişir; repoyu nereye
> kopyaladıysan o yolu kullan.

---

## Hangi script neyi oluşturur?

Scriptlerin tamamı `scripts/project_gen/` altındadır; aşağıdaki yollar o
klasöre görelidir. Projeler `main_files/Vivado_projects/` altına, hedef kart
**Nexys A7** (`xc7a100tcsg324-1`) olarak oluşturulur.

| Script | Oluşturduğu proje | Gereken firmware hedefi |
|---|---|---|
| `Main_MCU_Project.tcl` | **Tüm sistem** (bütün tasarım kodlarını içeren ana projeyi oluşturur.) | `make all` (`boot.hex`) |
| `System_test/boot_test.tcl` | Sistemin boot işlemi ve flash belleğe yazma testi | `make sim_boot` (`sim_boot.hex`) |
| `System_test/ai_accel_test.tcl` | Sistemin yapay zeka hızlandırıcısını test eder. | `make sim_app` (`sim_app.hex`) |
| `System_test/only_app_test.tcl` | Sistemin boot mekanizmasını atlayıp doğrudan `uygulama(app)` kodlarını çalıştırır. | `make app_bootrom` (`app_bootrom.hex`) |
| `System_test/yz_bench_test.tcl` | Hızlandırıcı ile CPU'da koşan TFLite yazılım gerçeklemesinin hız/doğruluk kıyası | `make sim_bench` (sim) + `make bench` (kart) |
| `CPU/create_CPU.tcl` | CV32E40P çekirdeği | — |
| `Interconnect/create_Interconnect.tcl` | AXI4 ara bağlantı | — |
| `Interconnect/create_Instruction_Splitter.tcl` | Komut (instruction) ayırıcı | — |
| `Memory/create_Boot_ROM.tcl` | Boot ROM | — |
| `Memory/create_Data_RAM.tcl` | Data RAM | — |
| `Memory/create_Instruction_RAM.tcl` | Instruction RAM | — |
| `Peripherals/create_GPIO.tcl` | GPIO | — |
| `Peripherals/create_Timer.tcl` | Timer | — |
| `Peripherals/create_UART_GU.tcl` | UART (genel kullanım) | — |
| `Peripherals/create_UART_YZ.tcl` | UART (YZ akışı) | — |
| `Peripherals/create_I2C.tcl` | I2C Master | — |
| `Peripherals/create_QSPI.tcl` | QSPI Master | — |

> Sistem testleri firmware hex'lerini `firmware/makefile_outputs/` altından
> okur; scripti çalıştırmadan önce ilgili `make` hedefini koşturun.

---

# scripts/yz_tflite + scripts/yz_accuracy — YZ Doğrulama Zinciri

Şartnamenin iki YZ maddesinin kanıtını üreten iki klasör. İkisinin de kendi
ayrıntılı README'si var; burada **hangisi ne işe yarıyor ve sırayla nasıl
kullanılır** anlatılır.

- **Hızlanma:** *"YZ hızlandırıcısı … RISC-V çekirdeği üzerinde çalışan yazılım
  gerçeklemesine kıyasla hızlanma elde etmelidir."*
- **Doğruluk:** *"… yazılım ile gerçeklenen modelin doğruluğunu %10'luk bir
  pencere dahilinde yakalamalıdır."*

İkisinin de kıyas noktası **aynı** yazılım gerçeklemesidir: modelin kendisinden
(`micro_speech_quantized.tflite`) çıkarılmış, TFLite Micro reference kernel'lerine
sadık bir C kodu (`firmware/yz_model/tflite_ref.c`).

---

## Hangi klasör ne yapar?

| Klasör | Ne işe yarar |
|---|---|
| `yz_tflite/` | Modeli `.tflite`'tan **çıkarır** (ağırlık, bias, kuantizasyon sabitleri), RTL'dekilerle çapraz doğrular ve iverilog ile hızlı RTL↔C karşılaştırması yapar. Kart/Vivado gerekmez. |
| `yz_accuracy/` | Etiketli ses kümesini **karta gönderir**, hızlandırıcı ile yazılımın doğruluk oranlarını kıyaslar, %10 penceresi kararını ve karışıklık matrislerini basar. |

---

## Sırayla nasıl kullanılır?

```bash
# 1) Modeli .tflite'tan üret + beş çapraz kontrolü koştur
cd scripts/yz_tflite && make data && make
#    -> firmware/yz_model/tflite_model_data.h  +  ./ref_run

# 2) Hızlı ön kontrol: RTL ile C aynı sınıfı veriyor mu? (iverilog, ~15 sn)
python3 compare_rtl.py

# 3) HIZLANMA — Vivado simülasyonu
cd ../../firmware && make sim_bench
#    Vivado Tcl: source scripts/project_gen/System_test/yz_bench_test.tcl

# 4) DOĞRULUK — kart (SW1=1, SW0=0)
make bench          # + aynı TCL ile sentez, bitstream, program device
python3 ../scripts/yz_accuracy/run_accuracy.py --dataset dataset --board
```

Adım 1 ve 2 birkaç saniye sürer ve hiçbir donanım istemez; bir şey bozulduysa
önce onlar konuşur. Adım 3 ~12 dakikalık bir simülasyondur.

> **Adım 1 ne zaman tekrar koşturulmalı:** `weights.hex` / `fc_weights.hex` ya da
> `conv_accelerator.v`'deki `M0_FLAT` / `SHR_FLAT` değişirse. `make check-data`
> tutarsızlığı yakalar; yoksa yazılım referansı sessizce eski modele bakar.

Ayrıntı için: [`yz_tflite/README.md`](yz_tflite/README.md) ve
[`yz_accuracy/README.md`](yz_accuracy/README.md).
