module boot_rom #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10,
    parameter INIT_FILE  = "boot_code.mem"
)(
    input  logic                  clk,

    input  logic [ADDR_WIDTH-1:0] addr_a,
    output logic [DATA_WIDTH-1:0] rdata_a,

    input  logic [ADDR_WIDTH-1:0] addr_b,
    output logic [DATA_WIDTH-1:0] rdata_b
);

    localparam int DEPTH = 1 << ADDR_WIDTH;

    (* rom_style = "block" *)
    logic [DATA_WIDTH-1:0] rom [0:DEPTH-1];

    initial begin
        $readmemh(INIT_FILE, rom);
    end

    always_ff @(posedge clk) begin
        rdata_a <= rom[addr_a];
        rdata_b <= rom[addr_b];
    end

endmodule
