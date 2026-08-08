`timescale 1ns / 1ps

// =========================================================================
//  GPIO_AXI4_Lite  --  blok seviyesi yonlendirilmis (directed) testbench
//  YTU YODA KYBER / TEKNOFEST 2026 Cip Tasarim Yarismasi
//
//  Kapsam:
//    - AXI4-Lite yazma/okuma el sikismasi ve reset degerleri
//    - GPIO_ODR / GPIO_IDR yazmac davranisi (EK-2 ister tablosu)
//    - Salt-okunur (RO) adres korunmasi ve tanimsiz adres davranisi
//    - dma_enable_o turetimi (GPIO_IDR[1])
//    - 7-segment surucusu: anode one-cold garantisi, 13 mesaj tablosunun tum
//      haneleri, animasyon deseni ve tarama sayaclarinin sarmasi
//
//  Not: Bu blok, sistemde 0x4001_0000 tabanina oturur; RTL adres kod cozmeyi
//  yalnizca alt 4 bit uzerinden yaptigi icin testler hem ofset (0x0/0x4) hem
//  de tam sistem adresi ile calistirilmistir (bkz. TEST 10).
// =========================================================================

`include "axi4lite_bind_gpio.svh"

module GPIO_testbench;

    // clock ve reset sinyalleri
    logic clk_i = 0;
    logic rst_n = 0;

    // GPIO I/O portlari
    logic [31:0] GPIO_IDR = 0;   // TB surer (switch/giris pinleri)
    logic [31:0] GPIO_ODR;       // DUT surer (cikis pinleri)

    // AW Portlari
    logic [31:0] awaddr  = 0;
    logic        awvalid = 0;
    logic        awready;

    // W Portlari
    logic [31:0] wdata   = 0;
    logic        wvalid  = 0;
    logic        wready;

    // B Portlari
    logic        bready  = 1;   // AXI4-Lite'ta READY'yi surekli assert etmek yasaldir
    logic [ 1:0] bresp;
    logic        bvalid;

    // AR Portlari
    logic [31:0] araddr  = 0;
    logic        arvalid = 0;
    logic        arready;

    // R Portlari
    logic        rready  = 1;   // AXI4-Lite'ta READY'yi surekli assert etmek yasaldir
    logic [31:0] rdata;
    logic [ 1:0] rresp;
    logic        rvalid;

    // Yardimci cikislar
    logic        dma_enable_o;
    logic [ 7:0] catode;
    logic [ 7:0] anode;

    // axi okuma yaparken veriyi kaydedecegimiz register
    logic [31:0] read_data;

    // ---- Basari sayaclari ----
    integer toplam_basari    = 0;
    integer toplam_basarisiz = 0;


    //  MODULU CAGIRMA
    GPIO_AXI4_Lite dut(
        .clk_i(clk_i),
        .rst_n(rst_n),
        .GPIO_IDR(GPIO_IDR),
        .GPIO_ODR(GPIO_ODR),
        .awaddr(awaddr),
        .awvalid(awvalid),
        .awready(awready),
        .wdata(wdata),
        .wvalid(wvalid),
        .wready(wready),
        .bresp(bresp),
        .bvalid(bvalid),
        .bready(bready),
        .araddr(araddr),
        .arvalid(arvalid),
        .arready(arready),
        .rdata(rdata),
        .rresp(rresp),
        .rvalid(rvalid),
        .rready(rready),
        .dma_enable_o(dma_enable_o),
        .catode(catode),
        .anode(anode)
    );


    // --- CLOCK URETIMI ---
    always begin
        #5 clk_i = ~clk_i; // 100MHZ CLK
    end

    // Reset islemi
    task reset;
        begin
            rst_n = 0;
            #20;
            rst_n = 1;
            #20;
        end
    endtask


    // AXI4-Lite YAZMA.
    //
    // DIKKAT -- neden her sey negedge'de suruluyor:
    //   Eski surum wait(awready && wready) ile bekleyip sinyalleri SAAT
    //   KENARIYLA AYNI ZAMAN ADIMINDA suruyordu. Bu, awvalid/wvalid/arvalid
    //   uzerinde SIFIR GENISLIKLI darbe (0->1->0, ayni t aninda) uretebiliyordu:
    //   DUT'un always blogu ayni aktif bolgede darbeyi yakalayip islemi kabul
    //   ederken, bind edilmis protokol kontrolcusunun sayac mantigi darbeyi
    //   goremiyor; sayaclar ayrisinca ORD/OUT kurallari sahte ihlal yagdiriyordu
    //   (QSPI blok testinde 600 binden fazla sahte ihlal bu yuzden olusmustu).
    //   Cozum: butun stimulus saat kenarindan uzakta (negedge'de) surulur,
    //   butun ornekleme de negedge'de yapilir -> yaris yok, darbe yok.
    task axi_write(input [31:0] addr, input [31:0] data);
        begin
            @(negedge clk_i);
            awaddr  = addr;
            wdata   = data;
            awvalid = 1;
            wvalid  = 1;

            // AW/W el sikismasinin gerceklesecegi posedge'i bekle
            while (!(awready && wready)) @(negedge clk_i);
            @(negedge clk_i);           // el sikisma posedge'i gecildi
            awvalid = 0;
            wvalid  = 0;
            // B cevabi beklenmez: bready surekli 1, el sikisma kendiliginden olur
        end
    endtask

    // AXI4-Lite OKUMA.  (Zamanlama gerekcesi icin axi_write aciklamasina bak.)
    task axi_read(input [31:0] addr, output [31:0] read);
        begin
            @(negedge clk_i);
            araddr  = addr;
            arvalid = 1;

            // AR el sikismasinin gerceklesecegi posedge'i bekle
            while (!arready) @(negedge clk_i);
            @(negedge clk_i);           // AR el sikisma posedge'i gecildi
            arvalid = 0;

            while (!rvalid) @(negedge clk_i);
            read = rdata;               // rdata, rvalid boyunca kararli
            // R el sikismasi rready surekli 1 oldugu icin bir sonraki posedge'de olur
        end
    endtask

    // Tek satirlik sonuc raporlama yardimcilari
    task kontrol(input string ad, input [31:0] beklenen, input [31:0] gozlenen);
        begin
            if (gozlenen === beklenen) begin
                $display("  [GECTI ] %0s: beklenen=0x%08h, gozlenen=0x%08h", ad, beklenen, gozlenen);
                toplam_basari = toplam_basari + 1;
            end else begin
                $display("  [KALDI ] %0s BASARISIZ: beklenen=0x%08h, gozlenen=0x%08h", ad, beklenen, gozlenen);
                toplam_basarisiz = toplam_basarisiz + 1;
            end
        end
    endtask

    // 7-segment desen kontrolu: verilen IDR/ODR/anode_select icin catode dogru mu?
    task seg_kontrol(input string ad, input [31:0] idr, input [15:0] odr,
                     input [2:0] a_sel, input [7:0] beklenen);
        begin
            GPIO_IDR = idr;
            axi_write(32'h0000_0004, {16'h0000, odr});
            #40;                                  // ODR'nin yazmaca oturmasi icin
            force dut.anode_select = a_sel;
            #40;                                  // catode'un yeniden hesaplanmasi icin
            if (catode === beklenen) begin
                $display("  [GECTI ] %0s (IDR=%0d ODR=%0d anode_select=%0d): catode=8'b%08b",
                         ad, idr, odr, a_sel, catode);
                toplam_basari = toplam_basari + 1;
            end else begin
                $display("  [KALDI ] %0s BASARISIZ (IDR=%0d ODR=%0d anode_select=%0d): beklenen=8'b%08b, gozlenen=8'b%08b",
                         ad, idr, odr, a_sel, beklenen, catode);
                toplam_basarisiz = toplam_basarisiz + 1;
            end
            release dut.anode_select;
        end
    endtask

    // Bir mesaj tablosunun TAMAMINI tarar: anode_select = a_bas..7.
    // tbl[i] = anode_select == i icin beklenen catode deseni.
    // a_bas'tan kucuk indisler RTL'deki case'de yer almadigi icin okunmaz
    // (o hanelerde catode, animasyon blogundan gelen degerini korur).
    //
    // Tek satirlik sonuc basar; hata varsa hangi hanede oldugunu detaylandirir.
    task mesaj_tara(input string ad, input [31:0] idr, input [15:0] odr,
                    input int a_bas, input logic [7:0] tbl [8]);
        int a;
        int hata;
        begin
            hata     = 0;
            GPIO_IDR = idr;
            axi_write(32'h0000_0004, {16'h0000, odr});
            #40;                                  // ODR'nin yazmaca oturmasi icin
            for (a = a_bas; a <= 7; a = a + 1) begin
                force dut.anode_select = a[2:0];
                #40;                              // catode'un yeniden hesaplanmasi icin
                if (catode !== tbl[a]) begin
                    hata = hata + 1;
                    $display("      anode_select=%0d: beklenen=8'b%08b, gozlenen=8'b%08b",
                             a, tbl[a], catode);
                end
            end
            release dut.anode_select;

            if (hata == 0) begin
                $display("  [GECTI ] %0s (IDR=%0d ODR=%0d, hane %0d-7): tum haneler dogru",
                         ad, idr, odr, a_bas);
                toplam_basari = toplam_basari + 1;
            end else begin
                $display("  [KALDI ] %0s BASARISIZ (IDR=%0d ODR=%0d): %0d hanede hata",
                         ad, idr, odr, hata);
                toplam_basarisiz = toplam_basarisiz + 1;
            end
        end
    endtask

    // Animasyon deseni kontrolu: anode_select 0 veya 1 iken catode yalnizca
    // anim_select'e baglidir. Ikisini de 'force' ile sabitleyip bakiyoruz.
    //
    // ONEMLI: cagirmadan once IDR/ODR, mesaj case'inde 0 ve 1 haneleri
    // TANIMSIZ olan bir kombinasyona ayarlanmis olmali (orn. IDR=1, ODR=1).
    // Aksi halde mesaj blogu ayni catode'u sonradan ezer ve animasyon deseni
    // hic gorunmez -- RTL'de iki blok da ayni always icinde, sonraki kazanir.
    task anim_kontrol(input string ad, input [2:0] a_sel, input [3:0] an_sel,
                      input [7:0] beklenen);
        begin
            force dut.anode_select = a_sel;
            force dut.anim_select  = an_sel;
            #40;
            if (catode === beklenen) begin
                $display("  [GECTI ] %0s (hane=%0d anim=%0d): catode=8'b%08b",
                         ad, a_sel, an_sel, catode);
                toplam_basari = toplam_basari + 1;
            end else begin
                $display("  [KALDI ] %0s BASARISIZ (hane=%0d anim=%0d): beklenen=8'b%08b, gozlenen=8'b%08b",
                         ad, a_sel, an_sel, beklenen, catode);
                toplam_basarisiz = toplam_basarisiz + 1;
            end
            release dut.anode_select;
            release dut.anim_select;
        end
    endtask

    // anim_select'i BIR adim ilerletir -- sayaci zorlamadan, RTL'in kendi
    // yolundan.
    //
    // RTL'de anim_select yalnizca clk_div == 0 oldugunda artar; clk_div ise
    // 5_000_000'dan geri sayar. Yani dogal periyot 5.000.001 vurus (50 MHz'de
    // 100 ms). Bunun yerine clk_div'i 2'ye zorlayip birakiyoruz:
    //     2 -> 1 -> 0 -> (clk_div==0 dali) yeniden yukle + anim_select++
    // Boylece sayacin KENDI mantigi kosar (anim_select'e elle deger
    // yazilmaz), sadece bekleme suresi kisalir. anim_select == 7 sarma dali
    // da bu yolla gercek sekilde tetiklenir.
    //
    // Yan etki (kasitli): clk_div == 0 aninda clk_div[10:0] de 0 oldugundan
    // ayni vuruşta anode_select de bir artar -- onun sarma dali da kapsanir.
    task anim_ilerlet;
        begin
            force dut.clk_div = 32'd2;
            @(posedge clk_i);
            #1;
            release dut.clk_div;
            repeat (4) @(posedge clk_i);
            #1;
        end
    endtask


    // --- TEST ---
    initial begin
        $display("======================================================================");
        $display("               GPIO_AXI4_Lite TESTBENCH BASLIYOR");
        $display("======================================================================\n");

        // Reset ile sisteme temiz bir baslangic yapiyoruz
        reset();

        // =====================================================================
        // TEST 1: Reset sonrasi baslangic degerleri
        // Reset kalktiktan sonra AXI kanallari bos (idle) durumda olmali:
        // awready/wready/arready = 1 (yeni istek kabul edilebilir), bvalid ve
        // rvalid = 0 (bekleyen cevap yok). Cikis yazmaci GPIO_ODR ise
        // tamamen sifirlanmis olmali; aksi halde acilista pinlere cop deger
        // surulur ve karttaki LED'ler rastgele yanar.
        // =====================================================================
        $display("--- TEST 1: Reset sonrasi baslangic degerleri ---");

        if (awready === 1'b1 && wready === 1'b1 && arready === 1'b1 &&
            bvalid  === 1'b0 && rvalid === 1'b0 && GPIO_ODR === 32'h0) begin
            $display("  [GECTI ] Test 1 basarili: AXI idle (aw/w/arready=1, b/rvalid=0), GPIO_ODR=0");
            toplam_basari = toplam_basari + 1;
        end else begin
            $display("  [KALDI ] Test 1 BASARISIZ: awready=%0b wready=%0b arready=%0b bvalid=%0b rvalid=%0b GPIO_ODR=0x%08h",
                     awready, wready, arready, bvalid, rvalid, GPIO_ODR);
            toplam_basarisiz = toplam_basarisiz + 1;
        end

        // =====================================================================
        // TEST 2: GPIO_ODR temel yazma / geri okuma
        // 0x04 ofsetine bir deger yaziyoruz. Iki sey ayni anda dogrulanmali:
        // (a) deger cikis portuna (GPIO_ODR pinlerine) yansimali,
        // (b) ayni adresten AXI ile geri okundugunda ayni deger donmeli.
        // (b) olmadan yazilim yazdigini teyit edemez.
        // =====================================================================
        $display("\n--- TEST 2: GPIO_ODR yazma ve geri okuma ---");

        axi_write(32'h0000_0004, 32'h0000_ABCD);
        #40;
        kontrol("Test 2a (GPIO_ODR cikis portu)", 32'h0000_ABCD, GPIO_ODR);

        axi_read(32'h0000_0004, read_data);
        kontrol("Test 2b (GPIO_ODR geri okuma)",  32'h0000_ABCD, read_data);

        // =====================================================================
        // TEST 3: GPIO_ODR[31:16] etkisiz olmali  (Sartname EK-2)
        // Sartname: "GPIO_ODR[15:0] bitlerine yazilan 16-bit degeri cikis
        // bitlerine iletir. GPIO_ODR[31:16] bitlerine yazilan deger etkisizdir."
        // Ust 16 biti 1'lerle doldurup yaziyoruz; donanim bunlari kirpmali,
        // yani geri okundugunda yalnizca alt 16 bit gorulmeli.
        // =====================================================================
        $display("\n--- TEST 3: GPIO_ODR[31:16] etkisiz (EK-2 isteri) ---");

        axi_write(32'h0000_0004, 32'hFFFF_1234);
        #40;
        kontrol("Test 3a (ust 16 bit kirpildi mi)", 32'h0000_1234, GPIO_ODR);

        axi_read(32'h0000_0004, read_data);
        kontrol("Test 3b (geri okumada da kirpik)", 32'h0000_1234, read_data);

        // =====================================================================
        // TEST 4: GPIO_IDR okuma
        // Giris pinlerine bir desen suruyoruz ve 0x00 ofsetinden okuyoruz.
        // GPIO_IDR yazmaci saf kombinasyonel bir gecis yolu oldugundan
        // okunan deger pinlerdeki desenin aynisi olmali.
        // =====================================================================
        $display("\n--- TEST 4: GPIO_IDR okuma ---");

        GPIO_IDR = 32'h0000_5A5A;
        #40;
        axi_read(32'h0000_0000, read_data);
        kontrol("Test 4 (GPIO_IDR okuma)", 32'h0000_5A5A, read_data);

        // =====================================================================
        // TEST 5: GPIO_IDR salt-okunur (RO) olmali
        // 0x00 ofsetine yazma denemesi yapiyoruz. GPIO_IDR bir giris yazmaci
        // oldugu icin bu yazmanin (a) IDR'yi degistirmemesi, (b) yanlislikla
        // GPIO_ODR'ye sizmamasi gerekiyor. (b) onemli: adres kod cozmede
        // eksik bir kosul olsaydi 0x00'a yazilan deger ODR'yi bozardi.
        // =====================================================================
        $display("\n--- TEST 5: GPIO_IDR salt-okunur (RO) korunmasi ---");

        axi_write(32'h0000_0000, 32'hFFFF_FFFF);   // RO adrese yazma denemesi
        #40;
        kontrol("Test 5a (GPIO_ODR bozulmadi)", 32'h0000_1234, GPIO_ODR);

        axi_read(32'h0000_0000, read_data);
        kontrol("Test 5b (GPIO_IDR degismedi)", 32'h0000_5A5A, read_data);

        // =====================================================================
        // TEST 6: dma_enable_o turetimi
        // RTL'de dma_enable_o dogrudan GPIO_IDR[1] bitinden kaydedilir
        // (bir saat vurusu gecikmeli). Bu sinyal Top_module'de YZ veri akisi
        // DMA'sini tetikledigi icin hem yukselen hem dusen kenari test edilir.
        // =====================================================================
        $display("\n--- TEST 6: dma_enable_o (GPIO_IDR[1]) ---");

        GPIO_IDR = 32'h0000_0002;                  // bit1 = 1
        #40;
        kontrol("Test 6a (IDR[1]=1 -> dma_enable_o=1)", 32'd1, {31'd0, dma_enable_o});

        GPIO_IDR = 32'h0000_0000;                  // bit1 = 0
        #40;
        kontrol("Test 6b (IDR[1]=0 -> dma_enable_o=0)", 32'd0, {31'd0, dma_enable_o});

        // =====================================================================
        // TEST 7: anode "one-cold" garantisi
        // 7-segment surucusunde anode sinyali her an tam olarak BIR adet '0'
        // icermelidir (aktif-dusuk secim). Iki hane ayni anda secilirse
        // ekranda hayalet (ghosting) olusur; hicbiri secilmezse ekran soner.
        // Bu yuzden 2000 saat vurusu boyunca her vuruşta $countones ile
        // kontrol ediyoruz. Ayrica surucunun gercekten tarama yaptigini
        // (anode_select'in ilerledigini) dogruluyoruz.
        // =====================================================================
        $display("\n--- TEST 7: anode one-cold ve tarama (scan) kontrolu ---");

        begin : test7_blok
            integer i;
            integer ihlal;
            logic [2:0] ilk_sel;
            logic       sel_degisti;

            ihlal       = 0;
            sel_degisti = 0;
            ilk_sel     = dut.anode_select;

            // 2500 > 2048: anode_select periyodu 2048 vurus oldugundan bu
            // pencere icinde en az bir ilerleme gorulmesi garantidir.
            for (i = 0; i < 2500; i = i + 1) begin
                @(posedge clk_i);
                #1;
                if ($countones(~anode) !== 1) ihlal = ihlal + 1;
                if (dut.anode_select !== ilk_sel) sel_degisti = 1;
            end

            if (ihlal == 0) begin
                $display("  [GECTI ] Test 7a basarili: 2000 vurus boyunca anode her zaman tek-'0' (one-cold)");
                toplam_basari = toplam_basari + 1;
            end else begin
                $display("  [KALDI ] Test 7a BASARISIZ: %0d vuruşta anode one-cold degildi", ihlal);
                toplam_basarisiz = toplam_basarisiz + 1;
            end

            if (sel_degisti) begin
                $display("  [GECTI ] Test 7b basarili: anode_select ilerliyor (tarama calisiyor), son deger=%0d",
                         dut.anode_select);
                toplam_basari = toplam_basari + 1;
            end else begin
                $display("  [KALDI ] Test 7b BASARISIZ: anode_select %0d degerinde takildi, tarama yok", ilk_sel);
                toplam_basarisiz = toplam_basarisiz + 1;
            end
        end

        // =====================================================================
        // TEST 8: Ekran sonuk (blank) kosullari
        // RTL'de ekran yalnizca  (GPIO_IDR==1 && GPIO_ODR[2:0]!=0) || GPIO_IDR==2
        // kosulunda desen surer; disinda catode = 8'hFF (tum segmentler sonuk).
        // Iki sonuk senaryosunu test ediyoruz:
        //   8a) GPIO_IDR = 0            -> hicbir mod aktif degil
        //   8b) GPIO_IDR = 1, ODR[2:0]=0 -> mod aktif ama gosterilecek durum yok
        // =====================================================================
        $display("\n--- TEST 8: Ekran sonuk (blank) kosullari ---");

        GPIO_IDR = 32'h0000_0000;
        axi_write(32'h0000_0004, 32'h0000_0000);
        #200;
        kontrol("Test 8a (IDR=0 -> catode sonuk)", 32'h0000_00FF, {24'h0, catode});

        GPIO_IDR = 32'h0000_0001;
        axi_write(32'h0000_0004, 32'h0000_0000);   // ODR[2:0] = 0
        #200;
        kontrol("Test 8b (IDR=1, ODR=0 -> catode sonuk)", 32'h0000_00FF, {24'h0, catode});

        // =====================================================================
        // TEST 9: 7-segment mesaj tablolarinin TAM taranmasi
        // RTL'in mesaj blogu iki kolludur:
        //   GPIO_IDR[1:0] == 1  -> flasher/boot durumlari (ERASE, SNDING,
        //                          FINISH, ERROR, default=BOOT)
        //   GPIO_IDR[1:0] == 2  -> YZ akisi (SNDING, INFRNC, EVET, HAYIR,
        //                          SESSIZLK, BILINMYN, default=YZUART)
        // Her mesajin altinda anode_select uzerine kurulu bir case daha var.
        // Burada her mesajin BUTUN hanelerini tariyoruz; boylece 13 mesaj x
        // 6-8 hane = 90'a yakin dalin tamami tetiklenir.
        //
        // anode_select 'force' ile sabitlenir (Timer_tb'deki yaklasimin aynisi):
        // gercek tarama periyodu 50 MHz'de 2048 vurus/hane oldugundan, dogal
        // yoldan beklemek simulasyonu gereksiz uzatirdi.
        //
        // Hane 0 ve 1: IDR=1 kolunun tamaminda ve IDR=2'nin SNDING/INFRNC/
        // YZUART mesajlarinda case'de tanimli DEGILDIR -- o hanelerde catode
        // animasyon blogundan gelen degerini korur (bkz. TEST 14). Bu yuzden
        // o tablolar hane 2'den baslar.
        // =====================================================================
        $display("\n--- TEST 9: 7-segment mesaj tablolari (tam tarama) ---");

        // ---- IDR = 1 kolu: flasher / boot durumlari ----
        //                                  hane:   0      1        2             3             4             5             6             7
        mesaj_tara("Test 9a ERASE",    32'd1, 16'd1,  2, '{8'hFF, 8'hFF, 8'b1111_1111, 8'b1000_0110, 8'b1001_0010, 8'b1000_1000, 8'b1100_1110, 8'b1000_0110});
        mesaj_tara("Test 9b SNDING",   32'd1, 16'd2,  2, '{8'hFF, 8'hFF, 8'b1001_0000, 8'b1100_1000, 8'b1111_1001, 8'b1010_0001, 8'b1100_1000, 8'b1001_0010});
        mesaj_tara("Test 9c FINISH",   32'd1, 16'd3,  2, '{8'hFF, 8'hFF, 8'b1000_1001, 8'b1001_0010, 8'b1111_1001, 8'b1100_1000, 8'b1111_1001, 8'b1000_1110});
        mesaj_tara("Test 9d ERROR",    32'd1, 16'd4,  2, '{8'hFF, 8'hFF, 8'b1111_1111, 8'b1100_1110, 8'b1100_0000, 8'b1100_1110, 8'b1100_1110, 8'b1000_0110});
        mesaj_tara("Test 9e BOOT(def)",32'd1, 16'd5,  2, '{8'hFF, 8'hFF, 8'b1111_1111, 8'b1111_1111, 8'b1000_0111, 8'b1100_0000, 8'b1100_0000, 8'b1000_0011});

        // ---- IDR = 2 kolu: YZ veri akisi ve siniflandirma sonuclari ----
        mesaj_tara("Test 9f SNDING",   32'd2, 16'd5,  2, '{8'hFF, 8'hFF, 8'b1001_0000, 8'b1100_1000, 8'b1111_1001, 8'b1010_0001, 8'b1100_1000, 8'b1001_0010});
        mesaj_tara("Test 9g INFRNC",   32'd2, 16'd6,  2, '{8'hFF, 8'hFF, 8'b1100_0110, 8'b1100_1000, 8'b1100_1110, 8'b1000_1110, 8'b1100_1000, 8'b1111_1001});
        mesaj_tara("Test 9h EVET",     32'd2, 16'd7,  0, '{8'b1111_1111, 8'b1111_1111, 8'b1111_1111, 8'b1111_1111, 8'b1000_0111, 8'b1000_0110, 8'b1100_0001, 8'b1000_0110});
        mesaj_tara("Test 9i HAYIR",    32'd2, 16'd8,  0, '{8'b1111_1111, 8'b1111_1111, 8'b1111_1111, 8'b1100_1110, 8'b1111_1001, 8'b1001_0001, 8'b1000_1000, 8'b1000_1001});
        mesaj_tara("Test 9j SESSIZLK", 32'd2, 16'd9,  0, '{8'b1000_1010, 8'b1100_0111, 8'b1010_0100, 8'b1111_1001, 8'b1001_0010, 8'b1001_0010, 8'b1000_0110, 8'b1001_0010});
        mesaj_tara("Test 9k BILINMYN", 32'd2, 16'd10, 0, '{8'b1100_1000, 8'b1001_0001, 8'b1110_1010, 8'b1100_1000, 8'b1111_1001, 8'b1100_0111, 8'b1111_1001, 8'b1000_0011});
        mesaj_tara("Test 9l YZUART(def)",32'd2,16'd11,2, '{8'hFF, 8'hFF, 8'b1000_0111, 8'b1100_1110, 8'b1000_1000, 8'b1100_0001, 8'b1010_0100, 8'b1001_0001});

        // =====================================================================
        // TEST 10: Sistem adresi ile erisim (adres kod cozme)
        // RTL adres kod cozmeyi yalnizca awaddr[3:0] / araddr[3:0] uzerinden
        // yapar; ust bitler interconnect tarafindan zaten ayiklanmistir.
        // Bu yuzden blogun sistemdeki gercek adresi olan 0x4001_0004 ile de
        // ayni davranisi gostermesi gerekir. Bu test, blok testbench'i ile
        // sistem seviyesi davranisi arasindaki kopukluğu kapatir.
        // =====================================================================
        $display("\n--- TEST 10: Sistem adresi (0x4001_0004) ile erisim ---");

        GPIO_IDR = 32'h0000_0000;
        axi_write(32'h4001_0004, 32'h0000_BEEF);
        #40;
        kontrol("Test 10a (sistem adresine yazma)", 32'h0000_BEEF, GPIO_ODR);

        axi_read(32'h4001_0004, read_data);
        kontrol("Test 10b (sistem adresinden okuma)", 32'h0000_BEEF, read_data);

        // =====================================================================
        // TEST 11: Arka arkaya (back-to-back) yazma
        // AXI el sikismasinin ardisik islemlerde kilitlenmedigini ve her
        // yazmanin bir oncekinin uzerine dogru sekilde yazildigini gosterir.
        // Bir onceki islemin B kanali kapanmadan yenisi baslarsa FSM takilir;
        // bu test tam olarak o senaryoyu zorlar.
        // =====================================================================
        $display("\n--- TEST 11: Arka arkaya yazma ---");

        axi_write(32'h0000_0004, 32'h0000_0001);
        axi_write(32'h0000_0004, 32'h0000_0002);
        axi_write(32'h0000_0004, 32'h0000_0003);
        axi_write(32'h0000_0004, 32'h0000_00A5);
        #40;
        kontrol("Test 11 (son yazilan deger gecerli)", 32'h0000_00A5, GPIO_ODR);

        // =====================================================================
        // TEST 12: Tanimsiz adres davranisi
        // GPIO'da yalnizca 0x00 ve 0x04 ofsetleri tanimlidir.
        // 12a) Tanimsiz bir adrese yazma GPIO_ODR'yi bozmamali.
        // 12b) Tanimsiz bir adresten okuma: RTL'deki okuma case'inde 'default'
        //      dali yoktur, bu yuzden rdata onceki degerini korur. Bu bir hata
        //      degil bilincli bir tercihtir (AXI4-Lite SLVERR zorunlu degildir),
        //      ancak davranisin belgelenmesi icin BILGI olarak raporlanir.
        // =====================================================================
        $display("\n--- TEST 12: Tanimsiz adres davranisi ---");

        axi_write(32'h0000_0008, 32'hDEAD_BEEF);   // tanimsiz ofset
        #40;
        kontrol("Test 12a (tanimsiz adrese yazma ODR'yi bozmadi)", 32'h0000_00A5, GPIO_ODR);

        axi_read(32'h0000_0008, read_data);
        $display("  [BILGI ] Test 12b: tanimsiz adresten okuma -> rdata=0x%08h (case'de default yok, onceki deger korunur), bresp=%0d rresp=%0d",
                 read_data, bresp, rresp);

        // =====================================================================
        // BILGI: GPIO_IDR[31:16] hakkinda
        // Sartname EK-2: "GPIO_IDR[31:16] bitlerinde her zaman '0' degeri
        // mevcuttur." Bu kirpma blok icinde degil, fpga_top.sv icinde
        //     assign gpio_idr_internal = {16'h0, GPIO_IDR_pins};
        // satiri ile saglanir. Blok seviyesinde GPIO_IDR bir giris portu
        // oldugundan burada ne surulurse o okunur; asagidaki satir bu
        // mimari kararin bilincli oldugunu kayit altina alir.
        // =====================================================================
        GPIO_IDR = 32'hFFFF_5A5A;
        #40;
        axi_read(32'h0000_0000, read_data);
        $display("\n  [BILGI ] GPIO_IDR=0xFFFF_5A5A surulunce okunan: 0x%08h", read_data);
        $display("  [BILGI ] EK-2'nin IDR[31:16]=0 isteri fpga_top.sv'de {16'h0, GPIO_IDR_pins} ile saglanir.");
        GPIO_IDR = 32'h0000_0000;

        // =====================================================================
        // TEST 13: Calisma sirasinda reset
        // Sistem "her bir komponentin kullaniminin ardindan bekleme haline
        // gecebilmeli" isterini destekleyen temel kontrol: reset uygulandiginda
        // GPIO_ODR sifirlanmali ve AXI kanallari yeniden idle duruma donmeli.
        // =====================================================================
        $display("\n--- TEST 13: Calisma sirasinda reset ---");

        axi_write(32'h0000_0004, 32'h0000_FFFF);
        #40;
        reset();

        if (GPIO_ODR === 32'h0 && awready === 1'b1 && wready === 1'b1 &&
            arready === 1'b1 && bvalid === 1'b0 && rvalid === 1'b0) begin
            $display("  [GECTI ] Test 13 basarili: reset sonrasi GPIO_ODR=0 ve AXI yeniden idle");
            toplam_basari = toplam_basari + 1;
        end else begin
            $display("  [KALDI ] Test 13 BASARISIZ: GPIO_ODR=0x%08h awready=%0b wready=%0b arready=%0b bvalid=%0b rvalid=%0b",
                     GPIO_ODR, awready, wready, arready, bvalid, rvalid);
            toplam_basarisiz = toplam_basarisiz + 1;
        end

        // Reset sonrasi blogun hala calistigini dogrula (olu kalmadi)
        axi_write(32'h0000_0004, 32'h0000_0055);
        #40;
        kontrol("Test 13b (reset sonrasi tekrar yazilabiliyor)", 32'h0000_0055, GPIO_ODR);

        // =====================================================================
        // TEST 14: Animasyon (bekleme) deseni kod cozme
        // Ekranin ilk iki hanesi (anode_select 0 ve 1) mesaj tablolarindan
        // bagimsizdir: orada catode dogrudan anim_select'e gore surulur ve
        // kart uzerinde donen bir "bekleniyor" animasyonu olusturur.
        //
        // IDR=1 / ODR=1 (ERASE) secildi cunku o mesajin case'inde 0 ve 1
        // haneleri YOK -- boylece animasyon deseni sonradan ezilmez.
        //
        // anim_select 4 bitlik bir sayac ama case yalnizca 0-7'yi ayirt eder;
        // 8 degerin tamamini (default dallari dahil) tariyoruz.
        // =====================================================================
        $display("\n--- TEST 14: Animasyon deseni (anode_select 0 ve 1) ---");

        GPIO_IDR = 32'd1;
        axi_write(32'h0000_0004, 32'd1);       // ERASE: hane 0/1 tanimsiz
        #40;

        // Hane 0 -- anim 3 ve 4 case'de yok, default (sonuk) beklenir
        anim_kontrol("Test 14a hane0 anim0", 3'd0, 4'd0, 8'b0111_0001);
        anim_kontrol("Test 14b hane0 anim1", 3'd0, 4'd1, 8'b0111_0011);
        anim_kontrol("Test 14c hane0 anim2", 3'd0, 4'd2, 8'b0111_0111);
        anim_kontrol("Test 14d hane0 anim3", 3'd0, 4'd3, 8'b1111_1111);
        anim_kontrol("Test 14e hane0 anim4", 3'd0, 4'd4, 8'b1111_1111);
        anim_kontrol("Test 14f hane0 anim5", 3'd0, 4'd5, 8'b1111_1110);
        anim_kontrol("Test 14g hane0 anim6", 3'd0, 4'd6, 8'b1111_1100);
        anim_kontrol("Test 14h hane0 anim7", 3'd0, 4'd7, 8'b1111_1000);

        // Hane 1 -- anim 0 ve 7 case'de yok, default (sonuk) beklenir
        anim_kontrol("Test 14i hane1 anim0", 3'd1, 4'd0, 8'b1111_1111);
        anim_kontrol("Test 14j hane1 anim1", 3'd1, 4'd1, 8'b0111_0111);
        anim_kontrol("Test 14k hane1 anim2", 3'd1, 4'd2, 8'b0110_0111);
        anim_kontrol("Test 14l hane1 anim3", 3'd1, 4'd3, 8'b0100_0111);
        anim_kontrol("Test 14m hane1 anim4", 3'd1, 4'd4, 8'b1100_1110);
        anim_kontrol("Test 14n hane1 anim5", 3'd1, 4'd5, 8'b1101_1110);
        anim_kontrol("Test 14o hane1 anim6", 3'd1, 4'd6, 8'b1111_1110);
        anim_kontrol("Test 14p hane1 anim7", 3'd1, 4'd7, 8'b1111_1111);

        // =====================================================================
        // TEST 15: Tarama sayaclarinin sarmasi (wrap)
        // Iki sayac da 7'ye ulastiginda 0'a donmeli:
        //     if(anode_select == 7) anode_select <= 0;  else anode_select+1
        //     if(anim_select  == 7) anim_select  <= 0;  else anim_select +1
        // Sarma dallari, sayac 7'ye ulasmadan tetiklenemez. anim_select'in
        // dogal periyodu 5.000.001 vurus oldugu icin (50 MHz'de 100 ms x 8 =
        // 0.8 s) dogal yoldan beklemek anlamsizdi; anim_ilerlet() clk_div'i
        // kisaltarak ayni yolu hizlandirir -- sayac mantigi yine RTL'in kendi
        // kodudur, elle deger yazilmaz.
        //
        // anim_ilerlet() her cagrida anode_select'i de bir artirdigi icin
        // (clk_div==0 aninda clk_div[10:0] de 0'dir) iki sarma da bu dongude
        // gerceklesir.
        // =====================================================================
        $display("\n--- TEST 15: anode_select / anim_select sarma (wrap) ---");

        begin : test15_blok
            integer adim;
            logic   anim_sardi;
            logic   anode_sardi;
            logic [3:0] anim_onceki;
            logic [2:0] anode_onceki;

            anim_sardi  = 0;
            anode_sardi = 0;

            // En fazla 20 adim: iki sayac da 8'lik periyotta oldugundan
            // 7 -> 0 gecisi bu pencerede kesin gorulur.
            for (adim = 0; adim < 20; adim = adim + 1) begin
                anim_onceki  = dut.anim_select;
                anode_onceki = dut.anode_select;

                anim_ilerlet();

                if (anim_onceki  == 4'd7 && dut.anim_select  == 4'd0) anim_sardi  = 1;
                if (anode_onceki == 3'd7 && dut.anode_select == 3'd0) anode_sardi = 1;

                if (anim_sardi && anode_sardi) break;
            end

            if (anode_sardi) begin
                $display("  [GECTI ] Test 15a basarili: anode_select 7 -> 0 sarmasi gozlendi");
                toplam_basari = toplam_basari + 1;
            end else begin
                $display("  [KALDI ] Test 15a BASARISIZ: anode_select sarmasi gozlenemedi (son deger=%0d)",
                         dut.anode_select);
                toplam_basarisiz = toplam_basarisiz + 1;
            end

            if (anim_sardi) begin
                $display("  [GECTI ] Test 15b basarili: anim_select 7 -> 0 sarmasi gozlendi");
                toplam_basari = toplam_basari + 1;
            end else begin
                $display("  [KALDI ] Test 15b BASARISIZ: anim_select sarmasi gozlenemedi (son deger=%0d)",
                         dut.anim_select);
                toplam_basarisiz = toplam_basarisiz + 1;
            end
        end


        // =====================================================================
        //                              OZET
        // =====================================================================
        $display("\n----------------------------------------------------------------------");
        $display("---------------------- BUTUN TESTLER TAMAMLANDI ----------------------");
        $display("----------------------------------------------------------------------\n");

        $display("Toplam basarili test sayisi: %0d", toplam_basari);
        $display("Toplam basarisiz test sayisi:%0d\n", toplam_basarisiz);

        if (toplam_basarisiz == 0) begin
            $display("TUM TESTLER BASARILI!\n");
        end else begin
            $display("BAZI TESTLER BASARISIZ OLDU\n");
        end
        $display("----------------------------------------------------------------------");
        $display("----------------------------------------------------------------------");


        // AXI4-Lite protokol kontrolcusunun (bind ile baglanan) toplu ozeti.
        // Sartname madde 5.2-3 -- ihlal varsa test BASARISIZ sayilir.
        if (axi_chk_pkg::final_report() != 0)
            $fatal(1, "AXI protokol ihlali tespit edildi.");


        $finish;
    end

    // -------------------------------------------------------------------------
    // Global zaman asimi: bir AXI el sikismasi takilirsa test sonsuza kadar
    // beklemesin; zaman asimi bir BASARISIZLIKTIR, sessizce $finish edilmez.
    // -------------------------------------------------------------------------
    initial begin
        #5_000_000;   // 5 ms
        $display("\n  [KALDI ] GLOBAL ZAMAN ASIMI: test tamamlanamadi (muhtemel AXI kilitlenmesi).");
        $fatal(1, "GPIO_tb zaman asimi.");
    end

endmodule
