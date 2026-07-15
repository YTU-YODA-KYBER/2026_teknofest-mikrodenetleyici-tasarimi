# Firmware — Derleme Komutları Açıklamaları

> Not: `riscv32-unknown-elf-gcc` (toolchain) kurulu ve PATH'te olmalı.

> Not: Buradaki kodları derledikten sonra kullanabilmek için `./main_files/scripts/Full_MCU_Project.tcl.` scriptini ilgili klasördeki README açıklamasına göre çalıştırıp ana MCU projesini oluşturmanız gerekmektedir.
---

## Makefile komutları ne işe yarar?
| Komut | Ne yapar |
|---|---|
| `make boot` | Ana kod olan `main_boot.c` ve onun çalışması için gerekli olan linker.ld ve boot.S'yi derleyip main_boot klasörü içerisine firmware.hex adında çıkartır. |
| `make app` | Ana kod olan `main_app.c` ve onun çalışması için gerekli olan linker_app.ld ve boot.S'yi derleyip main_app klasörü içerisine firmware.hex adında çıkartır. |
| `make` | `make boot` ve `make app` komutlarını tek seferde uygular |
| `make circle` | Kart üzerinde basit bir LED animasyon demosu |
| `make echo` | Test amaçlı UART echo testi |


## Derlenmiş dosyalar nasıl kullanılır?
Not kısmında belirtilen tcl scripti otomatik olarak main_boot klasöründeki firmware.hex dosyasını Memory File olarak projeye ekler. Bu dosya default olarak projede bulunan Boot ROM'a yüklenir ve sistem reset sinyalinden sonra buradaki buyrukları çalıştırır. 
Dolayısıyla, yapmak istediğiniz işleme göre yukarıdan ilgili make komutunu çalıştırıp oluşturulan klasörün adını "main_boot" yapmanız ve sonrasında tcl scripti ile projeyi oluşturmanız yeterlidir.
> "firmware.hex" dosyasını Instruction RAM'e yükleyip sistemi oradan başlatmak için projedeki `top_module` isimli koddan `boot_addr` isimli parametrenin değerini 0x10000000 yapınız.

Sistemin boot senaryosunu ve yazılan uygulama kodlarını çalıştırabilmesi için ise şu adımlar uygulanmalıdır:
> Bu işlem için uyumlu bir non-volatile flash belleği FPGA kartına bağlamanız gerekmektedir.

`1-`Herhangi bir kodu değiştirmeyin, make boot komutu ile derleme işlemini yapıp tcl scripti ile projeyi oluşturun. Projeyi bitstream ile karta yükleyip çalıştırın.
`2-` "make app" ile ana uygulama kodunu derleyin. Oluşturulan hex kodunun kart üzerinde çalışması için önce kartın `SW0` pinini açıp kartın `CPU RESET` tuşuna basarak resetleyin, 7-segment ekranda boot yazısı yazmalı.
`3-` "/firmware/scripts" klasöründe bulunan send_data.py scriptini, o klasördeki README açıklamasına göre çalıştırın, bu sayede derlediğiniz uygulama kodları QSPI modülü aracılığı ile flash belleğe yazılır.
`4-` İşlem tamamlandıktan sonra `SW0` pinini kapatıp kartı tekrar resetleyin. Bu sefer bağlı olan flash bellekteki verileri kendi belleğine yazıp uygulama kodlarını yürütme işine başlayacaktır.

## YZ Hızlandırıcı Nasıl Kullanılır?
Yukarıdaki işlemleri yaptıktan sonra eğer main_app.c kodunda herhangi bir değişiklik yapmadıysanız kart üzerindeki SW1 pinini açarsanız MCU YZ-UART moduna geçecektir. /firmware/scripts klasöründeki send_data.py scriptini, o klasördeki README açıklamasına göre çalıştırın. Bu script karta UART aracılığı ile hex uzantılı ses dosyasını gönderecek, kart ise otomatik olarak bu verileri YZ belleğine yazıp çıkarım işlemini yapacak ve sonucu 7-segment ekrana yazacaktır.
>Uygulama koduna ihtiyacınıza göre eklemeler yapabilirsiniz.


