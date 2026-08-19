module boot_rom_axi_ctrl #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10,
    parameter INIT_FILE  = "boot_code.mem"
)(
    input logic clk_i,
    input logic rst_n,

    input  logic [31:0]           axi_boot_rom_araddr,
    input  logic                  axi_boot_rom_arvalid,
    output logic                  axi_boot_rom_arready,
    output logic [DATA_WIDTH-1:0] axi_boot_rom_rdata,
    output logic [1:0]            axi_boot_rom_rresp,
    output logic                  axi_boot_rom_rvalid,
    input  logic                  axi_boot_rom_rready,

    input  logic [31:0]           axi_boot_rom_interconnect_araddr,
    input  logic                  axi_boot_rom_interconnect_arvalid,
    output logic                  axi_boot_rom_interconnect_arready,
    output logic [DATA_WIDTH-1:0] axi_boot_rom_interconnect_rdata,
    output logic [1:0]            axi_boot_rom_interconnect_rresp,
    output logic                  axi_boot_rom_interconnect_rvalid,
    input  logic                  axi_boot_rom_interconnect_rready
);

    logic [ADDR_WIDTH-1:0] raddr_a, raddr_b;
    logic [DATA_WIDTH-1:0] rdata_a, rdata_b;
    logic [DATA_WIDTH-1:0] rdata_latch_a, rdata_latch_b;

    logic pending_a, pending_b;

    assign raddr_a = axi_boot_rom_araddr[ADDR_WIDTH+1:2];
    assign raddr_b = axi_boot_rom_interconnect_araddr[ADDR_WIDTH+1:2];

    assign axi_boot_rom_rresp = 2'b00;
    assign axi_boot_rom_interconnect_rresp = 2'b00;

    boot_rom #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .INIT_FILE (INIT_FILE)
    ) boot_rom (
        .clk    (clk_i),
        .addr_a (raddr_a),
        .rdata_a(rdata_a),
        .addr_b (raddr_b),
        .rdata_b(rdata_b)
    );

    always_ff @(posedge clk_i or negedge rst_n) begin
        if (!rst_n) begin
            axi_boot_rom_rvalid  <= 1'b0;
            axi_boot_rom_arready <= 1'b1;
            pending_a            <= 1'b0;
            rdata_latch_a        <= '0;
        end
        else begin
            if (axi_boot_rom_arvalid && axi_boot_rom_arready) begin
                axi_boot_rom_arready <= 1'b0;
                pending_a            <= 1'b1;
            end

            if (pending_a) begin
                axi_boot_rom_rvalid <= 1'b1;
                pending_a           <= 1'b0;
                rdata_latch_a       <= rdata_a;
            end

            if (axi_boot_rom_rvalid && axi_boot_rom_rready) begin
                axi_boot_rom_rvalid  <= 1'b0;
                axi_boot_rom_arready <= 1'b1;
            end
        end
    end

    assign axi_boot_rom_rdata = rdata_latch_a;

    always_ff @(posedge clk_i or negedge rst_n) begin
        if (!rst_n) begin
            axi_boot_rom_interconnect_rvalid  <= 1'b0;
            axi_boot_rom_interconnect_arready <= 1'b1;
            pending_b                         <= 1'b0;
            rdata_latch_b                     <= '0;
        end
        else begin
            if (axi_boot_rom_interconnect_arvalid && axi_boot_rom_interconnect_arready) begin
                axi_boot_rom_interconnect_arready <= 1'b0;
                pending_b                         <= 1'b1;
            end

            if (pending_b) begin
                axi_boot_rom_interconnect_rvalid <= 1'b1;
                pending_b                        <= 1'b0;
                rdata_latch_b                    <= rdata_b;
            end

            if (axi_boot_rom_interconnect_rvalid && axi_boot_rom_interconnect_rready) begin
                axi_boot_rom_interconnect_rvalid  <= 1'b0;
                axi_boot_rom_interconnect_arready <= 1'b1;
            end
        end
    end

    assign axi_boot_rom_interconnect_rdata = rdata_latch_b;

endmodule
