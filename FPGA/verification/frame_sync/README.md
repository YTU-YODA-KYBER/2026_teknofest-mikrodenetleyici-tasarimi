# frame_sync — Çerçeve Senkronizasyon Kurtarma Doğrulaması

YZ girdi RAM kontrolcüsünün (`yz_acclrtr_bram_axi_ctrl`) **yazma sayacını
toparlayabilme** yeteneğinin yönlendirilmiş (directed) doğrulaması.

| Ölçüm | Sonuç |
|---|---|
| Testbench | [`main_codes/testbench/Memory/yz_bram_ctrl_tb.sv`](../../main_codes/testbench/Memory/yz_bram_ctrl_tb.sv) |
| Kontrol | **22 / 22 geçti** |
| Simülatör | Icarus Verilog 12.0 |
| Ham çıktı | [`yz_bram_ctrl_tb.log`](yz_bram_ctrl_tb.log) |

---

## Neden ayrı bir doğrulama

Hızlandırıcıya giden 1960 baytlık vektör tel üzerinde **çerçevelenmemiş**
akar: preamble, uzunluk alanı ve sağlama toplamı yoktur, kontrolcü yalnızca
bayt sayar ve 1960. baytta CPU'ya kesme kaldırır.

Sayacın tek çıkışı 1960'a ulaşmak olsaydı, eksik ya da fazla baytlı tek bir
çerçeve **kalıcı** bir kayma bırakırdı: o andan sonra her çıkarım kaymış bir
pencere üzerinde yapılır ve tek kurtuluş yolu kartı resetlemek olurdu. Demo
dokümanı adım 5 tam bunu yasaklıyor — tasarımın FPGA yeniden programlanmadan
çalışmaya devam etmesi gerekiyor.

Demo test harness'i bu durumu iki senaryoyla zorluyor:

| Senaryo | Ne gönderiyor | Bıraktığı kayma |
|---|---|---|
| `truncated_frame` | 1960 − 64 = **1896 bayt** | sayaç 1896'da kalır |
| `oversized_frame` | 1960 + **32 fazla bayt** | sayaç 32'de kalır |

Aynı arıza, port açılışındaki tek bir hat glitch'i ya da tek bir bayt kaybıyla
da tetiklenebilir.

**Kurtarma boşta kalma sayacındadır:** hat `IDLE_LIMIT` çevrim boyunca sessiz
kalırsa yarım kalan kayıt atılır ve sonraki çerçeve yeniden hizalanır. Gerçek
tasarımda eşik 100.000 çevrim = 50 MHz'de **2 ms**; bir bayt süresinden
(1 Mbps'te 10 µs) çok uzun, çerçeveler arası boşluktan (20 ms) çok kısadır.

---

## Kapsanan durumlar

| # | Test | Ne kanıtlıyor |
|---|---|---|
| 1 | Tam çerçeve (1960 bayt) | IRQ kalkar, sayaç başa döner, ilk ve son bayt RAM'de doğru adreste |
| 2 | Kesme temizleme | `load_done_irq` seviyedir; yalnızca `cpu_clear_i` ile düşer |
| 3 | Kesik çerçeve | 1896 bayt sonrası sayaç ortada kalır, IRQ kalkmaz; boşta kalma eşiği aşılınca sayaç sıfırlanır |
| 4 | **Kurtarma** | Kesikten sonraki tam çerçeve doğru hizalanır — RAM[0] ve RAM[1959] yeni çerçevenin baytlarını taşır |
| 5 | Fazla bayt | Artık 32 bayt sayacı ilerletir, boşta kalma sıfırlar, sonraki çerçeve yine hizalı |
| 6 | **Sınır: erken susma** | Eşiğin *altında* bir duraklama çerçeveyi **bozmamalı** |

Test 6 en az diğerleri kadar önemlidir. Eşik çok küçük seçilseydi çerçeve
içindeki normal bayt aralıkları yanlışlıkla "çerçeve bitti" sayılır ve tasarım
hiçbir vektörü doğru okuyamazdı. Bu yüzden hem tetiklenmesi hem de erken
tetiklenmemesi doğrulanır.

Testbench eşiği parametreden alır (`IDLE_LIMIT`), sabit sayıya göre yazılmaz;
simülasyon süresi makul kalsın diye 200 çevrimle koşulur. Doğrulanan mantık
üretim değeriyle aynıdır, yalnızca eşik ölçeklenir.

---

## Koşum

Vivado gerektirmez:

```bash
cd FPGA/main_codes
iverilog -g2012 -o /tmp/yzbram.out \
    rtl/desgin_sources/Memory/BRAM_defines/bram_yz_def.sv \
    rtl/desgin_sources/Memory/YZ_RAM_AXI4-Lite/yz_bram_axi_ctrl.sv \
    testbench/Memory/yz_bram_ctrl_tb.sv
vvp /tmp/yzbram.out
```

Vivado projesi olarak: `scripts/project_gen/Memory/create_YZ_RAM.tcl`.

Sistem seviyesindeki karşılığı `ai_accel_test.sv` içindeki
`run_resync_check` görevidir: orada kesik çerçeve tam SoC üzerinde gönderilir
ve sonraki vektörün **doğru sınıflandığı** kontrol edilir.
