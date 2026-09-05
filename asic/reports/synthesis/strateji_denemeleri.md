# Sentez ayarı denemeleri — STAPrePNR karşılaştırması

20 ns (50 MHz) kısıtıyla, yerleştirme öncesi statik zamanlama analizi.
Amaç: LibreLane'in varsayılan sentez ayarlarından daha iyi bir kombinasyon var mı?

| Konfigürasyon | Std hücre alanı (µm²) | WNS tt | WNS ss | TNS ss |
|---|---:|---:|---:|---:|
| **AREA 0 + Yosys toplayıcı (varsayılan, seçilen)** | 768,485 | -16.22 ns | -27.47 ns | -11,493 ns |
| DELAY 0 | 874,177 | -55.49 ns | -57.37 ns | -11,784 ns |
| DELAY 1 | 856,040 | -37.42 ns | -44.62 ns | -11,603 ns |
| AREA 0 + carry-select toplayıcı | 928,699 | -15.31 ns | -30.25 ns | -34,903 ns |
| AREA 0 + ripple-carry toplayıcı | 909,412 | -17.01 ns | -40.68 ns | -76,623 ns |

**Sonuç:** LibreLane'in varsayılanı (`SYNTH_STRATEGY: "AREA 0"`, `SYNTH_ADDER_TYPE: "YOSYS"`)
hem en iyi zamanlamayı hem en küçük alanı veriyor. DELAY stratejileri toplam negatif
slack'i düşürmeden alanı %11-14 büyütüyor; özel toplayıcı haritaları ise yavaş corner'da
belirgin şekilde kötüleşiyor. Bu yüzden sentez ayarlarında değişiklik yapılmamıştır.

## Global routing tikanikligi -- 25 kosumun tam kaydi

Ham kanit dosyalari (`resolved.json`, GRT/DRT log ozetleri, `or_metrics_out.json`,
`warning.log`) her kosum icin `reports/synthesis/deney_arsivi/<kosum_adi>/`
altinda saklanmaktadir. Asagidaki her sayi o dosyalardan okunmustur.

### Kok neden: SRAM makrolarinin katman engelleri

Ilk sekiz denemede global routing yakinsamadi. Die boyutu, hucre dolgusu,
yerlestirme yogunlugu ve makro araligi tek tek denendi; hicbiri sorunu cozmedi
ve **die buyutmek olcum bazinda TERS etki yapti** (3600x3200 denemesi 257.887
overflow ile 3400x2900'un 133.432'sinden kotuydu).

Sebep, `sky130_sram_2kbyte_1rw1r_32x512_8.lef` icindeki `OBS` tanimlaridir:

| Katman | Yon | Makro uzerinde |
|---|---|---|
| met1 | yatay | tek `RECT`, %99,5 kapali |
| met2 | **dikey** | tek `RECT`, %99,5 kapali |
| met3 | yatay | 61 `RECT`, %96,7 kapali -- kesintisiz gecis yolu yok |
| met4 | **dikey** | 143 `RECT`, %97,8 kapali -- kesintisiz gecis yolu yok |
| met5 | yatay | engel **yok** |

SKY130'da dikey yonlu iki katman met2 ve met4'tur ve **ikisi de makro uzerinden
gecemez**. Makrolar die'in %42,3'unu kapladigi icin cipin bir yanindan digerine
giden her dikey tel yalnizca makrolar *arasindaki* sutun kanallarindan gecebilir.
Ortalama katman kullanimi %52 iken tikanmanin surmesi bununla aciklanir: sorun
genel kaynak darligi degil, **yereldir**.

### Neden `RT_MAX_LAYER: met5` (PDK varsayilani) yanlis sonuc verir

met5'e cikmak `via4` gerektirir; via4'un altindaki met4 makro uzerinde kapalidir.
Yani met5, makronun ustunde geometrik olarak bos gorunmesine ragmen oraya ancak
makro DISINDAN girilip cikilabilir. Global router bu erisim kisitini kaba
izgarada goremez, "met5 bos" deyip oraya yol planlar; detailed router gercek
geometriye carpinca sekilleri ust uste bindirir.

Olcum: met5 toplam talebin **%1,4**'unu tasirken DRC ihlallerinin **~%67**'sini
(6.056 kisa devre + 2.677 aralik) tek basina uretiyordu. Kontrollu deney
(`exp_met5_obs_grt`, 15 makronun met5 izdusumune obstruction eklenmis hali bile):
toplam overflow **94.692**.

### Belirleyici bulgu: `GRT_LAYER_ADJUSTMENTS` icindeki `0` "ceza yok" demek DEGIL

OpenROAD once `GRT_ADJUSTMENT`'i **butun** katmanlara uygular, sonra yalnizca
sifirdan farkli katman degerleri onu ezer. Ana config'te genel deger %30'du,
dolayisiyla listede `0` yazan ve gercekte BOS duran met3/met4 de farkinda
olmadan %30 kisiliyordu.

Ayni post-CTS ODB uzerinde yapilan kontrollu deneyler:

| # | Kosum | Genel ceza | Katman cezalari | met1 keep-out | iters | **Toplam overflow** | Kaynak | Tel |
|---|---|---:|---|---|---:|---:|---:|---:|
| 1 | `rtl2gds/39` | 0,30 | `[0,.30,.25,0,0,0]` | yok | 20 | **192.800** | 3.804.841 | 18,60 m |
| 2 | `exp_grt_adj010` | **0,10** | `[0,.30,.25,0,0,0]` | yok | 20 | **5.114** | 4.263.693 | 13,89 m |
| 3 | `exp_clock40_grt_ext1_i30` | 0,10 | `[0,.30,.25,0,0,0]` | `GRT_MACRO_EXTENSION:1` | 30 | 6.737 | 4.155.297 | 15,45 m |
| 4 | `..._m1obs_i30` | 0,10 | `[0,.30,.25,0,0,0]` | 1 makro | 30 | 4.285 | 4.257.370 | 15,05 m |
| 5 | `..._m1obs_relaxed_i30` | **0,05** | **`[0,.25,.20,0,0,0]`** | 1 makro | 30 | **372** | 4.496.947 | 14,09 m |
| 6 | `..._m1obs_relaxed_i50` | 0,05 | `[0,.25,.20,0,0,0]` | 1 makro | **50** | **90** | 4.496.947 | 14,17 m |
| 7 | `..._m1obs_g002_i50` | 0,02 | `[0,.25,.20,0,0,0]` | 1 makro | 50 | 90 (**ayni**) | 4.496.947 | 14,17 m |

**7. satir bir NO-OP'tur.** `[INFO GRT-0053]` derated resource satirlari 6. ve 7.
kosumda bit bazinda aynidir; `GRT_ADJUSTMENT` 0,02 hicbir seyi degistirmez.

---

## ⚠ EN ONEMLI BULGU: GRT ASIMI YANILTICI BIR VEKIL METRIKTIR

Yukaridaki tablo **GRT asimina** gore siralanmistir ve bu siralama **YANLIS
YONE goturur**. Nihai kosumda olculdu: asimi 39'a indiren yapilandirma detayli
yollamayi yakinsatamiyor.

Ayni netlist, ayni yerlestirme, ayni post-CTS veritabani uzerinde:

| GRT ayarlari | GRT asimi | DRT iter 0 | DRT iter 1 | DRT iter 3 | DRT sonuc |
|---|---:|---:|---:|---:|---:|
| adj 0.05, `[0,.25,.20]`, i50, + keep-out | **39** | 233.380 | 204.779 | ~165.000 | **yakinsamadi** |
| **adj 0.10, `[0,.30,.25]`, i20, keep-out yok** | **15.218** | 89.218 | 41.952 | 14.862 | **24 ihlal** |
| referans (eski netlist), adj 0.10 | 5.114 | 68.149 | 28.820 | 7.210 | 7 ihlal |

GRT metriginde 390 kat kotu gorunen yapilandirma, gercek metrikte binlerce kat
iyi sonuc veriyor.

**Mekanizma:** `GRT_ADJUSTMENT` dusurulunce global router'a daha fazla GORUNUR
kapasite verilir; daha sikisik guide uretir. Kaba izgarada "asim yok" gorunur,
detayli yollayici gercek geometride gerceklestiremez ve sekilleri bindirir.

**BENIMSENEN KURAL:** bir GRT ayari, DETAYLI YOLLAMADAN GECTIGI OLCULMEDEN
`config.yaml`'a alinmaz. Bu kural bu bulgudan sonra konmustur; ondan onceki
secimler GRT rakamina bakilarak yapilmis ve bir tam kosum (2 saat) bosa gitmisti.

**DURUSTLUK NOTU:** karsilastirmada ceza ayarlari ve keep-out'lar BIRLIKTE
degisti; hangisinin tek basina zararli oldugu IZOLE EDILMEDI. Dogrulanan sey
kombinasyondur. Keep-out ureteci korunmus, varsayilani `off` yapilmistir
(`make keepout MODE=on` ile geri acilir).

### Kalan DRC ihlallerinin yapisi

`drtfix_a` kosumunun biraktigi **24** ihlalin tamami `Short` ve tamami met2'de.
Dagilim UC makroya yayilir (onceki surumde "36 ihlal, iki conv makrosunda"
yaziyordu; ikisi de yanlisti -- 36 bir ARA iterasyon degeriydi, log 36 -> 26 ->
**24** diye bitiyor):

| Makro | Ihlal |
|---|---:|
| conv `g_2k[0]` | 8 |
| conv `g_2k[1]` | 14 |
| YZ `g_1k` | 2 |


```
violation type: Short
  srcs: net:conv_accelerator_inst.cbuf_raddr[1]
        inst:...u_conv_buf_ram.u_mem.u_mem.g_2k[1].u_cell.u_sram
  bbox = (2823.6400, 1575.6200) - (2823.7800, 1990.9200) on Layer met2
```

`g_2k[1]` ayak izi x 2563,1..3246,2, y 1575,0..1991,54 (macro_placement.cfg +
LEF SIZE'dan) -- yani marker makronun ICINDE. (Onceki surumde 2553..3236
yazilmisti; o, eski 10 um keep-out sinirinin koordinatiydi, makronun kendisinin
degil.)
SRAM LEF'inin met2 OBS dikdortgeni makro alaninin %99,52'sini kapatir; kalan
%0,48 makro cevresindeki ince serittir ve makro icinden gecen kullanilabilir
bir kanal degildir. Marker'in OBS dikdortgeninin ICINDE bulunmasi nedeniyle
"router kalan %0,5'ten gecmeye calisiyor" aciklamasi desteklenmez. Daha olasi
mekanizma kaba GCell guide'inin OBS icine tasmasi veya makro pin/engel erisim
modellemesidir. Referans kosumdaki 7 ihlal de ayni makrolardaydi, yalniz met1
uzerinde.

Tam ayak izine ikinci bir met2 obstruction eklemek mevcut OBS ile geometrik
olarak ayni oldugundan etkisiz kalabilir. Anlamli hedefli deney, makro disina
tasan bir halo/GCell yasak bolgesidir; yukaridaki kural geregi DRT'den gectigi
olculmeden teslim yapilandirmasina ALINMAMISTIR.

---

### Detailed routing ve kalan 7 DRC ihlali

2. satirin veritabaniyla (`exp_grt_adj010_drt`) DRT kosuldu:

| Olcum | Deger |
|---|---|
| Sure | **44 dk 08 sn** (CPU 7 sa 21 dk, 20 is parcacigi, tepe 6 GiB) |
| Kalan DRC ihlali | **7** |
| Tel uzunlugu | 11.200.300 um (met1 3,98 M / met2 3,77 M / met3 2,36 M / met4 1,09 M / met5 **0**) |
| Via | 878.737 (tamami single-cut) |
| Yollanan net | 89.130 |

Yakinsama egrisi: 68.149 -> 28.820 -> 26.123 -> 7.210 -> 2.658 -> 1.231 -> ...
-> iter 48'de **7**; sonraki iterasyonlarda 7-19 arasinda salindi, sifira inmedi.

7 ihlalin tam dokumu (`deney_arsivi/exp_grt_adj010_drt/top_module.drc`):

| # | Tur | Katman | Konum (um) | Netler |
|---|---|---|---|---|
| 1-2 | Short | met1 | (2632,74 , 1960,20) ve (2563,72 , 1960,20) | `_019282_` <-> conv_buf SRAM |
| 3-6 | Short | met1 | (2594,10 ... 2594,70 , 1965,64 ... 1990,92) | `...u_cell.rdata[2]` <-> ayni SRAM |
| 7 | Metal Spacing | met1 | (2594,47 , 1991,48) | `rdata[2]` <-> `rdata[5]` |

**7'sinin de katmani met1, 7'sinin de yeri TEK bir makronun** (conv
accelerator'in 2. adet 2 KiB SRAM'i, `g_2k[1]`) engel sinirinin hemen disi.
Bu gozlem `scripts/gen_macro_keepout.py`'nin dogus noktasidir: ayni yapisal
durum 15 makronun hepsinde vardir, hangisinin kurban olacagi yerlestirmeye
gore degisir; bu yuzden keep-out **hepsine** uygulanir ve elle degil
`macro_placement.cfg`'den **uretilir**.

### Global yerlestirme modu -- olculup elenen dal

| Kosum | `PL_ROUTABILITY_DRIVEN` | GPL sonucu | Yapay sisirme | GRT overflow |
|---|---|---|---:|---:|
| `candidate_clean_v2/28` | true | snapshot'a donus (iter 1097) | +%36,27 | (o donem) |
| `candidate_final40_arbfix_gpl_plain_diag` | **false** | iter 487'de temiz, HPWL 4,60e6 | **+%0,00** | — |
| `candidate_final40_arbfix_grt_i50_strict` | false (yukaridakinin devami) | — | — | **113.525** |
| `exp_clock40_grt_target_m1obs_relaxed_i50` | true | — | — | **90** |

`PL_ROUTABILITY_DRIVEN: false` HPWL'i **%22 kisaltiyor** ama toplam overflow'u
**1.261 kat** artiriyor. Belirleyici kanit lokalizasyondur: talep yalnizca %4,4
daha yuksek (1.770.584 vs 1.696.582) ama **tile basina en kotu asim 79/64 vs
5/2** (~16x/32x). Yani sorun global kaynak degil **HOTSPOT**: yonlendirilebilirlik
geri beslemesi kapatilinca hucreler makro aralarindaki dar kanallarda yiginlaşiyor.
Bu dal **kullanilmamistir**.

### Global yerlestirme iraksamasi ve cozumu

`PL_ROUTABILITY_DRIVEN: true` ile calisirken routability fazi
`[GPL-0089] could not reach target` deyip biraktiktan sonra duz Nesterov
cozucusu **iraksiyordu**. Belirti:

| Iterasyon | Overflow | HPWL |
|---:|---:|---:|
| 0 | 0,998 | 1,16e6 |
| 2050 | 0,415 | **1,78e8** |
| 3260 | 0,376 | **1,86e8** |

HPWL 150 kat buyuyup orada saliniyor, overflow 0,37-0,41 bandinda takiliyor ve
hedef 0,10'a hic inmiyor. Onceki oturumda bir kosum bu yuzden iterasyon 5450'de
elle oldurulmustu (`candidate_final40_arbfix_pre_route`) ve o dalda **hic ODB
uretilememisti** -- akisin onundeki gercek engel buydu.

Cozum, Nesterov cozucusunun yogunluk cezasi katsayisi mu_k'nin ust sinirini
kismaktir. Ayni pre-GPL veritabani uzerinde tek degiskenli deney:

| `PL_MAX_PHI_COEFFICIENT` | Sonuc | Son overflow | Son HPWL |
|---|---|---:|---:|
| (varsayilan 1,05) | 5000+ iterasyon, **yakinsamadi** | 0,38 (salinim) | 1,8e8 |
| **1,02** | **`[GPL-1001]` iterasyon 5481'de bitti** | **0,0999** | 6,06e6 |

`[GPL-1014] Final placement area: 1.159.967,51 (+%31,3)` -- artis
yonlendirilebilirlik modunun yapay hucre sismesidir ve beklenen davranistir.
Iraksama uyarisi (`GPL-0998`) hic uretilmedi.

Not: yerlestirmenin hedef overflow'a **tam** ulasmasi zorunlu degildir; daha
onceki bir kosum 0,198'de snapshot'a donup bitmis ve zinciri yine de en iyi
yollama sonucunu vermisti. Belirleyici olan yerlestirmenin **saglikli bir HPWL
ile SONLANMASIDIR**; iraksayan dalda o bile olmuyordu.

### Denenip elenen diger yaklasimlar

| Denenen | Olculen sonuc |
|---|---|
| Die 3600x3200'e buyutme | overflow 257.887 (3400x2900'un 133.432'sine karsi). **Sinirli cikarim:** bu, O DONEMKI yerlestirme, yogunluk ve 4x4 makro duzeniyle olculmustur; "die buyutmek her zaman ters etki yapar" demek DEGILDIR. Makro kanallari ve yerlestirme birlikte yeniden duzenlenirse sonuc farkli olabilir. |
| Makro izgarasini 3 sutun x 5 satira alma | overflow 72.909 -> **447.323**, tel +%34 -- ters etki |
| `CTS_APPLY_NDR: none` | talep +%18, tel +%21, overflow 72.909 -> **253.521** |
| `CTS_OBSTRUCTION_AWARE: true` | saat agaci makrolarin etrafindan dolasti, tel uzadi |
| Hucre dolgusu (`GPL/DPL_CELL_PADDING` 4/2) | tel 16,5 -> 24,6 m, overflow 540k |
| `PL_TARGET_DENSITY_PCT: 25` | overflow 258k (35 daha iyi) |
| `GRT_MACRO_EXTENSION: 1` | overflow 6.737. **DIKKAT: yalnizca GRT asimina bakilarak elendi, DRT kosulmadi** -- bu, bu belgedeki kendi kuralimiza aykiridir. Yeniden degerlendirilmeli. |
| `MAX_FANOUT_CONSTRAINT: 25` | **ise yaradi** -- overflow 133k -> 73k, tampon 23.137 -> 15.853 |
| `DESIGN_REPAIR_MAX_SLEW/CAP_PCT: 0` | **ise yaradi** -- tampon 15.783 -> 11.938 |

### GRT suresi ve NDR dongusu

GRT'nin dongusu "50 iterasyon" degildir: OpenROAD tikanik bir NDR netinin
kuralini kapattiginda **iterasyon sayacini sifirlar** (`applySoftNDR` icinde
`i = 1`), yani toplam sure

    T_GRT ~ (NDR_kapatma_sayisi + 1) x (GRT_OVERFLOW_ITERS - 1) iterasyon

Tasarimda NDR tasiyan 13 saat neti vardi -> 14 tura kadar. i50 kontrollu
kosumda GRT overflow'unu 372'den 90'a indirdi; ancak bu dal DRT/signoff
zincirinden gecmedi ve yukaridaki olcum dusuk GRT asiminin daha iyi DRT
anlamina gelmedigini gosterdi. Nihai akista sure--kapsam takasi acikca
belgelenerek `GRT_OVERFLOW_ITERS: 20` tutuldu; `rtl2gds` sonucu GRT 16.108,
DRT 14 ihlaldir.

Saat aginin hangi katmandan basladigi da tur sayisini belirliyordu:

| Saat min katmani | Turu bastan baslatma | Tur | GRT suresi |
|---|---:|---:|---|
| met1 (etkin varsayilan) | 99 | 2 | — |
| met3 (PDK tavsiyesi) | 301+ | 8+ | 9,5 saat, bitmedi |
| **met2 (kullanilan)** | 115 | 5 | **69 dakika** |

met3, saat agacini makrolarin %97 kapattigi katmanlara kilitledigi icin 13 NDR
netinin hepsini garantili tikanik bolgeden gecirir ve GRT her turda taze bir
kurban bulur. met2 uzlasma noktasidir.

### Post-route periyot ve CTS deneyleri (2026-08-28)

Eski 38 ns kosumunun **ayni RCX veritabani** üzerinde yalnız SDC periyodu
degistirilerek dokuz köseli STA tekrarlandi. Bu deney yeni sentez veya yeni
yönlendirme degildir; mevcut fiziksel tasarimin kapanabilecegi alt siniri
ölcer:

| Periyot | En kötü setup WS (`max_ss`) | Setup uç | En kötü hold WS | Hold uç |
|---:|---:|---:|---:|---:|
| 38 ns | -24,738 ns | 2.445 | -1,751 ns | 2.672 |
| 64 ns | **+1,262 ns** | **0** | -1,751 ns | 2.633 |
| 66 ns | +3,262 ns | 0 | -1,751 ns | 2.633 |
| 70 ns | +7,262 ns | 0 | -1,751 ns | 2.633 |

Kritik setup yolu SRAM degil, ivmelendiricideki register-to-register maske-ROM
yoludur; ölçülen gecikme yaklasik 62,738 ns'dir. 64 ns mevcut veritabaninda
kapanan en küçük **denenmis** degerdir. Ancak temiz bir 64/66/70 ns tam akis
farkli sentez/yerlestirme sonucu verebileceginden ana periyot ancak temiz tam
kosumla dogrulandiktan sonra beyan edilebilir. ASIC top kopyasindaki I2C saat
parametresi de periyotla birlikte üretildigi için ana periyot degisikligi RTL
kopyasini etkiler ve takim onayi olmadan uygulanmayacaktir.

CTS tarafinda dört fiziksel-only deney ayni detailed-placement durumundan
baslatildi:

| Deney | CTS tamponu | Post-CTS setup WS | Post-CTS hold WS / uç | Sonuç |
|---|---:|---:|---:|---|
| Varsayilan küme 20 | 1.251 | 8,606 ns | **+0,040 ns / 0** | Referans |
| Küme 10 | 2.899 | 8,611 ns | -0,024 ns / 1 | Reddedildi |
| Küme 10 + güçlü yaprak | 2.899 (toplam clock sınıfı 4.115) | 8,561 ns | -0,010 ns / 1 | Reddedildi |
| Küme 5 + güçlü yaprak | 4.204 (toplam clock sınıfı 5.940) | 8,479 ns | -0,031 ns / 5 | Reddedildi |
| Maksimum saat teli 500 µm | 1.251 + 157 tel tamponu | 8,503 ns | **-0,235 ns / 6** | Reddedildi |

Küme küçültme soyut skew'u az miktarda iyilestirse de gerçek post-CTS hold'u
bozdu ve tampon/tikaniklik maliyeti büyüktü. 500 µm tel siniri da OpenROAD'un
`RSZ-0065` uyarisi ile birlikte gecikmeyi artirdi. Bu nedenle varsayilan CTS
korunmustur.

### Macro-ring, signoff marji ve 46 ns kapanisi (2026-08-29)

15 SRAM'in 4200x3600 um die çevresine, tümü `N` yönünde yerleştirildiği
`macro_ring_4200x3600.yaml` adayı eski iç-küme yerleşiminin fiziksel
tıkanıklığını kaldırdı. İki bağımsız DRT dalı da sıfır geometrik ihlalle bitti.
Temel ve onarılmış adayların aynı 38 ns kısıtındaki dokuz-köşe RCX sonuçları:

