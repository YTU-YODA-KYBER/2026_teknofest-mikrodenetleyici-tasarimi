# Saat periyodu kalibrasyonu

Beyan edilecek ASIC saat frekansi TAHMIN EDILMEDI, olculdu. Yontem ve
gerekce `asic/scripts/calibrate_clock.py` basligindadir: tek bir CTS
veritabani uzerinde yalniz `OpenROAD.ResizerTimingPostCTS` adimi farkli
`CLOCK_PERIOD` degerleriyle tekrar kosuldu. O adim STA_CORNERS'in
tamamini yukler, dolayisiyla baglayici yavas kose (`nom_ss_100C_1v60`)
dahil butun corner'lari kapsar -- `OpenROAD.STAMidPNR` ise yalnizca
`DEFAULT_CORNER`'i kosar ve bu soruyu cevaplayamaz.

Girdi CTS veritabani: `run/calib2/07-openroad-cts/state_out.json`

| Periyot | Frekans | Sonuc | Baslangic WNS | Baslangic ihlal | Son WNS | Kalan ihlal | Onarim eforu (sok/buyut/ekle) | Sure |
|---:|---:|---|---:|---:|---:|---:|---|---:|
| 25 ns | 40.00 MHz | ihlalli | -17.441 | 1850 | -5.667 | 1850 | — | 0.0 dk |
| 35 ns | 28.57 MHz | **TEMIZ** | -7.441 | 515 | 0.028 | 1 | 89/143/30 | 0.0 dk |
| 36 ns | 27.78 MHz | **TEMIZ** | -6.441 | 494 | 0.009 | 4 | 56/81/18 | 0.0 dk |
| 38 ns | 26.32 MHz | **TEMIZ** | -4.441 | 297 | 0.058 | 0 | 13/26/9 | 0.0 dk |
| 40 ns | 25.00 MHz | **TEMIZ** | -2.441 | 66 | 0.088 | 0 | 6/6/6 | 0.0 dk |

## Secim kurali

**final WNS bir PAY OLCUSU DEGILDIR.** `repair_timing` slack'i
maksimize etmez; `-setup_margin 0.05` ile verilen 50 ps'lik ic hedefe
ulasir ulasmaz durur. Olculen deger bunu acikca gosteriyor: 35 ns'de
final WNS +0,028 ns, 38 ns'de +0,058 ns -- periyot 3 ns uzadigi halde
'pay' neredeyse ayni, cunku ikisinde de resizer ayni esikte durmustur.

Anlamli olan iki sey vardir:

1. **Kalan ihlalli uc sayisi.** Sifir ise resizer hedefini TAM
   tutturmustur, yani her ucun slack'i en az 50 ps'tir. Sifirdan
   buyukse (or. 35 ns'de 1 uc) tasarim o periyotta sinirdadir.
2. **Baslangicta ihlalli uc sayisi.** Onarim oncesi kac ucun
   sikistigi, periyodun ne kadar zorlandiginin dogrudan olcusudur.

Secim: **kalan ihlal sifir olan en kucuk TEST EDILMIS periyot**.

> Bu bir MUTLAK minimum degildir. Yalnizca --periods ile verilen degerler
> olculur; aradaki test edilmemis periyotlar (or. 37 ns) daha iyi olabilir.

> Nihai ve baglayici rakam yine de bu tablo DEGILDIR. Post-CTS
> parazitikler TAHMINIDIR ve bu akista `RUN_POST_GRT_RESIZER_TIMING`
> kapalidir (LibreLane varsayilani), yani yollama sonrasi ikinci bir
> zamanlama onarimi yoktur. Beyan edilen frekans, parazitik cikarim
> sonrasi `OpenROAD.STAPostPNR` sonucuyla DOGRULANMALIDIR; o sonuc
> README'nin *Signoff sonuc ozeti* bolumundedir.

## Sonuc

Bu tablonun onerdigi deger **38 ns = 26.32 MHz** idi (resizer sifir ihlale
ulasti; baslangicta 297 ihlalli uc vardi).

> **DIKKAT -- teslimde kullanilan deger bu DEGILDIR.** `config.yaml` icindeki
> `CLOCK_PERIOD` **35.714285714285715 ns (28 MHz)**'dir. Sebep: bu kalibrasyon
> post-CTS tahmini parazitiklerle calisir ve BAGLAYICI degildir; bagimsiz tam
> kosumlarla 28 MHz'in dokuz signoff kosesinde setup+hold ile kapandigi
> DOGRULANMISTIR (bkz. asic/README.md, "Frekans secimi" bolumu). 30 MHz iki kez
> tam kosumla denenmis ve ikisinde de signoff zamanlamasinda dusmustur; kosumdan
> kosuma dagilim ~2,4 ns olculdugu icin 28 MHz secilmistir.

**Test edilen periyotlar:** 25, 35, 36, 38, 40 ns. Aradaki degerler olculmedigi icin bu deger MUTLAK minimum degil, olculen aday kumesinin en kucugudur.

Sinirda kalan (kapaniyor ama resizer hedefini tutturamadi): 35 ns (1 uc kaldi), 36 ns (4 uc kaldi).