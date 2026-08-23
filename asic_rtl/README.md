# asic_rtl — ASIC Akışına Özgü RTL

Bu klasördeki dosyalar **yalnızca ASIC akışında** kullanılır; Vivado projeleri
hiçbirini görmez. Amaçları, FPGA'ya özgü yapıların yerine SKY130'da karşılığı
olan yapıları koymaktır.

Temel ilke şudur: **`FPGA/` klasöründeki hiçbir RTL dosyası değiştirilmemiştir.**
ASIC ile FPGA arasındaki fark, yalnızca [`../asic/filelist.f`](../asic/filelist.f)
dosyasının hangi kaynağı seçtiğinden ibarettir. Burada aynı modül adlarına ve
aynı port listelerine sahip alternatif gerçeklemeler durur; tasarımın geri kalanı
(CV32E40P, ara bağlantı, çevre birimleri, üst modül) doğrudan
[`../FPGA/main_codes/rtl/desgin_sources/`](../FPGA/main_codes/rtl/desgin_sources/)
altından okunur.

---

## Klasör yapısı

| Klasör | İçerik | Nasıl elde edildi |
|---|---|---|
| `tech/` | Xilinx `IOBUF` primitifinin teknolojiden bağımsız karşılığı | Elle yazıldı |
| `mem/` | SKY130 SRAM makro sarmalayıcıları | Elle yazıldı |
| `gen/` | Üretilmiş mask ROM'lar (Boot ROM, YZ ağırlık ROM'ları) | `asic/scripts/gen_rom.py` üretir |
| `patched/` | Üçüncü taraf ve proje RTL'inin yamalı kopyaları | `asic/scripts/patch_rtl.py` üretir |
| `testbench/` | ASIC belleklerinin eşdeğerlik testbench'i | Elle yazıldı |

> `gen/` ve `patched/` altındaki dosyalar **üretilmiştir, elle düzenlenmez.**
> Her `make asic_run` çalışmasında kaynaklarından yeniden üretilirler; yama
> uygulanamazsa (kaynak dosya değişmişse) betik hata verir.

---

## `tech/xilinx_iobuf_stub.sv`

`QSPI_Master_AXI4_Lite.sv` (4 adet) ve `I2C_Master_AXI4_Lite.sv` (1 adet) çift
yönlü pinleri Xilinx `IOBUF` primitifiyle sürüyor. ASIC akışında unisim
kütüphanesi yok; bu dosya aynı isim ve port listesiyle davranışsal karşılığını
verir:

```systemverilog
assign IO = T ? 1'bz : I;
assign O  = IO;
```

Yosys bundan `$_TBUF_` hücresi üretir, PDK'nın `tribuff_map.v` haritası da onu
`sky130_fd_sc_hd__ebufn_2` tri-state tamponuna çevirir.

---

## `mem/` — SRAM makro sarmalayıcıları

ASIC'te değişken bellekler SRAM makrosuyla, kalıcı bellekler mask ROM ile
gerçeklenir. Bu klasör birincisini kurar.

| Dosya | Modül | Ne yapar |
|---|---|---|
| `sram32_cell.sv` | `sram32_cell` | Tek `sky130_sram_2kbyte_1rw1r_32x512_8` (512×32) sarmalayıcısı |
| `sram32_cell_1k.sv` | `sram32_cell_1k` | Tek `sky130_sram_1kbyte_1rw1r_32x256_8` (256×32) sarmalayıcısı |
| `sram32_bank.sv` | `sram32_bank` | N makroyu 32-bit genişliğinde, bayt-yazma maskeli, 1W+1R bir belleğe bankalar |
| `sram8_bank.sv` | `sram8_bank` | Bayt genişliğindeki belleği 32-bit makrolar üzerine "bayt-şeritli" oturtur |
| `bram_instr_asic.sv` | `bram_instr` | Instruction RAM (2048×32 = 8 KB) → 4 makro |
| `bram_data_asic.sv` | `bram_data` | Data RAM (2048×32 = 8 KB) → 4 makro |
| `bram_yz_asic.sv` | `bram_yz` | YZ girdi RAM'i (9.216 B) → 4× 2 KB + 1× 1 KB makro |
| `conv_buf_ram_asic.sv` | `conv_buf_ram` | YZ konvolüsyon tamponu (4.096 B) → 2 makro |

