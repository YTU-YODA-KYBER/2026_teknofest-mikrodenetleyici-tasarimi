//=============================================================================
//  gpio_test_lib.svh  --  GPIO test kutuphanesi
//
//  Ortak yedi test (reset / bitwalk / RO / haritasiz / rastgele / islem
//  ortasinda reset / stres) + GPIO'ya ozgu testler.
//=============================================================================

//---- Taban ------------------------------------------------------------------
class gpio_base_test extends axil_base_test;
    `uvm_component_utils(gpio_base_test)

    gpio_env genv;

    // GPIO harita bilgisi (RTL decode YALNIZCA addr[3:0]'a bakar)
    bit [31:0] tum_ofset[$] = '{32'h00, 32'h04};
    bit [31:0] yaz_ofset[$] = '{32'h04};
    bit [31:0] ro_ofset [$] = '{32'h00};
    // Haritasiz: 0x08 ve 0x0C decode edilmez; 0x10/0x14 ise 16 baytlik
    // takma addir (0x00/0x04 ile ayni register'a duser).
    bit [31:0] hrt_ofset[$] = '{32'h08, 32'h0C};

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void yapilandir();
        base_addr = 32'h4001_0000;
        blok      = "GPIO";
    endfunction

    function void build_phase(uvm_phase phase);
        axil_base_env::type_id::set_type_override(gpio_env::get_type());
        super.build_phase(phase);
        if (!$cast(genv, env))
            `uvm_fatal("ENV", "gpio_env cast basarisiz")
    endfunction

    // Switch degerini kur ve otur
    task automatic switch_kur(bit [31:0] deger, int unsigned tut = 8);
        gpio_pad_pkg::gpio_switch_seq s;
        s = gpio_pad_pkg::gpio_switch_seq::type_id::create("sw");
        s.deger = deger;
        s.tut   = tut;
        s.start(genv.pad.sqr);
    endtask
endclass


