`timescale 1ns / 1ps

// =====================================================================
//  SPIKE ISS LOCKSTEP TESTBENCH
//  ---------------------------------------------------------------
//  Amac: Spike (altin referans ISS) ile CV32E40P RTL'ini AYNI programi
//        kosturup iki komut izini (trace) satir satir karsilastirmak.
//
//  Bu testbench sadece RTL tarafini uretir:
//      trace_core_00000000.log   <- cv32e40p_tracer
//  Spike tarafi (spike.log) proje disinda, spike_try/verif/ altinda uretilir.
//
//  ---------------------------------------------------------------
//  TASARIM KARARLARI (neden boyle)
//
//  1) BOOT ROM'DAN DEGIL, INSTRUCTION RAM'DEN KOSUYORUZ.
//     Spike, 0x0-0xFFF arasini kendi Debug Module'une ayirir ve bu
//     derleme zamani sabitidir (--disable-dtb, --halted kaldirmaz).
//     Yani ana projenin 0x0'daki Boot ROM haritasi spike'ta KURULAMAZ.
//     Cozum: test programini 0x1000_0000'daki INSTRRAM'e koyup
//     boot_addr'i oraya cekmek. Spike tarafinda karsiligi:
//         -m0x10000000:0x2000,0x20000000:0x2000 --pc=0x10000000 --disable-dtb
//     Boylece iki taraf da AYNI adres haritasini gorur.
//
//  2) RTL'E HIC DOKUNULMAZ.
//     top_module parametreleri (boot_addr, ADDR_WIDTH_*) buradan ezilir.
//     Sartname degerleri Top_module.sv'de oldugu gibi durur.
//
//  3) IMEM'i $readmemh ile DOGRUDAN DOLDURAMAYIZ.
//     bram_instr modulunde INIT_FILE parametresi yok (boot_rom'da var).
//     O yuzden hex'i burada elle ayristirip RAM dizisine hiyerarsik
//     referansla yaziyoruz. Ayrica objcopy'nin adres bicimi ozeldir:
//     "-O verilog --verilog-data-width=4" adresi VERI GENISLIGINE BOLER,
//     yani 0x1000_0000 bayt adresi dosyada "@04000000" olarak durur.
//     load_hex() bu tabani cikarip 0 tabanli kelime indeksine cevirir.
//
//  4) BELLEKLERI SIFIRLIYORUZ.
//     Spike'ta okunmamis bellek 0 doner; RTL'de bram_data X ile baslar.
//     Programin okumadigi bir adresi okumasi durumunda 0 vs X sahte
//     mismatch uretirdi. FPGA'da da BRAM konfigurasyon sonrasi 0'dir.
//
//  ---------------------------------------------------------------
//  KULLANIM
//    scripts/project_gen/SpikeISS/spike_test.tcl projeyi kurar,
//    define'i (CV32E40P_TRACE_EXECUTION) ve UVM kutuphanesini bagla:
//        Run Simulation -> Run Behavioral Simulation
//
//  Plusarg'lar (istege bagli, xsim.simulate.xsim.more_options ile):
//    +HEX=<dosya>    varsayilan "test.hex" (TCL bunu Memory File olarak ekler)
//    +CYCLES=<n>     watchdog, varsayilan 200000
//    +LOOPLIM=<n>    ayni PC kac kez cozulunce "program bitti" sayilsin (50)
// =====================================================================

module spike_iss_test;

    // -----------------------------------------------------------------
    //  Bellek haritasi — spike'taki -m degerleriyle BIREBIR ayni olmali
    // -----------------------------------------------------------------
    localparam int          ADDR_W_INSTR = 11;              // 2^11 kelime = 8 KB
    localparam int          ADDR_W_DATA  = 11;              // 2^11 kelime = 8 KB
    localparam logic [31:0] IMEM_BASE    = 32'h1000_0000;
    localparam int          IMEM_WORDS   = 1 << ADDR_W_INSTR;
    localparam int          DMEM_WORDS   = 1 << ADDR_W_DATA;

    // -----------------------------------------------------------------
    //  Plusarg ile ezilebilen ayarlar
    // -----------------------------------------------------------------
    string       hex_file = "test.hex";
    int unsigned max_cyc  = 200_000;
    int unsigned loop_lim = 50;

    // -----------------------------------------------------------------
    //  Saat / reset — 50 MHz (ana projeyle ayni)
    // -----------------------------------------------------------------
    logic clk_i  = 1'b0;
    logic rst_ni = 1'b0;

    always #10 clk_i = ~clk_i;

    // -----------------------------------------------------------------
    //  DUT baglantilari (bu test hicbir cevre birimini kullanmiyor)
    // -----------------------------------------------------------------
    logic [31:0] GPIO_IDR = 32'd0;
    logic [31:0] GPIO_ODR;
    logic [ 7:0] anode;
    logic [ 7:0] catode;

    logic        UART_GU_TX;
    logic        UART_GU_RX = 1'b1; // bosta '1' (idle)
    logic        UART_YZ_TX;
    logic        UART_YZ_RX = 1'b1; // bosta '1' (idle)

    logic        I2C_SCL;
    wire         I2C_SDA;
    pullup (I2C_SDA);

    wire         QSPI_SCLK, QSPI_CS;
    wire         QSPI_IO0, QSPI_IO1, QSPI_IO2, QSPI_IO3;
    pullup (QSPI_IO0);
    pullup (QSPI_IO1);
    pullup (QSPI_IO2);
    pullup (QSPI_IO3);

    // =================================================================
    //  DUT — parametreler DISARIDAN eziliyor, RTL'e dokunulmuyor
    // =================================================================
    top_module #(
        .ADDR_WIDTH_instr (ADDR_W_INSTR),
        .ADDR_WIDTH_data  (ADDR_W_DATA),
        .boot_addr        (IMEM_BASE)      // <-- Boot ROM'u atla, INSTRRAM'den basla
    ) dut (
        .clk_i     (clk_i),
        .rst_ni    (rst_ni),

        .GPIO_IDR  (GPIO_IDR),
        .GPIO_ODR  (GPIO_ODR),
        .anode     (anode),
        .catode    (catode),

        .UART_GU_TX(UART_GU_TX),
        .UART_GU_RX(UART_GU_RX),
        .UART_YZ_TX(UART_YZ_TX),
        .UART_YZ_RX(UART_YZ_RX),

        .I2C_SCL   (I2C_SCL),
        .I2C_SDA   (I2C_SDA),

        .QSPI_SCLK (QSPI_SCLK),
        .QSPI_CS   (QSPI_CS),
        .QSPI_IO0  (QSPI_IO0),
        .QSPI_IO1  (QSPI_IO1),
        .QSPI_IO2  (QSPI_IO2),
        .QSPI_IO3  (QSPI_IO3)
    );

    // =================================================================
    //  HEX YUKLEYICI
    //  objcopy -O verilog ciktisi:  "@<kelime_adresi>" + 8 haneli kelimeler
    //  $readmemh'i dogrudan kullanamiyoruz cunku dosyadaki adres
    //  0x04000000 (= 0x10000000 / 4) ve dizi sadece 2048 elemanli.
    // =================================================================
    logic [31:0] imem_img [0:IMEM_WORDS-1];

    task automatic load_hex(input string fname, input logic [31:0] base);
        int          fd;
        int          code;
        string       tok;
        int unsigned widx;
        int unsigned wcnt;
        logic [31:0] word;
        logic [31:0] file_addr;

        foreach (imem_img[i]) imem_img[i] = 32'h0000_0000;

        fd = $fopen(fname, "r");
        if (fd == 0) begin
            $fatal(1, "[SPIKE_TB] hex dosyasi acilamadi: %s", fname);
        end

        widx = 0;
        wcnt = 0;

        while (!$feof(fd)) begin
            code = $fscanf(fd, "%s", tok);
            if (code != 1) break;
            if (tok.len() == 0) continue;

            if (tok[0] == "@") begin
                // Adres satiri: dosyadaki deger KELIME adresidir.
                code      = $sscanf(tok, "@%h", file_addr);
                widx      = file_addr - (base >> 2);
                if (widx >= IMEM_WORDS) begin
                    $fatal(1, "[SPIKE_TB] hex adresi IMEM disinda: %s (taban 0x%08h)",
                           tok, base);
                end
            end else begin
                code = $sscanf(tok, "%h", word);
                if (widx >= IMEM_WORDS) begin
                    $fatal(1, "[SPIKE_TB] program IMEM'e sigmiyor (%0d kelime > %0d)",
                           widx, IMEM_WORDS);
                end
                imem_img[widx] = word;
                widx++;
                wcnt++;
            end
        end

        $fclose(fd);
        $display("[SPIKE_TB] %0d kelime (%0d bayt) yuklendi: %s", wcnt, wcnt*4, fname);
        if (wcnt == 0) begin
            $fatal(1, "[SPIKE_TB] hex bos gorunuyor — objcopy adimini kontrol et");
        end
    endtask

    // =================================================================
    //  Sim baslangici
    // =================================================================
    initial begin
        // Tracer $sformatf("%t") kullaniyor; format'i sabitlemezsek kolonlar
        // simulator varsayilanina gore kayar ve karsilastirma regex'i tutmaz.
        $timeformat(-9, 3, " ns", 10);

        void'($value$plusargs("HEX=%s",     hex_file));
        void'($value$plusargs("CYCLES=%d",  max_cyc));
        void'($value$plusargs("LOOPLIM=%d", loop_lim));

        $display("=====================================================");
        $display(" SPIKE ISS LOCKSTEP — RTL tarafi");
        $display("   hex        : %s", hex_file);
        $display("   IMEM taban : 0x%08h  (%0d kelime)", IMEM_BASE, IMEM_WORDS);
        $display("   watchdog   : %0d cevrim", max_cyc);
        $display("=====================================================");

        load_hex(hex_file, IMEM_BASE);

        // DIKKAT: bram_instr/bram_data kendi initial bloklarinda diziyi
        // sifirliyor. Ayni simulasyon zamaninda yazarsak iki initial'in
        // sirasi tanimsizdir (race). Bu yuzden bir saat cevrimi bekliyoruz.
        #20;

        for (int i = 0; i < IMEM_WORDS; i++)
            dut.instr_bram_ctrl_inst.instr_ram.ram[i] = imem_img[i];

        // Spike'ta okunmamis bellek 0 doner — RTL'i ona esitliyoruz.
        for (int i = 0; i < DMEM_WORDS; i++)
            dut.data_bram_ctrl_inst.data_ram.ram[i] = 32'h0000_0000;

        $display("[SPIKE_TB] INSTRRAM + DATARAM hazir, reset birakiliyor");

        #180 rst_ni = 1'b1;
    end

    // =================================================================
    //  Bitis kosulu
    //   a) Program sonsuz donguye girdi (while(1) -> "j ." ayni PC'yi
    //      tekrar tekrar cozuyor)  -> normal bitis
    //   b) Watchdog cevrim siniri  -> anormal bitis
    // =================================================================
    wire        dec_valid = dut.cpu_inst.CORE.core_i.id_stage_i.id_valid_o &
                            dut.cpu_inst.CORE.core_i.id_stage_i.is_decoding_o;
    wire [31:0] dec_pc    = dut.cpu_inst.CORE.core_i.id_stage_i.pc_id_i;

    int unsigned cyc      = 0;
    int unsigned dec_cnt  = 0;
    int unsigned same_pc  = 0;
    logic [31:0] last_pc  = 32'hFFFF_FFFF;

    task automatic bitir(input string sebep);
        $display("-----------------------------------------------------");
        $display("[SPIKE_TB] BITTI — %s", sebep);
        $display("   cevrim          : %0d", cyc);
        $display("   cozulen komut   : %0d", dec_cnt);
        $display("   son PC          : 0x%08h", last_pc);
        $display("   trace dosyasi   : trace_core_00000000.log");
        $display("   (simulasyon calisma dizininde: ");
        $display("    Vivado_projects/spike_test/spike_test.sim/sim_1/behav/xsim/)");
        $display("-----------------------------------------------------");
        $finish;
    endtask

    always_ff @(posedge clk_i) begin
        if (!rst_ni) begin
            cyc     <= 0;
            dec_cnt <= 0;
            same_pc <= 0;
            last_pc <= 32'hFFFF_FFFF;
        end else begin
            cyc <= cyc + 1;

            if (dec_valid) begin
                dec_cnt <= dec_cnt + 1;
                if (dec_pc == last_pc) same_pc <= same_pc + 1;
                else                   same_pc <= 0;
                last_pc <= dec_pc;
            end

            if (same_pc >= loop_lim)
                bitir($sformatf("program sonsuz donguye girdi (PC 0x%08h)", last_pc));
            else if (cyc >= max_cyc)
                bitir("WATCHDOG — cevrim siniri doldu");
        end
    end

    // =================================================================
    //  CV32E40P TRACER
    //  Upstream bhv/cv32e40p_tb_wrapper.sv icindeki blogun aynisi;
    //  tek fark hiyerarsi oneki:
    //      cv32e40p_top_i   ->   dut.cpu_inst.CORE
    //  (bizim SoC'ta cv32e40p_top, cv32e40p_obi_to_axi_wrapper icinde
    //   "CORE" adiyla, o da top_module icinde "cpu_inst" adiyla duruyor)
    //
    //  Tracer sadece `define CV32E40P_TRACE_EXECUTION verilirse derlenir.
    //  Vermezsen bu testbench yine calisir, sadece trace dosyasi olusmaz.
    // =================================================================
