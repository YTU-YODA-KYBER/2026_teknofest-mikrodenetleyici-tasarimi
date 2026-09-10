# ASIC akışı — devir teslim notu

> Bu bir **çalışma notudur**, teslim dokümanı değildir. Yeni bir oturumun
> sıfırdan aynı yolları tekrar denemesini önlemek için yazıldı.
> Teslim öncesi silinebilir.

**Hedef sırası (kullanıcı tarafından belirlendi):**
1. İhlalleri 0'a indirip fabrikaya üretime hazır çıktı üretmek
2. Sonra frekansı artırmak
3. Sonra alanı küçültmek

**Kısıt:** `FPGA/` klasöründeki kodlar değiştirilmeyecek. ASIC'e özgü RTL
değişiklikleri `asic_rtl/` altında, `scripts/patch_rtl.py` yama zinciriyle
yapılır (kaynak dosyalar metin ikamesiyle türetilir, orijinaline dokunulmaz).

---

## 1. Mevcut durum — doğrulanmış sayılar

Kaynak: `asic/reports/general/metrics.json` (teslim koşumu).

### Sıfır olanlar

| Kalem | Değer |
|---|---:|
| Routing DRC (OpenROAD) | 0 |
| Magic DRC | 0 |
| KLayout DRC | 0 |
| Netgen LVS (hata / cihaz / net / property) | 0 / 0 / 0 / 0 |
| Magic ↔ KLayout XOR | 0 |
| PDN ihlali (VPWR / VGND) | 0 / 0 |
| Yasa dışı örtüşme (`design__violations`) | 0 |
| Setup ihlalli uç — 9 köşe | 0 |
| Hold ihlalli uç — 9 köşe | 0 |
| Setup TNS / Hold TNS | 0 / 0 |
| max_fanout ihlali | 0 |
| Kritik bağlanmamış pin | 0 |

### Sıfır OLMAYANLAR — çözülecek liste

| Kalem | Değer | En kötü köşe |
|---|---:|---|
| **Anten — net** | **979** | — |
| **Anten — pin** | **1.034** | — |
| **max_slew ihlali** | **845** | `max_ss_100C_1v60` |
| **max_cap ihlali** | **22** | `max_*` köşeleri |
| **Bağlanmamış pin (kritik olmayan)** | **480** | — |

max_slew köşe dağılımı önemli: `max_ss_100C_1v60` **845**, `nom_ss` 428,
diğer yedi köşe **332–361** arasında. Yani ihlallerin yarısı yalnız en yavaş
köşede ortaya çıkıyor.

### Zamanlama ve alan

| Kalem | Değer |
|---|---:|
| Saat periyodu | 35,714 ns (**28 MHz**) |
| Setup WS (en kötü köşe `max_ss_100C_1v60`) | **+1,996 ns** |
| Setup WS (`nom_ss`) | +2,072 ns |
| Hold WS (en kötü `max_ff_n40C_1v95`) | **+0,390 ns** |
| Saat skew (setup / hold, en kötü) | +1,166 / −1,278 ns |
| Die alanı | 15,12 mm² (4200 × 3600 µm) |
| Çekirdek alanı | 14,98 mm² |
| Instance doluluk | 0,390 |
| **Std-cell doluluk** | **0,154** |
| Std-cell adedi | 282.317 |
| Fill cell | 1.060.558 |
| Timing-repair buffer | **65.850** (0,657 mm²) |
| Saat tamponu / inverter | 930 / 283 |
| Setup / hold buffer | 178 / 350 |
| Makro alanı | 4,17 mm² (15 SRAM) |

---

## 2. Kalan ihlaller — bilinenler ve seçenekler

### 2.1 Anten (979 net / 1.034 pin)

**Kök neden (ölçülmüş):** Makro LEF'i met3'ü ~%96 kapatıyor; tasarım doluluğu
düşük (%15,4 std-cell) olduğu için teller uzun. İkisi birlikte uzun kesintisiz
metal koşuları üretiyor.

