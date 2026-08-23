# UVM Doğrulama Ortamı

Yedi AXI4-Lite bloğunun — altı çevre birimi ve YZ hızlandırıcının CPU'ya bakan
CSR arayüzünün — UVM ortamı. Sonuçlar (regresyon matrisi, kapsam raporu,
bulunan RTL sorunları) burada değil, [`verification/uvm/`](../../../verification/uvm/)
altındadır.

Simülatör: **Verilator 5.050** · UVM: **2020.3.1 (no-DPI)**

---

## Neden tek bir agent yetiyor

Yedi slave de **aynı indirgenmiş AXI4-Lite'ı** konuşuyor: `WSTRB`, `PROT`,
`ID` ve burst yok, hepsi 1 outstanding ve AW ile W'yi aynı çevrimde bekliyor.
Bu yüzden sequencer, sürücü, monitör ve fonksiyonel kapsam toplayıcı ortaktır;
blok başına değişen tek şey taban adres, register modeli, scoreboard'un
tarif ettiği yan etkiler ve karşı taraf agent'ıdır.

### Sürücünün üç kilit kısıtı

Bunlar RTL'den çıkarılmıştır ve pazarlığa açık değildir:

1. **AW ve W aynı çevrimde sürülür.** Altı slave de kabul koşulunu
   `awvalid && wvalid && awready && wready` olarak yazmış; AW ile W'yi
   bağımsız kanallar gibi rastgele gecikmeyle süren klasik bir UVM sürücüsü
   bu tasarımı **kilitler**.
2. **Uyaran negedge'de sürülür, örnekleme posedge'de yapılır.** Posedge'de
   sürmek sıfır genişlikli VALID darbeleri üretir; mevcut blok
   testbench'leri bunun QSPI'da 600 binden fazla sahte protokol ihlali
   doğurduğunu kaydetmişti.
3. **Slave'ler 1 outstanding'dir.** Sürücü cevabı bekler, sonra `gap` kadar
   boşta durur.

`beats` alanı, aynı VALID yükseltmesi üzerinde kaç işlem yapılacağını söyler.
`beats = 1` normal master, `beats > 1` boru hatlı master demektir — AXI'de
tamamen yasaldır ve stres testleri bunu kullanır.

---

## Klasör yapısı

```
uvm/
├── Makefile                → derleme/koşturma; blok ve test listelerinin TEK kaynağı
├── common/                 → bütün blokların paylaştığı katman
│   ├── axil_if.sv              arayüz (+ testin reset isteyebildiği rst_req kancası)
│   ├── axil_pkg.sv             paket sarmalayıcısı
│   ├── axil_item.svh           transaction
│   ├── axil_cfg.svh            agent yapılandırması
│   ├── axil_driver.svh         master sürücüsü (üç kilit kısıt burada anlatılır)
│   ├── axil_monitor.svh        pasif monitör (+ gerçek boşluk ölçümü)
│   ├── axil_coverage.svh       fonksiyonel kapsam
│   ├── axil_agent.svh          sequencer + sürücü + monitör + kapsam
│   ├── axil_seq_lib.svh        ortak dizi kütüphanesi
│   ├── axil_reg_adapter.svh    uvm_reg ↔ axil_item çevirici
│   ├── axil_scoreboard.svh     gölge register dosyası (taban sınıf)
│   ├── axil_base_env.svh       ortak ortam
│   └── axil_base_test.svh      ortak test tabanı (+ rapor, + zaman aşımı koruması)
│
├── agents/                 → karşı taraf agent'ları
│   ├── gpio_pad_if.sv / gpio_pad_pkg.sv    switch sürme + 7-segment kuralları
│   ├── uart_if.sv  / uart_pkg.sv           gerçek baud zamanlamalı seri agent + DMA yan bandı
│   ├── i2c_if.sv   / i2c_slave_pkg.sv      protokol seviyesinde I2C slave
│   ├── qspi_if.sv  / qspi_flash_pkg.sv     hafif QSPI flash responder (x1/x2/x4)
│   └── yz_accel_if.sv / yz_accel_pkg.sv    hızlandırıcı el sıkışması taklidi
│
├── gpio/ timer/ uart/ uart_gu/ uart_yz/ i2c/ qspi/ yz_csr/
│                           → blok başına register modeli, scoreboard, ortam,
│                             test kütüphanesi, paket ve testbench üst modülü
│                             (uart/ ikisinin PAYLAŞTIĞI katmandır)
│
├── smoke/                  → araç kapı testleri (aşağıda)
└── verilator/
    ├── stubs/IOBUF.sv      Xilinx IOBUF primitifinin simülasyon karşılığı
    ├── run_smoke.sh        beş maddelik kapı testi
    ├── run_regression.py   regresyon koşucusu → verification/uvm/
    └── make_coverage.py    kapsam raporu üreteci → verification/uvm/coverage/
```

**RTL'e tek satır dokunulmaz.** Protokol kontrolcüsü `bind` ile bağlanır,
Xilinx `IOBUF` primitifi yalnızca UVM derlemesine giren bir sarmalayıcıyla
karşılanır ve hiçbir dosya sentez akışına girmez.

---

## Kullanım

