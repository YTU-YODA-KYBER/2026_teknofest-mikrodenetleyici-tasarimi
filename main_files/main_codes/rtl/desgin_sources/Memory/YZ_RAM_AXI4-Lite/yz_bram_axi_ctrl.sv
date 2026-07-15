module yz_acclrtr_bram_axi_ctrl #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 11          // 2^11=2048 >= 1960, bayt-adresli
)(
    input  logic clk_i,
    input  logic rst_n,

    input  logic [ADDR_WIDTH-1:0] yz_bram_raddr,
    output logic [DATA_WIDTH-1:0] yz_bram_rdata,

    input  logic                  dma_valid_i,
    input  logic [DATA_WIDTH-1:0] dma_data_i,

    input  logic                  cpu_clear_i,   // ISR'dan gelecek "gördüm" sinyali
    output logic                  load_done_irq  // SEVİYE, cpu_clear_i gelene kadar yüksek
);

    logic                   we;
    logic [DATA_WIDTH-1:0]  wdata;
    logic [ADDR_WIDTH-1:0]  waddr, raddr;
    logic [DATA_WIDTH-1:0]  rdata;
    logic [ADDR_WIDTH-1:0]  addr_cnt;
    logic                   load_pending;

    bram_yz #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) yz_ram (
        .clk   (clk_i),
        .we    (we),
        .wdata (wdata),
        .waddr (waddr),
        .raddr (raddr),
        .rdata (rdata)
    );

    assign we            = dma_valid_i;
    assign waddr         = addr_cnt;
    assign wdata         = dma_data_i;
    assign raddr         = yz_bram_raddr;
    assign yz_bram_rdata = rdata;

    always_ff @(posedge clk_i or negedge rst_n) begin
        if (!rst_n) begin
            addr_cnt     <= '0;
            load_pending <= 1'b0;
        end else begin
            // --- Yazma sayacı: her cycle SADECE bir atama, if/else ile ---
            if (dma_valid_i) begin
                if (addr_cnt == ADDR_WIDTH'(1959)) begin
                    addr_cnt     <= '0;       // yeni kayda hazır
                    load_pending <= 1'b1;     // bayrağı kaldır
                end else begin
                    addr_cnt <= addr_cnt + 1'b1;
                end
            end

            // --- CPU temizlerse indir (yazma olsun olmasın her zaman geçerli) ---
            if (cpu_clear_i)
                load_pending <= 1'b0;
        end
    end

    assign load_done_irq = load_pending;

endmodule