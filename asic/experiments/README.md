# `experiments/` — tanısal yapılandırma katmanları

Bu dizindeki dosyaların çoğu tanısaldır. İki istisna resmî üç-faz akışın
parçasıdır: `grt_layer_met3_010.yaml` faz 2/3'te, `antenna_jumper.yaml` faz
3'te `make asic_run` tarafından uygulanır. Diğer dosyalar `config.yaml`
üzerine elle bindirilen tek amaçlı **ölçüm** katmanlarıdır.

Neden saklanıyorlar: bu tasarımda alınan fiziksel tasarım kararlarının
neredeyse tamamı tahmin değil **kontrollü deney** sonucudur. Her overlay bir
hipotezi sınar — ama **hepsi tek değişkenli değildir**: örneğin
`grt_target_sram_m1_keepout_relaxed_*` hem ceza ayarlarını hem keep-out'ları
birlikte değiştirir, `grt_drt_validated.yaml` ise hem GRT ayarlarını hem anten
zincirini. Bu, sonuçların yorumunda dikkate alınmalıdır. Ölçüm sonuçları
[`../reports/synthesis/strateji_denemeleri.md`](../reports/synthesis/strateji_denemeleri.md)
dosyasında, ham kanıtları (`resolved.json`, log özetleri, `or_metrics_out.json`)
[`../reports/synthesis/deney_arsivi/`](../reports/synthesis/deney_arsivi/)
altındadır.

Çalıştırma kalıbı:

```bash
python3 scripts/run_flow.py \
    --config config.yaml --config experiments/<overlay>.yaml \
    --tag <etiket> --overwrite \
    --initial-state run/<kaynak>/<adım>/state_out.json \
    --from <AdımID> --to <AdımID>
```

## ⚠ ÖNEMLİ: GRT aşımına göre seçim YAPILMAMALIDIR

Aşağıdaki tablonun "ölçülen sonuç" sütunundaki GRT aşımı rakamları
**yanıltıcıdır**. Sonradan ölçüldü: aşımı düşüren ayarlar detaylı yollamayı
kötüleştiriyor.

| Yapılandırma | GRT aşımı | DRT sonucu |
|---|---:|---:|
| `adj 0.05` + keep-out + `i50` | **39** | **yakınsamadı** |
| `adj 0.10`, keep-out yok | 15.218 | **24 ihlal** |

Bu yüzden `grt_target_sram_m1_keepout_*` ailesi ve `grt_adjustment` 0,05
varyantı **geri alınmıştır**; nihai taban config `GRT_ADJUSTMENT: 0.10`,
`[0, 0.3, 0.25, 0, 0, 0]`, `GRT_OVERFLOW_ITERS: 30`, keep-out yok kullanır.
Resmî faz 2/3'te met3 girdisi `grt_layer_met3_010.yaml` ile %10 kısılır.

**Kural:** bir GRT ayarı, detaylı yollamadan geçtiği ölçülmeden ana config'e
alınmaz.

**Dürüstlük notu:** bu karşılaştırmada ceza ayarları ve keep-out'lar
**birlikte** değişti; hangisinin tek başına zararlı olduğu izole **edilmedi**.
Doğrulanan şey kombinasyondur. Ayrıştırmak için `adj 0.05/0.10` ×
`keep-out açık/kapalı` şeklinde 2×2 bir deney gerekir; yapılmadı.

Aynı sebeple `grt_macro_extension_1_i30.yaml` de **yalnızca GRT aşımına
bakılarak** elenmişti (aşım 6.737); bu, yukarıdaki kurala aykırıdır ve o
overlay'in DRT sonucu **ölçülmemiştir**.


## Sonuçlandırılmış deneyler

