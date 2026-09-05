// ===========================================================================
//  OTOMATIK URETILMIS YAMALI KOPYA -- ELLE DUZENLEME
//
//  Ureten : asic/scripts/patch_rtl.py
//  Kaynak : main_codes/rtl/desgin_sources/Memory/Instrurction_RAM_AXI4-Lite_Wrapper/instr_bram_axi_ctrl.sv
//  SHA256 : dad79cb539195162eed3711b51230258037da13f9ef5853f7bc4dbcb8ed32f83
//
//  Orijinal dosyaya DOKUNULMAMISTIR. ASIC akisi (asic/filelist.f) orijinalin
//  yerine bu kopyayi kullanir; FPGA/Vivado akisi orijinali kullanmaya devam eder.
//
//  YAPILAN DEGISIKLIK: IKI DUZELTME.
//
//  1) AXI RRESP yalniz reset dalinda suruluyordu; surekli OKAY
//     atamasina cevrildi.
//
//  2) Instruction SRAM read portu ARVALID'den bagimsiz olarak HER
//     CEVRIM acikti. CPU Boot ROM'dan calisirken bile QSPI DMA'nin
//     yazdigi IMEM adresiyle hayali bir read cakisip OpenRAM'in
//     tanimsiz ayni-adres cift-port durumunu uretebiliyordu. Gercek
//     read-enable yalniz AR handshake'inde darbe olur. DMA veya AXI
//     write ayni adrese denk gelirse yazma (DMA geri basilamaz)
//     oncelik alir ve ARREADY bir cevrim dusurulur; farkli adresli
//     read/write eszamanli kalir. AXI AW/W kanallari iki VALID
//     birlikteyken kabul edilir; DMA ile AXI write cakisirsa geri
//     basilabilen AXI write bekletilir.
// ===========================================================================

module instr_bram_axi_ctrl #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10 // 2^10 = 1024 derinlik, 1024x32 bit = 4KB BRAM
)(
    // DATA RAM PORTLARI

    input logic clk_i,
    input logic rst_n,

    // AW PORTLARI
    input  logic [31:0]           axi_instr_bram_awaddr,
    input  logic                  axi_instr_bram_awvalid,
    output logic                  axi_instr_bram_awready,

    // W PORTLARI
    input  logic [DATA_WIDTH-1:0] axi_instr_bram_wdata,
    input  logic [ 3:0]           axi_instr_bram_wstrb,
    input  logic                  axi_instr_bram_wvalid,
    output logic                  axi_instr_bram_wready,

    // B PORTLARI
    output logic [1:0]            axi_instr_bram_bresp,
    output logic                  axi_instr_bram_bvalid,
    input  logic                  axi_instr_bram_bready,

    // AR PORTLARI
    input  logic [31:0]           axi_instr_bram_araddr,
    input  logic                  axi_instr_bram_arvalid,
    output logic                  axi_instr_bram_arready,

    // R PORTLARI
    output logic [DATA_WIDTH-1:0] axi_instr_bram_rdata,
    output logic [1:0]            axi_instr_bram_rresp,
    output logic                  axi_instr_bram_rvalid,
    input  logic                  axi_instr_bram_rready,

    input  logic                  dma_valid_i,
    input  logic [DATA_WIDTH-1:0] dma_data_i
);
    logic bram_we;
    
    logic we;
    logic [3:0] be;

    logic [DATA_WIDTH-1:0] wdata;
    logic [ADDR_WIDTH-1:0] waddr;
    logic [ADDR_WIDTH-1:0] raddr;
    logic [DATA_WIDTH-1:0] rdata;

    logic [DATA_WIDTH-1:0] rdata_latch;

    logic [ADDR_WIDTH-1:0] addr_cnt;
    logic                  mem_re;
    logic                  arready_q;
    logic                  awready_q, wready_q;
    logic                  read_conflict;


bram_instr #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
)
instr_ram(
    .clk(clk_i),

    .we(we),
    .re(mem_re),
    .be(be),
    .wdata(wdata),
    .waddr(waddr),
    .raddr(raddr),
    .rdata(rdata)
);



assign be = dma_valid_i ? 4'hF : axi_instr_bram_wstrb;

// AW/W bagimsizdir; tampon yoksa yalniz ortak VALID aninda kabul et.
// DMA geri basilamadigi icin ayni cevrimde AXI write'i beklet.
assign axi_instr_bram_awready = awready_q && axi_instr_bram_wvalid && !dma_valid_i;
assign axi_instr_bram_wready  = wready_q  && axi_instr_bram_awvalid && !dma_valid_i;

assign bram_we = axi_instr_bram_awvalid && axi_instr_bram_wvalid && axi_instr_bram_awready && axi_instr_bram_wready;

assign we = bram_we || dma_valid_i;


assign waddr = bram_we ? axi_instr_bram_awaddr[ADDR_WIDTH+1:2] : addr_cnt;
assign wdata = bram_we ? axi_instr_bram_wdata : dma_data_i;

assign axi_instr_bram_bresp = 2'b00;

always_ff @(posedge clk_i or negedge rst_n) begin
    if (!rst_n) begin
        axi_instr_bram_bvalid <= 0;
        awready_q <= 1;
        wready_q  <= 1;
    end else if (axi_instr_bram_bvalid && axi_instr_bram_bready) begin
        axi_instr_bram_bvalid <= 0;
        awready_q <= 1;
        wready_q  <= 1;
    end else if (bram_we) begin
        axi_instr_bram_bvalid <= 1;
        awready_q <= 0;
        wready_q  <= 0;
    end
end



assign raddr = axi_instr_bram_araddr[ADDR_WIDTH+1:2];
// DMA'nin ready'si yoktur; ayni-adres cakismasinda write onceliklidir.
assign read_conflict = we && (waddr == raddr);
assign axi_instr_bram_arready = arready_q && !read_conflict;
assign mem_re = axi_instr_bram_arvalid && axi_instr_bram_arready;

logic pending_r;

always_ff @(posedge clk_i or negedge rst_n) begin
    if (!rst_n) begin
        axi_instr_bram_rvalid     <= 0;
        arready_q                 <= 1;
        pending_r                 <= 0;
    end
    else begin
        if (axi_instr_bram_arvalid && axi_instr_bram_arready) begin
            arready_q              <= 0;
            pending_r              <= 1;
        end
        
        if (pending_r) begin
            axi_instr_bram_rvalid  <= 1;
            pending_r              <= 0;
        end
        
        if (axi_instr_bram_rvalid && axi_instr_bram_rready) begin
            axi_instr_bram_rvalid  <= 0;
            arready_q              <= 1;
        end
    end
end

always_ff @(posedge clk_i or negedge rst_n) begin
    if (!rst_n) begin
        rdata_latch <= '0;
    end

    else if (pending_r) begin 
        rdata_latch <= rdata;
    end
end

assign axi_instr_bram_rdata = rdata_latch;



always_ff @(posedge clk_i or negedge rst_n) begin
    if (!rst_n) addr_cnt <= '0;
    else if (dma_valid_i) addr_cnt <= addr_cnt + 1;
end

    // ASIC yamasi: AXI OKAY yaniti surekli surulur.
    assign axi_instr_bram_rresp = 2'b00;

endmodule