Son dördü, `Memory/BRAM_defines/` ve `AI_Accelerator/` altındaki FPGA
karşılıklarının **birebir yerine geçer**: modül adı, parametre listesi ve port
listesi aynıdır, okuma gecikmesi de aynıdır (1 çevrim).

**Neden bayt-şeritli?** Onaylı SRAM makrolarının bayt genişliğindeki tek
seçeneği 1024×8'dir (0,203 mm²/KB); 512×32 makro ise 0,139 mm²/KB. Makronun
8-bit yazma granülaritesi (`wmask`) olduğu için bir baytı doğrudan
yazabiliyoruz: bayt adresinin alt 2 biti hangi şeridin yazılacağını seçer.

**`SRAM_SIM` tanımı.** Simülasyonda OpenRAM'in davranışsal modeli her erişimde
`$display` eder ve ilklendirilmemiş içeriği X'tir. Bu iki ayrıntı `SRAM_SIM`
tanımı altında tek yerden hallediliyor (`defparam VERBOSE=0` + istenirse içeriği
sıfırlama); sentez tarafı bunları hiç görmez, çünkü makro orada LEF/Liberty'den
gelen bir kara kutudur.

---

## `gen/` — üretilmiş mask ROM'lar

Boot ROM ve YZ ağırlık ROM'ları **kalıcı** belleklerdir: güç verildiğinde hazır
olmaları gerekir, dolayısıyla SRAM makrosuna konamazlar (silikonda
ilklendirilemezler). Karşılıkları standart hücrelerden örülen mask ROM'lardır.

| Dosya | Modül | Kaynak hex | İçerik |
|---|---|---|---|
| `boot_rom_asic.sv` | `boot_rom` | `firmware/makefile_outputs/boot.hex` | 193/256 kelime × 32 bit |
| `weights_rom_p8_asic.v` | `weights_rom_p8` | `AI_Accelerator/weights_p8.hex` | 80 × 64 bit |
| `fc_weights_rom_p4_asic.v` | `fc_weights_rom_p4` | `AI_Accelerator/fc_weights_p4.hex` | 4000 × 32 bit |

Üreten: [`asic/scripts/gen_rom.py`](../asic/scripts/gen_rom.py).

Üretilen dosya, orijinal RTL'in `reg mem[…]` + `initial` yapısını **birebir
korur** — düz bir `case` ifadesi yerine. Böylece Yosys'in ROM çıkarımı
(`memory_map`) devreye girer ve ABC içeriği mantıksal olarak sıkıştırır:

| ROM | Bit | Standart hücre | Alan |
|---|---:|---:|---:|
| `weights_rom_p8` | 5.120 | 783 | 0,0056 mm² |
| `fc_weights_rom_p4` | 128.000 | 10.826 | 0,065 mm² |

(Aynı ağırlıklar SRAM makrosuyla saklansaydı 8 makro, yani 2,28 mm² gerekirdi.)

İçeriğin RTL'e gömülmesinin ikinci bir faydası da `$readmemh` yol çözümünün
araca göre değişmesinin (Yosys kaynak dosyaya, XSim çalışma dizinine göre çözer)
tamamen ortadan kalkmasıdır.

---

## `patched/` — yamalı kopyalar

Bazı dosyalarda ASIC akışını durduran sorunlar vardı. Orijinallere dokunmamak
için [`asic/scripts/patch_rtl.py`](../asic/scripts/patch_rtl.py) açıkça
tanımlanmış metin değişiklikleriyle yamalı kopya üretir; her üretilen dosyanın
başında hangi değişikliğin neden yapıldığı yazılıdır.

| Dosya | Sorun | Yama |
|---|---|---|
| `GPIO`, `Timer`, `QSPI`, `UART_GU`, `UART_YZ` | `RRESP`/`BRESP` yalnızca reset dalında atanmış → çıkış sürülmüyor (20 bit) | Sürekli atama: `assign … = 2'b00;` (AXI OKAY) |
| `instr_bram_axi_ctrl` | `axi_instr_bram_rresp` aynı durumda (2 bit) | Aynı |
| `cv32e40p_obi_to_axi_wrapper` | Komut portunun kullanılmayan AXI yazma kanalı hiç atanmamış (67 bit) | Pasif değerlere açık `assign` |
| `obi_to_axi` | `obi_rsp_o.r.r_optional` hiçbir generate dalında sürülmüyor (2 bit); ayrıca sıfır genişlikli parça-seçim | Kapalı durum için `else` dalı; genişlik ifadesi en az 1 |
| `conv_accelerator` | MAC yolu 20 ns'lik periyoda sığmıyor (aşağıda) | Çarpma ile birikim ayrı evrelere alındı |

