module Instr_Splitter
(
    // clock ve reset sinyalleri
    input logic clk_i,
    input logic rst_n,   

    // ==========================
    //  GİRİŞ PORTLARI
    // ==========================
    input  logic [ 3:0] axi_awid ,
    input  logic [31:0] axi_awaddr,
    input  logic [ 7:0] axi_awlen,
    input  logic [ 2:0] axi_awsize,
    input  logic [ 1:0] axi_awburst,
    input  logic [ 2:0] axi_awprot,
    input  logic        axi_awvalid,
    output logic        axi_awready,

    input  logic [31:0] axi_wdata,
    input  logic [ 3:0] axi_wstrb,
    input  logic        axi_wlast,
    input  logic        axi_wvalid,
    output logic        axi_wready,

    input  logic        axi_bready,
    output logic [ 3:0] axi_bid = 0,
    output logic [ 1:0] axi_bresp,
    output logic        axi_bvalid,

    input  logic [ 3:0] axi_arid,
    input  logic [31:0] axi_araddr,
    input  logic [ 7:0] axi_arlen,
    input  logic [ 2:0] axi_arsize,
    input  logic [ 1:0] axi_arburst,
    input  logic [ 2:0] axi_arprot,
    input  logic        axi_arvalid,
    output logic        axi_arready,

    input  logic        axi_rready,
    output logic [ 3:0] axi_rid = 0,
    output logic [31:0] axi_rdata,
    output logic [ 1:0] axi_rresp,
    output logic        axi_rlast = 0,
    output logic        axi_rvalid,


    // =========================
    // INSTRUCTION RAM PORTLARI
    // =========================
    output logic [ 3:0] i_awid = 0,
    output logic [31:0] i_awaddr,
    output logic [ 7:0] i_awlen = 0,
    output logic [ 2:0] i_awsize = 0,
    output logic [ 1:0] i_awburst = 0,
    output logic [ 2:0] i_awprot = 0,
    output logic        i_awvalid,
    input  logic        i_awready,

    output logic [31:0] i_wdata,
    output logic [ 3:0] i_wstrb = 0,
    output logic        i_wlast = 0,
    output logic        i_wvalid,
    input  logic        i_wready,

    output logic        i_bready,
    input  logic [ 3:0] i_bid,
    input  logic [ 1:0] i_bresp,
    input  logic        i_bvalid,

    output logic [ 3:0] i_arid = 0,
    output logic [31:0] i_araddr,
    output logic [ 7:0] i_arlen = 0,
    output logic [ 2:0] i_arsize = 0,
    output logic [ 1:0] i_arburst = 0,
    output logic [ 2:0] i_arprot = 0,
    output logic        i_arvalid,
    input  logic        i_arready,

    output logic        i_rready,
    input  logic [ 3:0] i_rid,
    input  logic [31:0] i_rdata,
    input  logic [ 1:0] i_rresp,
    input  logic        i_rlast,
    input  logic        i_rvalid,

    // =========================
    // BOOT RAM PORTLARI
    // =========================
    output logic [ 3:0] b_awid = 0,
    output logic [31:0] b_awaddr,
    output logic [ 7:0] b_awlen = 0,
    output logic [ 2:0] b_awsize = 0,
    output logic [ 1:0] b_awburst = 0,
    output logic [ 2:0] b_awprot = 0,
    output logic        b_awvalid,
    input  logic        b_awready,

    output logic [31:0] b_wdata,
    output logic [ 3:0] b_wstrb = 0,
    output logic        b_wlast = 0,
    output logic        b_wvalid,
    input  logic        b_wready,

    output logic        b_bready,
    input  logic [ 3:0] b_bid,
    input  logic [ 1:0] b_bresp,
    input  logic        b_bvalid,

    output logic [ 3:0] b_arid = 0,
    output logic [31:0] b_araddr,
    output logic [ 7:0] b_arlen = 0,
    output logic [ 2:0] b_arsize = 0,
    output logic [ 1:0] b_arburst = 0,
    output logic [ 2:0] b_arprot = 0,
    output logic        b_arvalid,
    input  logic        b_arready,

    output logic        b_rready,
    input  logic [ 3:0] b_rid,
    input  logic [31:0] b_rdata,
    input  logic [ 1:0] b_rresp,
    input  logic        b_rlast,
    input  logic        b_rvalid
);

    logic boot_ram_read;
    logic instruction_ram_read;

    assign boot_ram_read        = (axi_araddr >= 32'h1000_0000) && (axi_araddr < 32'h1001_0000);
    assign instruction_ram_read = (axi_araddr >= 32'h0000_0000) && (axi_araddr < 32'h0001_0000);

    assign b_araddr  = axi_araddr; 
    assign i_araddr  = axi_araddr;

    assign b_arvalid = boot_ram_read ? axi_arvalid : 1'b0;
    assign i_arvalid = instruction_ram_read ? axi_arvalid : 1'b0;

    assign axi_arready   = boot_ram_read        ? b_arready : 
                       instruction_ram_read ? i_arready : 1'b0;

    assign axi_rvalid = b_rvalid | i_rvalid;

    assign axi_rdata  = b_rvalid ? b_rdata  : (i_rvalid ? i_rdata  : 32'h0);
    assign axi_rresp  = b_rvalid ? b_rresp  : (i_rvalid ? i_rresp  : 2'b00);

    assign b_rready = axi_rready;
    assign i_rready = axi_rready;

endmodule
