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
    input  logic                  axi_instr_bram_rready
);
    logic we;
    logic [DATA_WIDTH-1:0] wdata;
    logic [ADDR_WIDTH-1:0] waddr;
    logic [ADDR_WIDTH-1:0] raddr;
    logic [DATA_WIDTH-1:0] rdata;

    logic [DATA_WIDTH-1:0] rdata_latch;

    logic [3:0] be;
    assign be = axi_instr_bram_wstrb;

bram #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
)
instr_ram(
    .clk(clk_i),

    .we(we),
    .be(be),
    .wdata(wdata),
    .waddr(waddr),
    .raddr(raddr),
    .rdata(rdata)
);


assign we = axi_instr_bram_awvalid && axi_instr_bram_wvalid && axi_instr_bram_awready && axi_instr_bram_wready;

assign waddr = axi_instr_bram_awaddr[ADDR_WIDTH+1:2];
assign wdata = axi_instr_bram_wdata;

assign axi_instr_bram_bresp = 0;

always_ff @(posedge clk_i or negedge rst_n) begin
    if (!rst_n) begin
        axi_instr_bram_bvalid  <= 0;
        axi_instr_bram_awready <= 1;
        axi_instr_bram_wready  <= 1;
    end
    // ÖNCELİK 1: B handshake — response kabul edildi, sıfırla
    else if (axi_instr_bram_bvalid && axi_instr_bram_bready) begin
        axi_instr_bram_bvalid  <= 0;
        axi_instr_bram_awready <= 1;
        axi_instr_bram_wready  <= 1;
    end
    // ÖNCELİK 2: AW+W handshake — slave hazırken (awready=1, wready=1) kabul et
    else if (axi_instr_bram_awvalid && axi_instr_bram_awready &&
             axi_instr_bram_wvalid  && axi_instr_bram_wready) begin
        axi_instr_bram_bvalid  <= 1;
        axi_instr_bram_awready <= 0;
        axi_instr_bram_wready  <= 0;
    end
end



assign raddr = axi_instr_bram_araddr[ADDR_WIDTH+1:2];

logic pending_r;

always_ff @(posedge clk_i or negedge rst_n) begin
    if (!rst_n) begin
        axi_instr_bram_rvalid     <= 0;
        axi_instr_bram_arready    <= 1;
        axi_instr_bram_rresp      <= 0;
        pending_r                 <= 0;
    end
    else begin
        if (axi_instr_bram_arvalid && axi_instr_bram_arready) begin
            axi_instr_bram_arready <= 0;
            pending_r              <= 1;
        end

        if (pending_r) begin
            axi_instr_bram_rvalid  <= 1;
            pending_r              <= 0;
        end

        if (axi_instr_bram_rvalid && axi_instr_bram_rready) begin
            axi_instr_bram_rvalid  <= 0;
            axi_instr_bram_arready <= 1;
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

endmodule
