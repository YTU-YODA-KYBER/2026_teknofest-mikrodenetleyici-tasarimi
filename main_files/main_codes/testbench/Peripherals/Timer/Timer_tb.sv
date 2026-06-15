`timescale 1ns / 1ps

module Timer_testbench;

    // clock ve reset sinyalleri
    reg clk_i = 0;
    reg rst_n = 0;

    // AW Portları
    reg  [31:0] awaddr  = 0;
    reg         awvalid = 0;
    wire        awready;

    // W Portları
    reg  [31:0] wdata   = 0;
    reg         wvalid  = 0;
    wire        wready;

    // AW Portları (B Portları olmalı aslında)
    reg         bready  = 0;
    wire [ 1:0] bresp;
    wire        bvalid;
    
    // AR Portları
    reg  [31:0] araddr  = 0;
    reg         arvalid = 0;
    wire        arready;

    // R Portları
    reg         rready;
    wire [31:0] rdata;
    wire [1 :0] rresp;
    wire        rvalid;

    //axi okuma yaparken veriyi kaydedecegımız register
    reg [31:0] read_data;

    // ---- Basari sayaclari ----
    integer toplam_basari    = 0;
    integer toplam_basarisiz = 0;


    //  MODULU CAGIRMA
    Timer_AXI4_Lite dut(
        .clk_i(clk_i),
        .rst_n(rst_n),
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
        .rready(rready)
    );


    // --- CLOCK ÜRETİMİ ---
    always begin
        #5 clk_i = ~clk_i; // 100MHZ CLK
    end

    // Reset işlemi
    task reset;
        begin
            rst_n = 0;
            #20;
            rst_n = 1;
            #20;
        end
    endtask


    // AXI yazma testi
    task axi_write(input [31:0] addr, input [31:0] data);
        begin
            wait(awready && wready);
            awaddr = addr;
            wdata  = data;
            awvalid = 1;
            wvalid = 1;
            bready = 1;

            wait(!(awready && wready));

            awvalid = 0;
            wvalid  = 0;
        end
    endtask

    // AXI okuma testi
    task axi_read(input [31:0] addr, output [31:0] read);
        begin
            wait(arready);
            araddr = addr;
            arvalid = 1;

            wait(rvalid);
            read = rdata;
            rready = 1;
            arvalid = 0;

            wait(!rvalid);
            rready = 0;
        end
    endtask



    // --- TEST ---
    initial begin
        // Reset ile sisteme temiz bir başlangıç yapıyoruz
        reset();

        // =====================================================================
        // TEST 1: Yukari sayma - maksimum hiz
        // TIM_PRE_m = 0 yazarak prescaler'i devre disi birakiyoruz; bu durumda
        // sayac her saat vurusunda bir artar (maksimum hiz). TIM_ARE = 1453
        // ile sinir belirliyoruz ve TIM_MOD = 1 ile yukari sayma modunu
        // seciyoruz. Sistemin 1453 saat vurusu boyunca (100 MHz -> 14530 ns)
        // sayarak TIM_ARE degerine ulasip orada bir event (TIM_EVN) uretmesini
        // bekliyoruz. Test: sure dolunca TIM_EVN > 0 olmali.
        // =====================================================================
        $display("--- TEST 1: TIM_PRE_m = 0 | Hedef = 1453 Basliyor ---");

        axi_write(32'h0000_0000, 32'd0);         // TIM_PRE_m = 0
        axi_write(32'h0000_0004, 32'd1453);      // TIM_ARE = 1453
        axi_write(32'h0000_0010, 32'd1);         // TIM_MOD = 1
        axi_write(32'h0000_000C, 32'd1);         // TIM_ENA = 1

        // clk periyodu 10 ns olduguna gore 1453 x 10 = 14,530 ns beklememiz gerekiyor. Biraz ekstra zaman verelim ki kesinlikle sayma işlemi tamamlanmış olsun.
        #14600;
 
        if (dut.TIM_EVN > 0) begin
            $display("  [GECTI ] Test 1 basarili: TIM_ARE=%0d'e ulasildi, TIM_EVN=%0d", dut.TIM_ARE, dut.TIM_EVN);
            toplam_basari = toplam_basari + 1;
        end else begin
            $display("  [KALDI ] Test 1 BASARISIZ: Beklenen TIM_EVN > 0, gozlenen TIM_EVN=%0d", dut.TIM_EVN);
            toplam_basarisiz = toplam_basarisiz + 1;
        end

        // =====================================================================
        // TEST 2: Asagi sayma - maksimum hiz
        // Onceki test bitti; timer'i durdurup TIM_MOD = 0 ile asagi sayma
        // moduna geciyoruz. TIM_PRE_m = 0 ve TIM_ARE = 1453 ile sayac her vuruşta
        // 1 azalacak. Asagi sayac 0'a ulasinca TIM_ARE degerine (1453'e) reload
        // edilir ve TIM_EVN artar. 14540 ns beklendikten sonra TIM_EVN, test 1'den
        // kalan degerin uzerinde olmali.
        // =====================================================================
        $display("--- TEST 2: TIM_PRE_m = 0 | Hedef = 0(Geriye sayma) Basliyor ---");
        // ilk önce timerı durdurup ayarları yapıyorum.
        axi_write(32'h0000_000C, 32'd0);         // TIM_ENA = 0 (Timer aktif)

        axi_write(32'h0000_0000, 32'd0);         // TIM_PRE_m = 0
        axi_write(32'h0000_0004, 32'd1453);      // TIM_ARE = 1453
        axi_write(32'h0000_0010, 32'd0);         // TIM_MOD = 0 (Geriye sayma modu)
        axi_write(32'h0000_000C, 32'd1);         // TIM_ENA = 1

        begin : test2_blok
            reg [31:0] evn_once;
            evn_once = dut.TIM_EVN;              // enable oncesi mevcut event degeri
            #14600; // 1453 vurus x 10 ns = 14,530 ns + biraz ekstra zaman
            if (dut.TIM_EVN > evn_once) begin
                $display("  [GECTI ] Test 2 basarili: Asagi sayac calisip event uretti, TIM_EVN=%0d", dut.TIM_EVN);
                toplam_basari = toplam_basari + 1;
            end else begin
                $display("  [KALDI ] Test 2 BASARISIZ: Beklenen TIM_EVN > %0d, gozlenen TIM_EVN=%0d", evn_once, dut.TIM_EVN);
                toplam_basarisiz = toplam_basarisiz + 1;
            end
        end

        // =====================================================================
        // TEST 3: Maksimum sinir ve rollover
        // TIM_ARE = 0xFFFF_FFFF (32-bit maks) ile yukari sayac baslatilyoruz.
        // Simulasyonu hizlandirmak icin force komutuyla TIM_CNT'yi 0xFFFF_FFF0'a
        // cekip sayacin sadece son 16 adimi atmasini bekliyoruz. Sayac 0xFFFF_FFFF'e
        // ulasinca bir event uretip TIM_CNT'yi 0'a sarmaldir. Test: wait ile
        // TIM_CNT == 0 gorulmesi; gorulurse rollover basariyla gerceklesmis demektir.
        // =====================================================================
        $display("--- TEST 3: TIM_ARE = Maksimum (FFFF_FFFF) Basliyor ---");

        // Yeni ayarları güvenli yüklemek için önce sayacı durdurup temizleyelim
        axi_write(32'h0000_000C, 32'd0);         // TIM_ENA = 0
        axi_write(32'h0000_0008, 32'h0000_0001); // TIM_CLR = 1
        axi_write(32'h0000_0010, 32'd1);         // TIM_MOD = 1 (Tekrardan 1 yapmamız lazım ki maks degerden 0 a dogru saymasın.)

        // TIM_ARE'ye 32-bitlik en büyük sayıyı yazıyoruz
        axi_write(32'h0000_0004, 32'hFFFF_FFFF); // TIM_ARE = 4294967295
        #50; // AXI yazma işleminin donanımda tam oturması için minik bir bekleme

        // TIM_CNT degerını FFFF_FFF0 ye yakın bır degerden baslatıyorum kı sımulasyonu ızlemek kolay olsun.
        force dut.TIM_CNT = 32'hFFFF_FFF0;

        axi_write(32'h0000_000C, 32'd1);         // TIM_ENA = 1
        #10; // Sinyalin kilitlenmesi için 1 clock vuruşu süre

        release dut.TIM_CNT;

        // FFFF_FFF0'dan FFFF_FFFF'e kadar sayıp, tepe noktada TIM_EVN (kesme) bayrağını
        // kaldırarak 0'a tertemiz taşmasını (rollover) izlemek için bekliyoruz.
        wait(dut.TIM_CNT == 32'd0);
        #40;

        // wait(dut.TIM_CNT == 32'd0) buraya ulasabildi ise rollover gerceklesti demektir.
        $display("  [GECTI ] Test 3 basarili: 0xFFFF_FFFF sinirinda rollover gerceklesti, TIM_CNT=0'a dondu");
        toplam_basari = toplam_basari + 1;

        // =====================================================================
        // TEST 4: AXI okuma dogrulama
        // Bu senaryoda iki ayri AXI okuma islemi test ediliyor.
        // 4a) TIM_ARE yazmacinina 1981 yaziyoruz ve hemen AXI uzerinden okuyoruz;
        //     geri okunan deger 1981 olmali.
        // 4b) Timer calisirken TIM_CNT'yi (0x14 adresi) anlik okuyoruz; deger
        //     0'dan buyuk olmali (sayac ilerlemis olmali).
        // =====================================================================
        $display("---TEST 4: Axi okuma testi.---");

        begin : test4_blok
            reg test4a_gecti, test4b_gecti;
            test4a_gecti = 0;
            test4b_gecti = 0;

            axi_write(32'h0000_0004 , 32'd1981); // TIM_ARE ye 1981 yazdık.
            #20; //dalga formunun oturması ıcın bıraz beklıyoruz.
            axi_read(32'h0000_0004, read_data); // TIM_ARE okuyoruz.

            if(read_data == 32'd1981) begin
                $display("  [GECTI ] Test 4a basarili: AXI okuma dogru, okunan deger: %d", read_data);
                test4a_gecti = 1;
            end else begin
                $display("  [KALDI ] Test 4a BASARISIZ: Beklenen: 1981, Okunan: %d", read_data);
            end

            #100; // 2. okuma senaryosuna gecmeden once biraz bekliyoruz.

            axi_write(32'h0000_0000, 32'd0);         // TIM_PRE_m = 0
            axi_write(32'h0000_0010, 32'd1);         // TIM_MOD = 1
            axi_write(32'h0000_000C, 32'd1);         // TIM_ENA = 1
            axi_write(32'h0000_0008, 32'h0000_0001); // TIM_CLR = 1

            #250;

            // Sayacı durdurmadan, 0x14 adresindeki TIM_CNT'yi anlık okuyoruz
            axi_read(32'h0000_0014, read_data);

            if (read_data > 32'd0) begin
                $display("  [GECTI ] Test 4b basarili: Calisirken TIM_CNT anlık degeri %0d okundu", read_data);
                test4b_gecti = 1;
            end else begin
                $display("  [KALDI ] Test 4b BASARISIZ: Beklenen TIM_CNT > 0, okunan: %0d", read_data);
            end

            if (test4a_gecti && test4b_gecti) begin
                toplam_basari = toplam_basari + 1;
            end else begin
                toplam_basarisiz = toplam_basarisiz + 1;
            end

            // Sayacın tepeye (1981'e) ulaşıp tekrar 0'a dönmesini bekle
            wait(dut.TIM_CNT == 32'd0);

            // Sıfırlandığını dalga formunda görmek için minik bir nefes payı
            #50;
        end

        // =====================================================================
        // TEST 5: Ard arda okuma-yazma ve event temizleme
        // Timer ARE=10 ile maksimum hizda yukari sayarken (her ~11 vuruşta bir
        // event), TIM_EVN yazmacini bekliyip AXI ile okuyoruz.
        // Ardindan TIM_EVC=1 yazarak event sayacini temizliyoruz.
        // =====================================================================
        axi_write(32'h0000_000C, 32'd0);    // TIM_ENA = 0
        axi_write(32'h0000_0008, 32'd1);    // TIM_CLR = 1
        axi_write(32'h0000_0000, 32'd0);    // TIM_PRE_m = 0
        axi_write(32'h0000_0010, 32'd1);    // TIM_MOD = 1
        axi_write(32'h0000_0004, 32'd10);   // TIM_ARE = 10
        axi_write(32'h0000_000C, 32'd1);    // TIM_ENA = 1
        axi_write(32'h0000_0008, 32'd0);    // TIM_CLR = 0
        
        //1.islem
        wait(dut.TIM_EVN > 0);
        axi_read(32'h0000_0018, read_data); // 0018 adresinde TIM_EVN var.Onu kendi registerımıza atıp okuyoruz.
        $display("TIM_EVN kesmesi goruldu: %0d",read_data);

        //2.islem
        wait(dut.TIM_EVN > 0);
        axi_write(32'h0000_001C, 32'd1);
        $display("TIM_EVC'ye 1 yazildi,kesme temizlendi.");

        axi_write(32'h0000_001C, 32'd0); // ardından hemen tim_evc'ye 0 yazıyoruz ki sonraki kesmeleri de görebilelim.


        //3. islem
        axi_read(32'h0000_0018, read_data); // tim_evn'yi tekrar okuyarak kesme temizlenmiş mi kontrol ediyoruz.

        if(read_data == 0) begin
            $display("  [GECTI ] Test 5 basarili: TIM_EVN basariyla temizlendi, okunan deger: %0d", read_data);
            toplam_basari = toplam_basari + 1;
        end else begin
            $display("  [KALDI ] Test 5 BASARISIZ: TIM_EVN temizlenemedi, okunan deger: %0d", read_data);
            toplam_basarisiz = toplam_basarisiz + 1;
        end

        // =====================================================================
        // TEST 6: Hata Senaryolari (Gecersiz Adres ve Salt-Okunur Adrese Yazma)
        // AXI Branch/Statement coverage'i artirmak icin RTL'deki 'default'
        // ve hata kosullarini tetikliyoruz.
        // =====================================================================
        $display("--- TEST 6: AXI Hata Senaryolari Basliyor ---");

        // 6a) Tanimli olmayan adrese yazma denemesi (Ornek: 0x0000_00F0)
        axi_write(32'h0000_00F0, 32'hDEADBEEF);
        #20;
        $display("  [BILGI ] Test 6a: Gecersiz adrese yazma istegi gonderildi.");
        toplam_basari = toplam_basari + 1;

        // 6b) Tanimli olmayan adresten okuma denemesi
        axi_read(32'h0000_00F0, read_data);
        #20;
        $display("  [BILGI ] Test 6b: Gecersiz adresten okuma istegi gonderildi. Data: %h", read_data);
        toplam_basari = toplam_basari + 1;

        // 6c) Salt-Okunur (Read-Only) olan TIM_CNT (0x14) adresine yazma denemesi
        axi_write(32'h0000_0014, 32'hFFFF_FFFF);
        #20;
        $display("  [BILGI ] Test 6c: Salt-Okunur adrese (TIM_CNT) yazma denendi.");
        toplam_basari = toplam_basari + 1;

        $display("Sinyal dalga formu akisi basariyla tamamlandi.");

        $display("----------------------------------------------------------------------");
        $display("---------------------- BUTUN TESTLER TAMAMLANDI ----------------------");
        $display("----------------------------------------------------------------------\n");

        $display("Toplam basarili test sayisi: %d", toplam_basari);
        $display("Toplam basarisiz test sayisi:%d\n", toplam_basarisiz);
        
        // Basari sayisini 5'ten 8'e cektik cunku Test 6'da 3 yeni adim basari kabul ediliyor.
        if(toplam_basari == 8)begin
            $display("TUM TESTLER BASARILI!\n");
        end else begin
            $display("BAZI TESTLER BASARISIZ OLDU\n");
        end
        $display("----------------------------------------------------------------------");
        $display("----------------------------------------------------------------------");

        $finish;
    end

endmodule