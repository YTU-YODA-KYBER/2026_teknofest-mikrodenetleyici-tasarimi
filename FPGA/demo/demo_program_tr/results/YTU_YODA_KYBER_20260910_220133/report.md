# Demo Degerlendirme Raporu - YTU YODA KYBER

- Tarih: 2026-09-10T22:01:33+03:00
- Harness surumu: 1.0.1
- Konfigurasyon kaynagi: `/home/luxyxp/Documents/mainfiles/FPGA/demo/ytu_yoda_kyber_icd.json`
- Etkin konfigurasyon: `config_used.json` (SHA256 `27df781a3bc4b94e`)
- Veri seti: /home/luxyxp/Documents/mainfiles/FPGA/demo/demo_program_tr/public_dataset/manifest.csv | seed: 1337
- Arayuzler: stream `/dev/ttyUSB0@1000000`, core `/dev/ttyUSB2@3000000`

## 1. Ozet - RTL / Golden Model Uyumu

> **Olculen sey modelin dogrulugu degil, tasarimin golden modele sadakatidir.**
> Birincil olcut, donanimin urettigi sinifin golden modelin ayni vektor icin
> urettigi sinifla ayni olmasidir. Gercek etiket (truth) yalnizca bilgi
> amaciyla raporlanir ve puanlamada kullanilmaz.

| Metrik | Deger |
|---|---|
| Gonderilen ornek | 156 |
| Golden referansi olan | 156 |
| Yanitlanan | 156 |
| **Golden ile uyum** | 100.00 %  (156/156) |
| Uyusmazlik | 0 |
| Zaman asimi (referansli ornek) | 0 |
| Uyum (zaman asimlari da hata sayilirsa) | 100.00 % |
| **Golden skor hata orani (MAE)** | 0.0050 % |
| Skor karsilastirilan ornek | 156 |
| En yuksek ornek-bazli skor hatasi | 0.7812 % |
| Gecikme (medyan / p95 / max) | 8.21 / 9.23 / 9.32 ms |
| Olculen hizlanma (yazilim / donanim) | 30.7x |
| Saglamlik senaryolari | 10 / 10 (+1 opsiyonel atlandi) |

> Skor hata orani yalnizca ek bilgidir ve puanlamada kullanilmaz. UART'tan
> gelen dort skor, manifest'teki golden skorlarla ayni sinif sirasinda
> karsilastirilir. Deger 0'a yaklastikca sayisal uyum daha iyidir.

> Not: gecikme, cerceve yaziminin bittigi an ile sonuc satirinin son baytinin
> alindigi an arasidir; UART aktarim ve ISR suresini icerir. Saf hizlandirici
> cevrim sayisi icin RTL simulasyon capraz kontrolu esastir.

## 2. Uyum Matrisi (satir = golden referans, sutun = donanim ciktisi)

| golden \ donanim | silence | unknown | yes | no | TIMEOUT |
|---|---|---|---|---|---|
| **silence** | **6** | 0 | 0 | 0 | 0 |
| **unknown** | 0 | **16** | 0 | 0 | 0 |
| **yes** | 0 | 0 | **50** | 0 | 0 |
| **no** | 0 | 0 | 0 | **84** | 0 |

Kosegen = golden ile ayni sinif. Kosegen disi her hucre, RTL'in golden
modelden ayristigi bir ornektir.

### Bilgi amacli: gercek etikete (truth) gore dogruluk

_Bu bolum puanlamada KULLANILMAZ; veri setinin zorlugu hakkinda fikir verir._

| | Dogruluk |
|---|---|
| Donanim | 72.44 % |
| Golden model (yazilim) | 72.44 % |
| Fark | +0.00 puan |

## 3. Saglamlik Senaryolari (Secenek F)

| Senaryo | Sonuc | Aciklama |
|---|---|---|
| silence_zeros | PASS | cikti=no, gecikme=8.2 ms, sonraki gecerli cerceve yanitladi |
| silence_dither | PASS | cikti=no, gecikme=8.1 ms, sonraki gecerli cerceve yanitladi |
| saturate_max | PASS | cikti=unknown, gecikme=9.1 ms, sonraki gecerli cerceve yanitladi |
| saturate_min | PASS | cikti=silence, gecikme=9.2 ms, sonraki gecerli cerceve yanitladi |
| alternating | PASS | cikti=silence, gecikme=8.0 ms, sonraki gecerli cerceve yanitladi |
| back_to_back | PASS | araliksiz 5 cerceveden 5 tanesi yanitlandi |
| truncated_frame | PASS | kesik cerceve sonrasi kurtarma basarili (cikti=no) |
| oversized_frame | PASS | fazladan bayt sonrasi kurtarma basarili (cikti=no) |
| peripheral_interleave | SKIP | ATLANDI (opsiyonel): hooks.interleave_core_hex tanimlanmamis; cevre birimi araya girme testi uygulanmadi. |
| determinism | PASS | 10 tekrarda 1 farkli sonuc; gecikme jitter=0.32 ms |
| recovery_after_idle | PASS | 3 s bosta bekledikten sonra yanit verdi (no) |

## 4. Golden Modelden Ayrisan Ornekler

_Yok._

## 5. Dosyalar

- `samples.csv` - ornek bazli ham kayit ve skor hata bilgisi
- `robustness.csv` - senaryo sonuclari
- `summary.json` - makine okunabilir ozet
- `transcript.log` - core UART ham ciktisi
- `config_used.json` - kosumda gercekten kullanilan etkin ICD
