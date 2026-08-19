//=============================================================================
//  axi4lite_protocol_checker.sv
//
//  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim Yarismasi
//  Sartname madde 5.2-3 (zorunlu): "Cevre birimleri ve YZ hizlandiricinin
//  AXI/AXI-Lite arayuzlerinin en azindan protocol check duzeyinde
//  dogrulanmasi."
//
//  REFERANS : ARM IHI 0022 (AMBA AXI Protocol Specification)
//             - B1.1  AXI4-Lite tanimi ve kisitlari
//             - A3.1  Kanal el sikisma (handshake) kurallari
//             - A3.2  Kanal bagimliliklari
//             - A3.4.4 Cevap (response) kodlari
//
//  YAPI:
//    Sentezlenmez. RTL'e HIC DOKUNULMADAN 'bind' ile her AXI4-Lite
//    arayuzune baglanir (bkz. axi4lite_bind.svh). Tek kaynak dosya,
//    N arayuz  ->  kopyala-yapistir assertion yok, ayrisma riski yok.
//
//  PARAMETRELER:
//    NAME               : rapor ciktilarinda gorunecek arayuz adi
//    HAS_WRITE/HAS_READ : salt-okunur (Boot ROM) veya salt-yazar arayuzler icin
//    HAS_WSTRB          : cevre birimlerimizde WSTRB yok, RAM'lerde var
//    MAX_OUTSTANDING    : ayni anda cevaplanmamis islem ust siniri
//    ERR_IS_FATAL       : 1 => ilk ihlalde $fatal, 0 => say ve devam et
//                         (regresyonda 0 tercih edilir; TB sonda toplu bakar)
//
//  ASSERTION KIMLIKLERI (dogrulama planiyla birebir eslesir):
//    RST_xx  reset davranisi        STB_xx  yuk (payload) kararliligi
//    HSK_xx  VALID kararliligi      XCK_xx  X/Z kontrolu
//    RSP_xx  cevap kodu legalligi   ORD_xx  nedensellik / siralama
//    OUT_xx  outstanding limiti     WST_xx  WSTRB legalligi
//    STL_xx  takilma (stall) gozcusu  FIN_xx sim sonu bosaltma kontrolu
//=============================================================================
`timescale 1ns / 1ps

`ifndef AXI4LITE_PROTOCOL_CHECKER_SV
`define AXI4LITE_PROTOCOL_CHECKER_SV

module axi4lite_protocol_checker #(
    parameter string NAME               = "AXI",
    parameter int    ADDR_W             = 32,
    parameter int    DATA_W             = 32,
    parameter bit    HAS_WRITE          = 1,
    parameter bit    HAS_READ           = 1,
    parameter bit    HAS_WSTRB          = 0,
    parameter bit    REQUIRE_FULL_WSTRB = 0,
    parameter int    MAX_OUTSTANDING    = 8,
    parameter int    STALL_LIMIT        = 4096,
    parameter int    MAX_REPORTS        = 20,
    parameter bit    ERR_IS_FATAL       = 0,
    parameter bit    CHECK_X            = 1
)(
    input logic                  aclk,
    input logic                  aresetn,

    // ---- Write Address kanali ----
    input logic [ADDR_W-1:0]     awaddr,
    input logic                  awvalid,
    input logic                  awready,

    // ---- Write Data kanali ----
    input logic [DATA_W-1:0]     wdata,
    input logic [DATA_W/8-1:0]   wstrb,
    input logic                  wvalid,
    input logic                  wready,

    // ---- Write Response kanali ----
    input logic [1:0]            bresp,
    input logic                  bvalid,
    input logic                  bready,

    // ---- Read Address kanali ----
    input logic [ADDR_W-1:0]     araddr,
    input logic                  arvalid,
    input logic                  arready,

    // ---- Read Data kanali ----
    input logic [DATA_W-1:0]     rdata,
    input logic [1:0]            rresp,
    input logic                  rvalid,
    input logic                  rready
);

    //=========================================================================
    //  Ihlal kayit mekanizmasi
    //
    //  DIKKAT: Bu kayit MAKRO ile yapilir, task ile DEGIL.
    //  Concurrent assertion'in action block'undan kullanici task'i cagirmak
    //  XSIM'de sifir-gecikmeli yeniden giris yaratir ve simulasyon ayni
    //  zaman damgasinda sonsuz donguye girer. Ticari protokol VIP'leri de
    //  action block icinde yalnizca inline ifade / severity task kullanir.
    //=========================================================================
    int unsigned n_err  = 0;
    int unsigned n_warn = 0;

`define AXI_CHK_ERR(ID, MSG)                                                   \
    begin                                                                      \
        n_err = n_err + 1;                                                     \
        axi_chk_pkg::g_error_count = axi_chk_pkg::g_error_count + 1;            \
        if (n_err <= MAX_REPORTS)                                              \
            $display("[AXI-CHK] %0t ns | %0s | %0s IHLAL: %0s",                \
                     $time, NAME, ID, MSG);                                    \
        else if (n_err == MAX_REPORTS + 1)                                     \
            $display("[AXI-CHK] %0s | rapor siniri (%0d) asildi -- sayim devam ediyor, cikti susturuldu", \
                     NAME, MAX_REPORTS);                                       \
        if (ERR_IS_FATAL)                                                      \
            $fatal(1, "[AXI-CHK] %0s uzerinde %0s ihlali", NAME, ID);          \
    end