| Overlay | İzole ettiği değişken | Ölçülen sonuç | Ana config'e alındı mı? |
|---|---|---|---|
| `grt_layer_met3_010.yaml` | Güncel UART RTL'sinde met3 kaynak cezası %15 → %10 | Aynı faz-1 durumunda ilk GRT aşımı **56 → 0**; resmî tam koşumda DRT/Magic/KLayout DRC **0/0/0**, LVS/XOR **0/0**, setup/hold ihlalli uç **0/0**, anten **1.066/1.137** | **Evet — faz 2/3 resmî overlay'i; tam signoff geçti** |
| `grt_layer_met3_015.yaml` | Met3 kaynak cezası %10 etkin tabandan %15'e | Önceki RTL'de tam signoff anten **955/1.013 → 926/979**, DRC 0; güncel UART RTL'sinde ilk GRT **56 aşımla durdu** | Hayır — güncel RTL'de yollanamadığı için resmî akıştan çıkarıldı |
| `grt_layer_met3_020.yaml` | Met3 kaynak cezası %20 | İlk GRT anteni iyileşti; post-GRT resizer yeniden yollaması met3'te **9 aşım** ile durdu | Hayır |
| `antenna_jumper_margin20.yaml` | Jumper tarama marjı %5 -> %20 | 1.100 ek jumper'a rağmen signoff anten **955/1.013 -> 966/1.017** kötüleşti | Hayır |
| `antenna_jumper_i2.yaml` | Jumper iterasyonu 1 -> 2 | İkinci tur **0 jumper / 0 net**, ODB/DEF bit-özdeş; no-op | Hayır |
| `gpl_die3000_phi101.yaml` | Hazır 4200x3000 die probe paketi | GPL bitti ama HPWL **5,91 M -> 30,97 M um (5,238x)** | Hayır |
| `grt_adjustment_010.yaml` | `GRT_ADJUSTMENT` 0,30 → 0,10 | Toplam aşım **192.800 → 5.114**, tel 18,60 → 13,89 m. Listedeki `0`'ın "ceza yok" demek olmadığı bulgusu. | **Evet — nihai değer budur** |
| `grt_target_sram_m1_keepout_i30.yaml` | Tek makroya 10 µm met1 keep-out | Aşım 4.285 | **Hayır — sonradan geri alındı** (aşağıdaki uyarı) |
| `grt_target_sram_m1_keepout_relaxed_i30.yaml` | + `GRT_ADJUSTMENT` 0,05, katman cezaları 0,25/0,20 | Aşım **372** | **Hayır — geri alındı** |
| `grt_target_sram_m1_keepout_relaxed_i50.yaml` | + `GRT_OVERFLOW_ITERS` 50 | Aşım **90** — GRT metriğinde en iyi, **DRT'de en kötü** | **Hayır — geri alındı** |
| `grt_target_sram_m1_keepout_relaxed_g002_i50.yaml` | `GRT_ADJUSTMENT` 0,02 | Aşım 90 — **birebir aynı**, `GRT-0053` derated kaynakları bit bazında özdeş. **No-op.** | Hayır (gereksiz) |
| `grt_macro_extension_1_i30.yaml` | `GRT_MACRO_EXTENSION: 1` | Aşım 6.737 — keep-out yaklaşımından kötü | Hayır |
| `met5_macro_obstructions.yaml` | `RT_MAX_LAYER: met5` + 15 makronun met5 izdüşümüne engel | Aşım **94.692**; met5 talebin %1,4'ünü taşırken DRC'nin ~%67'sini üretiyor | Hayır — `RT_MAX_LAYER: met4` kaldı |
| `met5_signal_only.yaml` | met5 yalnız sinyale, saat met4'te | Yakınsamadı, kesildi | Hayır |
| `gpl_plain_diagnostic.yaml` | `PL_ROUTABILITY_DRIVEN: false` | HPWL %22 **kısaldı** ama aşım **90 → 113.525**; tile başına en kötü aşım 5/2 → 79/64 (hotspot) | Hayır — **çıkmaz dal** |
| `gpl_phi_102.yaml` | `PL_MAX_PHI_COEFFICIENT: 1.02` | Iraksayan global yerleştirmenin çözümü: HPWL 1,8e8 → 5,8e6, `[GPL-1001]` ile temiz bitiş | **Evet** |
| `gpl_phi_101.yaml` | `PL_MAX_PHI_COEFFICIENT: 1.01` | 1,02 yeterli olduğu için yalnızca yedek olarak tutuluyor | Hayır |
| `grt_drt_validated.yaml` | GRT ayarları 0,10'a geri + anten zinciri kapalı | GRT aşımı 15.218 ama **DRT 24 ihlalle bitti** — GRT metriğinin yanıltıcı olduğunun kanıtı | **Evet (kombinasyon)** |
| `grt_drt_validated_antenna.yaml` | ↑ ile aynı, yalnız anten zinciri **açık** | DRT iter 0 186.694 (kapalıda 89.218), iniş −%17 (kapalıda −%53) — **yakınsamadı** | Hayır — anten kapalı kaldı |
| `clock_40.yaml` | `CLOCK_PERIOD: 40` | Post-CTS çok-corner setup **temiz** (`RSZ-0098`) — 20 ns'in kapanmadığının ilk kanıtı | Yöntem `scripts/calibrate_clock.py`'ye taşındı |
| `postroute_sta40.yaml` | Yönlendirilmiş/RCX tasarımda yalnız `CLOCK_PERIOD: 40` | Setup WNS −24,738 → −22,738 ns; 1.936 setup ve 2.650 hold ihlalli uç kaldı. **40 ns de kapanmıyor.** | Hayır — fiziksel yeniden optimizasyon gerekiyor |
| `postroute_sta64.yaml` | Aynı yönlendirme/parasitikler üzerinde `CLOCK_PERIOD: 64` | Dokuz setup köşesi temiz; en kötü `max_ss` payı **+1,262 ns**, setup uç sayısı 0. Hold −1,751 ns / 2.633 uç. | Tanı — ana periyot değişikliği takım onayı ve temiz tam koşum gerektiriyor |
| `postroute_sta66.yaml` | Aynı koşulda `CLOCK_PERIOD: 66` | Dokuz setup köşesi temiz; en kötü pay **+3,262 ns**. Hold 64 ns ile aynı. | Tanı — 64 ns'e göre 2 ns ek marj |
| `postroute_sta70.yaml` | Aynı koşulda `CLOCK_PERIOD: 70` | Dokuz setup köşesi temiz; en kötü pay **+7,262 ns**. Hold 64 ns ile aynı. | Tanı — daha güvenli fakat frekans kaybı daha fazla |
| `cts_cluster10.yaml` | CTS sink küme boyutu 20 → 10 | Saat tamponu 1.251 → 2.899; post-CTS hold **+0,040 → −0,024 ns**. | Hayır — alan/tıkanıklık artıp hold bozuldu |
| `cts_cluster10_buf16.yaml` | Küme 10 + daha güçlü yaprak tamponu | Skew bir miktar iyileşti, fakat toplam saat tamponu 4.115 ve hold **−0,010 ns**. | Hayır |
| `cts_cluster5_buf16.yaml` | Küme 5 + daha güçlü yaprak tamponu | Toplam saat tamponu 5.940; hold **−0,031 ns**. | Hayır |
| `cts_maxwire500.yaml` | Saat segmentlerini 500 µm ile sınırlar | 157 ek tampon; setup 8,606 → 8,503 ns, hold **+0,040 → −0,235 ns / 6 uç**; OpenROAD da tel gecikmesi artışı uyarısı verdi. | Hayır |
| `primary_klayout_gds.yaml` | DRC girdisinde KLayout stream-out'u ana GDS yapar | Magic GDS üzerindeki çoklu top-cell PDK betiği sınırlaması aşıldı; KLayout DRC 10 adet `m2.2` işareti, Magic↔KLayout XOR 0. | **Evet — ana config'e alındı; temiz tam koşumla yeniden doğrulanacak** |
| `macro_ring_4200x3600.yaml` | 15 SRAM'i 4200×3600 µm çekirdeğin çevresine, tümü `N` yönünde yerleştirir | GRT taşması **0**, DRT **0**; temel RCX setup/hold WNS −7,444/−0,248 ns. Eski 3400×2900 yerleşim −24,738/−1,751 ns ve 14 DRC idi. | **Evet — seçilen fiziksel taban; temiz tam koşuma aktarılacak** |
| `postgrt_signoff_margin.yaml` | Post-GRT slew/cap marjı %20 ve hold marjı 0,45 ns | 30.986 timing tamponuna rağmen std-cell doluluğu %11,82; GRT/DRT **0**. 38 ns RCX'te hold WNS **+0,191 ns / 0 uç**, setup −7,273 ns. | **Evet — hold kapanışı için seçildi; temiz tam koşumla doğrulanacak** |
| `postroute_sta46.yaml` | Seçilen DRC-temiz rotanın mevcut RCX'i üzerinde yalnız `CLOCK_PERIOD: 46` | Dokuz köşede setup **+0,727 ns / 0 uç**, hold **+0,191 ns / 0 uç**. | Tanı — ana periyot ve üretilen ASIC top kopyası takım onayı bekliyor |
| `antenna_drt_i1_m10.yaml` | Seçilen macro-ring rotasında bir yalnız-diyot DRT antenna turu | İlk temiz DRT'den sonra ikinci turun iter-0 değeri **199.573** oldu; 40 dakikada ikinci yakınsama metriği çıkmadı. | **Hayır — kontrollü durduruldu** |

