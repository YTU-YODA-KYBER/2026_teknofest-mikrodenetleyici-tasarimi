# AXI4-Lite Protokol Kontrolcüsü

**YTU YODA KYBER — TEKNOFEST 2026 Çip Tasarım Yarışması**

Şartname **madde 5.2-3 (ödül kazanımı için zorunlu)**:

> *"Çevre birimleri ve YZ hızlandırıcının AXI/AXI-Lite arayüzlerinin en azından protocol check düzeyinde AXI agent'larıyla doğrulanması."*

Bu klasör o maddeyi karşılar.

---

## Dosyalar

| Dosya | Görevi |
|---|---|
| `axi_chk_pkg.sv` | Global ihlal sayacı ve simülasyon sonu özet raporu |
| `axi4lite_protocol_checker.sv` | Asıl kontrolcü — 10 kategoride 40 kural (33 `assert property` + 7 prosedürel `STL`/`FIN` kontrolü) |
| `axi4lite_bind.svh` | Sistem simülasyonu için 15 AXI arayüzünün tamamına `bind` bağlantıları |
| `Bind_for_peripherals/` | Tek blok testbench'lerinde kullanılan ayrı `bind` dosyaları (`gpio`, `i2c`, `qspi`, `timer`, `uart_gu`, `uart_yz`) |
| `tb_axi4lite_checker_selftest.sv` | **Kontrolcünün kendisini doğrulayan** self-test |

**Hiçbiri sentezlenmez.** bağlantı `bind` ile yapılır.

---

## Neden `bind`?

Assertion'ları her testbench'in içine kopyalamak yerine tek dosyada tutup `bind`
ile bağlıyoruz. Üç nedeni var:

1. **Tek kaynak.** 15 arayüz, tek dosya. Kopyaların birbirinden ayrışma riski yok.
2. **RTL'e dokunulmaz.** Tasarım kodu doğrulama koduyla kirlenmez, sentez akışı etkilenmez.
3. **Asıl riskli yeri kapsar.** Blok testbench'inde AXI'yi zaten biz sürüyoruz.
   Gerçek protokol hataları `CPU → OBI→AXI köprü → Splitter → Interconnect → 10 slave`
   yolunda yaşar; `bind` sistem simülasyonunda bu yolun tamamını izler.

---

## Kapsam — 15 AXI4-Lite arayüzü

### Katman 1 — Slave uç noktaları (11)

| # | Arayüz | Yazma | Okuma | WSTRB |
|---|---|:---:|:---:|:---:|
| 1 | Timer | ✔ | ✔ | — |
| 2 | GPIO | ✔ | ✔ | — |
| 3 | I2C Master | ✔ | ✔ | — |
| 4 | QSPI Master | ✔ | ✔ | — |
| 5 | UART_GU | ✔ | ✔ | — |
| 6 | UART_YZ | ✔ | ✔ | — |
| 7 | **YZ Hızlandırıcı CSR** | ✔ | ✔ | — |
| 8 | Data RAM | ✔ | ✔ | ✔ |
| 9 | Instruction RAM | ✔ | ✔ | ✔ |
| 10 | Boot ROM — CPU portu | — | ✔ | — |
| 11 | Boot ROM — interconnect portu | — | ✔ | — |

### Katman 2 — Master ve fabric (4)

| # | Arayüz | Not |
|---|---|---|
| 12 | CPU instruction master | Yazma kanalı fiziksel olarak var ama kullanılmamalı; `ORD_01/02` beklenmeyen komut-yolu yazmasını yakalar |
| 13 | CPU data master | |
| 14 | Instruction Splitter (slave tarafı) | Blok kombinasyonel olduğu için `top_module`'dan hiyerarşik referansla bağlanır |
| 15 | Interconnect S0 portu | CPU-yüzü slave portu |

**Interconnect'in M0…M9 master portları bilinçli olarak bind edilmemiştir** —
bunlar Katman 1'deki slave portlarının aynı telleridir; ikisini birden bağlamak
aynı sinyali iki kez kontrol etmek olurdu. S0 ise başka hiçbir yerde
kapsanmadığı için ayrıca bağlanmıştır.

---

## Kural seti (ARM IHI 0022)

