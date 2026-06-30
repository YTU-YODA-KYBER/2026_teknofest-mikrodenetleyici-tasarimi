# scripts/ — Vivado Proje Oluşturma Scriptleri

Bu klasördeki TCL scriptleri, Vivado projesini elle uğraşmadan **otomatik
oluşturur**. İki tür script var:

- **`TEKNOFEST_MCU_Project.tcl`** → Sistemin tamamını (tüm tasarım kodlarımızı)
  içeren ana projeyi oluşturur.
- **Diğer `create_*.tcl` scriptleri** → Sadece ilgili tekil RTL bloğunu (ve varsa
  testbench'ini) içeren bir proje oluşturur. Tek bir bloğu ayrı denemek istediğinde
  kullanılır.

---

## Nasıl çalıştırılır?

Vivado'nun **Tcl Console**'unda iki adım:

**1.** Önce `main_files` klasörüne gir:
```tcl
cd /home/stradale/Documents/main_files/
```

**2.** İhtiyacına uygun scripti `source` ile çalıştır:
```tcl
source /home/stradale/Documents/main_files/scripts/Interconnect/create_Interconnect.tcl
```

Bu kadar — proje otomatik oluşur.

> Yol (`/home/stradale/Documents/...`) sana göre değişir; repoyu nereye
> kopyaladıysan o yolu kullan.

---

## Hangi script neyi oluşturur?

| Script | Oluşturduğu proje |
|---|---|
| `TEKNOFEST_MCU_Project.tcl` | **Tüm sistem** (bütün tasarım kodları bir arada) |
| `CPU/create_CPU.tcl` | CV32E40P çekirdeği |
| `Interconnect/create_Interconnect.tcl` | AXI4 ara bağlantı |
| `Interconnect/create_Instruction_Splitter.tcl` | Komut (instruction) ayırıcı |
| `Memory/create_Boot_ROM.tcl` | Boot ROM |
| `Memory/create_Data_RAM.tcl` | Data RAM |
| `Memory/create_Instruction_RAM.tcl` | Instruction RAM |
| `Peripherals/create_Timer.tcl` | Timer |
| `Peripherals/create_UART_GU.tcl` | UART (genel kullanım) |
| `Peripherals/create_UART_YZ.tcl` | UART (YZ akışı) |
| `Peripherals/create_I2C.tcl` | I2C Master |
| `Peripherals/create_QSPI.tcl` | QSPI Master |