`ifdef CV32E40P_TRACE_EXECUTION
    cv32e40p_tracer #(
        .FPU  (0),
        .ZFINX(0)
    ) tracer_i (
        .clk_i(dut.cpu_inst.CORE.core_i.clk_i),  // always-running clock for tracing
        .rst_n(dut.cpu_inst.CORE.core_i.rst_ni),

        .hart_id_i(dut.cpu_inst.CORE.core_i.hart_id_i),

        .pc                (dut.cpu_inst.CORE.core_i.id_stage_i.pc_id_i),
        .instr             (dut.cpu_inst.CORE.core_i.id_stage_i.instr),
        .controller_state_i(dut.cpu_inst.CORE.core_i.id_stage_i.controller_i.ctrl_fsm_cs),
        .compressed        (dut.cpu_inst.CORE.core_i.id_stage_i.is_compressed_i),
        .id_valid          (dut.cpu_inst.CORE.core_i.id_stage_i.id_valid_o),
        .is_decoding       (dut.cpu_inst.CORE.core_i.id_stage_i.is_decoding_o),
        .is_illegal        (dut.cpu_inst.CORE.core_i.id_stage_i.illegal_insn_dec),
        .trigger_match     (dut.cpu_inst.CORE.core_i.id_stage_i.trigger_match_i),
        .rs1_value         (dut.cpu_inst.CORE.core_i.id_stage_i.operand_a_fw_id),
        .rs2_value         (dut.cpu_inst.CORE.core_i.id_stage_i.operand_b_fw_id),
        .rs3_value         (dut.cpu_inst.CORE.core_i.id_stage_i.alu_operand_c),
        .rs2_value_vec     (dut.cpu_inst.CORE.core_i.id_stage_i.alu_operand_b),

        .rs1_is_fp(dut.cpu_inst.CORE.core_i.id_stage_i.regfile_fp_a),
        .rs2_is_fp(dut.cpu_inst.CORE.core_i.id_stage_i.regfile_fp_b),
        .rs3_is_fp(dut.cpu_inst.CORE.core_i.id_stage_i.regfile_fp_c),
        .rd_is_fp (dut.cpu_inst.CORE.core_i.id_stage_i.regfile_fp_d),

        .ex_valid    (dut.cpu_inst.CORE.core_i.ex_valid),
        .ex_reg_addr (dut.cpu_inst.CORE.core_i.regfile_alu_waddr_fw),
        .ex_reg_we   (dut.cpu_inst.CORE.core_i.regfile_alu_we_fw),
        .ex_reg_wdata(dut.cpu_inst.CORE.core_i.regfile_alu_wdata_fw),

        .ex_data_addr   (dut.cpu_inst.CORE.core_i.data_addr_o),
        .ex_data_req    (dut.cpu_inst.CORE.core_i.data_req_o),
        .ex_data_gnt    (dut.cpu_inst.CORE.core_i.data_gnt_i),
        .ex_data_we     (dut.cpu_inst.CORE.core_i.data_we_o),
        .ex_data_wdata  (dut.cpu_inst.CORE.core_i.data_wdata_o),
        .data_misaligned(dut.cpu_inst.CORE.core_i.data_misaligned),

        .ebrk_insn(dut.cpu_inst.CORE.core_i.id_stage_i.ebrk_insn_dec),
        .debug_mode(dut.cpu_inst.CORE.core_i.debug_mode),
        .ebrk_force_debug_mode(dut.cpu_inst.CORE.core_i.id_stage_i.controller_i.ebrk_force_debug_mode),

        .wb_bypass(dut.cpu_inst.CORE.core_i.ex_stage_i.branch_in_ex_i),

        .wb_valid    (dut.cpu_inst.CORE.core_i.wb_valid),
        .wb_reg_addr (dut.cpu_inst.CORE.core_i.regfile_waddr_fw_wb_o),
        .wb_reg_we   (dut.cpu_inst.CORE.core_i.regfile_we_wb),
        .wb_reg_wdata(dut.cpu_inst.CORE.core_i.regfile_wdata),

        .imm_u_type       (dut.cpu_inst.CORE.core_i.id_stage_i.imm_u_type),
        .imm_uj_type      (dut.cpu_inst.CORE.core_i.id_stage_i.imm_uj_type),
        .imm_i_type       (dut.cpu_inst.CORE.core_i.id_stage_i.imm_i_type),
        .imm_iz_type      (dut.cpu_inst.CORE.core_i.id_stage_i.imm_iz_type[11:0]),
        .imm_z_type       (dut.cpu_inst.CORE.core_i.id_stage_i.imm_z_type),
        .imm_s_type       (dut.cpu_inst.CORE.core_i.id_stage_i.imm_s_type),
        .imm_sb_type      (dut.cpu_inst.CORE.core_i.id_stage_i.imm_sb_type),
        .imm_s2_type      (dut.cpu_inst.CORE.core_i.id_stage_i.imm_s2_type),
        .imm_s3_type      (dut.cpu_inst.CORE.core_i.id_stage_i.imm_s3_type),
        .imm_vs_type      (dut.cpu_inst.CORE.core_i.id_stage_i.imm_vs_type),
        .imm_vu_type      (dut.cpu_inst.CORE.core_i.id_stage_i.imm_vu_type),
        .imm_shuffle_type (dut.cpu_inst.CORE.core_i.id_stage_i.imm_shuffle_type),
        .imm_clip_type    (dut.cpu_inst.CORE.core_i.id_stage_i.instr[11:7]),
        .apu_en_i         (dut.cpu_inst.CORE.apu_req),
        .apu_singlecycle_i(dut.cpu_inst.CORE.core_i.ex_stage_i.apu_singlecycle),
        .apu_multicycle_i (dut.cpu_inst.CORE.core_i.ex_stage_i.apu_multicycle),
        .apu_rvalid_i     (dut.cpu_inst.CORE.core_i.ex_stage_i.apu_valid)
    );
`endif

endmodule