## Kabul/tanı amaçlı kalanlar

| Overlay | Ne işe yarar |
|---|---|
| `postgrt_timing_repair.yaml` | Standart `OpenROAD.ResizerTimingPostGRT` adımını varsayılan çok-köşeli marjlarla açar. PNR'da aynı Liberty/RC kümesini kullanan etiketleri `DEDUPLICATE_CORNERS` ile tekilleştirir; bu, final STA'nın dokuz köşesini azaltmaz. Post-CTS tahmininde temiz olup RCX sonrası bozulan setup/hold yollarını gerçek GRT RC tahminiyle onarmayı sınar; DRT ve RCX/STA ile olumlu ölçülmeden ana config'e alınmaz. |
| `postgrt_timing_repair_hold20.yaml` | Hold marjını 50 ps → 20 ps indirir. Tek başına 1 setup + 59 hold tamponuyla DRT'yi tamamladı; RCX sonrası hold uçları 2.672 → 1.147 azaldı, fakat TrDRC 14 → 44 ve setup uçları yaklaşık 2.446 → 2.560 oldu. Tek başına ana aday değildir; tasarım onarımıyla birleşimi ölçülmektedir. |
| `postgrt_design_repair_zero_margin.yaml` | GRT tahmininde 1.882 slew + 730 cap ihlalini 809 yeniden boyutlandırma ve 339 tamponla sıfırladı. İkinci GRT taşması 15.414 → 13.221, tel 15,188 M → 15,017 M µm oldu; bu nedenle 20 ps timing onarımıyla birleşime kabul edildi. RCX sonrası doğrulama tamamlanmadan ana config'e alınmaz. |
| `targeted_sram_met2_obstructions.yaml` | Son `rtl2gds` DRT koşusundaki 14 met2 Short işaretinin tamamını üreten YZ 1 KiB SRAM ile ikinci conv 2 KiB SRAM'in yalnız met2 izdüşümüne 2 µm halo ekler. Sinyal pinleri met3/met4'tedir. Overlay önce `Odb.AddRoutingObstructions --only`, sonra bu durumdan GRT→DRT şeklinde sınanır; kabul ölçütü GRT aşımı değil TrDRC sayısıdır. |
| `targeted_conv_sram_m1_m2_obstructions.yaml` | Post-GRT 20 ps adayındaki 44 Short işaretinin tamamını üreten iki conv 2 KiB SRAM'in met1/met2 izdüşümüne 2 µm halo ekler. Önce obstruction durumu oluşturulur, ardından GRT→DRT koşulur; ana yapılandırmaya ancak taşma ve TrDRC birlikte iyileşirse alınır. |
| `grt_strict_zero_overflow.yaml` | `GRT_ALLOW_CONGESTION: false` — global routing sıfır aşımla kapanıyor mu diye **kabul kapısı**. Ana config'te bayrak açık bırakıldığı için bu overlay ayrı bir doğrulama koşumunda kullanılır. |
| `diagnostic_continue.yaml` | Bütün `ERROR_ON_*` kapılarını gevşetir. **Yalnızca tanısal koşumlar içindir**; `make asic_run` veya nihai teslim için KULLANILMAZ. Bir signoff adımı hata verdiğinde sonraki adımların da rapor üretmesini sağlayıp tek koşumda tam tablo çıkarmaya yarar. |
| `antenna_grt_combined_i1_m5.yaml` | Tek bir GRT tabanlı anten onarım turunu izole eder (jumper+diyot). |
| `antenna_drt_i1_m10.yaml` | Ölçülmüş ve reddedilmiş yalnız-diyot antenna deneyi; yeniden üretim/tanı için korunur. |
| `postgrt_setup_margin10.yaml` | Kontrollü setup marjı taramasının 10 ns kolu; hold 0,45 ns'de sabit kalır. |
| `postgrt_setup_margin5.yaml` | Aynı post-GRT durumundan 5 ns setup marjı kolu. |
| `postgrt_setup_margin2.yaml` | Aynı post-GRT durumundan 2 ns setup marjı kolu. |
| `postgrt_setup_margin0p5.yaml` | Aynı post-GRT durumundan 0,5 ns setup marjı kolu. |

> **Anten onarımı ana config'te KAPALIDIR** (`RUN_ANTENNA_REPAIR: false`,
> `DIODE_ON_PORTS: "none"`, `DRT_ANTENNA_REPAIR_ITERS: 0`). Bir dönem açılmıştı;
> ölçüldü ve geri kapatıldı: aynı GRT ayarlarıyla anten zinciri DRT'yi
> 89.218'den 186.694'e çıkarıp yakınsamaz hâle getiriyor (`grt_drt_validated.yaml`
> ↔ `grt_drt_validated_antenna.yaml` karşılaştırması). Bedeli açıkça kabul
> edildi. Resmî faz 3 yalnız **jumper** onarımını açar; diyot eklemez. İhlaller
> hem azaltılır hem gerçek değerleriyle **ölçülüp raporlanır**. Diğer
> `antenna_*` overlay'leri kontrollü tanı ve reddedilmiş deney kanıtıdır.
