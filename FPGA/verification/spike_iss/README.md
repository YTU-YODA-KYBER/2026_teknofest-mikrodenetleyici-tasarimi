# spike_iss — Spike ISS Lockstep Doğrulaması

CV32E40P çekirdeğinin **komut seviyesinde** doğrulaması. Aynı program hem
referans ISA simülatöründe (Spike) hem de RTL'de koşturulur; iki tarafın ürettiği
komut izi satır satır karşılaştırılır. Diğer doğrulamalar tasarımın **sonucuna**
bakar (GPIO'ya doğru değer yazıldı mı, YZ doğru sınıfı buldu mu); bu doğrulama
her komutun **mimari etkisini** — PC, kodlama, register yazmaları — bağımsız bir
gerçeklemeye karşı denetler.

| Ölçüm | Sonuç |
|---|---|
| Karşılaştırılan komut | **193 / 193** |
| PC ayrışması | **0** |
| Kodlama ayrışması | **0** (103 komutta; 90 RVC komutu için bkz. aşağısı) |
| Register yazması ayrışması | **0** |
| Çıkış kodu | **0** |

---

## Ne kanıtlıyor

RTL tarafı **çıplak çekirdek değil, tam SoC**'dur: testbench `top_module`'ü
örnekler, komut ve veri erişimleri CV32E40P'nin OBI arayüzünden
`cv32e40p_obi_to_axi_wrapper` → `Instruction_Splitter` → `AXI4_Interconnect`
üzerinden BRAM'lere gider. Dolayısıyla eşleşme iki şeyi birden gösterir:

1. **Çekirdek ISA'ya uyuyor.** 193 komutun tamamında PC dizisi ve register
   dosyasının aldığı değerler Spike'ınkiyle aynı.
2. **Bellek yolu doğru veri döndürüyor.** 68 yükleme/saklama işleminin hepsinde
   AXI4-Lite zincirinden dönen kelime, Spike'ın düz bellek modelinden dönenle
   aynı. Adres kod çözme, `Instruction_Splitter` ayrımı ve BRAM sarmalayıcıları
   bu izin içinde dolaylı olarak doğrulanmış olur.

Test programı 1'den 10'a kadar kareler toplamını hesaplar (`385 = 0x181`) ve
`result` değişkenine yazar. Her iki taraf da aynı komutta aynı adrese aynı
değeri yazıyor:

```
spike : core   0: 3 0x10000094 (0x00e7a023) mem 0x20000000 0x00000181
rtl   : 9680.000 ns  474 10000094 00e7a023  sw x14, 0(x15) ... PA:20000000
```

İzde geçen komut çeşitliliği (11 farklı mnemonic): `lw`, `sw`, `c.sw`, `c.jal`,
`c.addi`, `c.add`, `bge`, `mul`, `auipc`, `addi`, `lui`. **M** (`mul`) ve **C**
(90 sıkıştırılmış komut) uzantıları çalıştırılmış olur.

---

## Adres haritası neden ana projeden farklı

Ana projede Boot ROM `0x0000_0000`'dadır. **Spike bu adresi kullandırmaz:**
`0x0`–`0xFFF` aralığını kendi Debug Module'üne ayırır ve bu bir derleme zamanı
sabitidir — `--disable-dtb` de `--halted` de kaldırmaz. O aralığa `-m` ile bellek
tanımlamaya çalışırsan spike tek satır bile koşmadan çıkar:

```
devices at [0, 1000) and [0, 1000) overlap
```

Bu yüzden lockstep testi **Instruction RAM haritasında** kurulur. Test programı
`0x1000_0000`'a linklenir, testbench `top_module`'ün `boot_addr` parametresini
oraya çeker; Spike tarafında karşılığı `--pc=0x10000000`'dır. `0x1000_0000`'daki
ns16550 UART modeli DTS'ten geldiği için `--disable-dtb` ile kalkar.

| | Ana proje | Lockstep testi |
|---|---|---|
| Başlangıç adresi | `0x0000_0000` (Boot ROM) | `0x1000_0000` (Instruction RAM) |
| Veri belleği | `0x2000_0000`, 8 KB | `0x2000_0000`, 8 KB (aynı) |

**RTL'e hiç dokunulmaz.** `Top_module.sv` şartname değerlerinde kalır;
`boot_addr` yalnızca testbench'ten ezilir — `yz_bench_test.sv`'nin yaptığının
aynısı.

---

## Dosyalar

| Dosya | Neyi raporlar |
|---|---|
| `logs/spike.log` | Spike commit log'u (`--log-commits`), 193 komut. Referans taraf |
| `logs/trace_core_00000000.log` | CV32E40P tracer çıktısı, 193 komut + başlık satırı. RTL taraf |
| `logs/compare.log` | İki izin karşılaştırması — bu doğrulamanın **sonucu** |
| `logs/xsim_console.log` | Simülasyon konsolu: kaç kelime yüklendi, kaç çevrimde bitti, hangi PC'de durdu |
| `test_program/test.c` · `boot.S` · `linker.ld` | Koşturulan program ve bellek haritası |
| `test_program/test.hex` | `objcopy -O verilog` çıktısı — testbench'in INSTRRAM'e yüklediği dosya |
| `test_program/test.disasm` | Programın disassembly'si; iz satırlarını kaynağa bağlamak için |
| `test_program/run_spike.sh` · `cmp_try.py` | Spike'ı koşturan ve izleri karşılaştıran araçlar |

> `run_spike.sh` günlük kullanımdaki hâliyle kopyalanmıştır ve
> `--instructions=100` ile koşar. Buradaki `spike.log` aynı komutla, tek
> farkla `--instructions=193` verilerek üretildi — sebebi aşağıda.

Doğrulamanın kendisi depoda iki dosyadır:
[`../../scripts/project_gen/SpikeISS/spike_test.tcl`](../../scripts/project_gen/SpikeISS/spike_test.tcl)
(projeyi kurar) ve
[`../../main_codes/testbench/spike_iss/spike_iss_test.sv`](../../main_codes/testbench/spike_iss/spike_iss_test.sv)
(testbench). Tracer, upstream CV32E40P v1.8.2'nin `bhv/` dosyalarıdır ve
`main_codes/testbench/spike_iss/cv32e40p-cv32e40p_v1.8.2/` altında durur;
sentezlenemez koddur, yalnızca `sim_1` fileset'ine eklenir ve
`CV32E40P_TRACE_EXECUTION` define'ı verilmezse hiç derlenmez.

---

## Nasıl üretildi

```bash
# 1) Test programını derle ve iki formata çevir  (spike çalışma klasöründe)
riscv-none-elf-gcc -march=rv32imc_zicsr_zifencei -mabi=ilp32 \
    -nostdlib -nostartfiles -T linker.ld -O0 -g \
    -o build/test.elf boot.S test.c
riscv-none-elf-objcopy -O verilog --verilog-data-width=4 \
    build/test.elf build/test.hex

# 2) Referans izi — Spike
spike --isa=rv32imc_zicsr_zifencei --priv=m \
      -m0x10000000:0x2000,0x20000000:0x2000 \
      --pc=0x10000000 --disable-dtb \
      --log-commits --log=spike.log --instructions=193 build/test.elf

# 3) RTL izi — Vivado/XSim   (FPGA/ kökünde)
vivado -mode batch -source scripts/project_gen/SpikeISS/spike_test.tcl
#   ardından: Run Simulation -> Run Behavioral Simulation
#   iz: Vivado_projects/spike_test/spike_test.sim/sim_1/behav/xsim/
#       trace_core_00000000.log

# 4) Karşılaştır
python3 cmp_try.py trace_core_00000000.log spike.log
```

Testbench programı INSTRRAM'e kendisi yükler (`bram_instr`'da `INIT_FILE`
parametresi yoktur), Data RAM'i sıfırlar — Spike'ta okunmamış bellek `0` döndüğü
için — ve program sonsuz döngüye girdiğinde (`while(1)` → `j .`, aynı PC 50 kez
çözülünce) kendiliğinden durur. Bu koşumda 777 çevrim sürdü.