| Aday | DRT | Setup WS / uç | Hold WS / uç | Max cap / slew |
|---|---:|---:|---:|---:|
| Eski 3400x2900 ana koşum | 14 | -24,738 / 2.445 | -1,751 / 2.672 | 3.809 / 38.890 |
| Macro-ring temel | **0** | -7,445 / 1.603 | -0,248 / 260 | 3.052 / 34.493 |
| + %0 design repair + 20 ps hold | **0** | -7,071 / 1.556 | -0,230 / 140 | 2.809 / 33.753 |
| + %20 design repair + 450 ps hold | **0** | -7,273 / 1.688 | **+0,191 / 0** | 2.816 / 32.539 |

Son varyant 30.986 timing-repair tamponu kullanır; buna rağmen büyük die
nedeniyle standart hücre doluluğu yalnız %11,82'dir. GRT taşması sıfır,
detaylı rota 44.412 -> 18.397 -> 15.346 -> 1.164 -> 87 -> 2 -> 2 -> **0**
şeklinde yakınsamıştır. Hold'u saati yavaşlatmadan dokuz köşenin tamamında
kapatması nedeniyle seçilen fiziksel aday budur.

Aynı rota/parazitikler üzerinde 46 ns tanı STA'sı setup WS'yi **+0,7267 ns**,
hold WS'yi **+0,1908 ns** ve her iki ihlal sayısını sıfır ölçtü. Ana periyot
değişikliği, ASIC'e özgü üretilen top kopyasındaki I2C frekans parametresini
de değiştireceği için takım onayı ve ardından temiz tam akış gerektirir.

DRT'nin bir turluk yalnız-diyot antenna onarımı da bu yerleşimde yeniden
ölçüldü: temiz ilk rotadan sonra yaklaşık 2.930 diyot ikinci turun başlangıç
DRC yükünü 199.573'e çıkardı ve 40 dakikada ikinci iterasyon metriği oluşmadı.
Deney kontrollü durduruldu; 2.946 net / 4.427 pin antenna takası raporlanarak
onarım kapalı tutuldu.

### Denenmemis, optimizasyon fazina birakilan kaldiraclar

Bu teslimde **bilerek denenmedi**: her biri yerlestirmeyi degistirir ve yeni
kazanilan yollama yakinsamasini (GRT 16.108, DRT 14, GPL-1001 temiz bitis)
riske atar.
Once eksiksiz ve tutarli bir teslim paketi uretilmesi onceliklendirilmistir.

| Kaldirac | Beklenen etki | Risk |
|---|---|---|
| `PL_TIMING_DRIVEN: true` (LibreLane varsayilani **false**) | Yerlestirici kritik yollari oncelikler; beyan edilen frekansi yukari cekebilir. Bu tasarimda ozellikle anlamli, cunku yonlendirilebilirlik modu tel uzunlugunu bilerek uzatiyor: DP sonrasi HPWL 8,36e6 um, ayni netlist'in routability KAPALI yerlestirmesinde 4,60e6 idi. | GPL icinde resizer kosar (sure artar); yerlestirme degisir, GRT/DRT yeniden olculmelidir |
| `PL_KEEP_RESIZE_BELOW_OVERFLOW` | Timing-driven iterasyonlarin resizer degisikliklerini geri almamasi | Yalniz `PL_TIMING_DRIVEN` acikken anlamli |
| SRAM cikisina register eklemek | SRAM okuma yolu **yarim cevrimden tam cevrime** doner; frekans tavanini belirleyen kisit ortadan kalkar (~80 FF, ~1.700 um² = %0,2 alan) | Her okumada +1 cevrim gecikme: `sram32_bank`, `sram8_bank`, dort AXI bellek denetleyicisi ve `conv_accelerator_asic.v`'nin boru hatti derinligi degisir; YZ'nin 46.018 cevrimlik referansi yeniden olculmelidir |
| Hucre kumeleme (`MANUAL_GLOBAL_PLACEMENTS` / bolge kisiti) | UART_YZ'nin 634 hucresi 3,03 mm²'ye, yz_bram_ctrl'un 167 hucresi 2,09 mm²'ye yayilmis durumda; toplamak tel uzunlugunu kisaltir | Elle bolge tanimi floorplan'a sikica baglanir |

### Nihai yapilandirma

Yukaridaki olcumlerin tamami `config.yaml`'a tasinmistir; her ayarin gerekcesi
o dosyada ilgili satirin hemen ustunde yorum olarak durur. Ozet:

```yaml
RT_MAX_LAYER: met4
RT_CLOCK_MIN_LAYER: met2
GRT_ADJUSTMENT: 0.10
GRT_LAYER_ADJUSTMENTS: [0, 0.30, 0.25, 0, 0, 0]
GRT_OVERFLOW_ITERS: 20
ROUTING_OBSTRUCTIONS: null
PL_ROUTABILITY_DRIVEN: true
MAX_FANOUT_CONSTRAINT: 25
DESIGN_REPAIR_MAX_SLEW_PCT: 0
DESIGN_REPAIR_MAX_CAP_PCT: 0
PL_RESIZER_HOLD_SLACK_MARGIN: 0.02
DEDUPLICATE_CORNERS: true
```

---

## Optimizasyon fazi (2026-08-30)

Baslangic referansi: `run/rtl2gds`, 50 ns, 4200x3600 um. Butun zorunlu signoff
metrikleri sifir; kalan gercek ihlaller anten 2.904 net / 4.341 pin, max slew
32.763, max cap 2.858 ve 891 lint uyarisi.
Kabul kapisi donduruldu: `reports/synthesis/deney_arsivi/baseline_rtl2gds_50ns/`
ve `scripts/compare_metrics.py`.

### CURUTULEN HIPOTEZ: `RSZ_CORNERS`'a max-RC kosesi eklemek

**Hipotez:** Resizer yalniz `nom_*` koselerini goruyor, signoff en kotu sonucu
`max_ss_100C_1v60`'ta oluyor; kose listesine `max_ss_100C_1v60` eklemek
tahmin/signoff bosluğunu kapatir.

**Olcum -- hipotez YANLIS:**
`librelane/scripts/openroad/common/set_rc.tcl:72` icindeki
`set_layers_default_rc`, katman RC'sini teknoloji LEF'inden okuyup **butun
kose'lere AYNI degeri** uygular. Kose bazli farklilasma yalnizca `_LAYER_RC_<i>`
env degiskenlerinden gelir ve kosumda **hic tanimli degildi**
(`grep -c "_LAYER_RC_" run/rtl2gds/43-*/\_env.tcl` -> 0).
`nom_/min_/max_` onekleri yalnizca **RCX cikarim kural setleridir**
(`RCX_RULESETS`) ve ancak detayli yollamadan SONRA devreye girer.
`14-openroad-dumprcvalues/resizer_values_after.rpt` de tek bir kose dokuyor.

Sonuc: PnR sirasinda `max_ss_100C_1v60` ile `nom_ss_100C_1v60` **AYNIDIR**
(ayni liberty, ayni tel RC). Degisiklik NO-OP olurdu; `RSZ_CORNERS` uc lib
kosesini (tt/ss/ff) zaten kapsadigi icin oldugu gibi birakildi.

### KOK NEDEN: PnR tel modeli gercekten 2,2 kat iyimser

Hipotezi cururturken asil hata bulundu. PnR'da SPEF yoktur; OpenSTA tel
parazitiklerini `set_wire_rc` ile tahmin eder ve LibreLane bu degerleri
teknoloji LEF'inden alir -- teknoloji LEF'inin kapasitansi ise yalnizca PLAKA
bilesenidir, sacaklanma ve komsu tel eslesmesi yoktur.

Tamamlanmis kosumun **kendi SPEF'leriyle** olculdu (yollanmis tel 10.715.050 um,
`*D_NET` toplam kapasitansi ve `*RES` toplam direnci uzerinden):

| RCX kose | gercek C (pF/um) | C orani | gercek R (ohm/um) | R orani | RC orani |
|---|---:|---:|---:|---:|---:|
| nom | 1,8058e-04 | 2,23 | 1,1927 | 2,27 | **5,1** |
| max | 1,9793e-04 | 2,44 | 2,1764 | 4,15 | **10,1** |
| min | 1,6034e-04 | 1,98 | 0,7231 | 1,38 | 2,7 |
| **tahminci** | **8,1050e-05** | 1,00 | **0,5248** | 1,00 | 1,0 |

Elmore gecikmesi R x C ile olceklendigi icin resizer tel gecikmesini **5-10 kat
dusuk** tahmin ediyor. Bu tek olcum uc bilinmeyeni ayni anda acikliyor:

1. post-GRT `repair_design` 2.720 slew / 786 cap ihlali gorup onariyor, nihai
   RCX STA ayni tasarimda 32.763 / 2.858 raporluyor -- 12 kat fark.
2. Resizer'in KENDI taktigi tamponlar ihlalde cikiyor (`wire333/A` 4,575 ns,
   `rebuffer15076/X` 1,862 ns): taktigi anda modele gore sinir icindeydiler.
3. 25 ps setup marjiyla tahmin temizken gercek max-SS sonucu -5,729 ns cikmisti.
   10 ns'lik `GRT_RESIZER_SETUP_SLACK_MARGIN` bu bosluga karsi konmus KOR bir
   yamadir; asil hata tel modelindedir.

**Uygulanan cozum:** `LAYERS_RC` (LibreLane yapilandirma degiskeni,
`steps/openroad.py:221`) ile kose basina R/C tanimlandi. Tablo LibreLane'in
KENDI kaynagindaki, OpenROAD Flow Scripts'ten uyarlanmis sky130 tablosudur --
`config/pdk_compat.py:258-301` icinde YORUM SATIRI olarak duruyor, yani hicbir
zaman etkinlesmiyor. Elle yazilmadan (sed + `ast.literal_eval`) tasindi.

Dogrulama: tablonun tt sinyal kapasitans ortalamasi (met1+met3)/2 =
1,9367e-04 pF/um; bizim nom SPEF'imizden olculen gercek deger 1,8058e-04.
Sapma **%7,2 ve pesimist yonde** -- PnR tahmini icin dogru yon budur.
Direnc tarafinda tablonun tt degerleri teknoloji LEF ile zaten aynidir
(met1 8,929e-04 vs 8,928571e-04); tablo yalnizca ss/ff icin fiziksel proses
degisimini (+/-%30) ekler.

Hicbir PDK/teknoloji/kural dosyasi degistirilmedi; degisen tek sey bir LibreLane
yapilandirma parametresidir ve tahmini KOTUMSER yapar.

### Saat portu surucu modeli