//---- 1) Reset degerleri -----------------------------------------------------
class gpio_reset_test extends gpio_base_test;
    `uvm_component_utils(gpio_reset_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_reset_seq s;
        uvm_status_e   st;
        uvm_reg_data_t d;

        phase.raise_objection(this);
        reset_bekle();

        // Register modeliyle reset degeri kontrolu
        genv.grm.GPIO_ODR.read(st, d);
        if (d !== 32'h0)
            `uvm_error("RESET", $sformatf("GPIO_ODR reset degeri 0 olmali, okunan 0x%08h", d))

        s = axil_reset_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = tum_ofset;
        diziyi_kostur(s);

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 2) Bit tarama (yalniz yazilabilir register'lar) ------------------------
class gpio_bitwalk_test extends gpio_base_test;
    `uvm_component_utils(gpio_bitwalk_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_bitwalk_seq s;
        phase.raise_objection(this);
        reset_bekle();
        s = axil_bitwalk_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = yaz_ofset;
        diziyi_kostur(s);
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 3) Salt-okunur register'a yazma ---------------------------------------
class gpio_ro_test extends gpio_base_test;
    `uvm_component_utils(gpio_ro_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_ro_seq s;
        phase.raise_objection(this);
        reset_bekle();
        switch_kur(32'h0000_1234);
        genv.gsb.pad_guncelle(32'h0000_1234);
        s = axil_ro_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = ro_ofset;
        diziyi_kostur(s);
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 4) Haritalanmamis ofsetler --------------------------------------------
//
//  GPIO'nun okuma case'inde DEFAULT yoktur: haritasiz bir ofset okundugunda
//  rdata onceki degerinde kalir ama rvalid yine de yukselir. Bu test o
//  davranisi ACIKCA dogrular -- bir hata degil, belgelenmis bir kisittir.
class gpio_unmapped_test extends gpio_base_test;
    `uvm_component_utils(gpio_unmapped_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_single_seq s;
        bit [31:0]      bilinen, bayat;

        phase.raise_objection(this);
        reset_bekle();

        // Bilinen bir deger yaz ve oku -> rdata bu degerde kalir
        s = axil_single_seq::type_id::create("w");
        s.kind = AXIL_WRITE; s.addr = base_addr + 32'h04;
        s.wdata = 32'h0000_5A5A; s.gap = 1; s.beats = 1;
        s.start(genv.agent.sqr);

        s = axil_single_seq::type_id::create("r");
        s.kind = AXIL_READ; s.addr = base_addr + 32'h04;
        s.wdata = 0; s.gap = 1; s.beats = 1;
        s.start(genv.agent.sqr);
        bilinen = s.rdata;

        // Haritasiz ofseti oku -> BAYAT deger beklenir
        s = axil_single_seq::type_id::create("ru");
        s.kind = AXIL_READ; s.addr = base_addr + 32'h08;
        s.wdata = 0; s.gap = 1; s.beats = 1;
        s.start(genv.agent.sqr);
        bayat = s.rdata;

        if (bayat !== bilinen)
            `uvm_error("UNMAP", $sformatf(
                "haritasiz ofsette bayat deger beklendi (0x%08h), okunan 0x%08h",
                bilinen, bayat))
        else
            `uvm_info("UNMAP", $sformatf(
                "haritasiz ofset 0x08 bayat deger dondurdu (0x%08h) -- belgelenen davranis",
                bayat), UVM_LOW)

        // Haritasiz ofsete yazma etkisiz olmali
        s = axil_single_seq::type_id::create("wu");
        s.kind = AXIL_WRITE; s.addr = base_addr + 32'h08;
        s.wdata = 32'hFFFF_FFFF; s.gap = 1; s.beats = 1;
        s.start(genv.agent.sqr);

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 5) Kisitli rastgele -----------------------------------------------------
class gpio_random_test extends gpio_base_test;
    `uvm_component_utils(gpio_random_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_random_seq s;
        bit [31:0]      sw;

        phase.raise_objection(this);
        reset_bekle();

        repeat (4) begin
            sw = $urandom_range(0, 16'hFFFF);
            switch_kur(sw, 6);
            genv.gsb.pad_guncelle(sw);

            s = axil_random_seq::type_id::create("s");
            s.base_addr  = base_addr;
            s.offsets    = tum_ofset;
            s.wr_offsets = yaz_ofset;
            s.n_items = $urandom_range(20, 40);
            diziyi_kostur(s);
        end

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 6) Islem ortasinda reset ------------------------------------------------
class gpio_reset_mid_test extends gpio_base_test;
    `uvm_component_utils(gpio_reset_mid_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_single_seq s;
        uvm_status_e    st;
        uvm_reg_data_t  d;

        phase.raise_objection(this);
        reset_bekle();

        s = axil_single_seq::type_id::create("w");
        s.kind = AXIL_WRITE; s.addr = base_addr + 32'h04;
        s.wdata = 32'h0000_BEEF; s.gap = 1; s.beats = 1;
        s.start(genv.agent.sqr);

        // Islem akarken reset uygula
        fork
            begin
                axil_random_seq r;
                r = axil_random_seq::type_id::create("r");
                r.base_addr  = base_addr;
                r.offsets    = tum_ofset;
                r.wr_offsets = yaz_ofset;
                r.n_items = 20;
                r.start(genv.agent.sqr);
            end
            begin
                repeat (30) @(posedge vif.clk);
                reset_uygula(6);
            end
        join

        // Iki kol da tamamlansin; boylece surucude sahipsiz islem kalmadan
        // son kosul temiz bir resetle denetlenir.
        reset_uygula(6);

        // Reset sonrasi ODR yeniden 0 olmali
        genv.grm.GPIO_ODR.read(st, d);
        if (d !== 32'h0)
            `uvm_error("RESET", $sformatf("reset sonrasi GPIO_ODR 0 olmali, okunan 0x%08h", d))

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 7) Stres: VALID'i el sikismadan sonra tutan trafik ---------------------
//
//  Bu test GPIO'da bulunan kabul-kosulu hatasinin regresyon korumasidir.
//  Master ayni VALID yukselmesi uzerinde iki islem sunar. GPIO islemi yalniz
//  kendi READY el sikismasinda kabul etmeli; dizi kilitlenmeden tamamlanmali
//  ve protokol kontrolcusu ihlal gormemelidir.
class gpio_stress_test extends gpio_base_test;
    `uvm_component_utils(gpio_stress_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        axil_stress_seq s;
        phase.raise_objection(this);
        reset_bekle();
        s = axil_stress_seq::type_id::create("s");
        s.base_addr = base_addr;
        s.offsets   = tum_ofset;
        s.n_items = 4;
        s.beats   = 2;
        diziyi_kostur(s, 200us);
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 8) GPIO'ya ozgu: ODR ust yarisi ve dma_enable aynasi -------------------
class gpio_pad_test extends gpio_base_test;
    `uvm_component_utils(gpio_pad_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    task run_phase(uvm_phase phase);
        uvm_status_e   st;
        uvm_reg_data_t d;
        bit [31:0]     sw;

        phase.raise_objection(this);
        reset_bekle();

        // ODR[31:16] donanimda yok -> yazilan ust yari geri okunmamali
        genv.grm.GPIO_ODR.write(st, 32'hFFFF_1234);
        genv.grm.GPIO_ODR.read (st, d);
        if (d !== 32'h0000_1234)
            `uvm_error("ODR", $sformatf("ODR[31:16] sifir bagli olmali, okunan 0x%08h", d))

        // IDR gecirgenligi + dma_enable aynasi (pad monitoru PAD_02'yi kontrol eder)
        for (int i = 0; i < 4; i++) begin
            sw = 32'h0 | (i & 32'h3);
            switch_kur(sw, 6);
            genv.gsb.pad_guncelle(sw);
            genv.grm.GPIO_IDR.read(st, d);
            if (d !== sw)
                `uvm_error("IDR", $sformatf("IDR gecirgenligi: surulen 0x%08h okunan 0x%08h", sw, d))
        end

        // Gosterim kosulu: IDR=1 & ODR[2:0]!=0  -> ekran yanar
        genv.grm.GPIO_ODR.write(st, 32'h0000_0001);
        switch_kur(32'h0000_0001, 40);
        genv.gsb.pad_guncelle(32'h0000_0001);
        repeat (40) @(posedge vif.clk);

        // Gosterim kapali -> ekran sonuk (pad monitoru PAD_03'u kontrol eder)
        switch_kur(32'h0000_0000, 40);
        genv.gsb.pad_guncelle(32'h0000_0000);
        genv.grm.GPIO_ODR.write(st, 32'h0000_0000);
        repeat (40) @(posedge vif.clk);

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass


//---- 9) 7-segment mesaj tablolari ------------------------------------------
//
//  GPIO_AXI4_Lite ayni zamanda 7-segment surucusudur. Gosterilecek mesaj
//  GPIO_ODR'den, gosterim modu GPIO_IDR[1:0]'dan secilir:
//
//    IDR[1:0] = 1 : ODR 1=ERASE 2=SNDING 3=FINISH 4=ERROR  digeri=BOOT
//    IDR[1:0] = 2 : ODR 5=SNDING 6=INFRNC 7=EVET 8=HAYIR
//                       9=SESSIZLK 10=BILINMYN  digeri=YZUART
//
//  Her mesaj sekiz basamaga yayilmistir ve basamak secici (anode_select)
//  clk_div[10:0] her sifirlandiginda ilerler -- yani 2048 cevrimde bir.
//  Bir mesajin butun basamaklarini gormek icin 8 x 2048 = 16.384 cevrim
//  beklemek gerekir. Test her deger icin bu kadar bekler.
//
//  KAPSAM NOTU: ilk iki basamaktaki ANIMASYON kareleri anim_select'e
//  baglidir; o sayac clk_div 5.000.000'dan geri sayip sifirlandiginda,
//  yani 5 milyon cevrimde bir ilerler. Sekiz animasyon karesinin tamami
//  40 milyon cevrim (50 MHz'de 800 ms) simulasyon ister; bu regresyona
//  konmamistir. Animasyon kareleri XSim'deki mevcut blok testbench'inde
//  ic sinyaller zorlanarak taranmaktadir.
class gpio_display_test extends gpio_base_test;
    `uvm_component_utils(gpio_display_test)
    function new(string name, uvm_component parent); super.new(name, parent); endfunction

    // Bir basamak taramasi: 8 x 2048 cevrim (+ pay)
    localparam int TARAMA = 8 * 2048 + 256;

    task automatic mesaj_goster(bit [31:0] idr, bit [31:0] odr, string ad);
        uvm_status_e st;
        genv.grm.GPIO_ODR.write(st, odr);
        switch_kur(idr, 4);
        genv.gsb.pad_guncelle(idr);
        repeat (TARAMA) @(posedge vif.clk);
        `uvm_info("EKRAN", $sformatf("IDR=%0d ODR=%0d -> %s tarandi", idr, odr, ad), UVM_LOW)
    endtask

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        reset_bekle();

        // IDR = 1 modundaki mesajlar
        mesaj_goster(32'd1, 32'd1,  "ERASE");
        mesaj_goster(32'd1, 32'd2,  "SNDING");
        mesaj_goster(32'd1, 32'd3,  "FINISH");
        mesaj_goster(32'd1, 32'd4,  "ERROR");
        mesaj_goster(32'd1, 32'd5,  "BOOT (default)");

        // IDR = 2 modundaki mesajlar
        mesaj_goster(32'd2, 32'd5,  "SNDING");
        mesaj_goster(32'd2, 32'd6,  "INFRNC");
        mesaj_goster(32'd2, 32'd7,  "EVET");
        mesaj_goster(32'd2, 32'd8,  "HAYIR");
        mesaj_goster(32'd2, 32'd9,  "SESSIZLK");
        mesaj_goster(32'd2, 32'd10, "BILINMYN");
        mesaj_goster(32'd2, 32'd11, "YZUART (default)");

        // Gosterim kapali: ekran sonuk olmali (pad monitoru PAD_03'u kontrol eder)
        mesaj_goster(32'd0, 32'd0, "sonuk");

        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
    endtask
endclass