`define AXI_CHK_WARN(ID, MSG)                                                  \
    begin                                                                      \
        n_warn = n_warn + 1;                                                   \
        axi_chk_pkg::g_warn_count = axi_chk_pkg::g_warn_count + 1;             \
        $display("[AXI-CHK] %0t ns | %0s | %0s UYARI: %0s",                    \
                 $time, NAME, ID, MSG);                                        \
    end

    initial axi_chk_pkg::g_check_count = axi_chk_pkg::g_check_count + 1;

    //=========================================================================
    //  Islem sayaclari  (nedensellik ve outstanding kontrolu icin)
    //=========================================================================
    // Reset'e DUYARLI sayaclar: ORD/OUT kontrolleri icin, her reset'te sifirlanir
    int unsigned aw_acc, w_acc, b_acc, ar_acc, r_acc;

    // KUMULATIF sayaclar: yalnizca raporlama icin, reset'ten ETKILENMEZ.
    // Cok fazli testlerde (or. flasher -> reset -> boot) toplam trafigi
    // gorebilmek sart; reset'e duyarli sayaclar son fazi gosterir ve
    // kapsam olculerken yaniltir.
    int unsigned aw_tot = 0, w_tot = 0, b_tot = 0, ar_tot = 0, r_tot = 0;

    wire aw_hs = awvalid & awready;
    wire w_hs  = wvalid  & wready;
    wire b_hs  = bvalid  & bready;
    wire ar_hs = arvalid & arready;
    wire r_hs  = rvalid  & rready;

    always_ff @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            aw_acc <= '0;  w_acc <= '0;  b_acc <= '0;
            ar_acc <= '0;  r_acc <= '0;
        end else begin
            if (aw_hs) aw_acc <= aw_acc + 1;
            if (w_hs)  w_acc  <= w_acc  + 1;
            if (b_hs)  b_acc  <= b_acc  + 1;
            if (ar_hs) ar_acc <= ar_acc + 1;
            if (r_hs)  r_acc  <= r_acc  + 1;
        end
    end

    // Reset sayaci: reset sirasinda iptal olan islemleri aciklayabilmek icin.
    // Reset, ucusta olan bir islemi (AW/W kabul edilmis ama B henuz gelmemis)
    // yok eder. Bu protokol ihlali DEGILDIR; gercek donanimda da boyle olur.
    int unsigned n_reset = 0;

    // ORD_xx / OUT_xx icin "zaten raporlandi" bayraklari.
    //   Bu kontrollerin hepsi ayni KUMULATIF sayac ciftlerine (aw/b, w/b, ar/r)
    //   bakar. Sayaclar bir kez ayristiginda -- ornegin checker'in goremedigi bir
    //   el sikisma yuzunden r_acc > ar_acc olursa -- fark KALICI olarak bozuk kalir:
    //     * OUT_xx her CEVRIMDE,
    //     * ORD_xx her ISLEMDE
    //   simulasyon sonuna kadar tetiklenir. MAX_REPORTS yalnizca ciktiyi susturur,
    //   sayimi degil; sonucta tek bir kok sebep ozet raporda yuz binlerce ihlale
    //   donusur ve "Protokol ihlali : N" satiri anlamsizlasir.
    //
    //   Onemli nokta: sayaclar ayristiktan SONRA bu kurallarin verdigi hicbir karar
    //   zaten guvenilir degildir -- yani kirpilan tekrarlar bilgi tasimiyor. Bayrak
    //   ILK tespiti asla gizlemez, sadece ayni kok sebebin yankilarini keser.
    //   Reset sayaclari sifirladigi icin bayraklar da reset'te temizlenir.
    bit ord01_seen  = 1'b0;
    bit ord02_seen  = 1'b0;
    bit ord03_seen  = 1'b0;
    bit out_wr_seen = 1'b0;
    bit out_rd_seen = 1'b0;

    always @(negedge aresetn) begin
        n_reset     = n_reset + 1;
        ord01_seen  = 1'b0;
        ord02_seen  = 1'b0;
        ord03_seen  = 1'b0;
        out_wr_seen = 1'b0;
        out_rd_seen = 1'b0;
    end

    // Kumulatif sayim: reset'siz, tum simulasyon boyunca birikir
    always_ff @(posedge aclk) begin
        if (aw_hs) aw_tot <= aw_tot + 1;
        if (w_hs)  w_tot  <= w_tot  + 1;
        if (b_hs)  b_tot  <= b_tot  + 1;
        if (ar_hs) ar_tot <= ar_tot + 1;
        if (r_hs)  r_tot  <= r_tot  + 1;
    end

    // Ayni cevrimde el sikisma + cevap durumunu yanlis alarma cevirmemek icin
    // "efektif" sayac: bu cevrimdeki el sikismayi da dahil eder.
    // NOT: net tipleri 4-durumlu olmak ZORUNDADIR (IEEE 1800 6.7.1), bu yuzden
    // 2-durumlu 'int' yerine packed vektor kullanilir. 'wire int' XSIM'de
    // "net data types must be 4 state" hatasi verir.
    wire [31:0] aw_eff = aw_acc + (aw_hs ? 32'd1 : 32'd0);
    wire [31:0] w_eff  = w_acc  + (w_hs  ? 32'd1 : 32'd0);
    wire [31:0] ar_eff = ar_acc + (ar_hs ? 32'd1 : 32'd0);

    //=========================================================================
    //  RST : Reset davranisi           (IHI0022 A3.1.2)
    //  "VALID sinyalleri reset aktifken LOW olmak zorundadir."
    //=========================================================================
    generate
    if (HAS_WRITE) begin : g_rst_wr
        RST_01_awvalid: assert property (@(posedge aclk) (!aresetn) |-> (awvalid === 1'b0))
            else `AXI_CHK_ERR("RST_01", "reset aktifken AWVALID yuksek")
        RST_02_wvalid:  assert property (@(posedge aclk) (!aresetn) |-> (wvalid  === 1'b0))
            else `AXI_CHK_ERR("RST_02", "reset aktifken WVALID yuksek")
        RST_03_bvalid:  assert property (@(posedge aclk) (!aresetn) |-> (bvalid  === 1'b0))
            else `AXI_CHK_ERR("RST_03", "reset aktifken BVALID yuksek")
    end
    if (HAS_READ) begin : g_rst_rd
        RST_04_arvalid: assert property (@(posedge aclk) (!aresetn) |-> (arvalid === 1'b0))
            else `AXI_CHK_ERR("RST_04", "reset aktifken ARVALID yuksek")
        RST_05_rvalid:  assert property (@(posedge aclk) (!aresetn) |-> (rvalid  === 1'b0))
            else `AXI_CHK_ERR("RST_05", "reset aktifken RVALID yuksek")
    end
    endgenerate

    //=========================================================================
    //  HSK : VALID kararliligi          (IHI0022 A3.2.1)
    //  "VALID bir kez yukseldiginde, READY gelene kadar dusurulemez."
    //  Bu, AXI'nin EN SIK ihlal edilen kuralidir: FSM'de VALID'i sartli
    //  dusuren tasarimlar burada yakalanir.
    //=========================================================================
    generate
    if (HAS_WRITE) begin : g_hsk_wr
        HSK_01_awvalid: assert property (@(posedge aclk) disable iff (!aresetn)
            (awvalid && !awready) |=> awvalid)
            else `AXI_CHK_ERR("HSK_01", "AWREADY gelmeden AWVALID dusuruldu")
        HSK_02_wvalid: assert property (@(posedge aclk) disable iff (!aresetn)
            (wvalid && !wready) |=> wvalid)
            else `AXI_CHK_ERR("HSK_02", "WREADY gelmeden WVALID dusuruldu")
        HSK_03_bvalid: assert property (@(posedge aclk) disable iff (!aresetn)
            (bvalid && !bready) |=> bvalid)
            else `AXI_CHK_ERR("HSK_03", "BREADY gelmeden BVALID dusuruldu")
    end
    if (HAS_READ) begin : g_hsk_rd
        HSK_04_arvalid: assert property (@(posedge aclk) disable iff (!aresetn)
            (arvalid && !arready) |=> arvalid)
            else `AXI_CHK_ERR("HSK_04", "ARREADY gelmeden ARVALID dusuruldu")
        HSK_05_rvalid: assert property (@(posedge aclk) disable iff (!aresetn)
            (rvalid && !rready) |=> rvalid)
            else `AXI_CHK_ERR("HSK_05", "RREADY gelmeden RVALID dusuruldu")
    end
    endgenerate

    //=========================================================================
    //  STB : Yuk (payload) kararliligi  (IHI0022 A3.2.1)
    //  "VALID yuksekken READY beklenirken adres/veri degistirilemez."
    //=========================================================================
    generate
    if (HAS_WRITE) begin : g_stb_wr
        STB_01_awaddr: assert property (@(posedge aclk) disable iff (!aresetn)
            (awvalid && !awready) |=> $stable(awaddr))
            else `AXI_CHK_ERR("STB_01", "AWVALID beklerken AWADDR degisti")
        STB_02_wdata: assert property (@(posedge aclk) disable iff (!aresetn)
            (wvalid && !wready) |=> $stable(wdata))
            else `AXI_CHK_ERR("STB_02", "WVALID beklerken WDATA degisti")
        STB_03_bresp: assert property (@(posedge aclk) disable iff (!aresetn)
            (bvalid && !bready) |=> $stable(bresp))
            else `AXI_CHK_ERR("STB_03", "BVALID beklerken BRESP degisti")
    end
    if (HAS_WRITE && HAS_WSTRB) begin : g_stb_wstrb
        STB_04_wstrb: assert property (@(posedge aclk) disable iff (!aresetn)
            (wvalid && !wready) |=> $stable(wstrb))
            else `AXI_CHK_ERR("STB_04", "WVALID beklerken WSTRB degisti")
    end
    if (HAS_READ) begin : g_stb_rd
        STB_05_araddr: assert property (@(posedge aclk) disable iff (!aresetn)
            (arvalid && !arready) |=> $stable(araddr))
            else `AXI_CHK_ERR("STB_05", "ARVALID beklerken ARADDR degisti")
        STB_06_rdata: assert property (@(posedge aclk) disable iff (!aresetn)
            (rvalid && !rready) |=> $stable(rdata))
            else `AXI_CHK_ERR("STB_06", "RVALID beklerken RDATA degisti")
        STB_07_rresp: assert property (@(posedge aclk) disable iff (!aresetn)
            (rvalid && !rready) |=> $stable(rresp))
            else `AXI_CHK_ERR("STB_07", "RVALID beklerken RRESP degisti")
    end
    endgenerate

    //=========================================================================
    //  XCK : X / Z kontrolu
    //  Protokol kurali degil ama pratikte en cok bug yakalayan kontrol:
    //  sifirlanmamis register, eksik default, baglanmamis port hep buradan cikar.
    //=========================================================================
    generate
    if (CHECK_X) begin : g_xck
        if (HAS_WRITE) begin : g_xck_wr
            XCK_01_ctrl_wr: assert property (@(posedge aclk) disable iff (!aresetn)
                !$isunknown({awvalid, awready, wvalid, wready, bvalid, bready}))
                else `AXI_CHK_ERR("XCK_01", "yazma kanali kontrol sinyallerinde X/Z")
            XCK_02_awaddr: assert property (@(posedge aclk) disable iff (!aresetn)
                awvalid |-> !$isunknown(awaddr))
                else `AXI_CHK_ERR("XCK_02", "AWVALID yuksekken AWADDR icinde X/Z")
            XCK_03_wdata: assert property (@(posedge aclk) disable iff (!aresetn)
                wvalid |-> !$isunknown(wdata))
                else `AXI_CHK_ERR("XCK_03", "WVALID yuksekken WDATA icinde X/Z")
            XCK_04_bresp: assert property (@(posedge aclk) disable iff (!aresetn)
                bvalid |-> !$isunknown(bresp))
                else `AXI_CHK_ERR("XCK_04", "BVALID yuksekken BRESP icinde X/Z")
        end
        if (HAS_READ) begin : g_xck_rd
            XCK_05_ctrl_rd: assert property (@(posedge aclk) disable iff (!aresetn)
                !$isunknown({arvalid, arready, rvalid, rready}))
                else `AXI_CHK_ERR("XCK_05", "okuma kanali kontrol sinyallerinde X/Z")
            XCK_06_araddr: assert property (@(posedge aclk) disable iff (!aresetn)
                arvalid |-> !$isunknown(araddr))
                else `AXI_CHK_ERR("XCK_06", "ARVALID yuksekken ARADDR icinde X/Z")
            XCK_07_rdata: assert property (@(posedge aclk) disable iff (!aresetn)
                rvalid |-> !$isunknown({rdata, rresp}))
                else `AXI_CHK_ERR("XCK_07", "RVALID yuksekken RDATA/RRESP icinde X/Z")
        end
    end
    endgenerate

    //=========================================================================
    //  RSP : Cevap kodu legalligi       (IHI0022 A3.4.4 + B1.1)
    //  AXI4-Lite'ta EXOKAY (2'b01) YASAKTIR; exclusive access desteklenmez.
    //=========================================================================
    generate
    if (HAS_WRITE) begin : g_rsp_wr
        RSP_01_bresp_legal: assert property (@(posedge aclk) disable iff (!aresetn)
            bvalid |-> (bresp != 2'b01))
            else `AXI_CHK_ERR("RSP_01", "BRESP=EXOKAY -- AXI4-Lite'ta yasak")
    end
    if (HAS_READ) begin : g_rsp_rd
        RSP_02_rresp_legal: assert property (@(posedge aclk) disable iff (!aresetn)
            rvalid |-> (rresp != 2'b01))
            else `AXI_CHK_ERR("RSP_02", "RRESP=EXOKAY -- AXI4-Lite'ta yasak")
    end
    endgenerate

    //=========================================================================
    //  ORD : Nedensellik / siralama     (IHI0022 A3.3)
    //  "Slave, AW ve W el sikismalarini almadan BVALID yukseltemez."
    //  "Slave, AR el sikismasini almadan RVALID yukseltemez."
    //  -> Istek olmadan gelen sahte cevaplari ve kaybolan islemleri yakalar.
    //=========================================================================
    generate
    //  ordxx_seen: ilk ihlalden sonra ayni kok sebebin yankilarini kirpar
    //  (bkz. bayrak tanimindaki aciklama). Ilk tespit asla gizlenmez.
    if (HAS_WRITE) begin : g_ord_wr
        ORD_01_b_needs_aw: assert property (@(posedge aclk) disable iff (!aresetn)
            (bvalid && !ord01_seen) |-> (aw_eff > b_acc))
            else begin
                ord01_seen = 1'b1;
                `AXI_CHK_ERR("ORD_01", "karsiliksiz BVALID: bekleyen AW islemi yok")
            end
        ORD_02_b_needs_w: assert property (@(posedge aclk) disable iff (!aresetn)
            (bvalid && !ord02_seen) |-> (w_eff > b_acc))
            else begin
                ord02_seen = 1'b1;
                `AXI_CHK_ERR("ORD_02", "karsiliksiz BVALID: bekleyen W islemi yok")
            end
    end
    if (HAS_READ) begin : g_ord_rd
        ORD_03_r_needs_ar: assert property (@(posedge aclk) disable iff (!aresetn)
            (rvalid && !ord03_seen) |-> (ar_eff > r_acc))
            else begin
                ord03_seen = 1'b1;
                `AXI_CHK_ERR("ORD_03", "karsiliksiz RVALID: bekleyen AR islemi yok")
            end
    end
    endgenerate

    //=========================================================================
    //  OUT : Outstanding islem limiti
    //  Basit AXI4-Lite slave'lerde tipik olarak 1'dir. Limiti tasarimin
    //  gercek niyetine gore daraltmak, gecen bir assertion olarak daha
    //  guclu bir uygunluk beyanidir.
    //=========================================================================
    generate
    //  DIKKAT: sayaclar unsigned. Once (aw_acc >= b_acc) kontrol edilmezse,
    //  cevaptan fazla istek durumunda cikarma alttan tasar ve devasa bir
    //  degere donuserek YANLIS alarm uretir. Sirali kontrol bunu engeller
    //  ve ayni zamanda "istekten fazla cevap" hatasini da yakalar.
    //  out_wr_seen / out_rd_seen: ilk ihlalden sonra tekrarlari kirpar
    //  (bkz. bayrak tanimindaki aciklama). Ilk tespit asla gizlenmez.
    if (HAS_WRITE) begin : g_out_wr
        OUT_01_wr: assert property (@(posedge aclk) disable iff (!aresetn)
            out_wr_seen || ((aw_acc >= b_acc) && ((aw_acc - b_acc) <= MAX_OUTSTANDING)))
            else begin
                out_wr_seen = 1'b1;
                `AXI_CHK_ERR("OUT_01", "yazma outstanding limiti asildi veya B cevabi AW isteginden fazla")
            end
    end
    if (HAS_READ) begin : g_out_rd
        OUT_02_rd: assert property (@(posedge aclk) disable iff (!aresetn)
            out_rd_seen || ((ar_acc >= r_acc) && ((ar_acc - r_acc) <= MAX_OUTSTANDING)))
            else begin
                out_rd_seen = 1'b1;
                `AXI_CHK_ERR("OUT_02", "okuma outstanding limiti asildi veya R cevabi AR isteginden fazla")
            end
    end
    endgenerate

    //=========================================================================
    //  WST : WSTRB legalligi
    //  Cevre birimlerimizde WSTRB portu yok (HAS_WSTRB=0 -> atlanir).
    //  RAM kontrolculerinde var. REQUIRE_FULL_WSTRB=1 ise tasarim sadece
    //  tam-kelime yazma varsayiyor demektir; bu varsayim burada test edilir.
    //=========================================================================
    generate
    if (HAS_WRITE && HAS_WSTRB) begin : g_wst
        WST_01_known: assert property (@(posedge aclk) disable iff (!aresetn)
            wvalid |-> !$isunknown(wstrb))
            else `AXI_CHK_ERR("WST_01", "WVALID yuksekken WSTRB icinde X/Z")
        if (REQUIRE_FULL_WSTRB) begin : g_wst_full
            WST_02_full: assert property (@(posedge aclk) disable iff (!aresetn)
                wvalid |-> (&wstrb))
                else `AXI_CHK_ERR("WST_02", "kismi WSTRB geldi ama tasarim tam-kelime varsayiyor")
        end
    end
    endgenerate

    //=========================================================================
    //  STL : Takilma (stall) gozcusu
    //  Protokol ihlali DEGIL, ama kilitlenme/hang tespiti icin kritik.
    //  Bu yuzden UYARI seviyesinde raporlanir, ihlal sayacini artirmaz.
    //=========================================================================
    int unsigned stall_aw, stall_w, stall_b, stall_ar, stall_r;

    always_ff @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            stall_aw <= '0; stall_w <= '0; stall_b <= '0;
            stall_ar <= '0; stall_r <= '0;
        end else begin
            // AW
            if (awvalid && !awready) begin
                stall_aw <= stall_aw + 1;
                if (stall_aw == STALL_LIMIT)
                    `AXI_CHK_WARN("STL_01", $sformatf("AWVALID %0d cevrimdir bekliyor", STALL_LIMIT))
            end else stall_aw <= '0;
            // W
            if (wvalid && !wready) begin
                stall_w <= stall_w + 1;
                if (stall_w == STALL_LIMIT)
                    `AXI_CHK_WARN("STL_02", $sformatf("WVALID %0d cevrimdir bekliyor", STALL_LIMIT))
            end else stall_w <= '0;
            // B
            if (bvalid && !bready) begin
                stall_b <= stall_b + 1;
                if (stall_b == STALL_LIMIT)
                    `AXI_CHK_WARN("STL_03", $sformatf("BVALID %0d cevrimdir bekliyor", STALL_LIMIT))
            end else stall_b <= '0;
            // AR
            if (arvalid && !arready) begin
                stall_ar <= stall_ar + 1;
                if (stall_ar == STALL_LIMIT)
                    `AXI_CHK_WARN("STL_04", $sformatf("ARVALID %0d cevrimdir bekliyor", STALL_LIMIT))
            end else stall_ar <= '0;
            // R
            if (rvalid && !rready) begin
                stall_r <= stall_r + 1;
                if (stall_r == STALL_LIMIT)
                    `AXI_CHK_WARN("STL_05", $sformatf("RVALID %0d cevrimdir bekliyor", STALL_LIMIT))
            end else stall_r <= '0;
        end
    end

    //=========================================================================
    //  FIN : Simulasyon sonu bosaltma (drain) kontrolu
    //  Cevapsiz kalan islem = kaybolmus transaction = gizli hang.
    //  Bu kontrol, testin "gecti" gorunup aslinda yarim kalmasini engeller.
    //=========================================================================
    int unsigned wr_out, rd_out;

    final begin
        wr_out = (aw_tot >= b_tot) ? (aw_tot - b_tot) : 0;
        rd_out = (ar_tot >= r_tot) ? (ar_tot - r_tot) : 0;

        if (HAS_WRITE && (wr_out != 0)) begin
            if (wr_out <= (n_reset + MAX_OUTSTANDING))
                $display("[AXI-CHK] %0s | FIN_01 BILGI: %0d yazma cevapsiz -- %0d reset ve outstanding limiti (%0d) ile aciklanabilir, protokol ihlali DEGIL",
                         NAME, wr_out, n_reset, MAX_OUTSTANDING);
            else begin
                $display("[AXI-CHK] %0s | FIN_01 IHLAL: %0d yazma cevapsiz -- %0d reset ve limit %0d ile ACIKLANAMAZ",
                         NAME, wr_out, n_reset, MAX_OUTSTANDING);
                axi_chk_pkg::g_error_count = axi_chk_pkg::g_error_count + 1;
            end
        end

        if (HAS_READ && (rd_out != 0)) begin
            if (rd_out <= (n_reset + MAX_OUTSTANDING))
                $display("[AXI-CHK] %0s | FIN_02 BILGI: %0d okuma cevapsiz -- %0d reset ve outstanding limiti (%0d) ile aciklanabilir, protokol ihlali DEGIL",
                         NAME, rd_out, n_reset, MAX_OUTSTANDING);
            else begin
                $display("[AXI-CHK] %0s | FIN_02 IHLAL: %0d okuma cevapsiz -- %0d reset ve limit %0d ile ACIKLANAMAZ",
                         NAME, rd_out, n_reset, MAX_OUTSTANDING);
                axi_chk_pkg::g_error_count = axi_chk_pkg::g_error_count + 1;
            end
        end

        // Trafik gormeyen bir arayuzde "0 ihlal" hicbir sey KANITLAMAZ.
        // Kapsam bosluklarinin raporda gorunur olmasi icin acikca isaretlenir.
        if ((HAS_WRITE && (aw_tot == 0)) && (HAS_READ && (ar_tot == 0)))
            $display("[AXI-CHK] %-14s | *** TRAFIK YOK -- bu arayuz HIC test edilmedi ***", NAME);

        $display("[AXI-CHK] %-14s | AW=%0d W=%0d B=%0d AR=%0d R=%0d | ihlal=%0d uyari=%0d",
                 NAME, aw_tot, w_tot, b_tot, ar_tot, r_tot, n_err, n_warn);
    end

endmodule : axi4lite_protocol_checker

`undef AXI_CHK_ERR
`undef AXI_CHK_WARN

`endif