module AXI4_Interconnect (

    // ==============================================================
    // GLOBAL CLOCK VE RESET
    // ==============================================================
    input  logic clk_i,
    input  logic rst_ni,

    // ==============================================================
    // SLAVE 0: CPU DATA PORTLARI (AXI4)
    // ==============================================================
    input  logic [ 3:0] axi_s0_awid,
    input  logic [31:0] axi_s0_awaddr,
    input  logic [ 7:0] axi_s0_awlen,
    input  logic [ 2:0] axi_s0_awsize,
    input  logic [ 1:0] axi_s0_awburst,
    input  logic [ 2:0] axi_s0_awprot,
    input  logic        axi_s0_awvalid,
    output logic        axi_s0_awready,

    input  logic [31:0] axi_s0_wdata,
    input  logic [ 3:0] axi_s0_wstrb,
    input  logic        axi_s0_wlast,
    input  logic        axi_s0_wvalid,
    output logic        axi_s0_wready,

    input  logic        axi_s0_bready,
    output logic [ 3:0] axi_s0_bid = 0,
    output logic [ 1:0] axi_s0_bresp,
    output logic        axi_s0_bvalid,

    input  logic [ 3:0] axi_s0_arid,
    input  logic [31:0] axi_s0_araddr,
    input  logic [ 7:0] axi_s0_arlen,
    input  logic [ 2:0] axi_s0_arsize,
    input  logic [ 1:0] axi_s0_arburst,
    input  logic [ 2:0] axi_s0_arprot,
    input  logic        axi_s0_arvalid,
    output logic        axi_s0_arready,

    input  logic        axi_s0_rready,
    output logic [ 3:0] axi_s0_rid,
    output logic [31:0] axi_s0_rdata,
    output logic [ 1:0] axi_s0_rresp,
    output logic        axi_s0_rlast,
    output logic        axi_s0_rvalid,

    // ==============================================================
    // MASTER 0: TIMER PORTLARI (AXI4-Lite) - Base: 0x4000_0000
    // ==============================================================
    output logic [31:0] axi_m0_awaddr,
    output logic        axi_m0_awvalid,
    input  logic        axi_m0_awready,
    output logic [31:0] axi_m0_wdata,
    output logic        axi_m0_wvalid,
    input  logic        axi_m0_wready,
    input  logic [ 1:0] axi_m0_bresp,
    input  logic        axi_m0_bvalid,
    output logic        axi_m0_bready,
    output logic [31:0] axi_m0_araddr,
    output logic        axi_m0_arvalid,
    input  logic        axi_m0_arready,
    input  logic [31:0] axi_m0_rdata,
    input  logic [ 1:0] axi_m0_rresp,
    input  logic        axi_m0_rvalid,
    output logic        axi_m0_rready,

    // ==============================================================
    // MASTER 1: GPIO PORTLARI (AXI4-Lite) - Base: 0x4001_0000
    // ==============================================================
    output logic [31:0] axi_m1_awaddr,
    output logic        axi_m1_awvalid,
    input  logic        axi_m1_awready,
    output logic [31:0] axi_m1_wdata,
    output logic        axi_m1_wvalid,
    input  logic        axi_m1_wready,
    input  logic [ 1:0] axi_m1_bresp,
    input  logic        axi_m1_bvalid,
    output logic        axi_m1_bready,
    output logic [31:0] axi_m1_araddr,
    output logic        axi_m1_arvalid,
    input  logic        axi_m1_arready,
    input  logic [31:0] axi_m1_rdata,
    input  logic [ 1:0] axi_m1_rresp,
    input  logic        axi_m1_rvalid,
    output logic        axi_m1_rready,

    // ==============================================================
    // MASTER 2: I2C PORTLARI (AXI4-Lite) - Base: 0x4002_0000
    // ==============================================================
    output logic [31:0] axi_m2_awaddr,
    output logic        axi_m2_awvalid,
    input  logic        axi_m2_awready,
    output logic [31:0] axi_m2_wdata,
    output logic        axi_m2_wvalid,
    input  logic        axi_m2_wready,
    input  logic [ 1:0] axi_m2_bresp,
    input  logic        axi_m2_bvalid,
    output logic        axi_m2_bready,
    output logic [31:0] axi_m2_araddr,
    output logic        axi_m2_arvalid,
    input  logic        axi_m2_arready,
    input  logic [31:0] axi_m2_rdata,
    input  logic [ 1:0] axi_m2_rresp,
    input  logic        axi_m2_rvalid,
    output logic        axi_m2_rready,

    // ==============================================================
    // MASTER 3: QSPI PORTLARI (AXI4-Lite) - Base: 0x4003_0000
    // ==============================================================
    output logic [31:0] axi_m3_awaddr,
    output logic        axi_m3_awvalid,
    input  logic        axi_m3_awready,
    output logic [31:0] axi_m3_wdata,
    output logic        axi_m3_wvalid,
    input  logic        axi_m3_wready,
    input  logic [ 1:0] axi_m3_bresp,
    input  logic        axi_m3_bvalid,
    output logic        axi_m3_bready,
    output logic [31:0] axi_m3_araddr,
    output logic        axi_m3_arvalid,
    input  logic        axi_m3_arready,
    input  logic [31:0] axi_m3_rdata,
    input  logic [ 1:0] axi_m3_rresp,
    input  logic        axi_m3_rvalid,
    output logic        axi_m3_rready,

    // ==============================================================
    // MASTER 4: DATA RAM PORTLARI (AXI4-Lite) - Base: 0x2000_0000
    // ==============================================================
    output logic [31:0] axi_m4_awaddr,
    output logic        axi_m4_awvalid,
    input  logic        axi_m4_awready,
    output logic [31:0] axi_m4_wdata,
    output logic        axi_m4_wvalid,
    input  logic        axi_m4_wready,
    input  logic [ 1:0] axi_m4_bresp,
    input  logic        axi_m4_bvalid,
    output logic        axi_m4_bready,
    output logic [31:0] axi_m4_araddr,
    output logic        axi_m4_arvalid,
    input  logic        axi_m4_arready,
    input  logic [31:0] axi_m4_rdata,
    input  logic [ 1:0] axi_m4_rresp,
    input  logic        axi_m4_rvalid,
    output logic        axi_m4_rready,

    output logic [ 3:0] axi_m4_awid = 0,
    output logic [ 7:0] axi_m4_awlen = 0,
    output logic [ 2:0] axi_m4_awsize = 0,
    output logic [ 1:0] axi_m4_awburst = 0,
    output logic [ 2:0] axi_m4_awprot = 0,
    output logic [ 3:0] axi_m4_wstrb = 0,
    output logic        axi_m4_wlast = 0,
    output logic [ 3:0] axi_m4_arid = 0,
    output logic [ 7:0] axi_m4_arlen = 0,
    output logic [ 2:0] axi_m4_arsize = 0,
    output logic [ 1:0] axi_m4_arburst = 0,
    output logic [ 2:0] axi_m4_arprot = 0,
    input  logic [ 3:0] axi_m4_bid,
    input  logic        axi_m4_rlast,
    input  logic [ 3:0] axi_m4_rid,
    
    // ==============================================================
    // MASTER 5: INSTRUCTION RAM PORTLARI (AXI4-Lite) - Base: 0x0000_0000
    // ==============================================================
    output logic [31:0] axi_m5_awaddr,
    output logic        axi_m5_awvalid,
    input  logic        axi_m5_awready,
    output logic [31:0] axi_m5_wdata,
    output logic        axi_m5_wvalid,
    input  logic        axi_m5_wready,
    input  logic [ 1:0] axi_m5_bresp,
    input  logic        axi_m5_bvalid,
    output logic        axi_m5_bready,
    output logic [31:0] axi_m5_araddr,
    output logic        axi_m5_arvalid,
    input  logic        axi_m5_arready,
    input  logic [31:0] axi_m5_rdata,
    input  logic [ 1:0] axi_m5_rresp,
    input  logic        axi_m5_rvalid,
    output logic        axi_m5_rready,

    output logic [ 3:0] axi_m5_awid = 0,
    output logic [ 7:0] axi_m5_awlen = 0,
    output logic [ 2:0] axi_m5_awsize = 0,
    output logic [ 1:0] axi_m5_awburst = 0,
    output logic [ 2:0] axi_m5_awprot = 0,
    output logic [ 3:0] axi_m5_wstrb = 0,
    output logic        axi_m5_wlast = 0,
    output logic [ 3:0] axi_m5_arid = 0,
    output logic [ 7:0] axi_m5_arlen = 0,
    output logic [ 2:0] axi_m5_arsize = 0,
    output logic [ 1:0] axi_m5_arburst = 0,
    output logic [ 2:0] axi_m5_arprot = 0,
    input  logic [ 3:0] axi_m5_bid,
    input  logic        axi_m5_rlast,
    input  logic [ 3:0] axi_m5_rid
);

    // ==============================================================
    // 1. ADRES ÇÖZÜCÜ (Address Decoder)
    // ==============================================================
    logic sel_timer_aw, sel_gpio_aw, sel_i2c_aw, sel_qspi_aw, sel_dataram_aw, sel_instrram_aw;
    logic sel_timer_ar, sel_gpio_ar, sel_i2c_ar, sel_qspi_ar, sel_dataram_ar, sel_instrram_ar;
    
    // YAZMA (AW) Hedefleri
    assign sel_timer_aw   = (axi_s0_awaddr >= 32'h4000_0000) && (axi_s0_awaddr < 32'h4001_0000);
    assign sel_gpio_aw    = (axi_s0_awaddr >= 32'h4001_0000) && (axi_s0_awaddr < 32'h4002_0000);
    assign sel_i2c_aw     = (axi_s0_awaddr >= 32'h4002_0000) && (axi_s0_awaddr < 32'h4003_0000);
    assign sel_qspi_aw    = (axi_s0_awaddr >= 32'h4003_0000) && (axi_s0_awaddr < 32'h4004_0000);
    assign sel_dataram_aw = (axi_s0_awaddr >= 32'h2000_0000) && (axi_s0_awaddr < 32'h2001_0000);
    assign sel_instrram_aw = (axi_s0_awaddr >= 32'h1000_0000) && (axi_s0_awaddr < 32'h1001_0000);

    // OKUMA (AR) Hedefleri
    assign sel_timer_ar   = (axi_s0_araddr >= 32'h4000_0000) && (axi_s0_araddr < 32'h4001_0000);
    assign sel_gpio_ar    = (axi_s0_araddr >= 32'h4001_0000) && (axi_s0_araddr < 32'h4002_0000);
    assign sel_i2c_ar     = (axi_s0_araddr >= 32'h4002_0000) && (axi_s0_araddr < 32'h4003_0000);
    assign sel_qspi_ar    = (axi_s0_araddr >= 32'h4003_0000) && (axi_s0_araddr < 32'h4004_0000);
    assign sel_dataram_ar = (axi_s0_araddr >= 32'h2000_0000) && (axi_s0_araddr < 32'h2001_0000);
    assign sel_instrram_ar = (axi_s0_araddr >= 32'h1000_0000) && (axi_s0_araddr < 32'h1001_0000);

    // ==============================================================
    // 2. YAZMA KANALLARI (AW, W, B) YÖNLENDİRMESİ
    // ==============================================================
    
    // Adres, Veri ve Strobe Ortak Dağıtılır (Broadcast)
    assign axi_m0_awaddr = axi_s0_awaddr;  assign axi_m1_awaddr = axi_s0_awaddr;  
    assign axi_m2_awaddr = axi_s0_awaddr;  assign axi_m3_awaddr = axi_s0_awaddr;
    assign axi_m4_awaddr = axi_s0_awaddr;
    assign axi_m5_awaddr = axi_s0_awaddr;

    assign axi_m0_wdata  = axi_s0_wdata;   assign axi_m1_wdata  = axi_s0_wdata;   
    assign axi_m2_wdata  = axi_s0_wdata;   assign axi_m3_wdata  = axi_s0_wdata;
    assign axi_m4_wdata  = axi_s0_wdata;
    assign axi_m5_wdata  = axi_s0_wdata;

    assign axi_m0_bready = axi_s0_bready;  assign axi_m1_bready = axi_s0_bready;  
    assign axi_m2_bready = axi_s0_bready;  assign axi_m3_bready = axi_s0_bready;
    assign axi_m4_bready = axi_s0_bready;
    assign axi_m5_bready = axi_s0_bready;

    // Geçerlilik (Valid) sinyalleri sadece seçili modüle iletilir (Demux)
    assign axi_m0_awvalid = axi_s0_awvalid & sel_timer_aw;
    assign axi_m1_awvalid = axi_s0_awvalid & sel_gpio_aw;
    assign axi_m2_awvalid = axi_s0_awvalid & sel_i2c_aw;
    assign axi_m3_awvalid = axi_s0_awvalid & sel_qspi_aw;
    assign axi_m4_awvalid = axi_s0_awvalid & sel_dataram_aw;
    assign axi_m5_awvalid = axi_s0_awvalid & sel_instrram_aw;

    assign axi_m0_wvalid  = axi_s0_wvalid & sel_timer_aw;
    assign axi_m1_wvalid  = axi_s0_wvalid & sel_gpio_aw;
    assign axi_m2_wvalid  = axi_s0_wvalid & sel_i2c_aw;
    assign axi_m3_wvalid  = axi_s0_wvalid & sel_qspi_aw;
    assign axi_m4_wvalid  = axi_s0_wvalid & sel_dataram_aw;
    assign axi_m5_wvalid  = axi_s0_wvalid & sel_instrram_aw;

    // Hazır (Ready) sinyalleri işlemciye geri toplanır (Mux)
    assign axi_s0_awready = sel_timer_aw   ? axi_m0_awready :
                            sel_gpio_aw    ? axi_m1_awready :
                            sel_i2c_aw     ? axi_m2_awready :
                            sel_qspi_aw    ? axi_m3_awready :
                            sel_dataram_aw ? axi_m4_awready : 
                            sel_instrram_aw ? axi_m5_awready : 1'b0;

    assign axi_s0_wready  = sel_timer_aw   ? axi_m0_wready :
                            sel_gpio_aw    ? axi_m1_wready :
                            sel_i2c_aw     ? axi_m2_wready :
                            sel_qspi_aw    ? axi_m3_wready :
                            sel_dataram_aw ? axi_m4_wready :
                            sel_instrram_aw ? axi_m5_wready : 1'b0;

    // Cevap (B) kanalı sadece aktif modülden alınır
    assign axi_s0_bvalid  = axi_m0_bvalid | axi_m1_bvalid | axi_m2_bvalid | axi_m3_bvalid | axi_m4_bvalid;

    assign axi_s0_bresp   = axi_m0_bvalid ? axi_m0_bresp :
                            axi_m1_bvalid ? axi_m1_bresp :
                            axi_m2_bvalid ? axi_m2_bresp :
                            axi_m3_bvalid ? axi_m3_bresp :
                            axi_m4_bvalid ? axi_m4_bresp :
                            axi_m5_bvalid ? axi_m5_bresp : 2'b00;


    // ==============================================================
    // 3. OKUMA KANALLARI (AR, R) YÖNLENDİRMESİ
    // ==============================================================
    
    // Adres Ortak Dağıtılır
    assign axi_m0_araddr = axi_s0_araddr;  assign axi_m1_araddr = axi_s0_araddr;
    assign axi_m2_araddr = axi_s0_araddr;  assign axi_m3_araddr = axi_s0_araddr;
    assign axi_m4_araddr = axi_s0_araddr;
    assign axi_m5_araddr = axi_s0_araddr;

    assign axi_m0_rready = axi_s0_rready;  assign axi_m1_rready = axi_s0_rready;
    assign axi_m2_rready = axi_s0_rready;  assign axi_m3_rready = axi_s0_rready;
    assign axi_m4_rready = axi_s0_rready;
    assign axi_m5_rready = axi_s0_rready;

    // Okuma İsteği sadece ilgili modüle gönderilir
    assign axi_m0_arvalid = axi_s0_arvalid & sel_timer_ar;
    assign axi_m1_arvalid = axi_s0_arvalid & sel_gpio_ar;
    assign axi_m2_arvalid = axi_s0_arvalid & sel_i2c_ar;
    assign axi_m3_arvalid = axi_s0_arvalid & sel_qspi_ar;
    assign axi_m4_arvalid = axi_s0_arvalid & sel_dataram_ar;
    assign axi_m5_arvalid = axi_s0_arvalid & sel_instrram_ar;

    // ARREADY işlemciye iletilir
    assign axi_s0_arready = sel_timer_ar   ? axi_m0_arready :
                            sel_gpio_ar    ? axi_m1_arready :
                            sel_i2c_ar     ? axi_m2_arready :
                            sel_qspi_ar    ? axi_m3_arready :
                            sel_dataram_ar ? axi_m4_arready : 
                            sel_instrram_ar ? axi_m5_arready : 1'b0;

    // Okuma Cevabı (R) toplanıp işlemciye aktarılır
    assign axi_s0_rvalid  = axi_m0_rvalid | axi_m1_rvalid | axi_m2_rvalid | axi_m3_rvalid | axi_m4_rvalid;

    assign axi_s0_rdata   = axi_m0_rvalid ? axi_m0_rdata :
                            axi_m1_rvalid ? axi_m1_rdata :
                            axi_m2_rvalid ? axi_m2_rdata :
                            axi_m3_rvalid ? axi_m3_rdata :
                            axi_m4_rvalid ? axi_m4_rdata : 
                            axi_m5_rvalid ? axi_m5_rdata : 32'h0;

    assign axi_s0_rresp   = axi_m0_rvalid ? axi_m0_rresp :
                            axi_m1_rvalid ? axi_m1_rresp :
                            axi_m2_rvalid ? axi_m2_rresp :
                            axi_m3_rvalid ? axi_m3_rresp :
                            axi_m4_rvalid ? axi_m4_rresp :
                            axi_m5_rvalid ? axi_m5_rresp : 2'b00;

endmodule