```
source /usr/Verilator_uvm/env.sh

make smoke                                   # araç kapı testleri (5 madde)
make build BLK=gpio                          # tek blok derle
make run   BLK=gpio TEST=gpio_reset_test SEED=1
make gpio                                    # derle + varsayılan testi koştur
make regression                              # 7 blok × 73 test × 3 tohum
make coverage                                # kapsam raporunu üret
make clean
```

Blok adları: `gpio timer uart_gu uart_yz i2c qspi yz_csr`.
Her bloğun test listesi Makefile'daki `<blok>_TESTS` değişkenindedir;
regresyon koşucusu listeyi oradan okur, ikinci bir liste tutmaz.

> Bütün derleme çıktıları `UVM_OBJ_ROOT` (varsayılan `/usr/Verilator_uvm/build`)
> altına gider. `obj_dir`'ler ve kapsam veritabanları birkaç GB tutar; depoya
> ya da `/home`'a **yazılmaz**.

---

## Ortamın kurulumu

```
sudo apt install flex bison libfl-dev help2man lcov z3
git clone https://github.com/verilator/verilator /usr/Verilator_uvm/src/verilator
cd /usr/Verilator_uvm/src/verilator && git checkout v5.050
autoconf && ./configure --prefix=/usr/Verilator_uvm/verilator-5.050
make -j$(nproc) && make install
cp test_regress/t/uvm/uvm_pkg_all_v2020_3_1_nodpi.svh /usr/Verilator_uvm/uvm/
```

`/usr/Verilator_uvm/env.sh` `PATH`, `VERILATOR_ROOT`, `UVM_HOME` ve
`UVM_OBJ_ROOT` değişkenlerini kurar.

**Neden 5.050:** covergroup / coverpoint / bins desteği bu sürümde geldi.
Daha eskisi covergroup'ları sessizce atar ve fonksiyonel kapsam üretilemez.

**Neden bu UVM paketi:** Verilator deposunun kendi düzleştirilmiş UVM
2020.3.1 (no-DPI) sürümü, Verilator ekibinin sürekli tümleştirmesinde
koşturduğu paket olduğu için uyumluluk riski en düşük seçenektir. Vivado'nun
`xlnx_uvm_package.sv`'si XSim'e yamalıdır ve bu akışa girmez.

**z3 neden gerekli:** Verilator'un kısıtlı randomizasyonu (`randomize() with`)
z3 SAT çözücüsünü çağırır. Kurulu değilse `randomize()` sessizce 0 döner ve
rastgele testler anlamsız değerlerle koşar.

---

## Araç kapı testleri (`make smoke`)

Yedi bloğun ortamı yazılmadan önce, simülatörün bu tasarımın ihtiyaç duyduğu
beş dil özelliğini gerçekten kaldırdığı kanıtlandı. Ortam bir simülatör
değişikliğinden sonra da önce bu kapıdan geçirilmelidir.

| # | Ne kanıtlıyor | Nasıl |
|---|---|---|
| 1 | UVM çekirdeği ayakta | `smoke/t_uvm_hello.sv` |
| 2 | `bind` çalışıyor | `smoke/t_smoke_gpio.sv` + `axi4lite_bind_gpio.svh` |
| 3 | SVA çalışıyor | kontrolcünün 33 `assert property`'si derlenip koşuyor |
| 4 | covergroup çalışıyor | kapsam çıktısında 37 bin görünüyor |
| 5 | `uvm_reg` ayakta | 2 register'lık model + adapter + predictor |

---

## Bu ortamı kurarken karşılaşılan araç tuzakları

Hepsi Verilator 5.050'ye özgüdür ve tekrar karşılaşılmaması için buraya yazılmıştır.

- **`--coverage` kullanılmaz.** İçindeki iki alt metrik iç hata veriyor:
  `--coverage-expr`, `bind` edilmiş bir modülün assert action block'uyla
  birleşince `V3Localize.cpp:203: AstVarRef not under function`;
  `--coverage-fsm` ise `always @(posedge clk) if (!rst_n) <tek deyim>`
  kalıbında `V3FsmDetect.cpp:1065`. Kullanılan üç metrik (`--coverage-line`,
  `--coverage-toggle`, `--coverage-user`) sorunsuz çalışıyor ve ihtiyacımız
  olan hepsi bu.

- **covergroup, kapsayan sınıfın üyesine bakamaz.** Klasik UVM subscriber
  kalıbı (`class member tr` → `coverpoint tr.kind`) şu uyarıyla **sessizce
  atılır**: *"Unsupported: 'covergroup' coverpoint referencing enclosing class
  member; ignoring covergroup"*. Çözüm `with function sample(...)` biçimidir:
  coverpoint'ler covergroup'un kendi sample argümanlarına bakar.

- **Yorum satırı `// Verilator` ile başlayamaz.** Verilator bunu bilinmeyen
  bir pragma sanıp `BADVLTPRAGMA` hatası verir. Türkçe metinde
  "Verilator'da..." diye başlayan bir yorum bu tuzağa düşer.

- **Zaman kontrolünden sonra otomatik `output` argümana yazılamaz**
  (IEEE 1800 13.2.2). `@(posedge x)` bekleyen bir task sonucunu `output`
  argümanla döndüremez; sınıf üyesi kullanılır.

- **Tristate ve `pullup` sorunsuz çalışır.** `stubs/IOBUF.sv` ile I2C'nin
  SDA hattı ve QSPI'nin dört IO hattı gerçek open-drain gibi davranır;
  bu bir risk olarak görülmüştü ama değil.