**Akıştaki asıl bulgu — üç fazlı koşumun sebebi:**
LibreLane Classic'in adım sırası sabit
(`GlobalRouting → CheckAntennas → RepairAntennas → ResizerTimingPostGRT → DetailedRouting`).
`RepairAntennas` jumper'ları **yönlendirme rehberi (guide)** olarak ekler.
Hemen sonraki `ResizerTimingPostGRT`, `rsz_timing_postgrt.tcl:26-31`'de
**koşulsuz** bir `global_route` çalıştırır (OpenROAD #5590 nedeniyle `if`
yorum satırına alınmış). `GlobalRouter::saveGuides` her netin rehberini
`clearGuides()` ile silip yeniden yazar. Jumper netlist hücresi değil, yalnızca
guide geometrisi olduğu için **%100'ü yok olur**.

ODB denetimiyle ölçüldü: **1.661 guide → 0 guide**, geriye 1.422 sahipsiz
"onarıldı" bayrağı kalıyor.

Çözüm: jumper'ı resizer'ın **çıktısı** üzerine ekleyip DRT'yi tek kez koşmak
(`experiments/antenna_jumper.yaml`, faz 3). Ölçülen kazanç: **1.935 → 1.474 net**
(o koşumda); güncel teslimde 979/1.034.

**Denenmiş ve ELENMİŞ olanlar — tekrar etme:**

