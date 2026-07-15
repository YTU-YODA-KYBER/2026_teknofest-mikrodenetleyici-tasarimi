module bram_yz #(
    parameter DATA_WIDTH = 8,       // <-- 8 bit (bayt bayt)
    parameter ADDR_WIDTH = 11      // <-- 2048 derinlik (hizlandirici 11-bit adres suruyor)
)(
    input  logic                  clk,
    input  logic                  we,
    input  logic [ADDR_WIDTH-1:0] waddr,
    input  logic [DATA_WIDTH-1:0] wdata,
    input  logic [ADDR_WIDTH-1:0] raddr,
    output logic [DATA_WIDTH-1:0] rdata
);
    logic [DATA_WIDTH-1:0] ram [0:(2**ADDR_WIDTH)-1];
    always_ff @(posedge clk) if (we) ram[waddr] <= wdata;
    always_ff @(posedge clk) rdata <= ram[raddr];
endmodule