`SYNTH_CLK_DRIVING_CELL` tanimsizdi -> `constraints/design.sdc` saat portunu
genel `SYNTH_DRIVING_CELL` (`inv_2`) ile modelliyordu. Olculen sonuc
(`max_ss_100C_1v60/checks.rpt`): `clk_i` slew 3,027 ns, `clkbuf_regs_0_clk_i/A`
3,139 ns, `delaybuf_0_clk_i/A` 3,089 ns -- tasarimdaki en kotu alti slew
ihlalinin ucu, hicbiri gercek tasarim sorunu degil. `clkbuf_16` secildi
(CTS'in kok tamponu zaten odur). Bir IO VARSAYIMIDIR, README 9.6'da beyan edilir.

### Lint: 891 uyarinin 465'i tek bir direktiften

`%Warning-TIMESCALEMOD` 465 adet ve bunlarin **446'si LibreLane'in kendi
urettigi PDK kara-kutu dosyasindan** geliyor
(`run/<tag>/tmp/<hash>.bb.v` -- `sky130_ef_sc_hd__decap_*` vb.), bizim RTL'den
degil. Verilator kurali: bazi moduller `timescale` tasiyorsa tasimayanlari
uyarir. ASIC filelist'inde `timescale` tasiyan **tek dosya**
`asic_rtl/patched/conv_accelerator_asic.v`'dir (satir 35) ve o modulde hic
gecikme operatoru yoktur (`#` eslesmesi yalnizca `module conv_accelerator #(`
parametre listesi). Yani direktif islevsel olarak atildir ve tek basina 465
uyari ureten tetikleyicidir.

Planlanan: `patch_rtl.py` ASIC kopyasindan direktifi cikarir -> 891 -> ~426.
Kabul kapisi: bes ASIC regresyonu (ozellikle YZ'nin 46.018 cevrimlik bit-exact
referansi) degismeden gecmelidir. Probe kosumlari devam ederken UYGULANMADI --
kosum ortasinda RTL degistirmek A/B karsilastirmasini kontrolsuz kilardi.

### RC farkinin ayristirilmasi: kapasitans gercek hata, direnc li1 artefakti

Yukaridaki tabloda direnc orani da 2,27-4,15 cikmisti. Ayristirildiginda bunun
buyuk kismi **modelleme hatasi degil**: li1 yerel baglanti katmani
75,29 ohm/um, met1-met4 ortalamasi ise (GRT talep karisimina gore agirlikli)
0,5829 ohm/um -- yani 130 kat. li1 `SIGNAL_WIRE_RC_LAYERS` icinde DEGILDIR ve
olmamalidir da (uzun net tahminlerini mahvederdi), ama SPEF onu icerir.

| RCX kose | SPEF toplam R | met1-4 payi | met disi kalan | esdeger li1 uzunlugu |
|---|---:|---:|---:|---:|
| nom | 1,278e+07 ohm | 6,246e+06 | 6,534e+06 | 86.776 um (telin %0,81'i) |
| max | 2,332e+07 ohm | 6,246e+06 | 1,707e+07 | 226.761 um (%2,12) |
| min | 7,748e+06 ohm | 6,246e+06 | 1,502e+06 | 19.945 um (%0,19) |

Sonuc: telin yalnizca %0,8-2,1'i li1 oldugu halde direncin yarisindan
fazlasini o tasiyor. Yani **duzeltilebilir gercek hata KAPASITANSTADIR**
(2,23 kat, sacaklanma bileseninin teknoloji LEF'inde olmamasi) ve LAYERS_RC
tam olarak onu duzeltir. Direnc tarafinda met katmanlarinin degerleri zaten
dogruydu; kalan fark `set_wire_rc`'nin yapisal olarak li1'i modellememesinden
gelir ve LAYERS_RC ile kapatilamaz. Bu, LAYERS_RC sonrasi da bir miktar
tahmin/signoff bosluğu kalacagi anlamina gelir.

### Probe 1: `p_rc_only` -- LAYERS_RC tek basina, die 4200x3600

**Sonuc: adim 41'de `[GRT-0116]` ile durdu, ama basarisizlik marji 6 TILE.**

| Adim | Olcum |
|---|---|
| 28 global placement | `GPL-1001` iterasyon 11.263, overflow 0,0999, HPWL 6,63e6, alan +%48,09 -- SAGLIKLI |
| 32 repair design post-GPL | 4.981 slew + 2.553 cap + 874 fanout ihlali -> 3.098 hucre buyutme, **31.532 tampon** |
| 39 global routing | met1 %25,09 / met2 %22,32 / met3 %13,04 / met4 %10,23, **her katmanda tasma 0** |
| 41 repair design post-GRT | 3.469 slew + 3.501 cap -> 5.893 tampon daha; artimli GRT met3'te **6 tile** tasma -> akis oldu |

Karsilastirma (baseline, iyimser RC): post-GPL 11.938 tampon.
Yani gercek tel modeliyle onarim yuku **2,6 kat** artiyor -- ve bu, signoff'un
zaten raporladigi 32.763 slew ihlalinin durustce PnR'a tasinmis halidir.

Onemli: 31,5 bin fazladan tampon GRT kullanimini neredeyse hic degistirmedi
(%24,83 -> %25,85). Yani tampon maliyeti ALAN degil, yalnizca yerel tikanikliktir.

**Tani:** `GRT_DESIGN_REPAIR_MAX_SLEW/CAP_PCT: 20` ("kutuphane sinirinin %20
ALTINA kadar onar") tel modeli iyimserken gercek ihlalleri yakalamanin dolayli
yoluydu. Model duzeltilince ayni %20 CIFTE SAYIM olur. Devam kosumu
(`p_rc_a2`) bu marji 0'a cekip `GRT_OVERFLOW_ITERS`'i 30'a cikararak
adim 40 state'inden devam ettirildi.

### Probe 2: `p_rc_die2600` -- LAYERS_RC + die 4200x2600 + density 50

**Sonuc: adim 32'de `[DPL-0036] Detailed placement failed`. Kok neden GPL IRAKSAMASI.**

Global placement `GPL-1001` uretmedi. Yorunge:

| Iterasyon | Overflow | HPWL (um) | Ceza katsayisi |
|---:|---:|---:|---:|
| 1.000 | 0,5352 | 5,44e+06 | 8,86e-10 |
| 10.000 | 0,1343 | 7,05e+06 | 4,95e-06 |
| 13.000 | 0,1246 | **3,25e+07** | **1,44e+07** |
| 13.610 | 0,1241 | 3,50e+07 | 5,23e+09 |

Yogunluk overflow'u 0,124'te takilip hedefe (0,10) hic inemedi; cozucu bu
yuzden mu_k'yi sonsuza kadar buyuttu. `PL_MAX_PHI_COEFFICIENT: 1.02` buyume
HIZINI sinirlar ama 3.000 iterasyon boyunca 1,02^n yine patlar -- yani bu kapak
iraksamayi ONLEMEZ, yalnizca geciktirir. Karsilastirma icin ayni adimda
`p_rc_only` cezasi 1,09e-05 idi (14 mertebe fark).

Iraksayan yerlestirme 44.550 slew ihlali ve 90.411 tampon uretti (saglikli
dalda 4.981 / 31.532), DPL de bunu legalize edemedi. Yani DPL hatasi SONUCTUR,
sebep degildir.

**Ders:** iki degisken (die + density) ayni anda degistirildi; bu, projenin
kendi kuralinin ihlaliydi. Ayrica tam akis harcamak gereksizdi -- GPL'in
saglikli bitip bitmedigi `--to OpenROAD.GlobalPlacement` ile ~30 dakikada
olculebilir. Sonraki tur bu ucuz probe ile yurutuluyor:
die 2800/3000 x density 35/50 kombinasyonlari.

### Probe 1b: `p_rc_a2` -- post-GRT onarim marji %20 -> 0 (adim 40 state'inden devam)

`p_rc_only`'in adim 40 state'inden `--from OpenROAD.RepairDesignPostGRT` ile
devam ettirildi; boylece sentez/yerlestirme/CTS yeniden kosulmadi (~2 saat
tasarruf). Tek fark `GRT_DESIGN_REPAIR_MAX_SLEW/CAP_PCT: 20 -> 0` ve
`GRT_OVERFLOW_ITERS: 20 -> 30`.

| Olcum | marj %20 (`p_rc_only`) | marj %0 (`p_rc_a2`) |
|---|---:|---:|
| Bulunan slew ihlali | 3.469 | **1.342** |
| Bulunan cap ihlali | 3.501 | **1.758** |
| Eklenen tampon | 5.893 | **2.354** |
| Artimli GRT sonucu | met3'te 6 tile tasma -> `[GRT-0116]`, akis oldu | **her katmanda tasma 0** |
| met1 / met2 / met3 / met4 kullanimi | %25,85 / %22,55 / %12,05 / %10,39 | %25,28 / %22,36 / %12,88 / %10,25 |

**Dogrulanan tez:** `GRT_DESIGN_REPAIR_MAX_SLEW/CAP_PCT: 20`, tel modeli 2,2 kat
iyimserken gercek ihlalleri yakalamanin DOLAYLI yoluydu. LAYERS_RC ile model
duzeltilince ayni %20 cifte sayima donusuyor: onarilacak ihlal sayisini 2,6 kat,
tampon sayisini 2,5 kat sisiriyor ve tikanikligi tek basina o uretiyor.
Marj sifirlanınca hem ihlal hem tampon yariya iniyor, tikaniklik tamamen kalkiyor.

Not: bu kosumda iki degisken birlikte degisti (marj + GRT tur sayisi). Tampon
sayisindaki %60 dusus dogrudan marjdan gelir; tur sayisinin katkisi olsa olsa
marjinaldir, cunku tasma zaten 0'a inmistir.

Ayni mantik setup tarafinda `GRT_RESIZER_SETUP_SLACK_MARGIN: 10.0` icin de
gecerli olmali -- o da tel modeli iyimserken konmus kor bir yamaydi. Ayri
deneyde olculecek.

### Probe 1c: `p_rc_a3` -- LAYERS_RC + post-GRT marj %0, NIHAI OLCUM

`p_rc_a2` detayli yollama sirasinda OOM'da olduruldu (es zamanli Verilator
regresyonu bellegi tuketti); `04-openroad-stamidpnr-3` state'inden
`--from OpenROAD.DetailedRouting --to OpenROAD.STAPostPNR` ile devam edildi.
Die 4200x3600 DEGISMEDI; tek fark LAYERS_RC + design-repair marjinin sifirlanmasi.

**Kabul kapisi (`scripts/compare_metrics.py`): zorunlu metriklerin hepsi korundu.**
DRT DRC 0, PDN 0, kritik baglantisiz pin 0, unmapped 0, max fanout 0,
lint error / latch / timing construct 0. (Magic/KLayout DRC, LVS, XOR bu kismi
kosumda calismadi; tam kosumda dogrulanacak.)

| Metrik | baseline `rtl2gds` | `p_rc_a3` | Degisim |
|---|---:|---:|---:|
| **Max slew ihlali** (`max_ss`) | 32.763 | **880** | **-%97,3** |
| **Max cap ihlali** (`max_ss`) | 2.858 | **626** | **-%78,1** |
| **Anten ihlalli net** | 2.904 | **1.998** | -%31,2 |
| **Anten ihlalli pin** | 4.341 | **2.442** | -%43,7 |
| Setup WS (`max_ss`) | +2,1001 ns | **+3,6928 ns** | **+1,593 ns** |
| Hold WS (`max_ff`) | +0,1924 ns | **+0,3509 ns** | +0,158 ns |
| Setup / hold TNS | 0 / 0 | 0 / 0 | = |
| DRT DRC | 0 | 0 | = |

Maliyet:

| Metrik | baseline | `p_rc_a3` | Degisim |
|---|---:|---:|---:|
| Timing-repair tamponu | 31.350 | 50.753 | +19.403 |
| Std hucre alani | 1.287.680 um2 | 1.528.650 um2 | +%18,7 |
| Std hucre dolulugu | %11,914 | %14,144 | +2,23 puan |
| Toplam instance | 1.336.189 | 1.338.593 | +2.404 |
| Filler instance | 1.088.528 | 1.071.086 | -17.442 |
| Toplam tel | 10.715.050 um | 10.841.371 um | +%1,2 |
| Via | 814.406 | 909.107 | +%11,6 |
| Toplam guc | 34,13 mW | 35,03 mW | +%2,6 |

**Yorum.** Tel modeli duzeltilince resizer 19.403 tampon daha takti ve karsiliginda
slew ihlallerinin **%97'sini**, cap ihlallerinin %78'ini sildi. Anten de kendiliginden
%31-44 dustu: daha cok tampon = daha kisa kesintisiz metal kosusu = daha kucuk
anten orani. Bedeli %18,7 std hucre alani, ama die zaten %11,9 doluydu; doluluk
%14,1'e cikti, hala cok bos. Tel yalnizca %1,2 uzadi, GRT tikanmadi.

Ayrica setup slack +1,59 ns iyilesti: resizer artik GERCEK yollari onardigi icin
ayni periyotta daha genis pay kaldi. Bu, frekans kalibrasyonunda dogrudan
kullanilabilir.

**Sonraki olcum:** `GRT_RESIZER_SETUP_SLACK_MARGIN: 10.0` hala aktif ve artik
gercek RC uzerinde calisiyor -- 50.753 tamponun buyuk kismini o uretiyor olabilir.
{10, 5, 2} taramasi yapilacak; hedef, 9 kosede setup ihlali 0 kalirken en az tampon.

### Bagimsiz ic denetim (2026-08-30) -- dogrulama ve sonuclar

Sayisal iddialari bagimsiz olarak kontrol edildi, hepsi tuttu:

| Iddia | Dogrulama |
|---|---|
| Netlistte 16.516 `dlygate4sd3_1` | `grep -c` ile birebir 16.516 |
| SRAM `dout0`/`dout1` `timing_type : falling_edge` | Liberty satir 159 ve 398 |
| PDN 17 noktada met4-met5 via yerlestiremiyor | `warning.log` 17 eslesme |
| `config.yaml` yorumlari bayat (LAYERS_RC / saat katmani) | ikisi de dogru, DUZELTILDI |

#### FREKANS TAVANI KESINLESTI: SRAM yarim-cevrim okumasi

`p_rc_a3`'te kritik yol DEGISTI. Eski baseline'da CPU decoder'iyken, yeni
baseline'da ilk 20 setup yolunun **15'i YZ SRAM bank 0'dan baslayip**
`conv_accelerator`'in `prod[*]` registerlarinda bitiyor.

Mekanizma: SRAM Liberty'si `dout` yayini `falling_edge` olarak tanimlar. Okuma
DUSEN kenarda baslar, yakalama YUKSELEN kenarda olur -> konvolusyon MAC yoluna
periyodun tamami degil **T/2** butce kalir. Olculen iz (50 ns'de):
dusen kenar 25,000 ns -> `dout1[12]` 30,530 ns -> 15 seri tampon (~4,63 ns)
-> carpan -> yakalama 51,637 ns.

**Sonuc: periyodu dusurmenin onundeki asil duvar budur, mantik derinligi degil.**
Cozum SRAM cikisini registerlamaktir (`ram_rdata` + 64-bit `w_dout` birlikte,
~72 FF, ~1.700 um2, boru hatti +1 kademe -> +500 cevrim = 46.018 -> ~46.518,
%1,09). KAYNAK RTL DEGISIKLIGIDIR; takim onayi beklemektedir.

#### ALAN: onarim hucreleri std hucre alaninin %44'u

| Sinif | Adet | Alan |
|---|---:|---:|
| Timing-repair buffer | 50.753 | 0,516424 mm2 |
| `dlygate4sd3_1` (hold) | 16.516 | 0,165319 mm2 |
| **Toplam onarim** | **67.269** | **0,681743 mm2** |
| Std hucre alani (toplam) | — | 1,52865 mm2 |

Yani std hucre alaninin **%44,6'si onarim hucresidir**. Bu, daha once iptal
edilen marj taramasini yeniden degerli kilar.

**Onceki iptal gerekcem ve duzeltmesi:** setup marjini 10'dan dusurmenin slack'i
yiyecegini hesaplamistim (marj 10 -> final +3,69, arada 6,3 ns fark; marj 5 ->
final ~-1,3 ns). Bu hesap tek basina dogru fakat EKSIK: 6,3 ns'lik farkin bir
kismi tamponlamanin KENDISINDEN geliyor olabilir, yani marj dusunce fark da
kucule bilir. Bu yontem bunu ucuza olcuyor: ortak post-GRT state'ten
dallan, once yalniz PnR-corner STA ile filtrele (DRT'siz, ~20 dk/dal), yalniz
umut veren dallari tam DRT + 9 corner'a goturt. Overlay'ler hazir:
`experiments/postgrt_setup_margin{10,5,2,0p5}.yaml`.

#### GPL IRAKSAMASININ KOK NEDENI (OpenROAD kaynagi, commit dcf36133...)

1. `nesterovBase.cpp:3029-3058` -- iraksama algisi hem HPWL artisi HEM overflow
   artisi ister. Bizde overflow 0,11-0,14 platosunda SABIT kalip yalniz HPWL
   patladigi icin kosul **hic tetiklenmiyor**, cozucu durmuyor.
2. `nesterovBase.cpp:2806-2822` -- `densityPenalty *= phiCoef`, yani
   `PL_MAX_PHI_COEFFICIENT` mutlak tavan DEGIL **iterasyon basina carpandir**.
   1,02 ile 3.000 iterasyon 1,02^3000 demektir; iraksamayi onlemez, geciktirir.
3. `nesterovBase.cpp:2918-2948` -- normal bitis yalniz unscaled overflow hedefin
   altina inince olur.
4. `nesterovPlace.cpp:985-1020` -- routability snapshot aktifken `maxNesterovIter`
   de artar, yani iterasyon tavani fiilen ileri itilir.
5. `nesterovPlace.cpp:522-604` -- en-iyi-HPWL snapshot'i routability devam
   ederken kaydedilmez; geri donus yolu zayif.

Ayrica: `PL_ROUTABILITY_OVERFLOW_THRESHOLD` yalnizca routability KONTROL esigidir,
bitis hedefi DEGILDIR -- onu buyutmek "cozum" degildir.

Dogru mudahale carpani kucultmektir. Hazirlanan probe:
`experiments/gpl_die3000_phi101.yaml` (die 4200x3000 + phi 1,01, yalniz GPL).
Arsiv kaniti: 4200x3600'de phi 1,01 ile `GPL-1001` @10.076, overflow 0,0997,
HPWL 6,12e6.

#### Eski kritik yolun kaynagi

`_062092_`..`_062097_` seri OR/NOR zinciri (30,060688 -> 37,172947 ns =
**7,112259 ns**) `Instruction_Splitter.sv:45`'teki 64 KiB aralik testinden
uretilmis, ardindan `axi_read_arbiter2.sv:69,80` kombinasyonel seciminden
geciyor. Yeni baseline'da ilk 15'e girmedigi icin onceligi dusuk.

#### Teslim kapisi notu

Nihai tam kosum temiz cikarsa `ERROR_ON_*` bayraklari (DRT, Magic, KLayout, LVS,
XOR, illegal overlap, PDN) `true`ya dondurulmelidir -- temiz oldugu bilinen
siniflarda false birakmak gereksiz uyum riski yaratir. Anten ve 480 kritik
olmayan kopuk pin icin ham rapor ve acik gerekce korunur.

### SRAM cikisi kayit kademesi (`sramreg`, 2026-08-31)

Kullanici onayiyla uygulandi. **Kaynak RTL'ye DOKUNULMADI**; degisiklik
`scripts/patch_rtl.py`'nin mevcut yama zincirine yeni bir kademe olarak eklendi,
yani yalnizca `asic_rtl/patched/conv_accelerator_asic.v` etkilenir.

**Mekanizma.** SKY130 SRAM Liberty'si `dout` yayini `falling_edge` tanimlar:
adres t=0'da ornekleniyorsa veri t=T/2'de gecerli olur ve bir sonraki
yukselen kenarda (t=T) yakalanir -> yakalama penceresi **T/2**. Eski kodda o
pencerenin icinde 8x8 isaretli CARPMA vardi. Araya yalnizca kaydeden bir
kademe konarak carpma bir cevrim ileri alindi:

    if (v_s2)  begin rd_q <= ram_rdata; wd_q <= w_dout; end   // T/2: sadece tel
    if (v_s2d) prod[ci] <= (rd_q - INPUT_ZP) * wd_q[8*ci +: 8]; // TAM cevrim
    if (v_s3)  acc[ci]  <= acc[ci] + prod[ci];

Ayni kademe FC yoluna da uygulandi (`conv_buf_ram` de ayni SRAM makrosudur ve
ayni `falling_edge` yayina sahiptir). Bosaltma sayaclari 3 -> 4 cevrim.
Maliyet: 72 + 40 = 112 flip-flop.

**Islevsel dogrulama -- 5/5 regresyon GECTI.**

| Test | Sonuc |
|---|---|
| `yz` | EVET->2, HAYIR->3, SESSIZLIK->0; **46.519 cevrim** (46.018 + 501, tahminle birebir) |
| `collision` / `instr_collision` | BASARILI |
| `mem` | BASARILI, 12.592/12.592 |
| `boot` | BASARILI, 15 AXI arayuzunde 0 ihlal |

**Fiziksel sonuc (tam akis, 50 ns):**

| Metrik | `rtl2gds` | `sramreg` |
|---|---:|---:|
| **Setup WS (`max_ss`)** | +3,6236 ns | **+10,7706 ns** (+7,147) |
| Hold WS | +0,1099 ns | +0,1423 ns |
| Toplam tel | 10.465.589 um | 10.193.355 um (-%2,6) |
| Via | 894.988 | 889.976 |
| DRT / Magic / KLayout DRC | 0 / 0 / 0 | **0 / 0 / 0** |
| LVS / XOR / PDN / overlap | 0 | **0** |
| Anten net / pin | 1.977 / 2.388 | 1.943 / 2.423 |
| Max slew / cap | 880 / 628 | 1.019 / 640 |
| **Max fanout ihlali** | 0 | **2 <- KAPI REDDI** |

Adim 43 karsilastirmasi setup baskisinin gercekten azaldigini gosteriyor:
setup ihlalli endpoint 721 -> 545, setup tamponu 71 -> 24, yeniden
boyutlandirma 1.072 -> 752, hold tamponu 275 -> 19.

**KAPI REDDI -- benimsenmedi.** `design__max_fanout_violation__count` 0 -> 2.
Ikisi de CTS'in urettigi saat yaprak tamponunda:
`clkbuf_7_1__f_clk_i_regs/X` fanout 27, `clkbuf_7_3__f_clk_i_regs/X` fanout 26
(limit `MAX_FANOUT_CONSTRAINT: 25`). Sebep dogrudan bu degisikliktir: 112 yeni
flip-flop CTS kumelemesini iki noktada sinirin ustune tasidi.

Kozmetik degildir -- ayni iki tampon cap tarafinda da ihlaldedir
(0,247 ve 0,256 pF, limit 0,200). Yani gercekten asiri yuklenmislerdir.
"Saat neti, `set_max_fanout` sinyal kuralidir" diyerek gecistirmek dogru olmaz.

**Karar:** `sramreg` teslime ALINMADI; `reports/`+`results/` kapidan gecmis
`rtl2gds` kosumunda birakildi. Fanout duzeltmesi icin ayri bir kosum
harcanmayacak, cunku periyot degisince CTS zaten farkli bir agac kuracaktir;
duzeltme nihai kosuma katilacak. Aday cozum `CTS_MAX_CAP`'i acikca 0,2 pF'e
sabitlemek (CTS'in kendi kapasitans butcesini signoff limitiyle hizalar).
Kume boyutunu kucultmek daha kaba bir coz umdur ve bu belgede hold'u bozdugu
zaten olculmustur; hold su an +0,142 ns ile dardir.

### Periyot 50 -> 40 ns ve UART bolucusunun frekanstan turetilmesi (2026-08-31)

**Periyot secimi.** `sramreg` veritabani uzerinde, ayni rota ve ayni
parazitiklerle yalniz SDC periyodu degistirilerek olculdu:

| Periyot | Frekans | Setup WS (`max_ss`) | Ihlalli uc | Hold WS |
|---:|---:|---:|---:|---:|
| 50 ns | 20,0 MHz | +10,771 | 0 | +0,1423 |
| 46 ns | 21,7 MHz | +7,708 | 0 | +0,1423 |
| 44 ns | 22,7 MHz | +5,708 | 0 | +0,1423 |
| 42 ns | 23,8 MHz | +3,708 | 0 | +0,1423 |
| **40 ns** | **25,0 MHz** | **+1,708** | **0** | +0,1423 |
| 38 ns | 26,3 MHz | -0,292 | **13** (yalniz `max_ss`) | +0,1423 |

Taban ~38,3 ns. **40 ns secildi** (%25 hizlanma, +1,708 ns pay). Olcum 50 ns'ye
gore optimize edilmis rota uzerinde yapildigi icin bu pay MUHAFAZAKARDIR.
Hold her periyotta ayni kaldi -- ayni-kenar yollari periyottan bagimsizdir,
yani hizlanma hold'u riske atmaz.

Not: 50 -> 46 gecisi slack'ten 3,06 ns yedi, 46 -> 44 ise tam 2,00 ns. Demek ki
50 ns'de en kotu yol yarim-cevrimli bir yoldu (SRAM `dout -> rd_q` yakalamasi,
T/2 penceresinde bilerek kisa tutulmus); 46 ns'nin altinda tam cevrimli bir yol
devraldi ve oradan itibaren olcek birebir.

**UART bolucusu artik sabit degil.** Ayni firmware iki farkli saatte kosuyor:
FPGA 50 MHz, ASIC 25 MHz. `UART_CPB = 434` sabiti ASIC'te 57.604 baud verirdi;
217 yazilsaydi bu sefer FPGA demosu 230.415 baud'a kayardi. Cozum: deger
`soc.h` icinde derleme zamaninda hesaplanir

    #define UART_CPB_FOR(baud)  (((SYS_CLK_HZ) + (baud) / 2u) / (baud))

ve ASIC derlemesi `-DSYS_CLK_HZ` ile ezer (`FPGA/firmware/Makefile`:
`asic_boot`, `asic_app`, `asic_sim_boot`, `asic_sim_app`).
`SYS_CLK_HZ` zaten tanimliydi (soc.h:43); asil tanim `#ifndef` ile sarildi.

Dogrulama:

| Kontrol | Sonuc |
|---|---|
| FPGA `boot.hex` SHA-256 | `add3cd1f...` -- degisiklikten ONCEKIYLE BIREBIR AYNI |
| `asic_boot.hex` farki | tam **3 bayt** (434 -> 217 anlik sabiti) |
| Derleyici, varsayilan | CPB = 434 (115.207 baud @50 MHz) |
| Derleyici, `-DSYS_CLK_HZ=25000000` | CPB = 217 (115.207 baud @25 MHz) |
| I2C (patch_rtl.py otomatik) | `CLK_FREQ_HZ(25000000)`; kesirli 31/32 çevrimli yarı-periyotlarla ölçülen ortalama SCL **400,000 kHz**, FSM eşiği dinamik orta nokta |

**Akista frekansi sabit varsayan UC yer daha bulundu ve duzeltildi:**

1. `run_asic_sim.py` 434'u UC yerde sabit yaziyordu (biri `$fatal` assertion'i).
   `uart_cpb_from_config()` eklendi: `config.yaml`'daki `CLOCK_PERIOD`'dan
   firmware ile AYNI formulle turetir, boylece ikisi sessizce ayrisamaz.
2. `boot_test.sv` sabit `localparam int CPB = 416` tasiyordu ve UART'i cevrim
   sayarak suruyordu. Kaynak testbench DEGISTIRILMEDI; kosum aninda calisma
   dizinine yamali kopya yazilir (yz testindeki hizli-UART kalibiyla ayni).
3. `boot` ve `yz` testleri ROM'u simulasyona ozel imajla eziyordu
   (`sim_boot.hex` / `sim_app.hex`) ve onlar FPGA frekansindaydi. ASIC
   varyantlari eklendi.

**`mem` testi once BASARISIZ verdi -- ve test HAKLIYDI.** Uyusmayan iki kelime
cozuldugunde ortaya cikan:

    beklenen = 0x1b200713  ->  addi a4, x0, 434
    alinan   = 0x0d900713  ->  addi a4, x0, 217

Yani esdegerlik testi ASIC boot ROM'unu FPGA'nin `boot.hex`'iyle karsilastiriyor
ve kasitli olarak degistirilen TEK sabiti dogru sekilde yakaliyordu. Esik
gevsetilmedi; testin REFERANSI ASIC hex'ine cevrildi, boylece ASIC ROM'u ASIC
kaynagiyla karsilastiriliyor.

### `final40`: 40 ns + CTS_MAX_CAP + SRAM kaydi + UART turetimi (2026-08-31)

Bu kosum oturumdaki butun degisikliklerin birlesimidir ve bes ASIC regresyonu
(mem, boot, yz, collision, instr_collision) bu yapilandirmayla gecmistir.

| Metrik | benimsenen `rtl2gds` (20 MHz) | `final40` (25 MHz) |
|---|---:|---:|
| Frekans | 20 MHz | **25 MHz** (+%25) |
| Setup WS (`max_ss`) | +3,6236 ns | **+4,9597 ns** |
| Hold WS | +0,1099 ns | **+0,1424 ns** |
| DRT / Magic DRC | 0 / 0 | **0 / 0** |
| Anten net / pin | 1.977 / 2.388 | **1.929 / 2.370** |
| Max slew / cap | 880 / 628 | 1.079 / 635 |
| **Max fanout** | **0** | **1 <- kapi reddi** |

**Ekstrapolasyon dogrulandi ve asildi.** Periyot taramasi 40 ns icin +1,708 ns
ongormustu (50 ns'ye gore optimize edilmis rota uzerinde). Taze kosum
**+4,9597 ns** verdi -- 3,25 ns daha iyi. Sebep beklendigi gibi: resizer bu kez
40 ns hedefine gore calisti. Yani taban 38,3 ns tahmininden daha da asagidadir;
35 ns civari ayrica olculebilir.

#### DUZELTME: `CTS_MAX_CAP` dogru alet DEGILDI

`sramreg`'in 2 fanout ihlalini kapatmak icin `CTS_MAX_CAP: 0.2` konuldu ve
gerekce "CTS'in kapasitans butcesini signoff limitiyle hizalar" diye yazildi.
**Bu gerekce yanlisti.**

LibreLane kaynagi (`steps/openroad.py:2511`): *"Overrides the maximum
capacitance CTS **characterization** will test."* Yani deger yalnizca CTS'in
kumeleme sirasinda kullandigi gecikme/slew karakterizasyon tablolarinin ust
sinirini belirler; yollama sonrasi gercek tel kapasitansini BAGLAMAZ.

Olculen sonuc: ihlal 2 -> 1'e dustu (yani tamamen etkisiz degil), ama kalan
tampon hala sinirin ustunde:

    clkbuf_7_25_0_clk_i_regs/X   fanout 28 (limit 25),  cap 0,269 pF (limit 0,200)

Fanout'u dogrudan sinirlayan kaldirac `CTS_SINK_CLUSTERING_SIZE`'dir; cap limiti
fanout'u sinirlamaz, cunku birbirine yakin 28 sink dusuk kapasitans verebilir.

**Not:** `CTS_SINK_CLUSTERING_SIZE` bu belgede daha once 10 ve 5 degerleriyle
denenmis ve post-CTS hold'u bozdugu olculmustu. 20 degeri o denemelerden cok
daha yumusaktir ve ayrica denenmelidir; hold su an +0,1424 ns'dir.

**Kapi karari:** `final40` bir metrik disinda her yerde daha iyidir (daha hizli,
daha genis pay, daha az anten). Buna ragmen `compare_metrics.py` zorunlu
metriklerden birinin kotulesmesi nedeniyle REDDEDIYOR ve bu kosum kendi
basina teslime ALINMADI; karar takima birakildi.

### Bagimsiz ic denetim #2 (2026-08-31) -- KACIRILAN P0 ISLEVSEL HATA


#### I2C sabit sayac esigi -- 20 MHz'de tasarim CALISMIYORDU

`Peripherals/I2C/I2C_Master_AXI4_Lite.sv`:

    parameter HALF_PERIOD = (CLK_FREQ_HZ / (2 * I2C_FREQ_HZ)) - 1   // :7
    ...
    if (freq_div_cnt == HALF_PERIOD) begin freq_div_cnt <= 0; ... end  // :111
    ...
    else if (freq_div_cnt == 7'd29) begin                              // :228  SABIT

Sayac `HALF_PERIOD`'da sarar, FSM ise SABIT 29'u bekler. 29 sabiti modulun
varsayilan 48 MHz'inin orta noktasidir (HALF_PERIOD=59).

| Frekans | HALF_PERIOD | 29'a ulasir mi | Sonuc |
|---|---:|---|---|
| 48 MHz (varsayilan) | 59 | evet, tam orta | dogru |
| **20 MHz** (bugun teslim edilen) | **24** | **HAYIR** | **I2C KILITLENIR** |
| 25 MHz | 31 | evet ama orta 15 olmali | calisir, kenara yakin ornekler |

**Yani bugun erken saatlerde `rtl2gds` etiketiyle teslim edilen 20 MHz'lik
pakette I2C islevsel olarak calismiyordu.** Bu oturumda 25 MHz'e gecilmesi
sorunu TESADUFEN maskeledi. Bu hata onceki denetimlerde KACIRILDI; bes ASIC
regresyonu da yakalamadi cunku hicbiri I2C'yi yonlendirilmis bir senaryoyla
surmuyor.

**Cozum (kaynak RTL'ye dokunulmadan `patch_rtl.py` yama zincirine):**
kesirli (Bresenham) bolucu + FSM esiginin gercek orta noktaya baglanmasi.

    localparam HALF_BASE = CLK_FREQ_HZ / (2*I2C_FREQ_HZ);   // 25 MHz -> 31
    localparam HALF_REM  = CLK_FREQ_HZ % (2*I2C_FREQ_HZ);   // 25 MHz -> 200.000
    ...
    if (freq_div_cnt == (half_cycles_q - 1)) ...            // kesirli sarma
    else if (freq_div_cnt == ((half_cycles_q - 1) / 2))     // ORTA NOKTA

25 MHz'de 31/32 cevrimler 3:1 dagitilir, ortalama tam 31,25 -> SCL tam
400.000,000 Hz. 20 MHz'de oran zaten tam 25, jitter yoktur. Yonlendirilmis
I2C testleri iki frekansta da 10/10 gecti. Bes ASIC regresyonu yeni
netlistle 5/5 gecti (bu oturum).

Ek olarak `patch_rtl.py` artik `FPGA/firmware/Makefile`'daki `ASIC_CLK_HZ` ile
config'ten turetilen frekansi KARSILASTIRIR ve uyusmazlikta sentezden once
hata verir -- periyot degisip firmware unutulursa mask ROM yanlis baud tasirdi.

#### Duzeltme: Bir tespit eskiydi

Rapor "mevcut paket teslim edilebilir degil; `results/resolved.json`'da
`CLOCK_PERIOD=50`, 9 provenance hatasi" diyor. Kontrol edildi: `final40b`
toplamasi bittikten SONRA `resolved.json` 40'tir ve `verify_deliverables.py`
PAKET KAPISI GECTI verir. O gozlem toplama tamamlanmadan alinmis bir goruntuye
aittir. Ancak KARARI degistirmez: I2C yamasi netlisti degistirdigi icin mevcut
paket eski ve hatali I2C'yi tasir, yeni tam kosum zorunludur.

#### `ERROR_ON_*` bayraklari true yapildi

Temiz olcuLen siniflar icin: TrDRC, Magic DRC, KLayout DRC, LVS, XOR, illegal
overlap, PDN. Bu siniflar uc ardisik kosumda sifir olcuLdu, dolayisiyla kapi
artik gercektir: sessiz bir gerileme pakete giremez.
`ERROR_ON_DISCONNECTED_PINS` (bilinen 480 kullanilmayan SRAM `dout0` pini) ve
`ERROR_ON_LONG_WIRE` (yeni kosumda sifir oldugu henuz kanitlanmadi) false
kaldi; ikisi de raporlanmaya devam ediyor.

#### Kritik yol artik SRAM'de degil

`final40`'ta en kotu yol decoder `instr_rdata_i[15]` -> prefetch FIFO
`mem_q[53]`'tir (`run/final40/56-openroad-stapostpnr/max_ss_100C_1v60/max.rpt`).
SRAM kayit kademesi tavani gercekten kaldirmistir.

---

## 2026-09-02 — Sentez seviyesi A/B (bağımsız tarama)

Kaynak RTL bu turda kapsam dışı olduğu için 30 MHz kaldıracı sentezde arandı.
İki aday tek değişkenli koşuldu (`--to OpenROAD.STAPrePNR`).

| Aday | Hücre | Alan | pre-PnR WNS (ff/ss/tt) | Sonuç |
|---|---:|---:|---|---|
| baseline `final40c` | 69.011 | 779.660,3 µm² | −27,413 / −103,098 / −56,325 | — |
| `SYNTH_SIZING: true` | 69.011 | 779.970,6 (+%0,040) | −27,413 / −103,098 / −56,325 | **RED — no-op** |
| `SYNTH_ABC_USE_MFS3: true` | — | — | — | **RED — ABC çöktü** |

**`SYNTH_SIZING`** (LibreLane: "Enables abc cell sizing instead of buffering"):
netlist birebir aynı hücre sayısıyla çıktı, alan %0,04 kötüleşti, üç köşede
pre-PnR WNS **bit bit aynı**. Bu tasarımda ölçülebilir hiçbir etkisi yok.

**`SYNTH_ABC_USE_MFS3`** (LibreLane: "Experimental: SAT-based remapping"):
ABC assertion ile core dump veriyor, sentez rc=1 ile ölüyor —

    ABC: Abc_NtkFastExtract: Nodes have duplicated fanins. FX is not performed.
    ABC: Error: The network is combinational.
    ABC: yosys-abc: utilTruth.h:2257: Abc_TtExpand: Assertion failed
    ABC: Aborted (core dumped)  → return code 134

Yapılandırma hatası değil, araç hatasıdır. Bu tasarımda kullanılamaz.

Karşılaştırma için bagimsiz denetimin ölçtüğü `SYNTH_MUL_BOOTH: true` → 65.778 hücre /
754.566,2 µm² (**−%3,219**). Üç sentez kaldıracından **yalnız Booth işe yarıyor**.

---

## 2026-09-02 — bagimsiz denetimin yarım kalan çalışmasından çıkarılan sonuçlar

Önceki denetimin bıraktığı koşum dizinleri (`ant4_*`, `opt3_*`) ve
`scripts/jumper_odb_audit.py` incelendi;
aşağıdakiler o ölçümler + tamamlanan doğrulamadır.

### A. KÖK NEDEN BULUNDU — jumper'ları post-GRT resizer yok ediyor

bagimsiz denetim, `ResizerTimingPostGRT`'nin **hemen öncesinde ve sonrasında** ODB denetimi
aldı (`ant4_grt_jumper_final40c/{01-repair,02-resizer}/jumper_odb_audit.json`):

| Nokta | jumper guide | guide'lı net | "onarıldı" bayraklı net | guide'sız bayrak |
|---|---:|---:|---:|---:|
| `repair_antennas` sonrası | 1.661 | 1.422 | 1.422 | 0 |
| `ResizerTimingPostGRT` sonrası | **0** | **0** | 1.422 | **1.422** |

Resizer jumper guide'larının **%100'ünü** siliyor, ama `dbNet.hasJumpers()`
bayrakları ODB'de kalıyor. Sebebi LibreLane Classic'in sabit adım sırası
(`flows/classic.py:79-87`):

    79  GlobalRouting
    80  CheckAntennas
    84  RepairAntennas          <-- jumper guide'lari burada eklenir
    85  ResizerTimingPostGRT    <-- GRT_RESIZER_RUN_GRT=True: GRT'yi BASTAN kosar
    87  DetailedRouting

Diyotlar bundan etkilenmez çünkü onlar **netlist hücresidir**; jumper ise
yalnızca bir **yollama guide'ıdır** ve GRT guide'ları sıfırdan üretir.
Bu, projede daha önce "jumper no-op çıktı" diye kaydedilen bütün denemelerin
tek açıklamasıdır.

İkinci zarar: `jumper_odb_audit.py` docstring'inin belirttiği gibi
`dbNet.hasJumpers()` FlexDR'ın **guide-escape maliyet fonksiyonunu** değiştirir.
Yani geriye kalan 1.422 sahipsiz bayrak, karşılığı olmayan bir geometri için
DRT'yi rahatsız eder. Ölçümde görülüyor: sahipsiz bayraklı koşumda DRT
**16 iterasyonda**, temizinde **8 iterasyonda** yakınsıyor.

### B. DÜZELTME ÖLÇÜLDÜ — anten −%23,8, hiçbir bedel yok

`repair_antennas -jumper_only` resizer'ın **çıktısı** üzerinde koşuldu, sahipsiz
bayraklar temizlendi, sonra DRT tek kez koşuldu
(`ant4_postresizer_jumper_met4`). Ardından bu satırın yazarı zinciri
RCX + 9 köşe STA'ya kadar sürdürdü (`run/jumper_sta40`):

| Metrik | `final40c` | jumper | Δ |
|---|---:|---:|---|
| **Anten ihlalli net** | **1.935** | **1.474** | **−461 (−%23,8)** |
| **Anten ihlalli pin** | **2.364** | **1.870** | **−494 (−%20,9)** |
| Yollama DRC | 0 | **0** | = (ikisi de iter:8) |
| Setup WS (max_ss) | 6,3149 | **6,4294** | **+0,1145 ns** |
| Hold WS (min_ff) | 0,0570 | **0,0576** | +0,0006 ns |
| Setup / hold ihlal | 0 / 0 | **0 / 0** | = |
| Max slew | 991 | 990 | −1 |
| Max cap | 589 | 594 | +5 |
| Toplam tel | 10.192.713 | 10.194.298 | +1.585 µm (+%0,016) |
| Eklenen hücre | — | **0** | `antenna_diodes_count: 0` |
| stdcell / timing_repair_buffer | 264.845 / 49.471 | 264.845 / 49.471 | **birebir aynı** |

Yani hücre eklenmiyor, tel %0,016 artıyor, zamanlama **iyileşiyor**.
Tek gerileme max_cap'te +5 (yumuşak metrik, zorunlu-sıfır listesinde değil).

Soy zinciri doğrulaması: exp2'nin ODB'si `ant4_grt_jumper_final40c`'nin resizer
çıktısından türüyor; o resizer'ın ürettiği netlist `final40c` ile **birebir
aynıdır** (264.845 stdcell / 49.471 timing_repair_buffer), dolayısıyla
karşılaştırma geçerlidir.

**AÇIK KALAN:** Magic DRC / KLayout DRC / LVS / XOR henüz koşulmadı. Jumper
fazladan via demektir; via yoğunluğu/aralığı DRC riski gerçektir.

**UYGULAMA SORUNU:** `run_flow.py` başlığındaki kural gereği özel akış/adım
yoktur (`Flow.factory.get("Classic")`). Adım sırası LibreLane'de sabit olduğu
için bu kazanç stok akışla doğrudan alınamaz. Seçenekler takım kararına açık.

### C. 30 MHz KAPANIYOR — ölçüldü

bagimsiz denetim, `final40c`'nin **gerçek yollanmış veritabanı ve gerçek RCX
parazitikleriyle** yalnız SDC periyodunu değiştirip 9 köşe STA koştu:

| Periyot | Frekans | Setup WS | Setup ihlal | Hold WS | Hold ihlal |
|---:|---:|---:|---:|---:|---:|
| 40 ns | 25,00 MHz | +6,3149 | 0 | +0,0570 | 0 |
| 36 ns | 27,78 MHz | **+3,0717** | **0** | +0,0570 | **0** |
| 33,333 ns | **30,00 MHz** | **+0,4051** | **0** | +0,0570 | **0** |

30 MHz'de marj +0,4051 ns (periyodun %1,2'si) — ince ama pozitif ve dokuz
köşenin hepsinde temiz. Bu ölçüm, bu oturumda bağımsız olarak bulunan
"30 MHz'i sınırlayan yol ALU bölücüsüdür" tespitiyle sayısal olarak örtüşüyor.

**DİKKAT:** 30 MHz'i beyan etmek yeniden koşum gerektirir; periyot yalnız SDC'de
değil, I2C bölücü parametresinde ve firmware `UART_CPB`'sinde de gömülüdür
(ikisi de artık parametrik). Bu ölçüm "fiziksel gerçekleme tarzı 30 MHz'i
kaldırıyor" der, "mevcut GDS 30 MHz'dir" demez.

### D. NEGATİF SONUÇ — hold marjı 0,45'ten indirilemez

`GRT_RESIZER_HOLD_SLACK_MARGIN` süpürmesi (bagimsiz denetim, `opt3_hold_m*_sta40`):

| Marj | Hold WS | Hold ihlal | stdcell | Anten net (DRT sonrasi) |
|---:|---:|---:|---:|---:|
| 0,45 (mevcut) | **+0,0570** | **0** | 264.845 | 1.935 |
| 0,08 | −0,0222 | **9** | 253.705 | (olculmedi) |
| 0,06 | −0,0172 | **8** | — | (olculmedi) |
| 0,05 | −0,0636 | **28** | **252.397** | 2.024 |

Uc nokta da hold ihlali uretiyor; **0,45 bu haliyle korunmalidir.**

**DUZELTME (2026-09-02, bu satirin yazari):** ilk kayitta bu kosumlarin anten
sayisi 2.509 yazilmisti. 2.509, `final40c`'nin **DRT ONCESI** GRT tabanli
kontrolunun degeridir (adim 40); DRT sonrasi karsiligi 1.935'tir (adim 47).
bagimsiz denetimin kosumlarinda `final/metrics.json` bu pre-DRT degeri tasiyor.
Gercek DRT sonrasi sayi yalniz `opt3_hold_m005_ant` icinde var: **2.024**.
Yani dogru karsilastirma 1.935 -> 2.024'tur (+89), 1.935 -> 2.509 degil.

**ASIL BULGU BU SUPURMEDE DEGIL, HUCRE SAYISINDA:** marj 0,45 -> 0,05
stdcell'i 264.845 -> 252.397'ye indiriyor, **-12.448 hucre (-%4,7)**.
Yani hold marji bu tasarimdaki en buyuk alan kaldiracidir.
**0,10-0,40 araligi HIC OLCULMEDI** -- 0,08 ile 0,45 arasinda dokuz kat fark var.

### B-devam. Jumper varyantı TAM SIGNOFF'tan geçti

`run/jumper_sta40` zinciri `Checker.LVS`'e kadar sürdürüldü (25 adım):

| Kontrol | `final40c` | jumper |
|---|---:|---:|
| `route__drc_errors` | 0 | **0** |
| `magic__drc_error__count` | 0 | **0** |
| `klayout__drc_error__count` | 0 | **0** |
| `design__lvs_error__count` (+5 alt sayaç) | 0 | **0** |
| `design__xor_difference__count` | 0 | **0** |
| Magic illegal overlap | 0 | **0** |
| `design__power_grid_violation__count` | 0 | **0** |
| setup / hold ihlal | 0 / 0 | **0 / 0** |
| **anten net / pin** | 1.935 / 2.364 | **1.474 / 1.870** |

Magic loglarındaki "Error while reading cell" mesajları baseline'da da vardır
(final40c: streamout bbox 268+286, writelef 198, magic-drc 518) — SRAM soyut
görünümlerinden gelen bilinen gürültüdür, gerileme değildir.

**SONUÇ: anten −%23,8 kazancı bedelsizdir.** 16 zorunlu-sıfır metriğin hepsi
sıfır kalıyor, setup +0,1145 ns iyileşiyor, hücre eklenmiyor.
Tek engel akış sırası (bkz. A); paketleme yöntemi takım kararına açık.

### E. YENİ ÖLÇÜM — post-GRT resizer'ın gerçek maliyeti

`final40c` adım adım hücre sayısı:

| Adım | stdcell | Δ |
|---|---:|---:|
| 32 `RepairDesignPostGPL` | 244.565 | — |
| 39 `GlobalRouting` | 245.780 | +1.215 |
| 41 `RepairDesignPostGRT` | 248.117 | +2.337 |
| **43 `ResizerTimingPostGRT`** | **264.845** | **+16.728** |

Tek adım tasarımın **%6,8'ini** ekliyor. `GRT_RESIZER_SETUP_SLACK_MARGIN: 10`
ve `CLOCK_PERIOD: 40` olduğu için bu adım fiilen **30 ns'i hedefliyor**;
ulaştığı 33,69 ns (setup WS +6,3149). Yani ulaşamadığı bir hedef için
16.728 hücre harcıyor.

`config.yaml:638` bu marjin `LAYERS_RC` sonrasi yeniden olculecegini yaziyor
ama **olcum hic yapilmadi**. Periyot 33,333 olup marj 10 kalirsa arac
23,333 ns'i hedefler, bolucu yolu ise ~32,93 ns'dir (9,6 ns otede) -- yani
30 MHz'e gecisin on sartidir.

**ANCAK ATIF DUZELTMESI (DEF'ten sayildi):** bu +16.728 hucre setup marjindan
DEGIL, **hold onarimindan** geliyor. Adim 43'un DEF histogrami:

| Hucre | 41-repairdesign | 43-resizertiming | Δ |
|---|---:|---:|---:|
| **`sky130_fd_sc_hd__dlygate4sd3_1`** | **87** | **16.452** | **+16.365** |
| `buf_4` | 10.823 | 11.661 | +838 |
| `buf_2` | 4.844 | 4.044 | −800 |
| (diger ~60 tip) | | | net +325 |
| **toplam** | 255.808 | 272.536 | **+16.728** |

OpenROAD logu "Inserted 73 buffers" (setup) ve "Inserted 174 hold buffers"
diyor; **gecikme hucrelerini bu sayaclara yazmiyor.** Yani setup onarimi
gercekte yalniz 73 tampon + 1.107 boyutlandirma ekliyor, alan etkisi %0,1.
Tasarimin %6'si (16.365 `dlygate4sd3_1`) sadece hold icin var ve bu
`GRT_RESIZER_HOLD_SLACK_MARGIN: 0.45` degerinin dogrudan bedeli.

Bu, D maddesindeki stdcell olcumuyle ortusuyor: marj 0,05'te stdcell 252.397
(-12.448). **Alan ve anten icin asil kaldirac setup marji degil, hold marjidir.**

---

## 2026-09-02 — `GRT_RESIZER_SETUP_SLACK_MARGIN` 10 -> 2 (tam olcum, `run/margin2`)

`final40c`'nin adim 42 durumundan zincirlendi (`--from OpenROAD.ResizerTimingPostGRT
--to OpenROAD.STAPostPNR`), yani TEK degisken setup marjidir. 14 adim, DRT + RCX +
9 kose STA dahil.

| Metrik | marj 10 (`final40c`) | marj 2 (`margin2`) | Δ |
|---|---:|---:|---|
| **Setup WS** (max_ss) | **+6,3149** | **+3,6179** | **−2,6970 ns** |
| **Hold WS** (min_ff) | **+0,0570** | **+0,3579** | **+0,3009 ns (6,3 kat)** |
| Setup / hold ihlal | 0 / 0 | **0 / 0** | = |
| Yollama DRC | 0 | **0** | = |
| Anten net / pin | 1.935 / 2.364 | 1.951 / 2.377 | +16 / +13 |
| Toplam tel | 10.192.713 | 10.186.032 | −6.681 µm |
| stdcell | 264.845 | 264.952 | **+107** |
| stdcell alani | 1.497.830 µm² | 1.496.440 µm² | −1.390 (−%0,09) |
| `dlygate4sd3_1` | 16.452 | 16.681 | +229 |
| Setup onarim isi | 73 tampon + 1.107 boyutlandirma | **10 tampon + 34 boyutlandirma** | −%86 |

### Sonuc 1: Bu bir ALAN kaldiraci DEGIL

Setup onarim isi %86 azalmasina ragmen hucre sayisi **artiyor** (+107) ve alan
yalniz %0,09 dusuyor. Mekanizma: setup tamponlari veri yolunu YAVASLATTIGI icin
dolayli olarak hold'a da yardim ediyor. Onlar cekilince hold onarimi 229 gecikme
hucresi daha koyuyor ve iki etki birbirini yiyor. Alan kaldiraci setup marjinda
degil, hold marjindadir (bkz. D maddesi: 0,45 -> 0,05 = −12.448 hucre).

### Sonuc 2: Bu bir SETUP <-> HOLD TAKAS dugmesi

Olculen takas orani: **1 ns setup ~ 0,11 ns hold.**

| Marj | Setup WS | Hold WS |
|---:|---:|---:|
| 10 | +6,3149 | +0,0570 |
| 2 | +3,6179 | +0,3579 |

Daha fazla setup tamponu -> daha hizli veri yolu -> daha kotu hold. Tersi de dogru.

### Sonuc 3: 30 MHz icin marj 10 KORUNMALI

Onceki tahmin ("periyot 33,333'te marj 10 arac 23,333'u hedefler, bosuna ogutur")
**bu olcumle curudu**: 40 ns'de marj 10 zaten ulasilamayan bir hedefe (30 ns)
nisan aliyordu ve maliyeti yalniz 73 tampon + 1.107 boyutlandirma, yani %0,1 alan.
Ogutme diye bir bedel yok.

Buna karsilik marj 2'nin setup bedeli **2,70 ns**'dir. 30 MHz'de elde yalniz
+0,4051 ns oldugu icin marj 2 ile 33,333 ns **kapanmaz**.

**Karar: 30 MHz denemesinde `GRT_RESIZER_SETUP_SLACK_MARGIN: 10` degismeyecek.**

### Ne zaman ise yarar

Hold baglayici hale gelirse (su an +0,0570 ns ile jilet gibi) setup marjini
dusurmek hold'u 6,3 kat rahatlatan **olculmus** bir caredir. 40 ns'de kalinacaksa
marj 2 daha saglam bir paket verir: hold +0,3579, setup hala +3,6179, DRC 0,
tel −6.681 µm. Frekans ile hold saglamligini takas etme karari takimindir.

---

## 2026-09-02 — 30 MHz'e gecis (`CLOCK_PERIOD: 40 -> 33,333333`)

Kullanici karari: alan dali kapatildi (risk/emek getiriye degmiyor), tek hedef
**hatasiz, uretilebilir, 30 MHz**.

### Turetilen sabitler dogrulandi

| | 25 MHz | 30 MHz |
|---|---|---|
| I2C `HALF_BASE` / `HALF_REM` | 31 / 200.000 | **37 / 400.000** |
| I2C ortalama yari-periyot | 31,2500 | **37,5000** |
| **SCL** | 400.000,0 Hz | **400.000,0 Hz (tam)** |
| UART `CPB` | 217 | **260** |
| Gercek baud | 115.207,4 (+%0,006) | **115.384,6 (+%0,160)** |

Ust modulde override dogrulandi:
`I2C_Master_AXI4_Lite #(.CLK_FREQ_HZ(30000000))` (`Top_module_asic.sv:965`).

### 5/5 regresyon 30 MHz'de GECTI

`collision`, `instr_collision`, `mem`, `boot`, `yz` — hepsi BASARILI,
AXI protokol kontrolcusu her arayuzde ihlal 0. Boot testi otomatik yamalanmis
`boot_test_asic_cpb.sv` ile kosuldu (CPB config'ten turetiliyor).

### BULUNAN AKIS HATASI — bayat firmware sessizce kapilardan geciyordu

`make prepare` yalnizca `roms vendor filelist keepout` kosuyordu. `gen_rom.py`
mevcut `.hex`'ten `.sv` uretir; firmware'i DERLEMEZ. `UART_CPB` ise derleme
zamaninda `-DSYS_CLK_HZ` ile donar. Sonuc:

* `patch_rtl.py`'nin config.yaml <-> `FPGA/firmware/Makefile` capraz kontrolu
  **gecer** (iki dosya da elle guncellenmis olur),
* `gen_rom.py --all --check` **"guncel"** der (ROM ile hex tutarlidir),
* ama ROM'un ICINDEKI CPB bir onceki frekansa aittir.

25 -> 30 MHz gecisinde tam bu yasandi: `make prepare` sorunsuz gecti, ama
`asic_boot.hex` hala `0d900713` = `addi a4,x0,217` (25 MHz) tasiyordu.
Elle `make -C FPGA/firmware asic_*` kosulunca `10400713` = `addi a4,x0,260`
oldu.

**Duzeltme:** `asic/Makefile`'a `firmware` hedefi eklendi ve
`prepare: vendor firmware roms filelist keepout` yapildi. `ASIC_CLK_HZ`
override EDILMEZ — `FPGA/firmware/Makefile`'daki deger tek beyan noktasi olarak
kalir ve `patch_rtl.py` onu config.yaml ile karsilastirmaya devam eder, yani
cift yonlu kapi korunur. RISC-V derleyicisi nix ortaminda mevcut
(`/opt/riscv/current/bin/riscv-none-elf-gcc`), dolayisiyla `make asic_run`
zinciri bozulmuyor.

### Kosum yapisi

Faz 1: `--tag final30 --overwrite --to OpenROAD.ResizerTimingPostGRT`
Faz 2: `--tag final30 --from OpenROAD.RepairAntennas
        --config config.yaml --config experiments/antenna_jumper.yaml
        --initial-state run/final30/<43>/state_out.json`   (`--overwrite` YOK)

Faz 2 overlay'i anten jumper'ini resizer'in CIKTISI uzerinde ekler; gerekcesi
ve olculen kazanci `experiments/antenna_jumper.yaml` basliginda.

---

## final30 tam signoff sonucu ve Fmax olcumu (2026-09-03, bagimsiz denetim)

### 1. `run/final30` tamamlandi (78 adim, "Flow complete.")

Fiziksel signoff **temiz**, zamanlama **DUSTU**:

| Metrik | Deger |
|---|---:|
| Yollama DRC / Magic DRC / KLayout DRC | 0 / 0 / 0 |
| LVS (6 sayac) / XOR / illegal overlap / PDN | 0 |
| Hold WS (min_ff_n40C_1v95) | **+0,0726 ns**, 9 kosede 0 ihlal |
| **Setup WS (max_ss_100C_1v60)** | **−2,0116 ns** |
| Setup ihlalli uc | **1.169** (ss koselerinde: 460 / 416 / 293) |
| Setup TNS (max_ss) | −494,33 ns |
| Anten net / pin | 1.441 / 1.847 |
| Max slew / max cap (max_ss) | 949 / 584 |
| stdcell / tel | 264.984 / 10.203.893 um |

### 2. DOGRULANMIS DOGRUSAL SLACK MODELI (yeni)

Sabit bir netlist + sabit bir rota uzerinde slack periyoda **birebir dogrusal**
bagli. Iki yol sinifi ayri egime sahip:

* tam cevrimli yol: `slack(T) = slack(T0) + (T − T0)`
* yarim cevrimli (SRAM `falling_edge` `dout`) yol: `slack(T) = slack(T0) + (T − T0)/2`

Model `final40c` veritabaninda UC noktada dogrulandi (hepsi ayni DB, yalniz SDC
periyodu degisti):

| T | olculen WS (max_ss) | modelin verdigi | fark |
|---:|---:|---:|---:|
| 40 ns | +6,3149 (yarim cevrim baglayici) | — (referans) | — |
| 36 ns | +3,0717 | +3,072 (tam cevrim) | **0,000** |
| 33,3333 ns | +0,4051 | +0,405 (tam cevrim) | **0,000** |

Yani sifir-slack noktasi STA kosmadan hesaplanabilir. Yol sinifi basina en kotu
slack `57-openroad-stapostpnr/<kose>/max.rpt` icindeki her yolun yakalama-kenari
zamani ayristirilarak cikarildi.

### 3. IKI GERCEKLEMENIN OLCULEN Fmax'i

max_ss_100C_1v60 kosesinde tam cevrimli yolun sifir gectigi periyot:

| Gerceklem | hedef T | tam cevrim WS | **T0 (sifir slack)** | Fmax |
|---|---:|---:|---:|---:|
| `final40c` (+ `jumper_sta40`) | 40 ns | +0,4051 @ 33,3333 | **32,93 ns** | **30,37 MHz** |
| `final30` | 33,3333 ns | −2,0116 @ 33,3333 | **35,35 ns** | **28,29 MHz** |

`final30`'un yarim cevrimli sinifi T0'da +2,91 ns'dedir, yani baglayici degil.

**BEKLENMEDIK SONUC:** 25 MHz hedefiyle kosulan `final40c`, 30 MHz hedefiyle
kosulan `final30`'dan **2,42 ns DAHA HIZLI** bir fiziksel gerceklemedir. Iki
kosum yapisal olarak neredeyse ayni tasarimdir:

| | final40c | final30 |
|---|---:|---:|
| stdcell | 264.845 | 264.984 (+139) |
| sequential | 9.312 | 9.311 |
| kombinasyonel | 58.565 | 58.399 |
| yollanmis tel | 10.192.713 um | 10.203.893 um (+%0,11) |
| setup tamponu | 73 | 237 |

Netlist farki yalniz frekansa bagli sabitlerden gelir (boot ROM icerigi +
I2C bolucusu). Yani **kosumdan kosuma dagilim ~2,4 ns mertebesindedir** ve
beyan edilecek frekans bu dagilimi karsilayacak paya sahip olmalidir.

### 4. RESIZER TAHMINI <-> SIGNOFF BOSLUGU OLCULDU: ~8-9 ns

`43-openroad-resizertimingpostgrt` logundaki WNS sutunu marj-duzeltilmis
slack'tir (`gercek = WNS + GRT_RESIZER_SETUP_SLACK_MARGIN`):

| Kosum | resizer baslangic WNS | resizer bitis WNS | tahmini gercek slack | signoff nom_ss | **BOSLUK** |
|---|---:|---:|---:|---:|---:|
| final40c (T=40) | −1,462 | **+5,730** | +15,73 | +6,4747 | **9,26 ns** |
| final30 (T=33,33) | −7,132 | **−3,312** | +6,688 | −1,5145 | **8,20 ns** |

Ikisinde de `[WARNING RSZ-0062] Unable to repair all setup violations` var;
final30'da 2.205 uc onarilamadan kaldi. Tampon butcesi (`-max_buffer_percent 50`
= ~132.000 tampon) DOLMADI — yalnizca 237 tampon + 785 boyutlandirma yapildi,
yani resizer butceden degil **ilerleyememekten** durdu.

**Bu, `GRT_RESIZER_SETUP_SLACK_MARGIN: 10` degerinin neden calistigini
aciklar.** config.yaml yorumu onu "kor bir yama" diye niteliyordu; olcum
gosteriyor ki **dogru buyuklukte** bir yamadir: sistematik iyimserlik 8-9 ns,
marj 10 ns. Marj 2 denemesinin (`run/margin2`) neden setup'tan 2,70 ns
goturdugu de bundan anlasiliyor.

Kalibrasyonun tt kosesinde DOGRU oldugu ayrica olculdu:
`45-openroad-stamidpnr-3` (tahmini RC) nom_tt = +8,9725, signoff nom_tt =
+9,0823 -> fark yalnizca **0,11 ns**. Yani iyimserlik tt'de yok, ss'te 8,2 ns.
Uyari: iki kosede BAGLAYICI YOL AYNI DEGIL (tt'de yarim cevrimli SRAM yolu,
ss'te tam cevrimli mantik yolu), bu yuzden "hata ss'e ozgudur" cikarimi
**SUPHELIDIR** ve dogrulanmasi 9 koseli bir tahmini-RC STA'si gerektirir.

### 5. KRITIK YOLUN AYRISTIRMASI (final30, max_ss)

`_125848_` (id_stage decoder, `instr_rdata_i[18]`) -> `_124632_/D`:

| bilesen | deger |
|---|---:|
| launch saat gecikmesi | 6,3019 ns |
| capture saat gecikmesi | 5,7065 ns (skew **−0,5954 ns**, setup'a ZARARLI) |
| veri yolu (CQ + kombinasyonel) | **34,4449 ns** |
| CRPR kredisi | +0,1845 |
| saat belirsizligi | −0,25 |
| kutuphane setup | −0,2392 |
| **slack** | **−2,0116** |

Veri yolundaki 84 hucrenin dagilimi:

| sinif | adet | gecikme | pay |
|---|---:|---:|---:|
| **resizer tamponu** (`wire*`,`load_slew*`,`fanout*`,`max_cap*`) | **39** | **9,521 ns** | **%28** |
| gercek mantik | 45 | 24,532 ns | %72 |

En sik hucre `buf_12` (27 adet). Yani kritik yolun ucte biri **uzun tel
tekrarlayicisi**; mantik derinligi de 45 ile yuksek.

**DEVIR NOTU §7.2 DUZELTILMELIDIR.** Orada 30 MHz'in sinirlayicisi
`alu_i.alu_div_i.RemSel_SP` deniyor; o, `final40c` veritabani uzerinde SDC
yeniden analiziyle bulunmustu. TAZE `final30` kosumunda en kotu yol **ALU
bolucusu degil**, komut kod cozucusunden cikan bir yoldur.

### 6. BEYAN EDILEBILIR FREKANS TABLOSU (final30 gerceklemesi, model)

| f | T | tam cevrim WS | yarim cevrim WS | beklenen WS |
|---:|---:|---:|---:|---:|
| 28,29 MHz | 35,345 ns | 0,000 | +2,907 | **0** (sinir) |
| 28 MHz | 35,7143 ns | +0,369 | +3,091 | +0,369 |
| 27 MHz | 37,0370 ns | +1,692 | +3,753 | +1,692 |
| 26 MHz | 38,4615 ns | +3,117 | +4,466 | +3,117 |

Bu sayilar **mevcut** gerceklemenin sayilaridir; taze bir kosum ~2,4 ns
dagilim gosterebilir (bkz. §3). Beyan icin taze kosumun kendi
`metrics.json`'u esas alinacaktir.

---

## Akis/yapilandirma denetimi (2026-09-03, statik analiz)

Kaynak: LibreLane 3.0.6 kaynak agaci
`/nix/store/fg4z2q3h3rf8k60ix8y8b0hdpn9c1nsa-source/librelane`.

### D1. Signoff kapilari KOSE-FILTRELI — setup yalniz `*tt*`'de durduruyor

`run/final30/resolved.json`:

| degisken | etkin deger | kaynak |
|---|---|---|
| `TIMING_VIOLATION_CORNERS` | `["*tt*"]` | `config/pdk_compat.py:316` |
| `SETUP_VIOLATION_CORNERS` | `None` -> `*tt*`'ye duser | `steps/checker.py:532-540` |
| `HOLD_VIOLATION_CORNERS` | `["*"]` | `checker.py:683` `corner_override` |
| `MAX_SLEW_VIOLATION_CORNERS` | `[""]` = **hicbir kose** | `checker.py:672` |
| `MAX_CAP_VIOLATION_CORNERS` | `[""]` = **hicbir kose** | `checker.py:661` |

Sonuc, `final30` flow.log'unda birebir gorulur:

```
Running 'Checker.SetupViolations' ...
Setup violations found in the following corners:
* max_ss_100C_1v60
* min_ss_100C_1v60
* nom_ss_100C_1v60
No setup violations found          <-- akis DEVAM ETTI
```

1.169 setup ihlaline ragmen akis "Flow complete." ile bitti. Hold butun
koselerde kapili, setup yalniz tt'de, slew/cap hicbir kosede.

**Bu bir esik gevsetmesi degildir** (kimse degistirmemis, LibreLane/PDK
varsayilani boyle), ama teslim kapisi olarak GUVENILMEZ. `config.yaml`'a
`SETUP_VIOLATION_CORNERS: ["*"]` eklenmesi kapiyi SIKILASTIRIR — sartname
Bolum 1.1'in yasakladigi yon degil, tam tersi yondur.

Yan bilgi: `MetricChecker.deferred = True` (varsayilan) ve
`flows/sequential.py:389,401-409` deferred hatalari **toplayip `final/`
goruntuleri KAYDETTIKTEN SONRA** firlatir. Yani DEVIR notu Bolum 9'daki
*"ERROR_ON_TR_DRC: true iken tek ihlalde akis orada olur ve hicbir cikti
uretilmez"* ifadesi **YANLISTIR**; `Checker.TrDRC` de deferred'dir, akis
sonuna kadar kosar ve ciktilar uretilir.

### D2. `make asic_run` teslim edilen paketi YENIDEN URETMIYOR

`Makefile:asic_run` -> `run_flow.py --tag rtl2gds --overwrite` = **tek fazli**
kosum. `config.yaml`'da `RUN_ANTENNA_REPAIR: false` oldugu icin bu kosumda
`OpenROAD.RepairAntennas` HIC kosmaz. Anten jumper kazanci (1.935 -> 1.441 net)
yalnizca elle baslatilan 2. fazda (`experiments/antenna_jumper.yaml`) elde
edilir. Sartnamenin zorunlu hedefi teslim edilen sonucu uretmiyor.

### D3. Iki fazli kosum, teslim denetleyicisinin UC kapisini birden bozuyor

`scripts/verify_deliverables.py`:

1. `verify_provenance` -> `flow.log tek temiz kosum degil: Starting sayisi=2`.
   Olculdu: `final40c` = 1, `final30` = **2**, `jumper_sta40` = **2**.
2. `PROVENANCE_CONFIG_KEYS` icinde `RUN_ANTENNA_REPAIR` ve
   `RUN_POST_GRT_RESIZER_TIMING` var; 2. faz overlay'i ikisini de ters cevirdigi
   icin `config/resolved uyusmazligi` hatasi uretilir.
3. `REQUIRED_ZERO_METRICS` icinde `antenna__violating__nets` ve
   `..._pins` var; tasarimda 1.441/1.847 oldugu icin bu kapi zaten
   "SIGNOFF SONUCLARI TEMIZ DEGIL" veriyor (cikis kodu 1).

### D4. config.yaml anahtar denetimi: TEMIZ

73 anahtarin tamami LibreLane 3.0.6'da tanimli; deprecated isim yok, Classic
akista bulunmayan adima ait anahtar yok. `RUN_POST_GRT_DESIGN_REPAIR`,
`RUN_POST_GRT_RESIZER_TIMING`, `RUN_ANTENNA_REPAIR` adim adima degil
**akis seviyesinde** tanimlidir (`flows/classic.py:139,159,172,271-278`).

`MAX_TRANSITION_CONSTRAINT: 0,75` ve `MAX_CAPACITANCE_CONSTRAINT: 0,2`
config.yaml'da DEGIL, PDK'dan gelir
(`sky130A/libs.tech/openlane/sky130_fd_sc_hd/config.tcl:63-65`). DEVIR notu
Bolum 2'de "takim karariyla korunuyor" denmis; aslinda hic dokunulmamis
kutuphane varsayilanidir.

### D5. config.yaml yorumlari BAYAT (sartname Bolum 9.13 riski)

| satir | yorum ne diyor | gercek |
|---|---|---|
| ~186 | "mevcut fiziksel gerceklemenin kendisi 30 MHz'i **ZATEN karsiliyor**" | taze `final30` kosumu −2,0116 ns ile DUSTU |
| 465-497 | `RUN_ANTENNA_REPAIR` gerekcesi: "anten onarimi DRT'yi yakinsamaz yapiyor", "3.181 net / 4.874 pin, 14 yollama DRC" | jumper-only iki fazli cozum olculdu ve CALISIYOR: 1.441 net, DRC 0 |

### D6. Bayatlik kapilari calisiyor (test edildi)

`patch_rtl.py --check` (12 dosya / 61 degisiklik), `gen_rom.py --all --check`
(3 ROM), `gen_macro_keepout.py --check` ucu de gecti (rc=0).
`asic_boot.hex` icinde `10400713` = `addi a4,x0,260` bulundu, yani derlenmis
firmware 30 MHz'e ait. `patch_rtl.py:78-88` config.yaml `CLOCK_PERIOD` ile
`FPGA/firmware/Makefile` `ASIC_CLK_HZ` arasinda SERT bir capraz kapi tutuyor.

**Kalan delik:** `verify_generated` derlenmis `.hex`'in ICINDEKI frekans
sabitini dogrulamiyor; yalnizca hex->sv tutarliligini bakiyor. `make prepare`
artik firmware'i derledigi icin normal akista delik kapali, ama yalniz
`make asic_verify` kosuldugunda bayat hex yakalanmaz.

### D7. Regresyon kor noktasi dogrulandi

`scripts/run_asic_sim.py` senaryolari: `collision`, `instr_collision`, `mem`,
`boot`, `yz`. **I2C, Timer ve GPIO icin yonlendirilmis senaryo YOK.** QSPI
yalniz `boot` senaryosunda Micron flash modeliyle dolayli olarak surulur.
DEVIR notu Bolum 7.5 dogrudur.

### D8. README frekans beyanlari elle bakimli

`gen_readme_results.py` yalnizca `<!-- SONUC-OZETI-BASI -->` ..
`<!-- SONUC-OZETI-SONU -->` blogunu (README satir 1405-1490) yeniden uretir.
README'de "25 MHz" 12 kez, "40 ns" 16 kez elle yazilmis metinde geciyor;
frekans degisirse hepsi elle guncellenmelidir.

---

## 2026-09-03 — Bagimsiz denetim #2: statik tarama + kritik yol ayristirmasi

Bu bolum YALNIZ okuma/statik analiz ve mevcut rapor dosyalarindan cikarilan
olcumleri icerir; yeni bir agir kosum baslatilmamistir.

### 1. `run/final30` tamamlandi ve DUSTU — bagimsiz dogrulama

Onceki oturumun 28,29 MHz Fmax hesabi BAGIMSIZ olarak yeniden turetildi ve
birebir dogrulandi. `57-openroad-stapostpnr/max_ss_100C_1v60/max.rpt` icindeki
2.000 yol blogu ayristirildi:

| Olcum | Deger |
|---|---:|
| negatif slack'li yol | **460** |
| bunlarin yarim-cevrimli olani | **0** (hepsi tam cevrim) |
| en kotu slack | −2,0116 ns |
| **sifir-slack periyodu** | **35,345 ns → 28,293 MHz** |

Yarim cevrimli yol sinifinin sifir olmasi §7.1'i (veri RAM'i yarim-cevrim
yolu) 30 MHz icin **BAGLAYICI OLMAKTAN CIKARIR** — o yollarin hicbiri ihlal
etmiyor. Veri RAM'ine SRAM kayit kademesi yamasi 30 MHz icin GEREKSIZDIR.

### 2. KRITIK YOL DEGISTI — §7.2 artik gecerli degil

Teslim notu §7.2 ve config.yaml yorumu 33,333 ns'de kritik yolu
`ex_stage_i.alu_i.alu_div_i.RemSel_SP` (ALU bolucusu) diye veriyor. Bu, ESKI
veritabani (`final40c`) uzerinde yalniz SDC degistirilerek yapilan yeniden
analize aittir. TAZE `final30` kosumunda kritik yol BASKADIR:

    _125848_/Q  cpu_inst.CORE.core_i.id_stage_i.decoder_i.instr_rdata_i[18]
      -> 83 kademe ->
    _124632_/D  cpu_inst.CORE.core_i.alu_operand_a_ex[3]

Yani ID kademesi komut yazmaci → rs1 adresi → register-file okuma mux'i →
forwarding → ID/EX ALU operand yazmaci. ALU bolucusu DEGIL.

### 3. KRITIK YOLUN AYRISTIRILMASI (yeni olcum)

83 kademelik veri yolu, kademe adlarina gore siniflandirildi
(resizer tekrarlayicilari `wire*`, `load_slew*`, `fanout*`, `max_cap*`,
`rebuffer*` onekleriyle adlandirilir):

| Sinif | Kademe | Toplam gecikme | Ekleyen |
|---|---:|---:|---|
| **GERCEK MANTIK** | **44** | **23,618 ns** | sentez |
| `wire*` | 18 | 4,708 ns | repair_design (tel uzunlugu) |
| `load_slew*` | 10 | 2,335 ns | repair_design (max slew) |
| `fanout*` | 5 | 1,161 ns | repair_design (max fanout) |
| `rebuffer*` | 4 | 0,749 ns | repair_timing |
| `max_cap*` | 2 | 0,567 ns | repair_design (max cap) |
| **tekrarlayici TOPLAM** | **39** | **9,521 ns** | |

Yani gecikmenin **%29'u** sentezin urettigi mantik degil, fiziksel onarim
tamponudur. Bu iki ayri kaldirac demektir: mantik derinligi (sentez) ve
tel uzunlugu (yerlestirme).

ABC taban netlistinin bildirdigi mantik derinligi (`06-yosys-synthesis/
yosys-synthesis.log` son satiri): **`lev = 46`**, `area = 555889.79`.

### 4. `MAX_TRANSITION_CONSTRAINT` config.yaml'DAN GELMIYOR — atif duzeltmesi

Teslim notu §2.2 bunu "takim karariyla korunuyor" diye anlatiyor.
Olcum: config.yaml'da bu anahtar **YOKTUR**. Etkin 0,75 ns degeri PDK'nin
kendi dosyasindan gelir:

    pdk/ciel/sky130/versions/8afc.../sky130A/libs.tech/openlane/
      sky130_fd_sc_hd/config.tcl:63 -> set ::env(MAX_TRANSITION_CONSTRAINT) 0.75

LibreLane tanimina gore (config/flow.py:205-211) deger verilmezse periyodun
%10'u alinir, PDK'nin `DEFAULT_MAX_TRAN` degerini asarsa oraya kirpilir.
Sonuc ayni (dokunulmaz), ama gerekce "takim karari" degil "PDK varsayilani".

### 5. SIGNOFF KOR NOKTASI — checker'lar sanildigi kadar zorlayici degil

`librelane/steps/checker.py` okundu ve `run/final30/resolved.json` ile
dogrulandi:

| Checker | Etkin kose listesi | Akisi DUSURUR MU? |
|---|---|---|
| `Checker.HoldViolations` | `['*']` | **EVET**, 9 kosede |
| `Checker.SetupViolations` | `TIMING_VIOLATION_CORNERS = ['*tt*']` | yalniz **tt** koselerinde |
| `Checker.MaxSlewViolations` | `['']` | **HAYIR, HICBIR ZAMAN** |
| `Checker.MaxCapViolations` | `['']` | **HAYIR, HICBIR ZAMAN** |

`checker.py:531-538` `get_corner_wildcards()` bos joker `''`i eleyince
eslesen kose kumesi bosalir; `err_violating_corner` hep bos kalir.

**KANIT:** `run/final30` ss koselerinde 1.169 setup ihlaliyle
"Flow complete." dedi ve 78 adimin tamamini tamamladi. Yani
**"akis gecti" ≠ "zamanlama kapandi".** Zamanlama daima
`final/metrics.json` icindeki `timing__setup_vio__count` ve
`timing__setup__ws__corner:*` alanlarindan okunmalidir.

### 6. `final40c` max-slew ihlallerinin 20'si KUTUPHANE LIMITINI DE ASIYOR

README §4 991 max-slew ihlalini "uygulanan esik 0,75 ns; kutuphanenin
kendi `default_max_transition` degeri 1,5" diye cerceveliyor. Olcum
(`56-openroad-stapostpnr/max_ss_100C_1v60/checks.rpt` ayristirildi):

| Esik | Asan pin sayisi |
|---|---:|
| > 0,75 ns (uygulanan) | 991 |
| > 1,00 ns | 58 |
| **> 1,50 ns (kutuphane limiti)** | **20** |

En kotu 8: `clkbuf_leaf_1_clk_i/A` 2,339 · `clkbuf_leaf_0_clk_i/A` 2,320 ·
`clkbuf_leaf_6_clk_i/A` 2,315 · `clkbuf_leaf_7_clk_i/A` 2,312 ·
`clkbuf_leaf_8_clk_i/A` 2,310 · `QSPI_IO3` 2,308 ·
`clkbuf_1_0_1_clk_i/X` 2,289 · `QSPI_IO1` 2,267.

En kotuleri **saat agaci yaprak tamponlarinin girisleridir**. Kutuphane
karakterizasyon araligi disinda kalan bir slew, o hucrenin gecikmesinin
EKSTRAPOLE edildigi anlamina gelir; STA o arclarda guvenilir degildir.
README'nin "hepsi 1,5'in altinda" ima eden cercevesi bu 20 pin icin
duzeltilmelidir.

### 7. FIRMWARE BAYATLIK KAPISI — UCTAN UCA DOGRULANDI (pozitif sonuc)

Teslim notu §6.3'teki duzeltmenin gercekten kapanip kapanmadigi test edildi.
Endise: `ASIC_CLK_HZ` bir make DEGISKENI, dosya bagimliligi degil; frekans
degisince `.hex` yeniden derlenmeyebilir.

**Kapanmis.** `FPGA/firmware/Makefile`'daki dort `.elf` kuralinin hepsi
`Makefile`'in KENDISINI onkosul olarak listeler:

    $(OUT_DIR)/asic_boot.elf: $(BOOT_SRCS) $(BOOT_LD) Makefile | $(OUT_DIR)

`ASIC_CLK_HZ` ayni dosyada tanimli oldugu icin degeri degistirmek dosyanin
mtime'ini degistirir → `.elf` yeniden derlenir. Ikili dogrulama (ELF icinde
`addi a4,x0,IMM` komut kodu arandi):

| ELF | bulunan CPB | anlami |
|---|---:|---|
| `asic_boot.elf` | **260** | 30 MHz ✔ |
| `asic_app.elf` | **260** | 30 MHz ✔ |
| `boot.elf` (FPGA) | 434 | 50 MHz ✔ |

UYARI: kapi yalnizca deger Makefile ICINDE degistirilirse calisir. Komut
satirindan `make ASIC_CLK_HZ=...` override edilirse mtime degismez ve kapi
SESSIZCE ACILIR. `asic/Makefile` bilerek override etmiyor — oyle kalmali.

Ayni sekilde `patch_rtl.py --check`, `gen_rom.py --all --check`,
`gen_macro_keepout.py --check` kosuldu: ucu de temiz gecti.

### 8. DEPO SU AN TUTARSIZ BIR ARA DURUMDA (teslim riski)

| Kaynak | Frekans |
|---|---|
| `config.yaml` `CLOCK_PERIOD` | 33,333333 ns = **30 MHz** |
| `FPGA/firmware/Makefile` `ASIC_CLK_HZ` | **30000000** |
| `README.md` (satir 81, 427, 957, 982, 1274…) | **25 MHz / 40 ns** |
| Teslim edilebilir paket `final40c` | **25 MHz** |

Juri `make asic_run` kosarsa 30 MHz'lik, 1.169 setup ihlalli bir tasarim
uretir; README 25 MHz'in kapandigini beyan eder. Sartname §3.2.3:
"Sunumdaki sonuclar tasarim ciktilariyla dogrulanacak, uyumsuz olanlar
elenecektir."

**IYI HABER:** projenin kendi denetleyicisi bunu YAKALIYOR.
`scripts/verify_deliverables.py` kosuldu:

    ! config/resolved uyusmazligi: CLOCK_PERIOD: config=33.333333333333336, resolved=40
    PAKET KAPISI: BASARISIZ

Ayrica ayni kosumda 13 checksum uyusmazligi ve
`design__disconnected_pin__count = 480` raporlandi (`ERROR_ON_DISCONNECTED_PINS`
`false` oldugu icin akisi dusurmuyor). 480 baglanmamis pin teslim notunda
HIC GECMIYOR — ayrica incelenmeli.

### 9. `RSZ_CORNERS` hipotezi — ZATEN CURUTULMUS, tekrar onerilmemeli

Bu oturumda bagimsiz olarak yeniden "kesfedildi" (resizer yalniz `nom_*`
gorur, signoff `max_ss`'te duser) ve bu belgenin 389. satirindaki kayit
sayesinde bir kosum israfindan donuldu. Kayit dogru: PnR'da SPEF yoktur,
`set_layers_default_rc` butun kose'lere AYNI tel RC'sini uygular,
`nom_/min_/max_` onekleri yalnizca RCX kural setleridir ve detayli
yollamadan SONRA devreye girer. Degisiklik NO-OP olur.

### 10. HENUZ DENENMEMIS OLARAK KALAN KALDIRACLAR

| Kaldirac | Neden acik | Hedefledigi gecikme |
|---|---|---|
| **`SYNTH_STRATEGY: "AREA 0"` → `DELAY *`** | 2026-09-02 sentez A/B'si yalniz `SYNTH_SIZING` ve `SYNTH_ABC_USE_MFS3`'u denedi; `SYNTH_STRATEGY` HIC denenmedi | 44 kademe / 23,618 ns mantik |
| `PL_TARGET_DENSITY_PCT: 35` → 50 | 25 denendi (kotu), 50 yalniz die kucultmeyle BIRLIKTE denendi (`p_rc_die2600`) — tek basina degil. Ustelik GRT asimina bakilarak elendi, ki bu belge asimin yaniltici oldugunu soyluyor (satir 85) | 39 kademe / 9,521 ns tampon |
| `GRT_MACRO_EXTENSION: 1` | belgenin kendi notu: "yalnizca GRT asimina bakilarak elendi, DRT kosulmadi — yeniden degerlendirilmeli" | tel uzunlugu |

### 11. SENTEZ STRATEJISI A/B — `SYNTH_STRATEGY` ILK KEZ OLCULDU (2026-09-03)

2026-09-02 A/B'si `SYNTH_SIZING` ve `SYNTH_ABC_USE_MFS3`'u denemis ama
`SYNTH_STRATEGY`'yi HIC denememisti. Taban `"AREA 0"`dir.

**Gerekce:** alan dali takim karariyla kapali (die sabit, %56,94 filler,
std hucre dolulugu %13,86) → alan icin optimize etmenin getirisi SIFIR, bedeli
mantik derinligidir. Kritik yolun 44 kademesi / 23,618 ns'i gercek mantiktir.

**Olcut:** Yosys sentez logunun `ABC: WireLoad = "none" ... Delay = X ps`
satiri (`stime -p`, nihai eslenmis netlist, tel yuku YOK). Ayni tasarim,
ayni metrik, tek degisken.

**A/B #1 — 30 MHz netlisti uzerinde (CLOCK_PERIOD 33,333333):**

| Strateji | Gates | Area (um²) | ABC Delay | Sonuc |
|---|---:|---:|---:|---|
| `AREA 0` (taban) | 59.469 | 555.803 | **18.135,9 ps** | referans |
| `DELAY 0` | 61.766 | 619.696 | 21.852,2 ps (+%20,5) | **RED** |
| `DELAY 2` | 61.728 | 618.536 | 18.828,1 ps (+%3,8) | **RED** |

`DELAY 0`in kaybetme nedeni betiktedir, tesaduf degildir:
`construct_abc_script.py` icinde `elif strategy != "DELAY 0"` kosulu yuzunden
`DELAY 0` **`choice2` adimini atlar**; `AREA 0` onu kosar. Ustelik her iki
strateji de ayni gecikme odakli `&get -n; &st; &dch; &nf; &put` ile biter.
Yani `AREA 0` daha COK optimizasyon gorup ayni son eslemeyi aliyor.

**A/B #2 — 28 MHz netlisti uzerinde (CLOCK_PERIOD 35,714285714285715):**

| Strateji | Gates | Area (um²) | ABC Delay |
|---|---:|---:|---:|
| `AREA 0` (taban) | 59.666 | 557.284 | **19.198,4 ps** |
| **`DELAY 4`** | **76.224 (+%27,8)** | **709.215 (+%27,3)** | **9.394,5 ps (−%51,1)** |

**`DELAY 4` mantik gecikmesini YARIYA indiriyor: 19,198 → 9,394 ns.**

`DELAY 4` digerlerinden farklidir cunku ORFS betigidir; teknoloji eslemesi
yerine 5 kez `&st; &syn2; &if -g -K 6; &synch2; &nf` dongusu kosar
(`&if -g` = SOP dengeleme, zincirleri dengeli agaca cevirir) ve sonunda
kritik-yol farkindali `upsize -c` / `dnsize -c` uygular. Olculen kritik yol
tam da bunun hedefledigi yapiydi: `o311a` / `a221o` / `a31o` hucrelerinden
olusan DOGRUSAL (ripple) zincirler.

**YAN NOT — netlist gurultusu tek basina ~1 ns:** ayni `AREA 0` stratejisi
30 MHz netlistinde 18.135,9 ps, 28 MHz netlistinde 19.198,4 ps veriyor.
Tek fark boot ROM icerigi + I2C bolucu sabitleridir. Yani ABC seviyesinde bile
kosumdan kosuma ~1 ns dagilim vardir; bu, §3'teki 2,42 ns'lik fiziksel
dagilimin bir parcasini aciklar.

**UYARI — bu sayi tel gecikmesini ICERMEZ.** `WireLoad = "none"`. Olculen
kritik yolun 9,521 ns'i resizer tamponudur ve o tel uzunlugundan gelir;
hucre sayisi %27,8 artarsa yollama talebi de artar. DRT bu tasarimda sifir
DRC'ye ancak 10 iterasyonda ulasiyor. Bu nedenle `DELAY 4` TAM AKISLA
dogrulanmadan kabul EDILMEZ; once faz 1 (adim 43'e kadar) kosulup
GRT tikanikligi ve post-GRT resizer WNS'i tabanla karsilastirilacaktir.

**Karsilastirma tabani (final30, adim 43 post-GRT resizer):**
    baslangic WNS -7,132 / TNS -2938,0 / 2.791 ihlalli uc
    bitis      WNS -3,312 / TNS -1063,0 / 2.205 ihlalli uc
    237 tampon, 785 boyutlandirma, [WARNING RSZ-0062] takildi
Ayni adim final40c'de -1,462 -> +5,730 ile YAKINSAMISTI.

### 12. 480 BAGLANMAMIS PIN ACIKLANDI (yeni)

`design__disconnected_pin__count = 480`,
`design__critical_disconnected_pin__count = 0`. Teslim notunda hic gecmiyordu.

480 = **15 makro x 32 bit**. Netlist denetimi: her SRAM ornekinde `dout0`
(rw portunun okuma verisi) Yosys kukla telleri `{_NC1, _NC2, ...}` ile
baglanmistir; tasarim okumayi `dout1` (salt-okunur port) uzerinden yapar.

Yani bunlar **kullanilmayan CIKIS** pinleridir; islevsel bir sorun degildir,
`critical = 0` bu yuzdendir. README'de aciklanmali, cunku aciklanmamis bir
"480" sayisi juri icin acik soru birakir.

### 13. `SYNTH_STRATEGY: "DELAY 4"` — TAM AKISLA REDDEDILDI (2026-09-03)

§11'de ABC olcumu `DELAY 4`u -%51,1 ile acik ara one koymustu
(19.198,4 -> 9.394,5 ps). **Faz 1 kosumu bu tahmini CURUTTU.**
Kosum `run/final28`, CLOCK_PERIOD 35,714285714285715 (28 MHz), tek degisken
`SYNTH_STRATEGY`.

**1) Yerlestirme — yollanabilirlik sisirmesi 4 KATINA cikti**
(`28-openroad-globalplacement`, GPL-1011/1012/1014):

| Kosum | Strateji | Sentez alani | Sisirme | Nihai yerlesim alani |
|---|---|---:|---:|---:|
| final40c | AREA 0 | 892.532 | +%39,40 | 1.264.060 |
| final30 | AREA 0 | 890.597 | +%41,90 | 1.276.199 |
| **final28** | **DELAY 4** | 1.039.223 (+%16,7) | **+%166,65** | **2.791.036** |

**2) Zamanlama — post-CTS'te ZATEN GERIDE**
Iki kosum farkli periyotta oldugu icin ham WNS yaniltir; olcut
"gereken periyot = T - WS", ayni kose (`nom_tt_025C_1v80`), ayni adim:

| Adim | final30 (AREA 0, T=33,3333) | final28 (DELAY 4, T=35,7143) |
|---|---:|---:|
| 36 post-CTS | 24,8444 ns | 27,0047 ns |
| **38 post-CTS resizer** | **24,3120 ns** | **26,6829 ns (+2,371)** |

Yani post-CTS resizer'dan SONRA bile DELAY 4 tabandan **2,371 ns kotudur.**

**3) Global yollama — AKIS OLDU**
`39-openroad-globalrouting`, nihai tikaniklik raporu:

| | final30 (AREA 0) | final28 (DELAY 4) |
|---|---:|---:|
| met1 kullanim | %23,64 | %44,78 |
| met2 kullanim | %20,93 | %38,58 |
| met3 kullanim | %12,06 | %20,95 |
| met4 kullanim | %9,57 | %16,61 |
| **toplam talep** | **1.440.253** | **2.636.925 (+%83,1)** |
| **toplam kullanim** | **%17,53** | **%32,14** |
| **TOPLAM ASIM** | **0** | **102** (met1 16 / met2 4 / met3 78 / met4 4) |
| sure | 00:01:50 | 11+ dk, sonra hata |

    [ERROR GRT-0116] Global routing finished with congestion.
    librelane.flows.flow.FlowError: OpenROAD.GlobalRouting failed

`GRT_ALLOW_CONGESTION: false` oldugu icin akis burada oldu (adim 39).

**KOK NEDEN:** `DELAY 4` ORFS betigi mantigi `&if -g -K 6` (SOP dengeleme) ile
SIGLASTIRIR ama GENISLETIR. Hucre sayisi %27,8 artiyor, fakat yollama talebi
**%83,1** artiyor -- yani asil maliyet hucre alani degil, AG SAYISIDIR.
Bu tasarim tel-baskindir: olculen kritik yolun 83 kademesinin 39'u (9,521 ns)
zaten tel tekrarlayicisiydi. Mantik derinliginden kazanilan, telde fazlasiyla
geri veriliyor.

**GENEL DERS — ABC'nin `Delay`/`lev` metrigi BU TASARIM ICIN KOTU BIR VEKILDIR.**
`ABC: WireLoad = "none"` satirindaki sayi tel gecikmesini HIC icermez. Tel-baskin
bir tasarimda -%51'lik bir ABC kazanci, +2,37 ns'lik bir post-CTS KAYBINA ve
yollanamayan bir tasarima donusebiliyor. Sentez stratejisi kararlari bundan
sonra en az `39-openroad-globalrouting` asimina kadar kosulmadan verilmemeli.
Bu, bu belgedeki "GRT asimi yaniltici bir vekildir" (satir 85) dersinin
TERSI yonde bir tamamlayicisidir: asim tek basina KARAR VERDIRMEZ ama
SIFIRDAN 102'ye ciktiginda ve GRT hata verdiginde KESINDIR.

**Maliyet:** ~1 saat 16 dakika (15:04 -> 16:21). Faz 1'in ayri kosulmasi
sayesinde 12 saatlik tam akis israf edilmedi.

**SONUC: `SYNTH_STRATEGY` "AREA 0"da KALIYOR.** Uc DELAY varyantinin ucu de
olculup elendi (DELAY 0 ve DELAY 2 ABC'de, DELAY 4 tam akista).

### 14. `final28` TESLIM KOSUMU — 28 MHz TAM SIGNOFF'TAN GECTI (2026-09-03)

`CLOCK_PERIOD: 35.714285714285715` (28 MHz), `SYNTH_STRATEGY: "AREA 0"`,
iki fazli akis (faz 2 = `experiments/antenna_jumper.yaml`).

**16 zorunlu metrigin tamami SIFIR:**

| Metrik | Deger |
|---|---:|
| Setup ihlali (9 kose) | **0** |
| Hold ihlali (9 kose) | **0** |
| Yollama / Magic / KLayout DRC | **0 / 0 / 0** |
| LVS (6 sayac) | **0** |
| XOR farki | **0** |
| Magic illegal overlap | **0** |
| PDN ihlali | **0** |
| Max fanout | **0** |

**Zamanlama:**

| Kose | Setup WS | Hold WS |
|---|---:|---:|
| `max_ss_100C_1v60` | **+2,5223** | +0,8299 |
| `nom_ss_100C_1v60` | +2,9578 | +0,8242 |
| `min_ss_100C_1v60` | +3,3993 | +0,8179 |
| `nom_tt_025C_1v80` | +10,3398 | +0,2843 |
| `min_ff_n40C_1v95` | +12,8726 | **+0,0863** |

**Olculen Fmax:** 35,714286 - 2,5223 = **33,19 ns -> 30,13 MHz.**
Yani gerceklem 30 MHz'i de karsilardi, fakat yalnizca +0,14 ns payla; olculen
~2,4 ns'lik kosum dagilimi karsisinda o pay anlamsizdir. 28 MHz beyani
**+2,522 ns pay** birakir.

**Taban karsilastirmasi:**

| | `final40c` (25 MHz) | `final30` (30 MHz, DUSTU) | **`final28` (28 MHz)** |
|---|---:|---:|---:|
| Setup WS (max_ss) | +6,3149 | −2,0116 | **+2,5223** |
| Setup ihlali | 0 | 1.169 | **0** |
| Hold WS (min_ff) | +0,0570 | +0,0726 | **+0,0863** |
| Anten net / pin | 1.935 / 2.364 | 1.441 / 1.847 | **1.478 / 1.883** |
| Tel uzunlugu | 10.192.713 | 10.203.893 | **9.966.324** |
| DRT iterasyonu | — | 10 | **8** |
| DRT suresi | — | 38:44 | **17:34** |
| Max slew / cap (max_ss) | 991 / 583 | 949 / 584 | 969 / 605 |
| GRT asim | 0 | 0 | **0** (kullanim %17,12) |

**TAHMIN MODELI DOGRULANDI (yeni, gelecekte kullanilabilir).**
Kosum oncesinde adim 43 (`ResizerTimingPostGRT`) bitis WNS'inden signoff
max_ss tahmin edildi. Iki veri noktasindan (`final40c`: +5,730 -> +6,3149;
`final30`: −3,312 -> −2,0116) cikarilan dogru:

    signoff_max_ss ≈ 0,921 x resizer_bitis_WNS + 1,038

`final28` icin resizer bitisi **+1,364** olcusuldu; model **+2,294** verdi,
GERCEK **+2,5223** cikti — **0,23 ns hata**. Kaba yontem (delta'yi birebir
tasima) +2,66 verdi, 0,14 ns hata.

**Pratik degeri:** adim 43 faz 1'in SONUDUR ve ~1,3 saatte ulasilir; tam akis
~3,5 saattir. Yani bir kosumun kapanip kapanmayacagi, tam signoff beklenmeden
+-0,25 ns dogrulukla ONGORULEBILIR. Model iki noktadan turetildigi icin
ucuncu nokta (`final28`) ilk gercek dogrulamasidir; daha fazla nokta
biriktikce yeniden uydurulmalidir.

**Hold payi frekansla DARALMADI** — aksine genisledi (+0,0570 -> +0,0726 ->
+0,0863). Beklenen sonuc: hold ayni-kenar yollarina bakar ve periyottan
bagimsizdir; iyilesme resizer'in daha gevsek bir setup hedefiyle daha az
agresif calismasindan gelir.

### 15. AKIS ALTYAPISI DUZELTMELERI (2026-09-03)

**a) `make asic_run` artik IKI FAZLI.** Onceden tek fazliydi ve teslim edilen
anten sayilarini UREMIYORDU: jumper faz 2'de elle kosuluyordu. Sartname
Bolum 3.2.3 ("sonuclar ciktilarla dogrulanacak, uyumsuz olanlar elenecek")
acisindan bu bir eleme riskiydi. Hedef artik faz 1'i
`--to OpenROAD.ResizerTimingPostGRT` ile kosar, adim dizinini glob ile bulur,
faz 2'yi `--from OpenROAD.RepairAntennas` + overlay ile `--overwrite`
VERMEDEN baslatir, bulamazsa yuksek sesle hata verir.

**b) `verify_deliverables.py` iki fazli akisa uyarlandi -- ZAYIFLATILMADAN.**
Beklenen deger artik `config.yaml` + resmi faz 2 overlay'idir, boylece
overlay'in bilerek degistirdigi anahtarlar dogru referansa karsi denetlenir ve
digerleri zorlanmaya devam eder. Ustune IKI YENI KAPI eklendi:
  - faz 2'nin gercekten kostugunun kaniti (`RUN_ANTENNA_REPAIR` ve
    `GRT_ANTENNA_REPAIR_JUMPER_ONLY` resolved.json'da true olmali)
  - faz 1 ayarlarinin korundugu (`config.yaml` icinde `RUN_ANTENNA_REPAIR`
    false, `RUN_POST_GRT_RESIZER_TIMING` true) -- cunku overlay YALNIZ faz 2'ye
    uygulanir ve bu anahtarlar aksi halde denetimsiz kalirdi
`flow.log` beklentisi 1 -> 2 "Starting…" oldu.

**KAPILAR CANLI OLARAK TEST EDILDI** (enjekte edilen sapma, sonra geri alindi):
  - `CLOCK_PERIOD` 35,714 -> 40,0 : YAKALANDI
  - `RUN_ANTENNA_REPAIR` false -> true : YAKALANDI (yeni faz 1 kapisi)
  - temiz durum : PAKET KAPISI GECTI, 79/79 kalem

**c) Bulunan tuzak:** `make -n asic_run` GERCEK dry-run DEGILDIR. Recipe tek
mantiksal satirdir ve icinde `$(MAKE)` gectigi icin GNU make onu `-n` altinda
yine de CALISTIRIR. (Mevcut bir davranistir, bu oturumda eklenmedi.) Nix
ortami disinda calistirildiginda librelane import'unda durur ve hata yolu
dogru davranir: "Akis final/metrics.json uretmeden kesildi; onceki teslim
ciktilari korunuyor."

### 16. 480 BAGLANTISIZ PIN — README'ye aciklama eklendi
§12'de bulunan aciklama (15 makro x 32 bit kullanilmayan `dout0` cikisi)
README Bolum 0.27'ye yazildi.

### 17. 30 MHz HEDEFI: UC TEL KALDIRACI (`run/final30b`, 2026-09-03)

Kullanici hedefi 28 -> 30 MHz'e cekti. `final28` olculen T0 = 33,19 ns idi,
yani 30 MHz'i (33,333 ns) yalnizca +0,14 ns payla karsiliyordu -- olculen
~2,4 ns kosum dagilimi karsisinde savunulamaz. Gereken: ~2 ns iyilesme.

**KOK NEDEN ANALIZI -- neden teller uzun?**

| | |
|---|---:|
| Die | 4200 x 3600 um = 15,12 mm² |
| 15 SRAM makrosu | 4,17 mm² (%27,6) |
| Standart hucreler | ~1,49 mm² |
| **std hucre dolulugu** | **%13,86** |

Mantik ihtiyacinin ~4 kati alana yayilmis. Kritik yolun 83 kademesinin 39'u
(9,521 ns, %29) bu yuzden tel tekrarlayicisidir.

**UYGULANAN UC KALDIRAC (hepsi "uzunluk siniri KAPALIYDI" temasinda):**

| Ayar | Eski | Yeni | Hedef | Olculen maliyet |
|---|---:|---:|---|---|
| `GRT_DESIGN_REPAIR_MAX_WIRE_LENGTH` | 0 (kapali) | 400 um | anten | 5.123 net, ~3.435 tampon (+%1,3 stdcell) |
| `CTS_CLK_MAX_WIRE_LENGTH` | 0 (kapali) | 600 um | slew + anten | 43 saat neti, ~32 tampon |
| `PL_TARGET_DENSITY_PCT` | 35 | 50 | **tel uzunlugu -> zamanlama** | die DEGISMEZ |

Ilk ikisinin gerekcesi §18'de (anten/slew tarama). Ucuncusu YENI:

**`PL_TARGET_DENSITY_PCT` 35 -> 50 -- die'a dokunmadan sikistirma.**
GPL'in kendi onerisi (`final28` logu, GPL-1006..1009):
    bos alanin %90'i icin 0,3134 | %80'i icin 0,3525 | %50'si icin 0,5641
Yani 0,35 "bos alanin %80'ini kullan" demekti. 0,50 ~%56'ya ceker.
GRT kullanimi `final28`'de yalnizca %17,12 ve sifir asimdi -> sikistirmak
icin GERCEKTEN YER VAR.

Onceki kayit duzeltmesi: `PL_TARGET_DENSITY_PCT: 25` denenmis ve kotu cikmisti
(overflow 258k). **50 ise yalnizca die kucultmeyle BIRLIKTE** denenmisti
(`p_rc_die2600`) ve o kosum GPL iraksamasindan olduğu icin sonuc KARISIKTIR.
50 tek basina hic olculmedi; bu kosum onu olcer.

**DIE KUCULTME BU TURDA YAPILMADI -- bilincli.** Once yogunlugun tek basina
ne getirdigi gorulecek; ikisi ayni anda degistirilirse hangisinin ise
yaradigi bilinemez (bu belgenin kendi kurali, bkz. `p_rc_die2600` dersi).
Hazir bir sonraki adim: `experiments/gpl_die3000_phi101.yaml`
(die 4200x3000 + phi 1,01), once `--to OpenROAD.GlobalPlacement` ile ~35 dk.

**FREKANS TAVANI TAHMINI (kaldiraclarin sinirini gostermek icin):**
Kritik yolun 44 kademesi (23,618 ns) GERCEK MANTIKTIR. Saat ek yuku ~0,9 ns.
Yani teller SIFIR olsa bile taban ~24,5 ns -> mutlak tavan ~40 MHz.
Gercekci tel gecikmesiyle pratik tavan ~33-35 MHz. 35+ MHz ancak mantik
derinligini azaltmakla olur (register-file okuma yolunu boru hattina almak,
yani CV32E40P mimarisine dokunmak). Sentez tarafi TUKENDI: uc DELAY
varyantinin ucu de elendi (§11, §13).

**30 MHz'in BOLUCU BEDELI:** 30.000.000 / 800.000 = 37,5 -> kesirli
(Bresenham) I2C bolucusu yeniden devreye girer. 28 MHz'de bolme tam 35'ti ve
kesirli dal atildi. Islevsel engel degil (uygulanmis ve test edilmis), ama
28 MHz'e gore kaybedilen bir sadeliktir. UART: CPB 260, hata +%0,160
(28 MHz'de 243 ve +%0,023 idi).

5/5 regresyon 30 MHz'de GECTI.

### 17b. DUZELTME — `PL_TARGET_DENSITY_PCT: 50` CURUTULDU (2026-09-03)

§17'de "olcer" denilen yogunluk kaldiraci OLCULDU VE REDDEDILDI. Kosum
`run/final30b` GPL'de (adim 28) durduruldu, ~25 dakika maliyetle.

Tek degiskenli karsilastirma (ayni netlist sinifi, ayni die, ayni makro
yerlesimi; yalnizca `PL_TARGET_DENSITY_PCT` degisti):

| Metrik | density 35 (`final28`) | density 50 (`final30b`) |
|---|---:|---:|
| Sentez alani | 892.159,87 | 890.596,54 |
| Routability sisirmesi | +%36,84 | **+%217,48** |
| Nihai yerlesim alani | 1.241.747,29 | **2.844.385,41** |
| GPL sonu routing overflow | 1.263,93 | 1.300,54 |
| **NESTEROV HPWL** | **5,912e+06 um** | **7,075e+06 um (+%19,7)** |
| GPL suresi | 00:10:51 | 00:10:24 |

**HIPOTEZ YANLIS CIKTI.** Hedef yogunlugu artirmak telleri KISALTMADI,
%19,7 UZATTI.

**MEKANIZMA:** yuksek hedef yogunluk yerlestiriciyi once sikistirir; bu YEREL
tikaniklik yaratir; routability surucusu hucreleri +%217 sisirerek patlatir.
Net sonuc, gevsek hedefle baslamaktan DAHA YAYVAN bir yerlesimdir --
yerlestirici kendisiyle guresiyor. Iç overflow'un neredeyse ayni kalmasi
(1.264 -> 1.301) bunu dogrular: ayni tikaniklik seviyesine cok daha fazla
yayilarak ulasilmistir.

Yani `35` yerel optimuma yakindir. `25` de daha once elenmisti (overflow 258k).
Her iki yon de kotu; aracin kendi onerisi (GPL-1007: bos alanin %80'i icin
0,3525) dogru noktayi isaret ediyor.

**GENEL DERS (ikinci kez):** Bu, `SYNTH_STRATEGY: DELAY 4` ile AYNI hata
desenidir -- ara bir vekil metrikte (ABC delay / hedef yogunluk) iyi gorunen
bir degisiklik, routability surucusunun tepkisi yuzunden GERCEK sonucta
kotulesiyor. Kural: yerlestirme ve sentez degisiklikleri en az GPL'in
NESTEROV HPWL satirina (adim 28, ~11 dk) kadar kosulmadan kabul edilmemeli;
sentez degisiklikleri icin esik GlobalRouting'e (adim 39) kadardir.

**Ucuz kontrol noktalari (bu oturumda dogrulandi):**
    adim 28 GPL   ~11 dk -> Nesterov HPWL + routability sisirmesi
    adim 39 GRT   ~35 dk -> toplam asim (0 olmali)
    adim 43 RSZ   ~80 dk -> resizer bitis WNS -> signoff tahmini (+-0,25 ns)

**KALAN 30 MHz KALDIRACLARI:** yalnizca die kucultme
(`experiments/gpl_die3000_phi101.yaml`, die 4200x3000 + phi 1,01). Yogunluk
kapisi kapandi.

### 17c. 30 MHz + TEL BOLME KALDIRAKLARI — KAPANMADI (`run/final30b`, faz 1)

`CLOCK_PERIOD 33,333333`, density 35, `GRT_DESIGN_REPAIR_MAX_WIRE_LENGTH: 400`,
`CTS_CLK_MAX_WIRE_LENGTH: 600`.

**Kaldiraclar CALISTI, ama ZAMANLAMAYA TERS yonde:**

| Adim | eski `final30` (limit yok) | `final30b` (limitli) |
|---|---|---|
| 35 CTS `repair_clock_nets` | `Using max wire length 2936um`, 2 tel, 4 tampon | `WARNING RSZ-0065: less than 2936u increases wire delays`, **12 tel, 48 tampon** |
| 40 anten (ham) | 2.452 net | **2.405 net** (-%1,9, saf CTS katkisi) |
| 41 `repair_design` | 2.210 tampon / 2.736 net | **7.110 tampon / 5.659 net** |
| 39 GRT asim | 0 (%17,53) | **0** (%17,54) |
| **43 resizer baslangic** | −7,132 | **−8,157** |
| **43 resizer bitis** | −3,312 (takildi) | **−3,756** (takildi) |
| **signoff max_ss** | **−2,0116 (olculdu)** | **≈ −2,42 (model)** |

**KRITIK BULGU — `0` "KAPALI" DEMEK DEGIL (komuta gore degisir):**
* `repair_clock_nets -max_wire_length 0` -> OpenROAD GECIKME-OPTIMAL degeri
  KENDISI HESAPLAR: **2936 um**. LibreLane bu anahtari
  `clock_tree_synthesis`'e degil bu komuta gecirir (`cts.tcl:96`).
* `repair_design -max_wire_length 0` -> LibreLane dokumani "no buffers
  will be inserted" der ve dogrudur (uzunluk-tabanli ekleme kapanir), ama
  slew/cap tabanli bolme devam eder (eski kosumda 2.210 tampon).

**Yani 400/600 degerleri gecikme-optimal 2936 um'nin COK ALTINDADIR.**
OpenROAD bunu iki kez acikca uyardi. Tampon gecikmesi RC kazancini asiyor;
resizer 1,025 ns daha kotu bir noktadan basliyor ve 0,444 ns daha kotu
bitiyor.

**SONUC — IKI HEDEF BIRBIRIYLE CELISIYOR:**

| Kaldirac | Anten/slew | Zamanlama |
|---|---|---|
| tel BOLME (max_wire_length) | iyi | **kotu** |
| yogunluk 50 | — | **kotu** (§17b) |
| sentez DELAY 0/2/4 | — | **kotu** (§11, §13) |

Telleri BOLMEK anteni duzeltir, zamanlamayi bozar. Telleri KISALTMAK ikisini
birden duzeltirdi; tek yolu die kucultmektir.

**30 MHz BU FLOORPLAN ILE ULASILAMAZ.** Iki bagimsiz tam kosum
(`final30` −2,0116 olculdu, `final30b` ≈−2,42 tahmin) ve tuketilmis
sentez/yerlestirme kaldiraclari bunu gosteriyor.

**SIRADAKI VE SON KALDIRAC:** die 4200x3600 -> 4200x3000 (−%16,7 alan),
`PL_MAX_PHI_COEFFICIENT: 1.01` ile (GPL iraksama kok nedeni §683'te; carpan
iterasyon basinadir, kucultmek gerekir). Ucuz kontrol: `--to
OpenROAD.GlobalPlacement` ~15 dk, olcut NESTEROV HPWL.
    taban `final30b` HPWL = 6,098e+06 um
    anlamli iyilesme esigi ~5,3e+06 (yaklasik -%13)

### 18. ANTEN/SLEW KAMPANYASI — `run/ant28` (28 MHz, 2026-09-04)

Kullanici 30 MHz'den vazgecip 28 MHz'de anten ihlallerini minimize etmeyi
istedi. Uygulanan: `GRT_DESIGN_REPAIR_MAX_WIRE_LENGTH: 250` (400 degil --
28 MHz'de +2,522 ns pay vardi, bedel `final30b`'de ~0,44 ns olculmustu) +
`CTS_CLK_MAX_WIRE_LENGTH: 600`.

**ONCE: ULASILABILIR TABAN MODELLENDI** (final28'in 1.927 ihlalli pini,
her netin uzunlugu `reports/routing/wire_lengths.csv`'den):

| Sinir | Model: cozulur | Model: kalir |
|---|---:|---:|
| 400 um | %45,4 | ~1.053 pin |
| 250 um | %71,4 | ~552 pin |

**SIFIR ULASILAMAZ — yapisal, uc bagimsiz sebep:**
1. Ihlallerin %29,5'i ZATEN 400 um'nin altinda. Bunlar uzun olduklari icin
   degil KAPILARI KUCUK oldugu icin ihlal ediyor. P/R = metal_alani /
   kapi_alani; oran-uzunluk korelasyonu yalnizca **r = 0,177**.
2. Ihlallerin %72,6'si met3'te ve jumper met3'u duzeltemez (iki katman
   yukari cikar, met5 gerekir, `RT_MAX_LAYER: met4`; met5 ayrica yapisal
   olarak elenmis -- via4 makro ustunde kapali).
3. Diyot yolu kapali: `RUN_ANTENNA_REPAIR` diyotlari DRT'yi yakinsamaz
   yapiyor (README 0.1 kontrollu karsilastirma); `HeuristicDiodeInsertion`
   ise `GPL/DPL_CELL_PADDING > 0` istiyor, o da olculmus ve teli
   16,5 -> 24,6 m yapmis (overflow 540k).

**OLCULEN SONUC:**

| Metrik | `final28` | **`ant28`** | degisim |
|---|---:|---:|---:|
| Setup WS (max_ss) | +2,5223 | **+0,8987** | −1,624 ns |
| Hold WS (min_ff) | +0,0863 | +0,0717 | −0,015 |
| Setup / hold ihlali (9 kose) | 0 / 0 | **0 / 0** | — |
| **Anten net** | 1.478 | **955** | **−%35,4** |
| **Anten pin** | 1.883 | **1.013** | **−%46,2** |
| **Max cap ihlali** | 613 | **14** | **−%97,7** |
| Max slew ihlali | 969 | **731** | −%24,6 |
| — bunun SRAM pini (limit 0,04) | 328 | **328** | degismedi |
| — bunun std hucre (limit 0,75) | 641 | **403** | **−%37,1** |
| Yollama DRC | 0 | **0** | — |
| Tel uzunlugu | 9.966.324 | 9.991.404 | +%0,25 |
| Adim 41 tampon | 2.210 | **17.436** | +15.226 |
| Adim 43 hold tamponu | 139 | **12** | −127 |
| GRT asim | 0 (%17,12) | **0** (%17,13) | — |
| DRT iterasyon / sure | 8 / 17:34 | 8 / 21:19 | — |

**BEKLENMEDIK KAZANC — MAX CAP %97,7 DUSTU.** Bu ongorulmemisti. Mekanizma
acik: neti bolmek net basina KAPASITANSI da boluyor. Yani tel bolme UC
problemi birden vuruyor: anten, max cap, max slew.

**MODEL HATASI KAYDI:** model 250 um icin ~552 kalan pin ongordu, GERCEK
**1.013** cikti -- model 2 kat iyimserdi. Sebep: model DRT'nin YENIDEN
YOLLAMA sirasinda URETTIGI YENI ihlalleri hesaba katmiyordu. Ara olcum bunu
dogruluyor: adim 44 (jumper cikisi) 677 pin -> adim 48 (DRT sonrasi)
1.013 pin. **Gelecekte anten tahminine DRT buyume faktoru (~1,5x)
eklenmelidir.**

**TAHMIN MODELI UCUNCU KEZ TUTTU:** adim 43 resizer bitisi +0,034 ->
model `0,921 x 0,034 + 1,038 = +1,069` -> GERCEK **+0,8987**. Hata 0,17 ns.
Dort noktalik kayit:
    final40c  +5,730 -> model +6,315 | gercek +6,3149  (hata 0,000)
    final30   −3,312 -> model −2,012 | gercek −2,0116  (hata 0,000)
    final28   +1,364 -> model +2,294 | gercek +2,5223  (hata 0,228)
    ant28     +0,034 -> model +1,069 | gercek +0,8987  (hata 0,170)

**TAKAS OZETI:** 1,62 ns setup payi karsiliginda anten pin −%46,2,
max cap −%97,7, std hucre slew −%37,1. Kalan pay +0,8987 ns hala gercek bir
signoff payidir (uzerine %5 OCV derate ve 0,25 ns belirsizlik ZATEN
uygulanmistir).

### 19. TESLIM PAKETI `ant28` OLARAK GUNCELLENDI (2026-09-04)

`collect.py --run-dir run/ant28`, `gen_versions.py`, `gen_readme_results.py`,
`gen_checksums.py` kosuldu. `verify_deliverables.py` -> **79/79 kalem,
PAKET KAPISI GECTI.** Bayatlik kapilari (patch_rtl/gen_rom/keepout) temiz.

Tutarlilik zinciri dogrulandi:
    config.yaml CLOCK_PERIOD   = 35.714285714285715
    firmware ASIC_CLK_HZ       = 28000000
    README saat portu          = 28 MHz (35,714286 ns)
    results/metrics setup WS   = 0.8987
    results/metrics anten      = 955 / 1013

README'de elle guncellenen bolumler: 0.05 (hold), 0.1 (anten), 0.15 (slew/cap
tam yeniden yazim), 0.25 (Fmax tablosu + 30 MHz'in iki kez dusmesi + elenen
kaldirac listesi), YENI 0.28 (tel bolme kampanyasi).

**YEDEK:** `run/final28` diskte duruyor (ayni frekans, tel bolmesiz,
setup +2,5223 / anten 1.478). Geri donus icin collect + README bolum geri
alimi gerekir.

### 20. ANTEN JUMPER ITERASYONU 1 -> 2 — NO-OP (`ant28_jmpi2`, 2026-09-04)

`ant28` adim 43 state'i uzerinde tek degiskenli olarak
`GRT_ANTENNA_REPAIR_ITERS: 1 -> 2` denendi. Diger ayarlar resmi
`experiments/antenna_jumper.yaml` overlay'inden geldi.

| Olcum | iter=1 (`ant28`) | iter=2 (`ant28_jmpi2`) |
|---|---:|---:|
| Onarim girisi | 1.927 | 1.927 |
| Ilk tur eklenen jumper / net | 1.329 / 1.274 | 1.329 / 1.274 |
| Ilk tur sonrasi GRT ihlali | 655 | 655 |
| Ikinci tur eklenen jumper / net | — | **0 / 0** |
| Ikinci tur sonrasi GRT ihlali | — | **655** |
| OpenROAD CheckAntennas net / pin | 618 / 677 | **618 / 677** |
| RepairAntennas toplam suresi | 4:15 | **6:57** |

Bit-duzeyi kanit: RepairAntennas cikisindaki `top_module.odb` ve
`top_module.def` iki kosumda ayni SHA-256'ya sahiptir; ara `antenna.rpt` de
birebir aynidir. OpenROAD kaynagi (`GlobalRouter.cpp:524-548`) yalnizca
`hasNewViolations()` true ise yeni jumper arar. Ikinci turdaki 655 net ilk
turdan kalan ayni kume oldugu icin bu kosul false olur ve tur no-op kalir.

DRT ayni ODB/DEF girdisiyle baslatildi, fakat yeni bilgi uretmeyecegi bit-duzeyi
karsilastirmayla kanitlandiktan sonra kontrollu durduruldu; bu nedenle bu
deney icin yeni bir post-DRT anten sayisi **OLCULMEDI**. Sonuc: iter=2 RED;
iter=3 de ayni kod yolu nedeniyle denenmeyecek. Ham kanitlar
`deney_arsivi/ant28_jmpi2/` altindadir.

### 21. ANTEN ONARIM MARJI %5 -> %20 — RED (`ant28_jmpm20`, 2026-09-04)

`ant28` adim 43 state'i uzerinde tek degiskenli olarak
`GRT_ANTENNA_REPAIR_MARGIN: 5 -> 20` denendi. Bu ayar foundry anten
esigini degistirmez; yalniz GRT'nin onarim adaylarini daha siki tarar.

| Olcum | marj=%5 (`ant28`) | marj=%20 (`ant28_jmpm20`) |
|---|---:|---:|
| Onarim taramasi girisi | 1.927 | **3.199** |
| Eklenen jumper / net | 1.329 / 1.274 | **2.429 / 2.335** |
| Onarim taramasi kalani | 655 | **870** |
| Pre-DRT gercek anten net / pin | 618 / 677 | **619 / 678** |
| Post-DRT gercek anten net / pin | **955 / 1.013** | **966 / 1.017** |
| Post-DRT katman kaydi m1/m2/m3/m4 | 302/28/658/27 | **313/38/640/28** |
| DRT ihlali | 0 | **0** |
| Tel uzunlugu | 9.991.404 | **9.991.142** |
| Via | 969.608 | **973.333** |
| DRT suresi | 21:19 | **21:26,8** |

Marji dort katina cikarmak 1.100 ek jumper uretti, fakat signoff anten pini
**4**, ihlalli neti **11** artirdi. Met3 kaydi 18 azalirken alt katman
kayitlari artti; ek jumperlar problemi yalniz katmanlar arasinda tasidi.
Sonuc RED; %20 teslim adayina alinmayacak. Ham kanitlar
`deney_arsivi/ant28_jmpm20/` altindadir.

### 22. MET3 KAYNAK CEZASI %20 — ANTEN OLUMLU, ADIM 43 ASIM RED (`ant28_m3a020`, 2026-09-04)

Tek degisken `GRT_LAYER_ADJUSTMENTS` icindeki met3 cezasinin `0 -> 0.20`
olmasidir. Ilk GRT ucuz kapisi ve zorunlu post-GRT resizer yeniden yollamasi
ayri ayri olculdu.

| Olcum | `ant28` | met3=%20 |
|---|---:|---:|
| Ilk GRT anten net / pin | 2.496 / 3.132 | **2.441 / 3.011** |
| Ilk anten katman kaydi m1/m2/m3/m4 | 1.116/292/1.734/159 | **1.042/341/1.631/174** |
| Ilk GRT asimi | 0 | **0** |
| Ilk GRT tel / via | 11.805.741 / 806.068 | **12.029.149 / 811.512** |
| Resizer setup onarimi son WNS | +0,034 | **+0,038** |
| Resizer setup tamponu | 17.436 | **198** |
| Son yeniden yollama tel / via | — | **12.455.500 / 1.024.139** |
| Son yeniden yollama met3 asimi | 0 | **9** |
| Adim 43 sonucu | gecti | **`GRT-0116`, durdu** |
| Resizer adimi suresi | — | **41:51** |

Ilk kapida anten pini 121 (%3,86), met3 kaydi 103 azaldi; fikir fiziksel
olarak gercekten calisiyor. Buna karsilik ilk GRT'nin sifir asimi yeterli
olmadi: zamanlama/hold onarimindan sonra artan net ve via sayisi daraltilmis
met3 kaynaginda 9 asim uretti. Final DRT ve signoff **OLCULMEDI**, cunku akis
zorunlu sifir-asim kapisinda durdu. %20 RED; bir sonraki tek-degiskenli aday
met3=%15. Ham kanitlar `deney_arsivi/ant28_m3a020/` altindadir.

### 23. MET3 KAYNAK CEZASI %15 — YESIL, YENI TESLIM ADAYI (`ant28_m3a015`, 2026-09-04)

%20 deneyinden sonra tek degisken met3 cezasinin `0.20 -> 0.15` olmasidir.
Ucuz GRT, adim 43, DRT ve tum signoff zinciri tamamlandi.

| Olcum | `ant28` | met3=%15 |
|---|---:|---:|
| Ilk GRT anten net / pin | 2.496 / 3.132 | **2.440 / 2.990** |
| Ilk anten katman kaydi m1/m2/m3/m4 | 1.116/292/1.734/159 | **1.043/367/1.584/179** |
| Ilk GRT tel / via | 11.805.741 / 806.068 | **12.063.608 / 809.532** |
| Ilk / adim-43 GRT asimi | 0 / 0 | **0 / 0** |
| Adim-43 setup WNS | +0,034 | **+0,007** |
| Model signoff tahmini | +1,069 | **+1,044** |
| Pre-DRT anten net / pin | 618 / 677 | **614 / 665** |
| Jumper / onarilan net | 1.329 / 1.274 | **1.432 / 1.384** |
| Post-DRT anten net / pin | 955 / 1.013 | **940 / 990** |
| Post-DRT katman kaydi m1/m2/m3/m4 | 302/28/658/27 | **310/33/619/29** |
| Yollama / Magic / KLayout DRC | 0 / 0 / 0 | **0 / 0 / 0** |
| LVS / XOR / illegal overlap / PDN | 0 | **0** |
| 16 zorunlu metrik | tumu 0 | **tumu 0** |
| Setup / hold WS | +0,8987 / +0,0717 | **+0,9291 / +0,0706** |
| Setup / hold ihlalli uc | 0 / 0 | **0 / 0** |
| Max cap / max slew | 14 / 731 | **14 / 770** |
| DRT tel / via | 9.991.404 / 969.608 | **10.205.047 / 974.231** |
| DRT suresi | 21:19 | **19:43** |

Gercek signoff anteni 15 net ve 23 pin azaldi; met3 kaydi 39 dustu. Bedeli
tel +213.643 um (%2,14), via +4.623 ve max slew +39'dur. Setup payi
azalmadi, +0,0303 ns artti; hold kaybi yalniz 0,0011 ns ve hala pozitiftir.
Adim-43 modeli +1,044 ongordu, gercek +0,929 oldu (hata 0,115 ns).
Birincil hedef anten oldugu ve tum zorunlu kapilar korundugu icin YESIL.
Ana `config.yaml` met3=%15'e guncellendi; `run/ant28` ve `run/final28`
degistirilmeden yedek olarak korunuyor.

### 24. MET3=%15'I AKIS BASINDAN UYGULAMA — GRT RED (`ant28_m3a015_clean`, 2026-09-04)

Checkpoint kosumunun teslim provenance'ini temizlemek icin met3=%15 ana
`config.yaml` icine alinip standart iki-faz `make asic_run` bastan kosuldu.
Bu, met3 ayarinin uygulama zamanini degistirdigi icin onceki deneyle ayni
fiziksel kosum degildir: ayar `RepairDesignPostGPL` icindeki erken GRT'yi de
etkiledi.

| Olcum | checkpoint (%15 adim 39'dan sonra) | bastan %15 |
|---|---:|---:|
| Adim-38 instance | 253.325 | **253.113** |
| Adim-38 timing-repair buffer | 30.208 | **29.981** |
| Ana GRT tel / via | 12.063.608 / 809.532 | **12.348.840 / 861.210** |
| Ana GRT met3 asimi | 0 | **3** |
| Sonuc | devam etti | **`GRT-0116`, durdu** |

Yani ayar erken adimlari da degistiriyor; %15'in kazanci yalnizca adim 39
ve sonrasina uygulaninca yeniden uretiliyor. Fiziksel esik veya checker
gevsetilmedi. Resmi `make asic_run` bu olcume dayanarak uc faza ayrildi:
taban config ile adim 38, met3 overlay'iyle adim 39-43, ardindan jumper ve
signoff. Bu basarisiz kosumda DRT/signoff **OLCULMEDI**.

### 25. UC FAZLI MET3=%15 TEMIZ YENIDEN URETIM — YESIL (`ant28_m3a015_clean`, 2026-09-04)

Guncellenen zorunlu `make asic_run` bastan sona kosuldu: faz 1 taban config
ile adim 38'e, faz 2 met3=%15 ile adim 43'e, faz 3 met3=%15 + jumper ile
signoff sonuna gitti. `flow.log` tam **3** gercek baslangic kaydi tasiyor;
birlesik/duzenlenmis log kullanilmadi.

| Olcum | `ant28` | temiz uc-faz `%15` |
|---|---:|---:|
| Ilk GRT anten net / pin | 2.496 / 3.132 | **2.440 / 2.990** |
| Ilk GRT tel / via | 11.805.741 / 806.068 | **12.063.594 / 809.533** |
| Ilk / adim-43 GRT asimi | 0 / 0 | **0 / 0** |
| Adim-43 setup WNS | +0,034 | **+0,009** |
| Onarim taramasi giris / kalan | 1.927 / 655 | **1.994 / 645** |
| Jumper / onarilan net | 1.329 / 1.274 | **1.394 / 1.353** |
| Pre-DRT anten net / pin | 618 / 677 | **608 / 663** |
| Post-DRT anten net / pin | 955 / 1.013 | **926 / 979** |
| Post-DRT katman m1/m2/m3/m4 | 302/28/658/27 | **300/39/611/30** |
| Setup / hold WS | +0,8987 / +0,0717 | **+0,9975 / +0,0711** |
| Setup / hold ihlalli uc | 0 / 0 | **0 / 0** |
| Max cap / max slew | 14 / 731 | **14 / 734** |
| DRT tel / via | 9.991.404 / 969.608 | **10.203.929 / 973.079** |
| Yollama / Magic / KLayout DRC | 0 / 0 / 0 | **0 / 0 / 0** |
| LVS / XOR / illegal overlap / PDN | 0 | **0** |
| 16 zorunlu metrik | tumu 0 | **tumu 0** |
| DRT suresi | 21:19 | **19:38** |

Checkpoint kosumundan daha da iyi olarak anten 29 net ve 34 pin azaldi.
Setup +0,0987 ns iyilesti; hold yalniz 0,0006 ns azaldi ve pozitiftir. Tel
+212.525 um (%2,13), via +3.471, max slew +3 bedeldir. Paketleme zinciri
`collect.py -> gen_versions.py -> gen_readme_results.py -> gen_checksums.py
-> make asic_verify` tamamlandi: **79/79, PAKET KAPISI GECTI.** Bu kosum yeni
teslim tabanidir; `run/ant28` ve `run/final28` degistirilmedi.

### 26. DIE 4200x3000 + PHI 1.01 UCUZ GPL PROBU — RED (`gplprobe_die3000`, 2026-09-04)

Gorev belgesinde hazir verilen `experiments/gpl_die3000_phi101.yaml` probu
`OpenROAD.GlobalPlacement` sonuna kadar kosuldu. Die, ona ait makro yerlesim
dosyasi ve phi=1.01 birlikte belgedeki tek probe paketidir.

| Olcum | 4200x3600 taban | 4200x3000 probe |
|---|---:|---:|
| Die alani | 15,12 mm2 | **12,60 mm2 (-%16,7)** |
| GPL bitis iterasyonu | 7.682 | **11.150** |
| Bitsin overflow | 0,1000 | **0,0999** |
| GPL-1001 normal bitis | evet | **evet** |
| HPWL | 5.912.343 um | **30.967.840 um** |
| HPWL orani | 1,00x | **5,238x (+%423,8)** |
| Routability weighted congestion | 1,0955 | **2,7112** |
| GPL suresi | — | **14:16** |
| GPL tepe RSS | — | **1 GiB** |

Cozucu artik sonsuz iraksamadi ve sayisal bitis uretti; fakat fiziksel sonuc
10 milyon um kabul kapisinin uc katindan da kotudur. Bu nedenle DPL/CTS/GRT,
30 MHz veya signoff **OLCULMEDI**. Die-kucultme buyuk kaldiraci RED; ayni
4200x3000 probe tekrar denenmeyecek. Ham kanitlar
`deney_arsivi/gplprobe_die3000/` altindadir.

### 27. BAGIMSIZ DENETIM — ONCEKI SONUCLARIN UCU CURUTULDU (2026-09-04)

Temiz oturumlu bagimsiz bir denetim kosuldu. Uc sonucumuzu curuttu; ucu de
BIRINCIL KAYNAKTAN yeniden dogrulandi ve DOGRU cikti.

#### C1 — "Diyot yolu olcumle kapali" SONUCU YANLIS TEMELE DAYANIYORDU

Elemenin dayandigi deney: `deney_arsivi/exp_macro_ring_repair_antenna_drt_rejected`
(die 4200x3600, yani MEVCUT floorplan). Belgede soyle yazilmisti:
    "yaklasik 2.930 diyot ikinci turun baslangic DRC yukunu 199.573'e cikardi"

GERCEK LOG (`openroad-detailedrouting.log.gz`):
    [INFO ANT-0002] Found 2930 net violations.     <- NET sayisi
    [INFO GRT-0015] Inserted 9587 diodes.          <- gercek DIYOT sayisi

**2.930 NET sayisidir, diyot degil.** Gercek diyot 9.587'dir (3,3 kat).
Bu, eski elemenin nicel temelini curutur. Ancak basarisizligin yalniz
"yasallastirilmamis hucre"den geldigi soylenemez: OpenROAD kaynagi diyot
ekledikten sonra detailed placement/legalization cagiriyor. Kanitlanan olgu,
DRT-ici 9.587 diyotlu deneyin sonraki yollamayi patlatmasidir; kesin kok
neden daha dar olarak OLCULMEDI.

**KRITIK AYRIM:** o deney diyotlari DRT DONGUSU ICINDE ekliyordu
(`DRT_ANTENNA_REPAIR_ITERS>0`). Adim 44'teki `OpenROAD.RepairAntennas`
(GRT asamasi) bir CompositeStep'tir ve yerlesimi DRT BASLAMADAN yasallastirir.
**GRT asamasi diyot yolu hic denenmedi** -- mevcut faz-2 overlay'imiz
`GRT_ANTENNA_REPAIR_JUMPER_ONLY: true` ile diyotlari acikca kapatiyor.

#### C2 — DIYOT FIZIGI: LIMITI ~7 KAT YUKSELTIYOR (dogrulandi)

Ihlaller "Gate area" degil **"Side area"** kuralindandir:
    antenna.rpt: Required ratio: 400.00 (Side area) (VIOLATED)

SKY130 tech LEF, met katmanlari:
    ANTENNADIFFSIDEAREARATIO PWL ( (0 400) (0.0125 400) (0.0225 2609) (22.5 11600) )

Sinir, nete bagli DIFUZYON alaninin fonksiyonudur.
`sky130_fd_sc_hd__diode_2` LEF: `ANTENNADIFFAREA 0.434700`.

**BU TASARIMIN KENDI RAPORUNDA DOGRULANIYOR** -- difuzyonu olan netlerin
gercek `Required` degerleri:
    2.778,20 (175 satir) · 2.956,40 (177) · 3.134,60 (624) · 3.312,80 (403)
    · 3.669,20 (122) · 3.872,32 (41)
Difuzyonsuz olanlar: 400,00 (3.410 satir).

Olculen P/R dagilimi: medyan 1,51x, en kotu 14,34x. **7 kat limit artisi
ihlallerin ezici cogunlugunu temizler.**

**TAHMINI BEDELI COK KUCUK:** `diode_2` giris kapasitansi 0,000981 pF ve PARALEL
YAPRAKTIR -- yola SERI GECIKME EKLEMEZ. Karsilastirma: tel bolme tamponu
0,002414 pF + ~0,25-0,37 ns seri gecikme. Alan: ~955 diyot ~ core'un %0,016'si.
Bu fiziksel veriler kaynaktan dogrulandi; GRT-diyotlu kosumun gercek diyot
sayisi, routing ve zamanlama bedeli henuz OLCULMEDI.

**IKINCI AVANTAJ:** diyot netlist hucresidir, jumper yalnizca guide
geometrisidir. Olculdu: adim 44 cikisi 618 net -> adim 48 (DRT sonrasi) 955 net;
DRT sonrasinda net sayisi 337 (%54,5) artiyor. Diyot bir netlist/ODB instance'i
oldugu icin DRT onu jumper guide'i gibi kaldiramaz; yine de yeni geometri ve
yeni anten ihlalleri uretebilir, toplam kazancin korunacagi garanti degildir.

#### C3 — `HeuristicDiodeInsertion` CELL_PADDING GEREKTIRMIYOR

Iddia: "calismasi icin GPL/DPL_CELL_PADDING > 0 gerekiyor".
LibreLane kaynagi (`steps/odb.py:746-751`):
    "GPL_CELL_PADDING ... Used by this step only to emit a warning if it's 0."
`steps/odb.py:783-786` yalnizca `self.warn(...)` cagiriyor.
Adim bir CompositeStep'tir, yerlesimi kendisi yasallastirir.
Olculen padding maliyeti (tel 16,5->24,6 m) `GPL/DPL_CELL_PADDING: 4/2`
AYARININ maliyetidir, adimin degil. **Bu yol da acik sayilmalidir.**

#### C4 — "met3 jumper'la ulasilamaz" ABARTILI
Gercek met3 payi 658/1.015 = **%64,8** (%72,6 degil). Ilk GRT'deki 1.734
kaydinin post-DRT'de 658'e inmesi end-to-end olcumdur; arada baska routing
adimlari da vardir. Bu nedenle "hic etkileyemez" hukmu fazla kesin, fakat
-%62'nin tamamini yalniz jumpere atfetmek de OLCULMUS degildir.

#### C5 — Tel bolme kalan ihlallerin ~%36'sini KENDISI URETTI (yeni)
Ihlalli pinin sahibi hucre tipine gore:
    ant28  : 1.015 satirin **401'i (%39,5)** tampon hucresi uzerinde (363'u `wire*`)
    final28: 1.927 satirin 335'i (%17,4)
`wire*` hucreleri `GRT_DESIGN_REPAIR_MAX_WIRE_LENGTH: 250`'nin kendi urunudur.
Her eklenen tampon YENI BIR KAPI PINI = yeni anten kontrol noktasi yaratir.

#### C6 — SRAM makrolari anten kontrolune GORUNMEZ (nicelendi)
`15-odb-checkmacroantennaproperties`:
    "Cell 'sky130_sram_2kbyte_1rw1r_32x512_8' has (59) input pin(s) without
     antenna gate information."
Makro LEF'leri ayri sayildi: 14 adet 2K SRAM x 59 pin + 1 adet 1K SRAM x
57 pin = **883 input pininde antenna gate bilgisi yoktur**. Bu, checker'in
makro inputlarinda iyimser kalabilecegini gosterir; 883 ek ihlal var demek
degildir. Makro LEF degistirilemez; README'de beyan edilmeli.

#### STRATEJIK SONUC

Diyot adim 44'te calisirsa **tel bolmenin geri alinabilmesi kuvvetli bir
hipotezdir**
(`GRT_DESIGN_REPAIR_MAX_WIRE_LENGTH: 0`, `CTS_CLK_MAX_WIRE_LENGTH: 0`) ve
setup payi +0,899 -> **+2,52 ns civarina** donebilir (`final28` tabani).
Diyot kapasitansi ve yeniden yollama nedeniyle bu zamanlama sonucu OLCULMEDI.
`run/final28` deneme tabanini diskte tutuyor.

**Onerilen ucuz sinama (~5 dk):** `antenna_jumper.yaml` kopyasinda tek degisken
`GRT_ANTENNA_REPAIR_JUMPER_ONLY: false`; faz 2'yi `run/final28` adim 43
state'inden baslat; adim 44 cikisindaki `antenna_diodes_count` + CheckAntennas
sayisi hemen gorulur. Tartismasiz teslim kabul kapisi: DRT/signoff DRC = 0,
post-DRT anten < **926 net / 979 pin**, setup tercihen > +2,0 ns ve tum
zorunlu metrikler sifir. 926-955 net arasi sonuc yalniz Pareto adayi sayilir.

#### C7 — TOPLAMA ETIKETI VE PAKET TUTARLILIGI (2026-09-04)

Final Ciktilar Bolum 6/9.12 kosum etiketinin README'de beyanini zorunlu
tutar; `results/config/run_tag.txt` dosyasini zorunlu tutmaz. `collect.py`
sonradan bu yardimci dosyayi yazacak sekilde degistirildi, fakat mevcut
pakette dosya yokken README ona atif yapiyor ve verifier onu kontrol etmiyor.
Son 79/79 sonucu bu eszamanli degisiklikten ONCE alinmistir. Bir sonraki resmi
collection'da gercek kosum etiketi, README, checksum ve verifier yeniden
birlikte dogrulanmalidir. `Path.resolve().name`, gecici merged-view diziniyle
collection yapilirsa gercek etiketi yanlis kaydedebilir.

### 21. DIYOT PROBE'U OLCULDU (`run/diode28`, 2026-09-04) — KISMEN BASARILI

`final28` adim 43 state'inden, TEK DEGISKEN:
`GRT_ANTENNA_REPAIR_JUMPER_ONLY: true -> false` (jumper + diyot).
Overlay: `experiments/antenna_jumper_diode.yaml`.

**Adim 44 (GRT asamasi) — HIPOTEZ DOGRULANDI:**

| | `final28` (yalniz jumper) | `diode28` (jumper+diyot) |
|---|---:|---:|
| Ihlalli net | 1.117 | **448 (-%60)** |
| Ihlalli pin | 1.501 | **527 (-%65)** |
| Eklenen diyot | 0 | **3.042** |
| Eklenen jumper | — | 1.635 (1.420 net) |

Diyot alani: 3.042 x 2,5024 um² = 7.612 um² = core'un **%0,051'i**.

**DRT SONRASI — HIPOTEZ KISMEN CURUDU:**

| Kosum | adim 44 | post-DRT | **buyume** | DRT iter / sure |
|---|---:|---:|---:|---|
| `final28` | 1.117 | 1.478 | 1,32x | 8 / 17:34 |
| `ant28` | 618 | 955 | 1,55x | 8 / 21:19 |
| **`diode28`** | **448** | **1.043** | **2,33x** | **17 / 1:01:36** |
| `ant28_m3a015` (teslim) | — | **926** | — | — |

**KOK NEDEN OLCULDU:** 3.042 diyot yollamayi cok zorlastirdi.
Baslangic DRC 131.148 (taban 52.836, 2,5 kat), 17 iterasyon (taban 8),
sure 1:01:36 (taban 17:34, 3,5 kat). Agresif yeniden yollama YENI anten
ihlalleri uretti. Nihai DRC yine de **0**; tel 10.081.754 um (+%1,2).

**SONUC:**
- Kendi tabanini (final28 1.478) belirgin gecti: **-%29**.
- Mevcut teslim paketini (926) GECEMEDI: 1.043 > 926.

**MODEL HATASI KAYDI:** bagimsiz denetimin "net basina 1 diyot ile
ihlallerin %98,8'i temizlenir" tahmini, mevcut P/R dagilimindan yapilan
STATIK bir hesapti ve DRT'nin yeniden yollamada URETTIGI yeni ihlalleri
hesaba katmiyordu. Gercek: GRT'de %60 dustu, DRT'de 2,33 kat geri geldi.
bagimsiz denetim bu riski onceden isaretlemisti ("OpenROAD kapi basina birden fazla
diyot ekleyebilir, yeniden yollama yeni geometri/ihlal uretebilir") --
uyari dogru cikti. **Anten tahminlerinde DRT buyume faktoru artik ZORUNLU
olarak modellenmelidir ve diyot durumunda o faktor daha BUYUKTUR (2,33x),
cunku diyotlar yollamayi zorlastirir.**

### 22. IKI OLCUM DUZELTMESI (2026-09-04, kendi hatalarim)

**D1 — "1,5 ns'yi asan 8 IC pin var" IDDIAM YANLISTI.**
`reports/timing/max_ss_100C_1v60/checks.rpt` icinde 1,5 ns ustu 12 kayit var.
Pin adlarindan 4'unu QSPI portu, 8'ini "ic pin" saymistim. NETLIST IZI
(`results/netlist/top_module.nl.v`) 12'sinin de DORT QSPI_IO inout agina
ait oldugunu gosteriyor:

    _128391_ .. _128394_  = sky130_fd_sc_hd__ebufn_8  (tristate surucu,
                            QSPI_IO0..3 uzerinde)
    wire30089/A, load_slew30083/A, load_slew30085/A, hold30268/A
                          = ayni aglardaki tamponlar

Yani kutuphanenin kendi `default_max_transition` degerini (1,5 ns) asan
**tek bir saf-ic pin YOKTUR**. Bu teslim icin DAHA IYI bir sonuctur: limiti
asan her kayit, slew'i ic mantik kalitesinden degil HARICI YUK MODELINDEN
(`OUTPUT_CAP_LOAD = 33,442 fF`, SDC tum ciktilara uygular) gelen cift yonlu
bir I/O agindadir. bagimsiz denetim bu duzeltmeyi yapti, netlist izinden dogrulandi.

**D2 — "16 zorunlu metrik sifir" IFADESI YANILTICI.**
Iki farkli 16'lik liste dolasiyor ve ikisinin de 16 olmasi tesadufi:

  (a) Benim kullandigim liste: setup vio, hold vio, route/Magic/KLayout DRC,
      6 LVS sayaci, XOR, illegal overlap, PDN, max fanout -> hepsi 0. DOGRU.
  (b) `verify_deliverables.py:158-175` icindeki `REQUIRED_ZERO_METRICS`:
      yukaridakilerin bir kismi + **antenna__violating__nets (926)**,
      **antenna__violating__pins (979)**, **design__disconnected_pin__count
      (480)** -> bu listeye gore sonuc **13/16**.

**README bu ifadeyi HIC kullanmiyor** (kontrol edildi); yalnizca
`reports/synthesis/` altindaki ic calisma raporlarinda geciyor. Yine de
kayit tutarsizdir. Bundan sonra "16 zorunlu metrik sifir" denmemeli;
dogru ifade: **"79/79 paket kapsami tam; DRC/LVS/XOR/PDN/setup/hold sifir;
anten ve baglantisiz pin sifir degil ve README'de acikca beyan ediliyor."**

---

## 2026-09-05 — GUNCEL UART RTL'SINDE MET3 %15 → %10 KABUL DENEYI

UART boot ROM bolucusu duzeltmesinden sonraki temiz faz-1 durumu
`run/uart28/38-openroad-stamidpnr-2/state_out.json` ortak baslangic olarak
kullanildi. Izole edilen tek degisken `GRT_LAYER_ADJUSTMENTS` listesindeki
met3 degeridir; diger butun yapilandirma ve fiziksel durum aynidir.

| Olcum | met3 %15 | met3 %10 |
|---|---:|---:|
| Ilk GRT toplam asim | **56** (met1 8, met2 1, met3 47) | **0** |
| Ilk GRT tel uzunlugu | 12.582.432 um | **12.244.153 um** |
| Ilk GRT via | 867.282 | **820.652** |
| Ilk GRT routed net | 101.650 | 101.650 |
| Ilk GRT final 3D kullanim | 4.112.494 | **3.925.521** |

**%15 REDDEDILDI:** LibreLane `GRT-0116` ile faz 2'nin ilk
`OpenROAD.GlobalRouting` adiminda durdu. Bu nedenle guncel UART RTL'si icin
detayli yollama veya signoff uretebilen bir aday degildir.

**%10 ikinci kapisi (`run/uart28_m3a010_phase2`) GECTI:** ayni %10
GlobalRouting durumundan `CheckAntennas` → `RepairDesignPostGRT` →
`ResizerTimingPostGRT` zinciri tamamlandi (`Flow complete`). Ara tasarim
onarimi yeniden yollamasi 0 asim / 12.309.669 um / 820.885 via; son timing
resizer yeniden yollamasi **0 asim / 12.676.507 um / 982.634 via** olctu.
Son yeniden yollamada 137.298 net vardi.

Post-GRT timing olcumu: setup WNS −5,928 ns'den **+2,078 ns**'ye cikti
(889 boyutlandirma, 214 setup tamponu); hold WNS +0,019 ns'den hedeflenen
**+0,450 ns**'ye cikti (210 sayilan hold tamponu). Adim sonunda 282.394
standart hucre, bunun 66.299'u timing-repair buffer olarak raporlandi.

**KARAR — %10 KABUL:** %15'in guncel RTL'de akisi durdurmasi ve %10'un
post-GRT resizer dahil uc ayri yeniden yollamayi sifir asimla tamamlamasi
nedeniyle `grt_layer_met3_010.yaml` resmi faz 2/3 overlay'i yapildi.

### Resmi temiz kosumun DRT ve signoff sonucu

`uart28_m3a010_final` etiketiyle sifirdan baslatilan resmi uc-fazli kosum
tamamlandi. Toplanan `results/metrics/metrics.json` ve signoff raporlarinin
olculen sonucu:

| Olcum | Sonuc |
|---|---:|
| DRT / Magic / KLayout DRC | **0 / 0 / 0** |
| LVS / XOR / PDN / illegal overlap | **0 / 0 / 0 / 0** |
| Setup / hold ihlalli uc (9 kose) | **0 / 0** |
| Setup / hold TNS (en kotu) | **0 / 0 ns** |
| En kotu setup / hold WS | **+2,449671 / +0,284925 ns** |
| Anten net / pin | **1.066 / 1.137** |
| Max slew / max cap | **830 / 21** |
| Kritik baglantisiz / toplam baglantisiz pin | **0 / 480** |
| Standart hucre / std-cell dolulugu | **282.394 / %15,4481** |
| Tel / via | **10.445.368 um / 990.254** |

Tam signoff, %10 adayinin yollanabilirligini ve zamanlama kapanisini
dogruladi. Anten sonucu onceki RTL'deki %15 teslim kosumunun 926/979
degerinden kotudur; ancak %15 guncel RTL'de GRT kapisini gecemedigi icin
ayni RTL'de tam signoff karsilastirmasi yoktur. Bu nedenle %10 kabul karari
korundu; anten 1.066/1.137 acik istisna olarak teslim belgelerine yazildi.