| Deneme | Sonuç |
|---|---|
| `antenna_jumper_i2` (iterasyon 1 → 2) | İkinci tur 0 jumper / 0 net, ODB bit-özdeş — **no-op** |
| `antenna_jumper_margin20` (marj %5 → %20) | 1.100 ek jumper'a rağmen 955/1.013 → **966/1.017 kötüleşti** |
| `antenna_drt_i1_m10` (yalnız diyot, DRT turu) | İkinci turun iter-0 değeri 199.573; 40 dakikada yakınsama metriği çıkmadı — **kontrollü durduruldu** |
| `grt_drt_validated_antenna` (GRT anten zinciri açık) | DRT iter-0 89.218 → 186.694, iniş −%53 → −%17 — **yakınsamadı** |
| `met5_macro_obstructions` (met5'i sinyale aç) | Aşım 94.692; met5 talebin %1,4'ünü taşırken DRC'nin ~%67'sini üretiyor |

**Temel takas (config.yaml:625-641'de belgelenmiş):** anten onarımı tam açıkken
ihlaller 3.676 net / 5.489 pin → **22 net / 30 pin**'e iniyordu, ama DRT
yakınsamıyor ve 24 routing DRC kalıyordu. Kapalıyken anten yüksek, DRC 0.
"Kullanılamayan bir GDS" yerine "ölçülüp raporlanan anten ihlali" seçildi.

**Denenmemiş fikirler (hipotez — maliyet/kazanç tahmini):**

1. **Dördüncü faz: yollanmış tasarım üzerinde ikinci jumper turu.**
   `antenna_jumper_i2` aynı adım içinde no-op çıktı çünkü resizer silmesinden
   *önce* koşuyor. Faz 3'ün **çıktısı** üzerinde yeni bir
   `CheckAntennas → RepairAntennas → DetailedRouting` turu bambaşka bir
   durumdur ve **ölçülmedi**. En umut verici yol bu; maliyeti bir DRT turu
   (~4 saat).
2. **`DIODE_ON_PORTS`** — config.yaml:637 bunu "denenmemiş ara yol" diye
   işaretliyor **ama aynı yerde kazancının küçük olduğunu da söylüyor**:
   yalnız 36 port netini düzeltir. Düşük öncelik.
3. **Doluluk artırmak.** Std-cell doluluğu %15,4; die'ı küçültmek telleri
   kısaltır. Ancak 3400×2900 denemesi 14 DRC ve 16.108 GRT aşımı verdi
   (makro halkası 4200×3600'de 0/0). Die küçültme yalnız makro yerleşimi
   yeniden tasarlanarak denenebilir.
4. **Sentezde fanout/uzunluk sınırı.** `MAX_FANOUT_CONSTRAINT: 25` var; net
   uzunluğu bazlı bir tampon ekleme kısıtı (`MAX_WIRE_LENGTH` benzeri)
   sentez/placement seviyesinde uzun netleri baştan kırabilir. Ölçülmedi.

### 2.2 max_slew (845) ve max_cap (22)

**Bilinen:** ihlallerin **328'i** SRAM makrolarının kendi Liberty'sindeki
**0,04 ns** max_transition sınırından geliyor. Bu değer hiçbir gerçek
yollanmış netle tutturulamaz — foundry DRC kuralı değil, zamanlama kalitesi
hedefidir.

Geriye kalan (~517, en kötü köşede) gerçek onarılabilir ihlallerdir.

**Elde hazır bekleyen çözüm:**
`experiments/postgrt_design_repair_zero_margin.yaml` — GRT tahmininde
**1.882 slew + 730 cap ihlalini 809 yeniden boyutlandırma ve 339 tamponla
sıfırladı**. İkinci GRT taşması 15.414 → 13.221, tel 15,188 M → 15,017 M µm.
Notu: *"RCX sonrası doğrulama tamamlanmadan ana config'e alınmaz."*

**Yani bu overlay ölçülmüş ve olumlu, sadece tam signoff doğrulaması
yapılmamış.** İhlalleri sıfıra indirme hedefinde ilk denenecek şey budur.

Yanında ölçülmüş ikinci parça:
`postgrt_timing_repair_hold20.yaml` (hold marjı 50 → 20 ps) tek başına hold
uçlarını 2.672 → 1.147 indirdi ama TrDRC 14 → 44 ve setup uçları ~2.446 → 2.560
oldu. Tek başına aday değil; **tasarım onarımıyla birleşimi ölçülmekteydi,
sonuçlanmadı.**

> Uyarı: max_slew/max_cap eşiklerini gevşetmek sayıyı düşürür ama **ölçüt
> değişikliği** olur. Önceki oturumlarda bilerek yapılmadı. Aynı çizgide
> kalınması önerilir.

### 2.3 Bağlanmamış pin (480, kritik 0)

Kritik olanı yok, yani fonksiyonel risk taşımıyor. Ne oldukları
**doğrulanmadı** — büyük ihtimalle kullanılmayan makro pinleri ve tie-off'lar.
Yapılacak: listeyi çıkarıp her birinin zararsız olduğunu belgelemek. Gerçekten
sıfıra indirmek isteniyorsa kullanılmayan makro girişlerine açık tie hücresi
bağlanabilir; çıkışlar zaten bağlanmak zorunda değildir.

---

## 3. Frekans — nerede durduğumuz

**Şu an: 28 MHz, setup payı +1,996 ns.**

Matematik: 35,714 − 1,996 = **33,72 ns → 29,66 MHz**. Yani teorik tavan
30 MHz'in hemen altında.

**30 MHz iki kez tam koşumla denendi ve ikisinde de düştü**
(`reports/synthesis/deney_arsivi/final30/`). Koşumdan koşuma dağılım **~2,4 ns**
ölçüldü; 30 MHz'in payı bu dağılımın altında kalıyor. Bu yüzden 28 MHz seçildi.

### Frekans duvarı ve NEDEN artık o duvar değil

Eski kök neden: SKY130 SRAM Liberty'si `dout` yayınını **`falling_edge`**
tanımlar. Adres t=0'da örneklenirse veri t=T/2'de geçerli olur ve bir sonraki
yükselen kenarda yakalanır → yakalama penceresi **T/2**. O pencerenin içinde
8×8 işaretli çarpma vardı.

**Bu çözüldü.** `sramreg` yaması (`patch_rtl.py` zincirinde, `conv_accelerator_asic.v`
içinde `rd_q` / `wd_q` / `v_s2d`) çarpmayı bir çevrim ileri aldı:

```verilog
if (v_s2)  begin rd_q <= ram_rdata; wd_q <= w_dout; end   // T/2: sadece tel
if (v_s2d) prod[ci] <= (rd_q - INPUT_ZP) * wd_q[8*ci +: 8]; // TAM cevrim
if (v_s3)  acc[ci]  <= acc[ci] + prod[ci];
```

Aynı kademe FC yoluna da uygulandı (`conv_buf_ram` de aynı SRAM makrosu).
Maliyet 112 flip-flop, çevrim 46.018 → 46.519 (%1,09).
Ölçülen kazanç 50 ns'de: setup WS **+3,62 → +10,77 ns**.

Fonksiyonel doğrulama: 5/5 regresyon geçti (`yz`, `collision`,
`instr_collision`, `mem`, `boot`).

> Bir dönem `max_fanout` 0 → 2 olduğu için reddedilmişti; `CTS_MAX_CAP: 0.2`
> eklenerek çözüldü ve benimsendi. **Güncel teslimde max_fanout = 0.**

### Sıradaki adım için gerekli bilgi

Kritik yolun **şu anda nerede** olduğu bu notu yazarken doğrulanmadı.
Yeni oturumun ilk işi bu olmalı:

```bash
grep -A40 "Startpoint" asic/reports/timing/max_ss_100C_1v60/*.rpt | head -60
```

SRAM yarım-çevrim duvarı kalktığına göre kritik yol büyük olasılıkla başka bir
yere taşındı (eski baseline'da CPU decoder'ıydı). Oraya bakılmadan periyot
denemesi yapmak boşa koşum olur.

**Ölçülmüş periyot taraması (eski rota/parazitikler üzerinde, tanı amaçlı):**

| Periyot | Setup WS (`max_ss`) | Not |
|---:|---:|---|
| 40 ns | −22,738 ns, 1.936 uç | kapanmıyor (eski rota) |
| 46 ns | +0,727 ns, 0 uç | |
| 64 ns | +1,262 ns, 0 uç | |
| 66 ns | +3,262 ns, 0 uç | |
| 70 ns | +7,262 ns, 0 uç | |

Bu tablo **makro halkası ve sramreg öncesi** rotaya aittir; güncel tasarım için
yeniden ölçülmelidir. Yöntem `scripts/calibrate_clock.py`'de.

---

## 4. Fiziksel tasarımda kesinleşmiş kararlar (değiştirme, ölçüldü)

| Karar | Değer | Gerekçe (ölçüm) |
|---|---|---|
| Makro yerleşimi | 4200×3600 halka, hepsi `N` | Eski 3400×2900 ızgara: 14 DRC, 16.108 GRT aşımı. Halka: 0 / 0 |
| `RT_MAX_LAYER` | met4 | met5'e çıkmak via4 makrolar üzerinde kapalı olduğu için erişilemez; aşım 94.692 |
| `GRT_ADJUSTMENT` | 0,10 | 0,30 → 0,10: toplam aşım 192.800 → 5.114, tel 18,60 → 13,89 m |
| met3 kaynak cezası | %9 (`grt_layer_met3_009.yaml`, faz 2/3) | %10 post-GRT'de 15 aşımla durdu; %9 iki GRT'yi 0/0 geçti |
| `PL_MAX_PHI_COEFFICIENT` | 1,02 | Iraksayan GPL'in çözümü: HPWL 1,8e8 → 5,8e6 |
| `CTS_CLK_MAX_WIRE_LENGTH` | 600 µm | Aracın önerdiği 2936 µm; 600'e çekmek 3,3× anten aşımını ve 2,3 ns slew'i birlikte kapattı |
| `CTS_SINK_CLUSTERING_SIZE` | 20 | 10 ve 5 denendi: saat tamponu 1.251 → 2.899 / 5.940, hold bozuldu |
| `CTS_MAX_CAP` | 0,2 pF | sramreg'in ürettiği 2 fanout ihlalini kapattı |
| Anten onarımı ana config'te | **kapalı** | Açıkken DRT yakınsamıyor; jumper yalnız faz 3'te |
| Doluluk hedefi | %35 | %50: araç kendi tıkanıklık çözücüsüyle %217 şişiriyor |

**Altın kural (experiments/README.md'de büyük harfle yazılı):**
> Bir GRT ayarı, **detaylı yollamadan geçtiği ölçülmeden** ana config'e alınmaz.
> GRT aşımı metriği yanıltıcıdır: `adj 0.05 + keep-out + i50` aşımı 39'a
> indirdi ama **DRT yakınsamadı**; `adj 0.10` aşımı 15.218 bıraktı ama DRT
> 24 ihlalle **bitti**.

---

## 5. DDK'nın resmî cevapları ve bunların bize açtığı kapılar

Yarışmayı düzenleyen ekip 8 Eylül 2026'da beş takımın sorusunu cevapladı.
Bunlar bağlayıcı yorumlardır; aşağıda özet ve **bizim için sonucu** var.

### 5.1 Kritik yol iyileştirme ve frekansın nasıl değerlendirileceği

Soruyu soran takımın kritik yollarının %97'si CV32E40P ALU'sunda toplanmış;
RTL'e dokunmadan ne yapılabileceğini ve frekansın nasıl puanlanacağını sormuş.

**DDK'nın saydığı meşru yöntemler:** sentez ve yerleştirmede timing-driven
optimizasyon, kritik yol hücrelerini boyutlandırma ve tampon ekleme, yüksek
fanout'lu kontrol sinyallerinin fiziksel optimizasyonu, floorplan / placement
density / congestion iyileştirme, kritik hücre ve register grupları arasındaki
fiziksel mesafeyi azaltma, CTS ve post-CTS timing optimizasyonu, yollama
sonrası parazitik gecikmesi yüksek netleri inceleme.

> **YASAK:** *"Gerçek senkron zamanlama yollarının yalnızca timing sonucunu
> iyileştirmek amacıyla false path veya multicycle path olarak tanımlanması
> uygun değildir."*
>
> Bu, SRAM yarım-çevrim yolunu `set_multicycle_path` ile geçiştirme fikrini
> **kapatır**. Zaten `sramreg` boru hattı kademesiyle doğru şekilde çözüldü.

**Frekansın tanımı — bizim 28 MHz duruşumuzu doğruluyor:**

* Doğrulanmış çalışma frekansı = **zorunlu signoff corner'larında setup VE
  hold'un kapandığı**, parazitik çıkarım sonrası Post-PnR STA ile gösterilen
  frekans.
* Negatif setup slack'li bir frekans **yalnızca hedeflenen frekanstır**,
  doğrulanmış sayılmaz.
* Zorunlu corner'lara ek corner'lar destekleyici bilgi olarak sunulabilir.
* *"DRC, LVS, anten, zamanlama ve diğer signoff sonuçları değerlendirmede
  birlikte dikkate alınır. Bu kontrollerden birinde ihlal bulunması tasarımı
  otomatik olarak geçersiz hâle getirmez; ancak ilgili değerlendirme kalemini
  ve genel tasarım kalitesi değerlendirmesini etkileyebilir."*
* Yüksek frekans hedefleyip zamanlaması kapanmayan tasarım ile düşük frekansta
  tamamen temiz tasarım karşılaştırılırken **yalnızca SDC frekansına
  bakılmayacak**.

**Sonuç:** 30 MHz'i zorlayıp signoff'u bozmak yerine 28 MHz'de temiz kalmak
puanlama açısından doğru tercih. Anten ihlalimiz teslimi geçersiz kılmıyor ama
"genel tasarım kalitesi" kalemini etkiliyor — bu yüzden ihlal düşürme
önceliği yerinde.

### 5.2 SRAM blackbox ve GDS tabanlı DRC

* Signoff DRC **GDS tabanlı** olmalı; LEF+DEF üzerinden alınan sonuç yalnızca
  destekleyici analiz sayılır.
* **SRAM makrosu takım tarafından üretilmişse** (ör. OpenRAM), makronun kendi
  DRC ve LVS sonuçları **ayrıca sunulmalıdır**. Top-level'da blackbox yapmak
  bunun yerine geçmez.
* Blackbox yalnızca makro iç geometrisinin top-level'da tekrar
  değerlendirilmesini engellemek için kullanılabilir; gerçek top-level DRC
  ihlallerini veya makro-çevre entegrasyon problemlerini gizlemek için
  kullanılamaz.
* DRC kural dosyaları, PDK ve kontrol eşikleri değiştirilmemeli; kullanılan
  yöntem README'de açıkça belirtilmeli.

**Bizim için:** SRAM'leri biz üretmedik, PDK'nın hazır ve onaylanmış
makrolarını kullanıyoruz. Dolayısıyla **makro seviyesinde ayrı DRC/LVS sunma
yükümlülüğümüz yok**; makrolar nihai GDSII'nin içinde mevcut. Bu cevap mevcut
yaklaşımımızı doğruluyor, bir aksiyon gerektirmiyor.

### 5.3 Magic DRC'nin bellek yetersizliğinden tamamlanamaması

* Bellek yetersizliği **tasarım kaynaklı DRC ihlali sayılmaz**.
* Ancak Magic DRC tamamlanmazsa **o signoff sonucu üretilmiş sayılmaz**.
* XOR = 0 olması Magic DRC'nin yerine **geçmez**; Magic DRC ve KLayout DRC
  ayrı signoff çıktılarıdır.
* Fiziksel tasarımı değiştirmeye gerek yok: **aynı nihai GDSII ile Magic DRC
  adımı daha yüksek bellekli başka bir ortamda yeniden koşulabilir.** Aynı
  LibreLane sürümü, aynı PDK, aynı stdcell kütüphanesi, aynı tasarım girdileri
  ve config, aynı GDSII, aynı DRC kural seti kullanılmalıdır.
* *"Yalnızca işlemin çalıştırıldığı bilgisayarın veya kullanılabilir RAM
  miktarının değiştirilmesi tasarım veya signoff metodolojisi değişikliği
  olarak değerlendirilmez."*
* PDK/kural dosyası değiştirmek, kontrol seviyesini azaltmak, kural devre dışı
  bırakmak veya Magic DRC adımını kaldırmak **uygun değil**. Standart dışı ya
  da hiyerarşik DRC için **önceden DDK onayı** gerekir.

**Bizim için:** Magic DRC adımımız ~14 GiB tepe bellek kullanıyor ve bir kez
bu yüzden koşum kesilmişti. Bu cevap, o adımı yalıtılmış/temiz bir ortamda
yeniden üretmenin meşru olduğunu teyit ediyor — nitekim öyle yapıldı ve Magic
DRC 0 ile kapandı. Yeni koşumlarda aynı sorun çıkarsa **çözüm bellektir,
config değil.**

### 5.4 ve 5.5 — POST-ROUTE ECO ADIMI SERBEST (en önemli yeni bilgi)

İki ayrı takım, Classic akışa yollama sonrası özel bir zamanlama düzeltme
adımı eklemeyi sordu; DDK **ikisini de uygun buldu**.

**Soru 4 — `repair_timing -hold` + ECO yeniden yollama:**
> *"Detailed Routing ve ilk parasitik çıkarım sonrasında, çıkarılmış
> parazitikler üzerinden `repair_timing -hold` ile hold iyileştirmesi yapılması
> ve eklenen hücre/netler için ECO yeniden yönlendirme uygulanması, zorunlu
> akış adımlarını kaldırmaması veya değiştirmemesi koşuluyla kullanılabilir."*

**Soru 5 — OpenROAD Tcl betiğiyle özel hold düzeltme adımı:** aynı şekilde
uygun bulundu.

**Ortak koşullar (ikisinde de tekrarlanıyor):**

1. Adım **otomatik ve yeniden üretilebilir** olmalı; DEF/GDSII elle
   düzenlenmemeli.
2. Yalnızca yarışmada izin verilen standart hücre kütüphanesinin hücreleri
   kullanılmalı.
3. PDK, stdcell kütüphanesi, SRAM modelleri, zamanlama kısıtları ve kontrol
   eşikleri değiştirilmemeli.
4. Hiçbir zorunlu akış veya signoff adımı devre dışı bırakılmamalı.
5. Adımdan sonra fiziksel tasarım değiştiği için **parasitik çıkarım yeniden**
   yapılmalı; nihai setup/hold STA yeni parazitikler üzerinden üretilmeli.
6. DRC, LVS, anten ve diğer fiziksel signoff kontrolleri **ECO sonrası nihai
   tasarım üzerinde** yeniden koşulmalı.
7. Adımın amacı, akıştaki konumu, kullanılan Tcl betiği ve yapılandırmalar
   **`asic/README.md` içinde açıkça belirtilmeli**; betik teslim edilen
   yeniden çalıştırılabilir akışın parçası olmalı.

> **Bu bizim için şu ana kadar hiç kullanılmamış bir kaldıraçtır.**
>
> Şimdiye kadarki bütün onarım denemeleri **post-GRT** aşamasındaydı, yani
> global routing'in *tahmini* RC değerleri üzerinde. `experiments/README.md`
> defalarca "GRT metriği yanıltıcıdır" diyor — post-route ECO ise **gerçek
> çıkarılmış parazitikler** üzerinde çalışır.
>
> Kalan ihlallerimiz (max_slew 845, max_cap 22) tam olarak bu tür onarımın
> hedefidir: `repair_design` slew/cap ihlallerini hücre boyutlandırma ve
> tamponla kapatır. Anten tarafında da ECO yeniden yollama, faz-3 sonrası
> ikinci bir jumper turuna meşru bir çerçeve sağlar.
>
> Maliyet: ECO sonrası RCX + STA + bütün fiziksel signoff yeniden koşulmalı
> (koşum başına saatler). Kazanç potansiyeli en yüksek yol budur.

---

## 6. Bu oturumda yapılan değişiklikler

FPGA tarafında gerçek bir hata bulunup düzeltildi (commit `800fb7a`):
Interconnect `0x1000_0000` (Instruction RAM) read adreslerini M8'e decode
ediyordu ama M8'in AR/R portları `Top_module.sv`'de bağlı değildi. O bölgeden
CPU load yapılınca ARREADY hiç gelmiyor, decoder kapsadığı için DECERR de
üretilmiyordu → sessiz kilitlenme.

Düzeltme: iki-master AXI read arbiter (`axi_read_arbiter2`) ile instruction
fetch ve data read tek Instruction RAM read denetleyicisine bağlandı.

**ASIC açısından önemli:** bu düzeltme zaten `patch_rtl.py` içinde ASIC'e özel
yama olarak vardı. Temel RTL'e taşındı, ASIC'teki kopya ve ilgili dört yama
kaldırıldı. Yeniden üretilen `Top_module_asic.sv`'nin **RTL gövdesi değişmedi**
(yalnız başlık yorumu). Doğrulandı: `git diff` yalnızca yorum satırları.

→ **Mevcut ASIC sonuçları geçerlidir, yeniden koşum gerekmez.** Ama yeni bir
koşum yapılacaksa önce `make prepare` (veya `python3 scripts/patch_rtl.py` +
`gen_filelist.py`) çalıştırılmalı; `asic/filelist.f` ve `asic/config.yaml`
arbiter'ın yeni yolunu gösterecek şekilde güncellendi.

### Teslim paketi temizliği (commit `85f62c3`)

Şartname Bölüm 5.5 Tablo 13 corner başına istenen rapor kümesini tanımlıyor.
Bu kümede olmayan ve pakete ağırlıktan başka bir şey katmayan dosyalar
çıkarıldı:

| Çıkarılan | Boyut | Gerekçe |
|---|---:|---|
| `reports/timing/<corner>/sta.log` × 9 | 667 MB | OpenSTA ham konsol günlüğü; Tablo 9'da da Tablo 13'te de yok |
| `reports/timing/<corner>/*.sdf` × 9 | 495 MB | `results/sdf/` altındakilerle **MD5 birebir aynı**; şartnamenin belirttiği konum orası |
| `*.process_stats.json`, `_env_*.tcl`, `filter_unannotated*` × 45 | 1 MB | araç telemetrisi |

Tablo 13'ün tamamı (`max`, `min`, `checks`, `skew.max/min`, `ws.max/min`,
`wns.max/min`, `tns.max/min`, `violator_list`, `clock`, `unpropagated`) dokuz
corner için yerinde. `reports/timing` 1,8 GB → 668 MB.

**Bir eksik bulundu ve giderildi:** Tablo 9 `versions.txt`'yi genel akış
raporları arasında listeliyor, Tablo 8 ise `asic/environment/` altında.
Bizde yalnız ikincisi vardı. `scripts/gen_versions.py` artık **her iki
konuma da** yazıyor.

`checksums/SHA256SUMS` güncel dosya kümesine göre yeniden üretildi
(1442 → 1380 satır). **`make asic_verify` → PAKET KAPISI GEÇTİ.**

> Uyarı: `asic_verify` yalnızca dosyaların varlığını değil, `SHA256SUMS` ile
> tutarlılığı da denetler. Pakete dosya ekler veya çıkarırsan **`make checksums`
> çalıştırmayı unutma**, yoksa kapı "provenance hatası" verir.

### Disk / LFS durumu

`.git/lfs/objects` önbelleği silindi (3,8 GB kazanç; repo 8,2 GB → 4,4 GB).
İçeriği çalışma ağacındaki dosyaların ikinci kopyasıydı, hepsi GitHub'da
mevcut. Başka bir commit'e geçmek veya bir dosyayı yeniden oluşturmak
gerekirse:

```bash
git lfs pull
```

---

## 7. Pratik notlar

**Koşum:**
```bash
cd asic
make prepare      # vendor + firmware + roms + filelist + keepout
make asic_run     # üç fazlı akış
make asic_verify  # teslim dosyalarının varlık denetimi
```

Tek adım / overlay denemesi:
```bash
python3 scripts/run_flow.py \
    --config config.yaml --config experiments/<overlay>.yaml \
    --tag <etiket> --overwrite \
    --initial-state run/<kaynak>/<adım>/state_out.json \
    --from <AdımID> --to <AdımID>
```

**Tuzaklar:**

- **Tek DRT turu ~4 saat.** Anten deneyleri pahalıdır, plan yaparak koş.
- **Magic DRC adımı ~14 GiB tepe bellek** kullanıyor. Bellek baskısı altında
  görev yöneticisi koşumu öldürebilir; `setsid nohup` ile ayrılmış koşmak
  gerekebilir. Ama dikkat: koşumu bölüp devam ettirmek **provenance kapısını
  bozar** (`Starting sayısı=4, beklenen 3`). Temiz tam koşum tercih edilmeli.
- **Disk:** `/home` şu an ~10 GB boş. Vivado projesi ve LFS geçmişi hızla
  doldurabiliyor; koşum öncesi `df -h` kontrol et.
- `diagnostic_continue.yaml` bütün `ERROR_ON_*` kapılarını gevşetir —
  **yalnız tanı için**, teslim koşumunda asla.
- Deney arşivi `reports/synthesis/deney_arsivi/` altında 100+ etiket var;
  yeni bir fikir denemeden önce **oraya ve `experiments/README.md`'ye bak**.
  Önceki oturumlarda tekrar önerilen birkaç fikir orada zaten çürütülmüş
  olarak bulundu.

---

## 8. Önerilen sıra

0. **Kritik yolu tespit et** (`reports/timing/max_ss_100C_1v60/max.rpt`).
   SRAM yarım-çevrim duvarı `sramreg` ile kalktı, kritik yol taşınmış olmalı.
   Bu bilgi olmadan frekans denemesi boşa koşumdur. 10 dakikalık iş.
1. **POST-ROUTE ECO adımını kur** (bkz. §5.4). DDK açıkça izin verdi ve bu
   şimdiye kadar hiç kullanılmadı. Bütün onarım denemelerimiz post-GRT'de,
   yani *tahmini* RC üzerindeydi; ECO gerçek çıkarılmış parazitikler üzerinde
   çalışır. `repair_design` ile slew/cap, `repair_timing -hold` ile hold
   hedeflenir. §5.4'teki yedi koşula birebir uy — özellikle ECO sonrası RCX +
   STA + bütün fiziksel signoff'un yeniden koşulması ve adımın README'de
   belgelenmesi.
2. **max_slew / max_cap:** ECO yetmezse
   `postgrt_design_repair_zero_margin.yaml`'ı tam signoff'a kadar götür.
   Ölçülmüş ve olumlu (1.882 slew + 730 cap → 0), sadece RCX sonrası
   doğrulaması eksik.
3. **Anten:** faz 3'ün çıktısı üzerinde **dördüncü faz** olarak ikinci bir
   `CheckAntennas → RepairAntennas → DetailedRouting` turu ölç. Aynı adım
   içindeki iterasyon no-op çıkmıştı; ayrı faz denenmedi.
4. **Bağlanmamış 480 pini** listele ve zararsızlıklarını belgele (veya tie
   hücresiyle kapat).
5. 1–4 sonrasında **periyot taramasını güncel rota üzerinde tekrarla**;
   29 MHz'i (34,5 ns) önce tanı olarak ölç, sonra tam koşum.
6. Alan: std-cell doluluğu %15,4 ve timing-repair buffer std-cell alanının
   büyük kısmı. Adım 2 tamponları azaltırsa alan da kendiliğinden düşer;
   ayrı bir alan çalışmasına ondan sonra bakılmalı.