## Kaynak dosyalar ne işe yarar?

| Dosya | Görevi |
|---|---|
| `main_boot.c` | **Boot ROM kodu.** SW0'a göre dallanır: SW0=1 → **flasher** (UART'tan app'i alıp QSPI flash'a yazar + doğrular), SW0=0 → **boot** (flash'tan app'i okuyup DMA ile INSTRRAM'e yazar, `0x10000000`'a atlar). |
| `main_app.c` | **Asıl uygulama.** Flash'a yazılıp INSTRRAM'e boot edilen, kesme-güdümlü ana program. `irq_init` + `trap_handler` + YZ hızlandırıcı ISR'larını (`load_done_isr`, `infer_done_isr`) içerir; `main()` kurulumdan sonra `for(;;)` ile durur, tüm iş mantığı kesmelerle yürür. |
| `circle.c` | LED animasyon demosu. Boot ROM / INSTRRAM boot akışını hızlandırıcı olmadan doğrulamak için ayrı `circle` hedefiyle derlenir. |
| `flasher_echo_test.c` | UART echo testi (baud + TX/RX doğrulaması için, Boot ROM'da koşar). |
| `boot.S` | Reset vektörü / crt0: sp kurulumu, `.data`/`.bss`, `main` çağrısı. |
| `linker.ld` | Boot ROM yerleşimi (`0x00000000`). |
| `linker_app.ld` | Uygulama yerleşimi (INSTRRAM, `0x10000000`). |
| `soc.h` | Donanım soyutlama başlığı (register/adres tanımları). |
| `hex2vmf.py` | `firmware.hex` → `mem_Q512.vmf` (Micron flash sim modeli için). |

---

## Simülasyon

| Ne Yapar | Komut |
|---|---|
| Boot ROM'u sim için derle (erase kapalı) | `make sim_boot` |
| Uygulamayı sim için derle | `make sim_app` |
| Flash imajı üret (app → mem_Q512.vmf) | `make flash_vmf` |
| Flash imajı üret (sim app'ten) | `make sim_flash_vmf` |

> **Neden ayrı sim hedefleri var?**
> - `sim_boot`: flasher'ın erase adımını atlar (`-DFLASHER_NO_ERASE`). Gerçek flash silme sim'de çok yavaş; sim'de flash zaten 0xFF (silinmiş) başlar.
> - `sim_app`: gerekirse `main_app.c` içindeki sim-özel kısaltmalar için (`-DSIMULATION`) kullanılır.

## Diğer

| İstediğin | Komut |
|---|---|
| Boyut raporu (main_boot + main_app) | `make size` |
| Boot ROM disassembly | `make disasm_boot` |
| Uygulama disassembly | `make disasm_app` |
| Üretilen klasörleri sil | `make clean` |

---

## Çıktılar

İlgili `build_*/` klasörüne yazılır:

| Dosya | Ne işe yarar |
|---|---|
| `build_boot/firmware.hex` | Boot ROM'a yüklenir (bitstream INIT / testbench `$readmemh`). HW build, erase **açık**. |
| `build_boot_sim/firmware.hex` | Aynısı, sim build (erase **kapalı**). |
| `build_app/firmware.hex` | Uygulama (main_app) hex'i (`hex2vmf.py` girdisi). |
| `build_app/app.bin` | Gerçek QSPI flash'a harici programlayıcı ile yazmak için. |
| `build_app/mem_Q512.vmf` | Sim'de Micron flash modeline yüklenen imaj (`make flash_vmf` üretir). |
| `build_circle/firmware.hex`, `build_circle/circle.bin` | Eski LED demosunun (circle) çıktıları. |

`make clean` tüm `build_*` klasörlerini (`build_boot`, `build_boot_sim`, `build_app`, `build_app_sim`, `build_circle`, `build_echo`) siler — elle temizlik gerekmez.

---
