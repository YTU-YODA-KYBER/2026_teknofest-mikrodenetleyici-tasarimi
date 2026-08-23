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

## Global routing tikanmasinin kok nedeni: makro katman engelleri

Ilk sekiz denemede global routing yakinsamadi. Die boyutu, hucre dolgusu,
yerlestirme yogunlugu ve makro araligi tek tek denendi; hicbiri sorunu
cozmedi ve **die buyutmek olcum bazinda ters etki yapti** (3600x3200
denemesi 257.887 overflow ile 3400x2900'un 133.432'sinden kotuydu).

Yon veren olcum 7. denemenin tikanma raporu oldu:

| Katman | Yon | Kaynak | Talep | Kullanim | Overflow |
|---|---|---|---|---|---|
| met1 | yatay | 888.056 | 601.397 | %67,7 | 19.359 |
| met2 | **dikey** | 1.026.462 | 635.853 | %62,0 | **29.847** |
| met3 | yatay | 929.323 | 423.739 | %45,6 | 13.036 |
| met4 | **dikey** | 628.088 | 178.356 | %28,4 | 9.149 |
| met5 | yatay | 116.039 | 26.994 | %23,3 | 1.518 |
| **Toplam** | | 3.587.968 | 1.866.339 | **%52,0** | **72.909** |

Toplam kullanim yalnizca **%52** iken overflow 72.909'du. Yani darbogaz genel
kaynak kitligi degil, **yerel** kanal darligiydi -- die buyutmenin neden
yardim etmedigi de bu.

Yerel darligin sebebi SRAM makrolarinin LEF'indeki engel (OBS) tanimlarinda
bulundu. `sky130_sram_2kbyte_1rw1r_32x512_8.lef` icin olculen degerler:

| Katman | Yon | Makro uzerinde durum |
|---|---|---|
| met1 | yatay | tek rect ile **tamamen kapali** |
| met2 | **dikey** | tek rect ile **tamamen kapali** |
| met3 | yatay | 61 rect, alanin %98,1'i kapali; kesintisiz gecis yolu **yok** |
| met4 | **dikey** | 143 rect, alanin %98,8'i kapali; kesintisiz gecis yolu **yok** |
| met5 | yatay | engel tanimi **yok** -- tamamen serbest |

SKY130'da dikey yonlu iki katman met2 ve met4'tur; **ikisi de makro uzerinden
gecemez.** Dolayisiyla cipin bir yanindan digerine giden her dikey tel
yalnizca makrolar ARASINDAKI sutun kanallarindan gecebilir. Yatay tarafta ise
met5 makro uzerinde serbest oldugu icin kacis yolu vardir -- met2'nin neden en
kotu katman oldugunu bu asimetri aciklar.

4x4 izgarada sutun araligi 120 um'ydi; ic dikey kanal toplami 3 x 120 = 360 um
ediyordu (die 3500 um genis oldugu halde). Yerlesim **3 sutun x 5 satira**
alindi:

| | 4x4 (1-9. denemeler) | 3x5 (10. deneme) |
|---|---|---|
| Ic dikey kanal (met2/met4) | 3 x 120 = **360 um** | 2 x 400 = **800 um** |
| Ic yatay kanal (met1/met3) | 3 x 250 = 750 um | 4 x 200 = 800 um |
| Die | 3500 x 3000 = 10,50 mm² | 3500 x 3210 = 11,24 mm² |
| Makro alani orani | %39,8 | %37,2 |

Yukseklik 210 um artirildi; boylece sutun kanallari genislerken satir
kanallari daralmadi. IMEM ve DMEM 2x2 banka kumesi olarak korundu; 3 sutunlu
izgarada bir bellegin dikey yigin olmasi kacinilmazdir ve bunun icin YZ girdi
RAM'i secildi (hizlandirici oraya cevrim basina tek kelime erisir, CPU'nun
kritik yolunda degildir).

Olcumler `scripts/gen_macro_placement.py` ile yeniden uretilebilir; izgara
secimi `--grid {4x4,3x5}` argumanindadir.