| Kimlik | Kategori | Referans | Ne yakalar |
|---|---|---|---|
| `RST_01…05` | Reset davranışı | A3.1.2 | Reset aktifken yüksek kalan VALID |
| `HSK_01…05` | VALID kararlılığı | A3.2.1 | **AXI'nin en sık ihlal edilen kuralı:** READY gelmeden VALID'i düşüren FSM |
| `STB_01…07` | Payload kararlılığı | A3.2.1 | El sıkışma beklerken değişen adres/veri/cevap |
| `XCK_01…07` | X/Z kontrolü | — | Sıfırlanmamış register, eksik `default`, bağlanmamış port |
| `RSP_01…02` | Cevap legalliği | A3.4.4, B1.1 | AXI4-Lite'ta yasak olan `EXOKAY` |
| `ORD_01…03` | Nedensellik | A3.3 | İstek olmadan gelen sahte cevap |
| `OUT_01…02` | Outstanding limiti | — | Limit aşımı + istekten fazla cevap |
| `WST_01…02` | WSTRB legalliği | — | X'li veya beklenmeyen kısmi strobe |
| `STL_01…05` | Takılma gözcüsü | — | Kilitlenme (uyarı seviyesi, ihlal sayılmaz) |
| `FIN_01…02` | Sim sonu boşaltma | — | Cevapsız kalan işlem = gizli hang |

---

## Testbench'e entegrasyon

Testbench'in **en üstünde, modül dışında**:

```systemverilog
`include "axi4lite_bind.svh"
```

Bu dosya 15 arayüzün tamamını bağladığı için yalnızca **sistem seviyesi**
testbench'lerde (`System_Test/boot_test.sv`, `System_Test/ai_accel_test.sv`)
kullanılır. Tek blok testbench'inde o bloğun kendi dosyası include edilir —
örneğin `Peripherals/GPIO/GPIO_tb.sv` içinde
`` `include "axi4lite_bind_gpio.svh" `` (bkz. `Bind_for_peripherals/`).

Testin **sonunda**, `$finish`'ten önce:

```systemverilog
if (axi_chk_pkg::final_report() != 0)
    $fatal(1, "AXI protokol ihlali tespit edildi.");
$finish;
```

`final_report()` şunu basar:

```
======================================================================
            AXI4-LITE PROTOKOL KONTROL OZETI
======================================================================
  Izlenen AXI arayuzu sayisi : 15
  Protokol ihlali            : 0
  Uyari (stall/watchdog)     : 0
  SONUC                      : GECTI  (0 ihlal)
======================================================================
```

---

## Self-test — kontrolcüyü kim kontrol ediyor?

"Assertion yazdık" demek yeterli değildir: **hiçbir şeyi yakalamayan bir checker
da "0 ihlal" raporlar.** `tb_axi4lite_checker_selftest.sv` her kural için bilerek
bir ihlal üretir ve kontrolcünün tam olarak onu yakaladığını kanıtlar.

Ayrıca iki ayrı **temiz trafik** senaryosu koşar ve orada **sıfır yanlış alarm**
beklenir — yanlış alarm veren bir checker regresyonu kullanılamaz hale getirir.

Doğrulanmış senaryolar: `HSK_01`, `HSK_05`, `STB_01`, `RSP_01`, `ORD_01/02`,
`ORD_03`, `XCK_02` (yalnız 4-durumlu simülatörde), + 2 temiz trafik kontrolü.

---

## Parametre ayarı

`MAX_OUTSTANDING` şu an tüm basit çevre birimlerinde **1**'e ayarlıdır.

Yanlış alarm verirse tasarımın gerçek pipeline derinliğine yükseltin — **ama
dar bir limitle geçen assertion, geniş limitten çok daha güçlü bir uygunluk
beyanıdır.** Sunumda bu değerin neden o seçildiğini gerekçelendirin.

`ERR_IS_FATAL` varsayılan olarak **0**'dır: ihlaller sayılır, simülasyon devam
eder. Regresyon için doğru seçim budur — tek bir ihlal 40 dakikalık koşuyu
öldürmemeli. Testbench sonda `final_report()` ile toplu karar verir.

---

## Bilinen kapsam sınırı

AXI'nin *"master, VALID'i yükseltmek için READY'yi beklememelidir"* kuralı
(IHI 0022 A3.3.1) sinyal seviyesinde biçimsel olarak kontrol edilemez; bu bir
kombinasyonel bağımlılık kısıtıdır, davranışsal bir kural değildir. Bilinçli
olarak kapsam dışında bırakılmıştır ve doğrulama planında bu şekilde
belgelenmiştir.
