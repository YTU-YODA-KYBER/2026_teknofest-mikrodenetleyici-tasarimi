module yz_csr_wrapper (
    input  logic clk, rst_n,

    // --- AXI4-Lite slave (senin interconnect portuna) ---
    input  logic [31:0] YZ_awaddr,  input  logic YZ_awvalid, output logic YZ_awready,
    input  logic [31:0] YZ_wdata,   input  logic YZ_wvalid,  output logic YZ_wready,
    output logic [1:0]  YZ_bresp,   output logic YZ_bvalid,  input  logic YZ_bready,
    input  logic [31:0] YZ_araddr,  input  logic YZ_arvalid, output logic YZ_arready,
    output logic [31:0] YZ_rdata,   output logic [1:0] YZ_rresp, output logic YZ_rvalid, input logic YZ_rready,

    // --- hızlandırıcıya/bellek kontrolcüsüne giden basit sinyaller ---
    output logic       acc_start,       // Hızlandırıcının çıkarımı başlat pulse sinyali
    input  logic       acc_busy,        // Çıkarım işleminin devam ettiğini gösterir
    input  logic       acc_done,        // Çıkarım bittiğinde pulse olur
    input  logic       acc_out_wen,     // "Çıkarım sonucu geçerli" mesajı için pulse olur. Bu 1 olduğu zaman satır 40 yapılır
    input  logic [7:0] acc_out_wdata,   // Güncel çıkarım sonucunu tutar
    input  logic       load_done_irq,   // YZ bellleğine yazma işleminin bittiğini CPU'ya bildirmek için kullanılan interrupt sinyali
    output logic       load_clear,      // "cpu_clear_i"ye bağlı, işlemci "load_done_irq" sinyalini gördükten sonra bu sinyal aracılığı ile irq sinyalini temizler
    output logic       infer_irq        // -> irq_i[17]
);
    logic [1:0] result_reg;             // "acc_out_wen" olduğu zaman "acc_out_wdata"daki çıkarım sonucunuu tutar.
    logic       infer_pending;          // infer_irq sinyalinin 1 olması için ve CPU tarafından gördükten sonra 0'a çekilmesi olayı için kullanılır

    assign YZ_bresp = 2'b00;
    assign YZ_rresp = 2'b00;
    assign infer_irq = infer_pending;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            YZ_awready <= 1; YZ_wready <= 1; YZ_bvalid <= 0;
            YZ_arready <= 1; YZ_rvalid <= 0; YZ_rdata <= 0;
            acc_start <= 0; load_clear <= 0;
            result_reg <= 0; infer_pending <= 0;
        end else begin
            // (1) start ve clear'lar HER cycle 0'a düşer -> otomatik 1-cycle pulse
            acc_start  <= 0;
            load_clear <= 0;

            // (2) sonucu yakala: hızlandırıcı yazdığı an
            if (acc_out_wen) result_reg <= acc_out_wdata[1:0];

            // (3) done pulse'unu latch'le -> seviye interrupt
            if (acc_done)          infer_pending <= 1;

            // --- AXI YAZMA (senin şablonun) ---
            if (YZ_awvalid && YZ_wvalid && YZ_awready && YZ_wready) begin
                YZ_bvalid  <= 1;
                YZ_awready <= 0; YZ_wready <= 0;
                case (YZ_awaddr[7:0])
                    8'h00: begin
                        // CTRL: her bit bir OLAY -> pulse üret, saklama
                        if (YZ_wdata[0]) acc_start  <= 1;
                        if (YZ_wdata[1]) load_clear  <= 1;
                        if (YZ_wdata[2]) infer_pending <= 0;  // INFER_CLEAR
                    end
                    // 0x04 STATUS, 0x08 RESULT read-only -> yazma yok
                endcase
            end else if (YZ_bvalid && YZ_bready) begin
                YZ_bvalid <= 0; YZ_awready <= 1; YZ_wready <= 1;
            end

            // --- AXI OKUMA (senin şablonun) ---
            if (YZ_arvalid && YZ_arready) begin
                YZ_rvalid <= 1; YZ_arready <= 0;
                case (YZ_araddr[7:0])
                    8'h04: YZ_rdata <= {29'h0, infer_pending, load_done_irq, acc_busy};
                    8'h08: YZ_rdata <= {30'h0, result_reg};
                    default: YZ_rdata <= 32'h0;
                endcase
            end else if (YZ_rvalid && YZ_rready) begin
                YZ_rvalid <= 0; YZ_arready <= 1;
            end
        end
    end
endmodule
