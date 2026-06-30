# 2026 TEKNOFEST — Mikrodenetleyici Tasarımı

**YTU YODA KYBER** takımının TEKNOFEST 2026 Çip Tasarım Yarışması
(Mikrodenetleyici Kategorisi) için sıfırdan geliştirdiği, **RISC-V tabanlı
ve yapay zekâ hızlandırıcılı** bir Sistem-on-Chip (SoC) tasarımı.

> Tasarım **CV32E40P** RISC-V çekirdeği etrafına kuruldu; çekirdeği AXI4
> ara bağlantı üzerinden bellekler, çevre birimleri ve bir yapay zekâ
> hızlandırıcısı ile birleştirip Basys3 FPGA üzerinde çalışır hâle getirdik.

`SystemVerilog · Verilog · Tcl` &nbsp;|&nbsp; Hedef: **Nexys A7 (Artix-7)** @ 50 MHz

---

## Bu proje ne yapıyor?

Tek cümleyle: **kendi çevre birimlerini, kendi ara bağlantısını ve bir yapay
zekâ hızlandırıcısını barındıran, üzerinde bare-metal yazılım koşan tam bir
mikrodenetleyici** tasarladık ve FPGA'de çalıştırdık.

Sistem açıldığında çekirdek, Boot ROM'daki bootloader'ı koşturur; bootloader
uygulama yazılımını QSPI flash'tan okuyup komut belleğine (Instruction RAM)
kopyalar ve oraya atlar. Uygulama da çevre birimlerini (UART, Timer, GPIO,
I2C, QSPI) ve yapay zekâ hızlandırıcısını kullanarak işini yapar.

---

## Öne çıkanlar

- **CV32E40P RISC-V çekirdeği** (RV32IMC + Zicsr/Zifencei), opsiyonel FPU varyantı
- **Bellekler:** Boot ROM, Instruction RAM, Data RAM (hepsi AXI4-Lite sarmalı)
- **Çevre birimleri:** GPIO, Timer, I2C Master, QSPI Master, iki UART
  (genel kullanım + YZ veri akışı)
- **Yapay zekâ hızlandırıcısı:** konvolüsyon + tam bağlı katmanlarla anahtar
  kelime tanıma (yes / no / sessizlik)
- **İki katmanlı boot:** Boot ROM'daki bootloader → QSPI flash'tan uygulamayı
  Instruction RAM'e yükler → çalıştırır
- **Kapsamlı doğrulama:** her çevre birimi ve sistem seviyesi için testbench'ler
  (QSPI için Micron flash simülasyon modeli dahil)
- **Tek tıkla kurulum:** Vivado projesini sıfırdan oluşturan TCL scriptleri

---

## Mimari (genel akış)

```
            ┌──────────────────┐
            │   CV32E40P CPU   │   (RISC-V, RV32IMC)
            └────────┬─────────┘
                     │ OBI
            ┌────────▼─────────┐
            │  OBI → AXI köprü │  + komut ayırıcı
            └────────┬─────────┘
                     │ AXI4
        ┌────────────▼─────────────┐
        │     AXI4 Interconnect     │
        └─┬───┬───┬───┬───┬───┬───┬─┘
          │   │   │   │   │   │   │
       Boot Instr Data GPIO Tim UART  ... I2C / QSPI / YZ Hızlandırıcı
        ROM  RAM  RAM        er
```

**Boot akışı:** Açılış → CPU Boot ROM'dan bootloader'ı koşar → bootloader
uygulamayı QSPI flash'tan Instruction RAM'e kopyalar → uygulamaya atlar → çalışır.

---

## Depo yapısı

Asıl çalışma dosyaları [`main_files/`](main_files/) altında:

| Klasör | İçerik |
|---|---|
| [`main_files/main_codes/`](main_files/main_codes/) | Donanım tasarımının tamamı (RTL) + testbench'ler |
| [`main_files/firmware/`](main_files/firmware/) | İşlemcinin koşturduğu bare-metal yazılım (C / asm) |
| [`main_files/scripts/`](main_files/scripts/) | Vivado projesini otomatik kuran TCL scriptleri |
| [`main_files/teknotest/`](main_files/teknotest/) | TEKNOFEST resmi test (DDK) ortamı ve teslim paketi |

Her klasörün kendi `README.md`'si, o klasöre özel detayları anlatır.

---

## Hızlı başlangıç

**1. Donanım projesini oluştur (Vivado Tcl Console):**
```tcl
cd .../main_files/
source .../main_files/scripts/TEKNOFEST_MCU_Project.tcl
```
Bu, tüm tasarımı içeren Vivado projesini otomatik kurar. Tekil blokları ayrı
denemek için `scripts/` altındaki diğer scriptler kullanılır
(bkz. `scripts/README.md`).

**2. Yazılımı derle:**
```bash
cd main_files/firmware/
make            # bootloader + uygulama
```
Derleme hedeflerinin tamamı `firmware/README.md` içinde.

---

## Doğrulama

İşlemci çekirdeği Spike ISS ile doğrulandı. Çevre birimleri ve AXI haberleşmelerinin UVM ile 
doğrulama süreci devam ediyor. Çevre birimlerinin her biri kendi directed testbenchleri ile, sistem ise
birkaç temel test ile doğrulandı. Sistem, yarışmada bizden istenilen UART-Sistem testini geçmektedir.


---

Bu tasarım **YTU YODA KYBER** takımı tarafından geliştirilmiştir.

> Çevre birimleri, OBI→AXI wrapper ve AXI4 interconnect kodları (testbench'ler
> dahil) **tamamen takım tarafından yazılmıştır**; hiçbir açık kaynak repo ya da
> yapay zekâ tarafından üretilmiş kod kullanılmamıştır. Yapay zekâdan yalnızca
> öğrenme ve hata ayıklama sürecinde destek alınmıştır.
