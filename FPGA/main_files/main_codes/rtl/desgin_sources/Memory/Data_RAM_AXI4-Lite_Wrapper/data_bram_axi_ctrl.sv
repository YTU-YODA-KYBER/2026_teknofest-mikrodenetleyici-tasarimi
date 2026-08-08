module data_bram_axi_ctrl #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 11          // 2^11 = 2048 kelime = 8KB  (top'tan zaten 11 geliyor)
)(
    input logic clk_i,
    input logic rst_n,

    // AW
    input  logic [31:0]           axi_data_bram_awaddr,
    input  logic                  axi_data_bram_awvalid,
    output logic                  axi_data_bram_awready,
    // W
    input  logic [DATA_WIDTH-1:0] axi_data_bram_wdata,
    input  logic [ 3:0]           axi_data_bram_wstrb,
    input  logic                  axi_data_bram_wvalid,
    output logic                  axi_data_bram_wready,
    // B
    output logic [1:0]            axi_data_bram_bresp,
    output logic                  axi_data_bram_bvalid,
    input  logic                  axi_data_bram_bready,
    // AR
    input  logic [31:0]           axi_data_bram_araddr,
    input  logic                  axi_data_bram_arvalid,
    output logic                  axi_data_bram_arready,
    // R
    output logic [DATA_WIDTH-1:0] axi_data_bram_rdata,
    output logic [1:0]            axi_data_bram_rresp,
    output logic                  axi_data_bram_rvalid,
    input  logic                  axi_data_bram_rready
);

    logic                  we;
    logic [DATA_WIDTH-1:0] wdata;
    logic [ADDR_WIDTH-1:0] waddr;
    logic [ADDR_WIDTH-1:0] raddr;
    logic [DATA_WIDTH-1:0] rdata;
    logic [3:0]            be;

    assign be    = axi_data_bram_wstrb;
    assign wdata = axi_data_bram_wdata;

    bram_data #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) data_ram (
        .clk(clk_i), .we(we), .be(be),
        .wdata(wdata), .waddr(waddr),
        .raddr(raddr), .rdata(rdata)
    );

    // ---------------- WRITE PATH ----------------
    assign we    = axi_data_bram_awvalid && axi_data_bram_wvalid &&
                   axi_data_bram_awready && axi_data_bram_wready;
    assign waddr = axi_data_bram_awaddr[ADDR_WIDTH+1:2];
    assign axi_data_bram_bresp = 2'b00;

    always_ff @(posedge clk_i or negedge rst_n) begin
        if (!rst_n) begin
            axi_data_bram_bvalid  <= 1'b0;
            axi_data_bram_awready <= 1'b1;
            axi_data_bram_wready  <= 1'b1;
        end else if (axi_data_bram_bvalid && axi_data_bram_bready) begin
            axi_data_bram_bvalid  <= 1'b0;
            axi_data_bram_awready <= 1'b1;
            axi_data_bram_wready  <= 1'b1;
        end else if (axi_data_bram_awvalid && axi_data_bram_awready &&
                     axi_data_bram_wvalid  && axi_data_bram_wready) begin
            axi_data_bram_bvalid  <= 1'b1;
            axi_data_bram_awready <= 1'b0;
            axi_data_bram_wready  <= 1'b0;
        end
    end

    // ---------------- READ PATH (düzeltildi) ----------------
    typedef enum logic [1:0] {R_IDLE, R_WAIT, R_VALID} rstate_e;
    rstate_e               rstate;
    logic [ADDR_WIDTH-1:0] raddr_q;

    assign raddr                 = raddr_q;            // BRAM sabit, geçerli adresten okur
    assign axi_data_bram_rdata   = rdata;              // BRAM registered çıkışı (raddr_q sabitken sabit kalır)
    assign axi_data_bram_rresp   = 2'b00;
    assign axi_data_bram_arready = (rstate == R_IDLE);
    assign axi_data_bram_rvalid  = (rstate == R_VALID);

    always_ff @(posedge clk_i or negedge rst_n) begin
        if (!rst_n) begin
            rstate  <= R_IDLE;
            raddr_q <= '0;
        end else begin
            case (rstate)
                R_IDLE : if (axi_data_bram_arvalid) begin
                             raddr_q <= axi_data_bram_araddr[ADDR_WIDTH+1:2];
                             rstate  <= R_WAIT;
                         end
                R_WAIT : rstate <= R_VALID;            // BRAM 1 çevrim sonra ram[raddr_q]'yi verir
                R_VALID: if (axi_data_bram_rready) rstate <= R_IDLE;
                default: rstate <= R_IDLE;
            endcase
        end
    end

endmodule