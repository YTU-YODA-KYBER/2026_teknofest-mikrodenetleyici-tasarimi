// ===========================================================================
//  OTOMATIK URETILMIS YAMALI KOPYA -- ELLE DUZENLEME
//
//  Ureten : asic/scripts/patch_rtl.py
//  Kaynak : main_codes/rtl/desgin_sources/Memory/Data_RAM_AXI4-Lite_Wrapper/data_bram_axi_ctrl.sv
//  SHA256 : b8fb32d2cd3d91a52934c51351656978e9baf960dfc30d12805103e44e42b40c
//
//  Orijinal dosyaya DOKUNULMAMISTIR. ASIC akisi (asic/filelist.f) orijinalin
//  yerine bu kopyayi kullanir; FPGA/Vivado akisi orijinali kullanmaya devam eder.
//
//  YAPILAN DEGISIKLIK: SRAM CIFT-PORT AYNI-ADRES CAKISMASI GIDERILDI.
//    OpenRAM makrosunda iki portun ayni saat kenarinda ayni adrese
//    erisimi tanimsizdir. ASIC sarmalayicisina gercek read-enable
//    tasinir; read portu yalnizca AR handshake kenarinda acilir ve
//    makro cikisi AXI stall boyunca sabit kalan bir register'a alinir. Ayni
//    adrese yeni veya outstanding bir read varken write ready
//    dusurulur ve yazma read tamamlanana kadar kayipsiz bekletilir.
//    Farkli adreslerde eszamanli read/write destegi korunur.
// ===========================================================================

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
    logic                  mem_re;
    logic                  awready_q, wready_q;
    logic                  write_conflict;
    logic [DATA_WIDTH-1:0] rdata_latch;
    typedef enum logic [1:0] {R_IDLE, R_WAIT, R_VALID} rstate_e;
    rstate_e               rstate;
    logic [ADDR_WIDTH-1:0] raddr_q;

    assign be    = axi_data_bram_wstrb;
    assign wdata = axi_data_bram_wdata;

    bram_data #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) data_ram (
        .clk(clk_i), .we(we), .re(mem_re), .be(be),
        .wdata(wdata), .waddr(waddr),
        .raddr(raddr), .rdata(rdata)
    );

    // ---------------- WRITE PATH ----------------
    assign waddr = axi_data_bram_awaddr[ADDR_WIDTH+1:2];

    // ASIC yamasi: ayni adreste read/write'a read onceligi ver.
    // IDLE'da yeni AR, diger durumlarda kayitli outstanding adres
    // karsilastirilir. Ready disaridan dusuruldugu icin istek kaybolmaz.
    assign write_conflict = axi_data_bram_awvalid && axi_data_bram_wvalid &&
        (((rstate != R_IDLE) && (waddr == raddr_q)) ||
         ((rstate == R_IDLE) && axi_data_bram_arvalid &&
          (waddr == axi_data_bram_araddr[ADDR_WIDTH+1:2])));
    // AW ve W AXI4-Lite'ta bagimsiz kanallardir. Bu tasarim adres/veri
    // tamponlamadigi icin READY yalniz iki VALID birlikteyken yukselir;
    // boylece tek kanal erken handshake olup kaybolamaz.
    assign axi_data_bram_awready = awready_q && axi_data_bram_wvalid
                                         && !write_conflict;
    assign axi_data_bram_wready  = wready_q  && axi_data_bram_awvalid
                                         && !write_conflict;
    assign we = axi_data_bram_awvalid && axi_data_bram_wvalid &&
                axi_data_bram_awready && axi_data_bram_wready;
    assign axi_data_bram_bresp = 2'b00;

    always_ff @(posedge clk_i or negedge rst_n) begin
        if (!rst_n) begin
            axi_data_bram_bvalid <= 1'b0;
            awready_q <= 1'b1;
            wready_q  <= 1'b1;
        end else if (axi_data_bram_bvalid && axi_data_bram_bready) begin
            axi_data_bram_bvalid <= 1'b0;
            awready_q <= 1'b1;
            wready_q  <= 1'b1;
        end else if (we) begin
            axi_data_bram_bvalid <= 1'b1;
            awready_q <= 1'b0;
            wready_q  <= 1'b0;
        end
    end

    // ---------------- READ PATH (düzeltildi) ----------------
    // Handshake kenarinda henuz raddr_q guncellenmedigi icin makroya
    // dogrudan AXI adresi verilir; sonraki cevrimlerde kayitli adres tutulur.
    assign raddr = (rstate == R_IDLE)
                 ? axi_data_bram_araddr[ADDR_WIDTH+1:2] : raddr_q;
    assign mem_re = axi_data_bram_arvalid && axi_data_bram_arready;
    assign axi_data_bram_rdata = rdata_latch;
    assign axi_data_bram_rresp   = 2'b00;
    assign axi_data_bram_arready = (rstate == R_IDLE);
    assign axi_data_bram_rvalid  = (rstate == R_VALID);

    // Makro sonucu AR handshake'inden bir cevrim sonra sabitlenir.
    // RVALID stall olsa bile AXI RDATA artik makro csb davranisindan etkilenmez.
    always_ff @(posedge clk_i or negedge rst_n) begin
        if (!rst_n) rdata_latch <= '0;
        else if (rstate == R_WAIT) rdata_latch <= rdata;
    end

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