**Spike'a `--instructions=193` verilmesinin sebebi budur:** RTL sonsuz döngüde
durduğu için 193 komutta kalıyor, Spike ise sınır konmazsa sonsuza kadar koşar.
İki izin uzunluğunu eşitlemek karşılaştırmayı kolaylaştırır; `cmp_try.py`
farklı uzunlukları da tolere eder, ortak ilk *n* komutu karşılaştırır.

Araçlar: **Spike 1.1.1-dev**, **riscv-none-elf-gcc 15.2.0**,
**Vivado / XSim 2025.2**.

---

## Okurken dikkat edilecekler

- **Sıkıştırılmış komutlarda kodlama kolonu karşılaştırılamaz.** Spike bellekten
  okunan **ham 16-bit** RVC kodlamasını basar (`0xa001`), CV32E40P tracer'ı ise
  ID stage'e giren **genişletilmiş 32-bit** eşdeğeri basar (`0x0000006f`) —
  tracer'ın `.instr` portu compressed decoder'dan *sonraki* sinyale bağlıdır.
  İkisi de doğrudur, farklı katmanlardır. `cmp_try.py` bu satırlarda kodlamayı
  atlar (alt iki bit `11` değilse komut 16-bit'tir), **PC ve register
  yazmalarını yine karşılaştırır**. 193 komutun 90'ı bu durumdadır; kalan
  103'ünde kodlama birebir eşleşmiştir.

- **Tracer değerleri `0x` öneki olmadan basar** (`x2=20002000`), Spike önekli
  basar. `cmp_try.py`'nin RTL regex'i bu yüzden öneki isteğe bağlı tutar.

- **`x0`'a yazmalar yok sayılır.** Register donanımsal olarak sıfırdır; iki
  aracın bu yazmayı loglama biçimi farklıdır, sahte fark üretmemesi için
  ayıklanır.

- **İzin son 50 satırı `c.jal x0, 0`'dır** — programın `while(1)` döngüsü
  (`0x1000_0098`). Anlamlı iş ilk 143 komutta biter; iki taraf döngüde de aynı
  satırı üretmeye devam eder.

- **Kapsam tek programdır.** 11 mnemonic, M ve C uzantıları, yükleme/saklama ve
  dallanma yolları çalıştırılmıştır; **CSR erişimi, kesme ve istisna yolları bu
  izde yoktur.** Doğrulamanın gücü tam olarak koşturulan programın kapsadığı
  kadardır — farklı optimizasyon seviyelerinde (`-O0/-O1/-O2/-Os`) yeniden
  derleyip tekrarlamak, kod üreticisi farklı komut dizileri seçtiği için ucuz
  bir çeşitlilik kaynağıdır.

- **Tracer sentezlenen tasarımın parçası değildir.** `bind` ile değil, testbench
  içinden hiyerarşik referanslarla bağlanır (`dut.cpu_inst.CORE.core_i...`) ve
  `` `ifdef CV32E40P_TRACE_EXECUTION `` içindedir. Depodaki çekirdek upstream
  v1.8.2 ile bit bit aynı olduğu için bu referansların hepsi birebir tutar.

- `xsim_console.log`'daki `unique case … 0ns` uyarıları reset öncesi CV32E40P
  artığıdır, zararsızdır.

---

Ölçüm tarihi: 2026-08-22. Simülatörler: Spike 1.1.1-dev, Vivado/XSim 2025.2.