Sürülmeyen sinyallerde ilgili değer **zaten sabitti**; Vivado sessizce 0'a
bağlıyordu. Yamalar bu sabiti açıkça yazar, üretilen donanım değişmez.

> Bu düzeltmelerin ana RTL'e de alınması önerilir: `RRESP`/`BRESP` sürmeyen bir
> AXI4-Lite slave, araç değiştiğinde farklı davranabilir.

### YZ hızlandırıcının MAC boru hattı

Bu, davranışı gerçekten etkileyen tek yamadır; bu yüzden ayrıca açıklanıyor.

**Sorun.** Orijinal RTL çarpma ile birikimi tek çevrimde yapıyor:

```verilog
acc[ci] <= acc[ci] + ($signed({1'b0, ram_rdata}) - INPUT_ZP) * $signed(w_dout[8*ci +: 8]);
```

FPGA'da bu ifade **DSP48E1** hard-makrolarına gidiyordu (çarp+topla tek blokta,
~5 ns). SKY130'da böyle bir blok yok; ifade standart hücrelerden örülü bir
çarpan + 32-bit toplayıcı zincirine dönüşüyor ve 20 ns'lik periyodu aşıyor.
İlk ASIC koşusunda tasarımın **bütün setup ihlalleri (254 uç) tam olarak bu
yollardaydı** — başlangıç noktası her seferinde YZ girdi RAM'i ya da
konvolüsyon tamponu SRAM'inin çıkışıydı.

**Çözüm.** Yol iki evreye bölündü:

```verilog
if (v_s2) prod[ci] <= ($signed({1'b0, ram_rdata}) - INPUT_ZP) * $signed(w_dout[8*ci +: 8]);
if (v_s3) acc[ci]  <= acc[ci] + prod[ci];
```

Aynısı FC birikimi için de yapıldı (`f_prod` / `f_v3`), boşaltma (drain)
sayaçları 2'den 3 çevrime çıkarıldı.

**Sonuç bit-exact.** Ara register'lar `signed [31:0]` olarak tanımlandı;
orijinalde de ifade 32-bit LHS bağlamında değerlendiriliyordu, dolayısıyla
kırpma davranışı aynı. Üç referans ses örneğinde sınıf ve dört FC skorunun
tamamı birebir aynı çıktı:

| Örnek | Sınıf | S0 | S1 | S2 | S3 | Çevrim (orijinal → ASIC) |
|---|---:|---:|---:|---:|---:|---|
| yes | 2 | −58032 | 21583 | 48674 | −4777 | 45.517 → 46.018 |
| no | 3 | −30588 | 7509 | 7419 | 18543 | 45.517 → 46.018 |
| sessizlik | 0 | 427 | −518 | −94 | 186 | 45.517 → 46.018 |

Tek fark çevrim sayısıdır: **+501 çevrim (+%1,1)** — 500 konvolüsyon pozisyonu
ve 1 FC boşaltması için birer çevrim. Tap başına 1 çevrimlik verim değişmedi.
Yazılım gerçeklemesine göre hızlanma 276,9× yerine **274,0×** olur.

Kanıt dosyası: [`../asic/reports/general/yz_boru_hatti_esdegerlik.md`](../asic/reports/general/yz_boru_hatti_esdegerlik.md)

```bash
# yeniden üretmek için (iverilog, ~15 sn)
cd asic && python3 scripts/run_asic_sim.py mem      # bellek eşdeğerliği
python3 scripts/run_asic_sim.py yz                  # sistem seviyesi YZ testi
```

---

## Doğrulama

`testbench/tb_asic_mem_equiv.sv` bu klasördeki bellek sarmalayıcılarının ve
mask ROM'ların orijinalleriyle eşdeğerliğini kanıtlar: rastgele okuma/yazma
dizileri, bütün ROM adreslerinin taranması, okuma gecikmesinin doğrulanması.

```bash
cd asic && python3 scripts/run_asic_sim.py mem
# -> SONUC: BASARILI -- 12592 kontrolun tamami gecti
```
