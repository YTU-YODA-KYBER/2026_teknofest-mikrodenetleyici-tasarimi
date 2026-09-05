// ---------------------------------------------------------------------------
//  axi_read_arbiter2 -- iki AXI4-Lite read masterini tek slave'e baglar.
//
//  Bu tasarimda Instruction RAM'in tek AXI read portunu hem CPU instruction
//  fetch yolu hem de CPU data yolu kullanir. Data yolu onceliklidir: instruction
//  prefetch ARVALID'i uzun sure yuksek kalabildigi icin ters oncelik bir load'u
//  ac birakabilirdi. CPU yeni data islemleri icin instruction ilerlemesine
//  ihtiyac duydugundan bu secim instruction yolunda kalici starvation yaratmaz.
//
//  Bir AR handshake'inden R handshake'ine kadar grant kayitli tutulur. Boylece
//  slave RVALID'i beklerken diger master'in sinyalleri degisse bile cevap yanlis
//  kaynaga donmez.
// ---------------------------------------------------------------------------
module axi_read_arbiter2 (
    input  logic        clk_i,
    input  logic        rst_ni,

    // Master 0: CPU instruction fetch
    input  logic [31:0] m0_araddr,
    input  logic        m0_arvalid,
    output logic        m0_arready,
    output logic [31:0] m0_rdata,
    output logic [ 1:0] m0_rresp,
    output logic        m0_rvalid,
    input  logic        m0_rready,

    // Master 1: CPU data read (oncelikli)
    input  logic [31:0] m1_araddr,
    input  logic        m1_arvalid,
    output logic        m1_arready,
    output logic [31:0] m1_rdata,
    output logic [ 1:0] m1_rresp,
    output logic        m1_rvalid,
    input  logic        m1_rready,

    // Tek downstream AXI4-Lite read slave
    output logic [31:0] s_araddr,
    output logic        s_arvalid,
    input  logic        s_arready,
    input  logic [31:0] s_rdata,
    input  logic [ 1:0] s_rresp,
    input  logic        s_rvalid,
    output logic        s_rready
);
    typedef enum logic [1:0] {
        ARB_IDLE,
        ARB_AR_WAIT,
        ARB_R_WAIT
    } arb_state_t;

    arb_state_t state_q;
    logic grant_m1_q;
    logic last_grant_m1_q;
    logic [31:0] araddr_q;
    logic select_m1;

    // IDLE'da iki istek ayni anda gelirse SIRAYLA (round-robin) verilir.
    //
    // Onceki surum `select_m1 = m1_arvalid` ile KATI ONCELIK uyguluyordu:
    // m1 (data load) surekli valid tutarsa m0 (instruction fetch) hic grant
    // alamazdi. Pratikte CV32E40P'de kalici aclik beklenmiyor (yeni data
    // islemleri icin buyruk ilerlemesi gerekir) ama bu, RTL'de zorlanmayan
    // bir varsayimdi. Son grant'in kaydi ile aclik YAPISAL olarak imkansiz
    // hale getirilir; tek bir istek varken davranis degismez, dolayisiyla
    // performans maliyeti yoktur.
    //   m1 tek       -> m1
    //   m0 tek       -> m0
    //   ikisi birden -> son grant kimdeyse digeri
    assign select_m1 = m1_arvalid && (!m0_arvalid || !last_grant_m1_q);

    always_comb begin
        m0_arready = 1'b0;
        m1_arready = 1'b0;
        m0_rdata   = s_rdata;
        m1_rdata   = s_rdata;
        m0_rresp   = s_rresp;
        m1_rresp   = s_rresp;
        m0_rvalid  = 1'b0;
        m1_rvalid  = 1'b0;
        s_araddr   = select_m1 ? m1_araddr : m0_araddr;
        s_arvalid  = 1'b0;
        s_rready   = 1'b0;

        unique case (state_q)
        ARB_IDLE: begin
            s_arvalid = select_m1 ? m1_arvalid : m0_arvalid;
            m1_arready =  select_m1 && s_arready;
            m0_arready = !select_m1 && s_arready;

        end

        // Downstream ARVALID bir kez gorulup ARREADY dusuk kalirsa AXI,
        // ARVALID ve ARADDR'in handshake'e kadar sabit tutulmasini ister.
        // Bu sirada daha yuksek oncelikli master gelse bile mevcut istek
        // preempt edilmez; owner ve payload kayitli degerlerden surulur.
        ARB_AR_WAIT: begin
            s_araddr  = araddr_q;
            s_arvalid = 1'b1;
            if (grant_m1_q)
                m1_arready = s_arready;
            else
                m0_arready = s_arready;
        end

        ARB_R_WAIT: begin
            if (grant_m1_q) begin
                m1_rvalid = s_rvalid;
                s_rready  = m1_rready;
            end else begin
                m0_rvalid = s_rvalid;
                s_rready  = m0_rready;
            end
        end
        default: ;
        endcase
    end

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            state_q         <= ARB_IDLE;
            grant_m1_q      <= 1'b0;
            last_grant_m1_q <= 1'b0;
            araddr_q        <= '0;
        end else begin
            unique case (state_q)
            ARB_IDLE: begin
                if (s_arvalid) begin
                    grant_m1_q      <= select_m1;
                    last_grant_m1_q <= select_m1;   // round-robin kaydi
                    araddr_q        <= s_araddr;
                    if (s_arready)
                        state_q <= ARB_R_WAIT;
                    else
                        state_q <= ARB_AR_WAIT;
                end
            end

            ARB_AR_WAIT: begin
                if (s_arready)
                    state_q <= ARB_R_WAIT;
            end

            ARB_R_WAIT: begin
                if (s_rvalid && s_rready)
                    state_q <= ARB_IDLE;
            end
            default: state_q <= ARB_IDLE;
            endcase
        end
    end

`ifdef AXI_ASSERTIONS
    always_ff @(posedge clk_i) begin
        if (rst_ni && m0_arready && m1_arready)
            $error("axi_read_arbiter2: iki master ayni cevrimde kabul edildi");
        if (rst_ni && m0_rvalid && m1_rvalid)
            $error("axi_read_arbiter2: cevap iki master'a birden yonlendirildi");
    end
`endif
endmodule