## 10-12. denemeler: iki hipotez elendi, bir tanesi dogrulandi

**10. deneme -- makro izgarasi 3x5 (yanlis cikti).** Yukaridaki "dikey kanal
darligi" teshisine gore izgara 3 sutun x 5 satira alindi ve ic dikey kanal
360 -> 800 um'ye cikarildi. Sonuc **kotulesti**: overflow 72.909 -> 447.323,
tel uzunlugu 16,6 -> 22,3 mm (+%34). Kanal genisligi darbogaz degilmis; die
buyudukce (10,50 -> 11,24 mm²) yerlestirici hucreleri daha genis alana
yayiyor, netler uzuyor ve talep kaynaktan hizli artiyor. Tek olumlu yani
zamanlamayi iyilestirmesiydi (CTS sonrasi TNS -6,596 -> -0,453 ns).

**11. deneme -- `CTS_APPLY_NDR: none` (yanlis cikti).** Die, izgara, katman
payi ve fanout 7. denemeyle birebir ayni tutuldu; tek degisken NDR'ydi.
Kaynak (3.587.968) ve net sayisi (92.860) iki kosumda da ayni cikti, yani
karsilastirma temizdi:

| | 7. deneme (NDR varsayilan) | 11. deneme (NDR none) |
|---|---:|---:|
| Talep | 1.866.339 | 2.195.883 (+%18) |
| Tel uzunlugu | 16,57 mm | 19,98 mm (+%21) |
| Overflow | **72.909** | 253.521 |

Saat agaci NDR'siz daha genis yayiliyor; met1/met2'de kazandirdigi paydan
fazlasini tel uzunlugu olarak geri aliyor. Ayar geri alindi.

**12. deneme -- tasarim onarimi marji (dogrulandi, ama kazanc kucuk).**
Yerlestirme yogunluk haritasi cikarildi: hucreler makro satirlari arasindaki
bantlarda toplaniyor, makro alanlari bos. Mutlak yogunluk en yogun bolgede
bile ~%23; yani hucreler sikisik degil, sorun **topolojidir** -- 5 ince yatay
ve 3 dar dikey koridor var ve die'i kesen butun trafik bunlardan geciyor.

`repair_design` varsayilan olarak kutuphane slew/kapasitans sinirinin **%20
altina** kadar onarim yapar. Marj 0'a cekildi:

| | marj %20 | marj 0 |
|---|---:|---:|
| Slew ihlali | 3.750 | 3.101 |
| Kapasitans ihlali | 1.608 | 1.258 |
| Fanout ihlali | 858 | 858 |
| Eklenen tampon | 15.783 | **11.938** |
| Yollanan net | 92.860 | **88.795** |
| Overflow | 72.909 | **69.399** |

Mekanizma calisti (net sayisi tam da eksilen tampon kadar dustu) ama overflow
yalnizca %4,8 iyilesti. Marj sifirlanmasina ragmen 3.101 slew ihlalinin
kalmasi da sunu soyluyor: bu netler marj yapaylıgı degil, gercekten uzun.

### Ozet: neden ayar aralığı yetmiyor

On iki denemede en iyi sonuc 69.399 overflow'dur ve her knob sonucu ancak
%5 mertebesinde oynatmaktadir. Tablo su noktada:

- ortalama kaynak kullanimi **%52,8** -- genel darlik yok
- tile basina en kotu asim **17/17** -- asim genise yayilmis, derin degil
- toplam overflow / toplam kaynak = **%1,9**

Bu profil global router'in kaba izgara tahminidir; gercek yollamayi DRT yapar
ve yerel tikanmayi cozmekte GRT'den cok daha yeteneklidir. 13. deneme bu
yuzden `GRT_ALLOW_CONGESTION: true` ile DRT'ye gecmektedir. Bayrak ihlali
gizlemez -- belirleyici olan DRT'nin kendi DRC sonucudur ve o da Magic ile
KLayout tarafindan bagimsiz dogrulanir.
