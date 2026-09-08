#!/usr/bin/env python3
# ---------------------------------------------------------------------------
#  patch_rtl.py -- ASIC akisi icin RTL'in yamali kopyalarini uretir
#
#  ILKE: main_codes/rtl/desgin_sources/ altindaki HICBIR dosya degistirilmez.
#  Gereken duzeltmeler burada acikca tanimlanmis metin degisiklikleri olarak
#  tutulur; ciktilar asic_rtl/patched/ altina yazilir ve
#  asic/filelist.f orijinallerin YERINE bu kopyalari secer. Boylece FPGA /
#  Vivado akisi hic etkilenmez ve yapilan her degisiklik tek bakista goruluyor
#  olur (sartname Bolum 9.9 ve Bolum 10).
#
#  Yama uygulanamazsa betik HATA verir; ust akis dosyasi degisirse sessizce
#  eski hali kullanilmaz.
#
#  ---------------------------------------------------------------------------
#  NEDEN GEREKLI?  Yosys'in sentez oncesi `check` gecisi 91 adet "surulmeyen
#  sinyal" buluyor ve LibreLane akisi bunun uzerine duruyor. Uc kok neden var:
#
#   (a) AXI4-Lite slave'lerinin RRESP/BRESP cikislarina YALNIZCA reset dalinda
#       0 atanmis, baska hicbir yerde atanmamis. Vivado bunlari sessizce 0'a
#       bagliyordu; RTL acisindan ise cikislar surulmuyor.
#   (b) CPU komut portunun (fetch) kullanilmayan AXI YAZMA kanali cikislari
#       (awaddr/awvalid/wdata/wvalid/bready) hic atanmamis.
#   (c) obi_to_axi'de OBI yanit yapisinin istege bagli alani (r_optional),
#       ilgili ozellikler kapali oldugu icin hicbir generate dalinda surulmuyor.
#
#  Uc durumda da ilgili sinyallerin DEGERI zaten sabittir; yamalar bu sabiti
#  acikca yazar. Uretilen donanim ve davranis DEGISMEZ, yalnizca surucu
#  belirsizligi ortadan kalkar.
#
#  ONERI: bu duzeltmeler ana RTL'e de alinmalidir -- RRESP/BRESP surmeyen bir
#  AXI4-Lite slave, arac degistiginde farkli davranabilir.
# ---------------------------------------------------------------------------
import argparse
import hashlib
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
SRC = ROOT / "FPGA/main_codes/rtl/desgin_sources"
DST = ROOT / "asic_rtl/patched"


def i2c_clk_freq_hz():
    """config.yaml'daki CLOCK_PERIOD'dan I2C bolucusu icin dogru CLK_FREQ_HZ.

    NEDEN GEREKLI?
      Ortak I2C RTL'i 50 MHz FPGA sistem saatini varsayar ve kesirli bolucuyle
      ortalama tam 400 kHz SCL uretir. ASIC sistem saati config.yaml'da ayri
      tanimlandigi icin Top_module_asic kopyasindaki I2C orneklemesine bu deger
      acikca aktarilir. Boylece ayni ortak RTL, FPGA'da 50 MHz ve ASIC'te
      beyan edilen saatle sartname Bolum 4.2'deki sabit 400 kHz hedefini korur.

    Beyan edilen 28 MHz icin yari-periyot 35 sistem cevrimidir; bolme tam
    sayidir ve kesirli dagitim/jitter olusmaz.
    """
    cfg = (ROOT / "asic/config.yaml").read_text()
    m = re.search(r"^CLOCK_PERIOD:\s*([\d.]+)\s*$", cfg, re.M)
    if not m:
        sys.exit("HATA: config.yaml icinde CLOCK_PERIOD bulunamadi")
    period_ns = float(m.group(1))
    f_hz = 1e9 / period_ns
    clk_hz = int(round(f_hz))
    # Firmware UART bolucusu ayri dizindeki Makefile'da derleme zamaninda
    # donuyor. Config degisip firmware unutulursa fiziksel akis calisir ama
    # mask ROM yanlis baud degeri tasir; bunu sentezden once sert hata yap.
    fw_makefile = ROOT / "FPGA/firmware/Makefile"
    fw_text = fw_makefile.read_text()
    fw_m = re.search(r"^ASIC_CLK_HZ\s*\?=\s*(\d+)\s*$", fw_text, re.M)
    if not fw_m:
        sys.exit("HATA: FPGA/firmware/Makefile icinde ASIC_CLK_HZ bulunamadi")
    fw_hz = int(fw_m.group(1))
    if fw_hz != clk_hz:
        sys.exit(
            f"HATA: ASIC saat uyusmazligi: config.yaml={clk_hz} Hz, "
            f"firmware/Makefile ASIC_CLK_HZ={fw_hz} Hz"
        )
    half_cycles = clk_hz // 800000
    return clk_hz, f_hz, half_cycles


def bias_literals():
    """`$readmemh` yerine gececek literal bias atamalarini uretir.

    NEDEN GEREKLI?  conv_accelerator.v bias dizilerini `initial` icinde once
    sifirlar, sonra `$readmemh("biases.hex", ...)` ile doldurur. Vivado bu
    dosyalari proje "Memory File" olarak cozer; Yosys ise GORELI yolu kendi
    CALISMA DIZININE gore arar (run/<etiket>/06-yosys-synthesis/) ve dosyayi
    bulamayinca HATA VERMEDEN gecer. Sonuc: diziler sifir kalir.

    Bu SESSIZ bir hatadir ve yalnizca yosys logundaki OPT_MEM ciktisindan
    farkedilir:
        top_module.conv_accelerator_inst.biases:    removing const-0 lane 0..31
        top_module.conv_accelerator_inst.fc_biases: removing const-0 lane 0..31
    (32 bit duzleminin tamami sabit-0 bulunmus). Bias'lar sifirlaninca
    konvolusyonun 8 kanali ve FC'nin 4 sinif skoru kayar; yani cikarim
    sonucu YANLIS olur. Agirlik ROM'lari bu sorundan etkilenmez, cunku
    onlar `gen_rom.py` ile literal sabit olarak URETILIR.

    Degerler burada elle yazilmaz; kaynak .hex dosyalarindan okunur. Boylece
    model yeniden egitilip .hex'ler degisirse bu yama otomatik olarak yeni
    degerleri alir ve donanim ile model senkron kalir.
    """
    def read_hex(name, count):
        p = SRC / "AI_Accelerator" / name
        if not p.is_file():
            sys.exit(f"HATA: bias dosyasi yok: {p}")
        vals = [w for w in p.read_text().split() if w and not w.startswith("//")]
        if len(vals) != count:
            sys.exit(f"HATA: {name} icinde {len(vals)} deger var, {count} bekleniyordu")
        for v in vals:
            int(v, 16)          # bicim dogrulamasi
        return vals

    conv = read_hex("biases.hex", 8)        # N_CH    = 8
    fc = read_hex("fc_biases.hex", 4)       # N_CLASS = 4
    L = ["        // ASIC yamasi: $readmemh yerine literal atama "
         "(gerekcesi dosya basinda).",
         "        // Degerler AI_Accelerator/{biases,fc_biases}.hex'ten uretildi."]
    L += [f"        biases[{i}]    = 32'h{v};" for i, v in enumerate(conv)]
    L += [f"        fc_biases[{i}] = 32'h{v};" for i, v in enumerate(fc)]
    return "\n".join(L)

NOTE_RESP = (
    "AXI4-Lite yanit kodlari (RRESP/BRESP) yalnizca reset dalinda 0 atanmisti,\n"
    "//    baska hicbir yerde atanmadigi icin cikislar SURULMEYEN sinyal olarak\n"
    "//    kaliyordu. Reset atamalari kaldirilip yerine surekli atama konuldu:\n"
    "//    deger her zaman 2'b00 (OKAY) -- yani davranis birebir aynidir, ama\n"
    "//    artik cikisin acik bir surucusu var."
)


def resp_patch(src, dst, signals, reset_lines, extra_note=""):
    """Reset dalindaki atamalari kaldirip surekli atamaya cevirir."""
    assigns = "\n".join(
        f"    // ASIC yamasi: bkz. dosya basi\n    assign {s} = 2'b00;   // AXI OKAY"
        for s in signals
    )
    return dict(
        src=src, dst=dst, why=NOTE_RESP + extra_note,
        subs=[(line, "") for line in reset_lines]
             + [("\nendmodule", f"\n{assigns}\n\nendmodule")],
    )


_I2C_CLK_HZ, _I2C_F_HZ, _I2C_HALF = i2c_clk_freq_hz()
_I2C_SCL_KHZ = 400.0

PATCHES = [
    # --- (c) ucuncu taraf: obi_to_axi -----------------------------------
    dict(
        src="CPU/openhw_obi_to_axi/obi_to_axi.sv",
        dst="obi_to_axi_asic.sv",
        why=(
            "UC DUZELTME.\n"
            "//\n"
            "//  1) SIFIR GENISLIKLI PORT/KAYIT VE PARCA-SECIM\n"
            "//     AxiDataWidth == ObiCfg.DataWidth (bu tasarimda ikisi de 32) iken\n"
            "//     $clog2(AxiDataWidth/ObiCfg.DataWidth) = $clog2(1) = 0 olur; sifir\n"
            "//     genislikli kayit/parca-secim SystemVerilog'da gecersizdir (LRM 11.5.1).\n"
            "//     Ayrica AxiUserWidth ve RUserWidth sifirken [WIDTH-1:0], [-1:0]\n"
            "//     olur ve iki bitlik ters aralik yaratir. Vivado/Yosys bunu hos gorur,\n"
            "//     bazi tam SV on ucleri reddeder. Mantiksal genislik parametreleri\n"
            "//     degistirilmeden yalniz fiziksel port/kayit tasiyicilari en az 1 bit\n"
            "//     yapilir; ozellikler kapali oldugundan donanim davranisi degismez.\n"
            "//\n"
            "//  2) SURULMEYEN obi_rsp_o.r.r_optional\n"
            "//     Bu alan yalnizca UseAtop / RUserWidth generate dallarinda\n"
            "//     suruluyor; ikisi de kapali oldugu icin hicbir surucusu yoktu.\n"
            "//     Kapali durum icin acik bir `else` dali eklendi."
        ),
        subs=[
            (
                "  input  logic [AxiUserWidth-1:0] user_i,",
                "  input  logic [((AxiUserWidth > 0) ? AxiUserWidth : 1)-1:0] user_i,",
            ),
            (
                "  output logic [AxiUserWidth-1:0] axi_rsp_b_user_o,",
                "  output logic [((AxiUserWidth > 0) ? AxiUserWidth : 1)-1:0] axi_rsp_b_user_o,",
            ),
            (
                "  output logic [AxiUserWidth-1:0] axi_rsp_r_user_o,",
                "  output logic [((AxiUserWidth > 0) ? AxiUserWidth : 1)-1:0] axi_rsp_r_user_o,",
            ),
            (
                "  input  logic [ObiCfg.OptionalCfg.RUserWidth-1:0] obi_rsp_user_i // If unused tie to '0",
                "  input  logic [((ObiCfg.OptionalCfg.RUserWidth > 0)\n"
                "                 ? ObiCfg.OptionalCfg.RUserWidth : 1)-1:0] obi_rsp_user_i // If unused tie to '0",
            ),
            (
                "  logic [$clog2(AxiDataWidth/ObiCfg.DataWidth)-1:0] data_offset, rdata_offset;",
                "  logic [((AxiDataWidth > ObiCfg.DataWidth)\n"
                "          ? $clog2(AxiDataWidth/ObiCfg.DataWidth) : 1)-1:0]\n"
                "      data_offset, rdata_offset;",
            ),
            (
                "  localparam int unsigned NumObiChanWidth = $clog2(NumObiChans);",
                "  localparam int unsigned NumObiChanWidth =\n"
                "      (NumObiChans > 1) ? $clog2(NumObiChans) : 1;",
            ),
            (
                "      data_offset = obi_req_i.a.addr[$clog2(ObiCfg.DataWidth/8)+:\n"
                "                                     $clog2(AxiDataWidth/ObiCfg.DataWidth)];",
                "      data_offset = obi_req_i.a.addr[$clog2(ObiCfg.DataWidth/8)+:\n"
                "                                     ((AxiDataWidth > ObiCfg.DataWidth)\n"
                "                                       ? $clog2(AxiDataWidth/ObiCfg.DataWidth)\n"
                "                                       : 1)];   // ASIC yamasi (1)",
            ),
            (
                "    assign obi_rsp_o.r.r_optional.exokay = rsp_sel[0] ?\n"
                "      (axi_rsp_i.b.resp == axi_pkg::RESP_EXOKAY) :\n"
                "      (axi_rsp_i.r.resp == axi_pkg::RESP_EXOKAY);\n"
                "  end",
                "    assign obi_rsp_o.r.r_optional.exokay = rsp_sel[0] ?\n"
                "      (axi_rsp_i.b.resp == axi_pkg::RESP_EXOKAY) :\n"
                "      (axi_rsp_i.r.resp == axi_pkg::RESP_EXOKAY);\n"
                "  end else begin : gen_no_atop_exokay\n"
                "    // ASIC yamasi (2): ozellik kapaliyken r_optional surulmuyordu\n"
                "    assign obi_rsp_o.r.r_optional = '0;\n"
                "  end",
            ),
        ],
    ),
    # --- (b) CPU komut portunun kullanilmayan yazma kanali ---------------
    dict(
        src="CPU/bizim_kodlar/cv32e40p_obi_to_axi_wrapper.sv",
        dst="cv32e40p_obi_to_axi_wrapper_asic.sv",
        why=(
            "KULLANILMAYAN AXI YAZMA KANALI SURULMUYORDU.\n"
            "//    Komut (fetch) portu yalnizca okuma yapar; buna karsilik modulun\n"
            "//    axi_instr_awaddr / awvalid / wdata / wvalid / bready cikislari\n"
            "//    HICBIR yerde atanmamisti (67 bit surulmeyen sinyal). Vivado bunlari\n"
            "//    sessizce 0'a bagliyordu. Yama, kanalin pasif degerlerini acikca\n"
            "//    surer: yazma istegi hic olusmaz, davranis degismez."
        ),
        subs=[(
            "\nendmodule",
            "\n    // -----------------------------------------------------------------\n"
            "    //  ASIC yamasi: komut portu yalnizca okuma yapar; kullanilmayan AXI\n"
            "    //  yazma kanali cikislarini acikca pasif degere bagla (bkz. dosya basi)\n"
            "    // -----------------------------------------------------------------\n"
            "    assign axi_instr_awaddr  = 32'h0000_0000;\n"
            "    assign axi_instr_awvalid = 1'b0;\n"
            "    assign axi_instr_wdata   = 32'h0000_0000;\n"
            "    assign axi_instr_wvalid  = 1'b0;\n"
            "    assign axi_instr_bready  = 1'b0;\n"
            "\nendmodule",
        )],
    ),
    # --- Data RAM: gercek read-enable + ayni-adres arbitraji ------------
    dict(
        src="Memory/Data_RAM_AXI4-Lite_Wrapper/data_bram_axi_ctrl.sv",
        dst="data_bram_axi_ctrl_asic.sv",
        why=(
            "SRAM CIFT-PORT AYNI-ADRES CAKISMASI GIDERILDI.\n"
            "//    OpenRAM makrosunda iki portun ayni saat kenarinda ayni adrese\n"
            "//    erisimi tanimsizdir. ASIC sarmalayicisina gercek read-enable\n"
            "//    tasinir; read portu yalnizca AR handshake kenarinda acilir ve\n"
            "//    makro cikisi AXI stall boyunca sabit kalan bir register'a alinir. Ayni\n"
            "//    adrese yeni veya outstanding bir read varken write ready\n"
            "//    dusurulur ve yazma read tamamlanana kadar kayipsiz bekletilir.\n"
            "//    Farkli adreslerde eszamanli read/write destegi korunur."
        ),
        subs=[
            (
                "    typedef enum logic [1:0] {R_IDLE, R_WAIT, R_VALID} rstate_e;\n"
                "    rstate_e               rstate;\n"
                "    logic [ADDR_WIDTH-1:0] raddr_q;\n\n",
                "",
            ),
            (
                "    logic [3:0]            be;",
                "    logic [3:0]            be;\n"
                "    logic                  mem_re;\n"
                "    logic                  awready_q, wready_q;\n"
                "    logic                  write_conflict;\n"
                "    logic [DATA_WIDTH-1:0] rdata_latch;\n"
                "    typedef enum logic [1:0] {R_IDLE, R_WAIT, R_VALID} rstate_e;\n"
                "    rstate_e               rstate;\n"
                "    logic [ADDR_WIDTH-1:0] raddr_q;",
            ),
            (
                "        .clk(clk_i), .we(we), .be(be),",
                "        .clk(clk_i), .we(we), .re(mem_re), .be(be),",
            ),
            (
                "    assign we    = axi_data_bram_awvalid && axi_data_bram_wvalid &&\n"
                "                   axi_data_bram_awready && axi_data_bram_wready;\n"
                "    assign waddr = axi_data_bram_awaddr[ADDR_WIDTH+1:2];",
                "    assign waddr = axi_data_bram_awaddr[ADDR_WIDTH+1:2];\n"
                "\n"
                "    // ASIC yamasi: ayni adreste read/write'a read onceligi ver.\n"
                "    // IDLE'da yeni AR, diger durumlarda kayitli outstanding adres\n"
                "    // karsilastirilir. Ready disaridan dusuruldugu icin istek kaybolmaz.\n"
                "    assign write_conflict = axi_data_bram_awvalid && axi_data_bram_wvalid &&\n"
                "        (((rstate != R_IDLE) && (waddr == raddr_q)) ||\n"
                "         ((rstate == R_IDLE) && axi_data_bram_arvalid &&\n"
                "          (waddr == axi_data_bram_araddr[ADDR_WIDTH+1:2])));\n"
                "    // AW ve W AXI4-Lite'ta bagimsiz kanallardir. Bu tasarim adres/veri\n"
                "    // tamponlamadigi icin READY yalniz iki VALID birlikteyken yukselir;\n"
                "    // boylece tek kanal erken handshake olup kaybolamaz.\n"
                "    assign axi_data_bram_awready = awready_q && axi_data_bram_wvalid\n"
                "                                         && !write_conflict;\n"
                "    assign axi_data_bram_wready  = wready_q  && axi_data_bram_awvalid\n"
                "                                         && !write_conflict;\n"
                "    assign we = axi_data_bram_awvalid && axi_data_bram_wvalid &&\n"
                "                axi_data_bram_awready && axi_data_bram_wready;",
            ),
            (
                "    always_ff @(posedge clk_i or negedge rst_n) begin\n"
                "        if (!rst_n) begin\n"
                "            axi_data_bram_bvalid  <= 1'b0;\n"
                "            axi_data_bram_awready <= 1'b1;\n"
                "            axi_data_bram_wready  <= 1'b1;\n"
                "        end else if (axi_data_bram_bvalid && axi_data_bram_bready) begin\n"
                "            axi_data_bram_bvalid  <= 1'b0;\n"
                "            axi_data_bram_awready <= 1'b1;\n"
                "            axi_data_bram_wready  <= 1'b1;\n"
                "        end else if (axi_data_bram_awvalid && axi_data_bram_awready &&\n"
                "                     axi_data_bram_wvalid  && axi_data_bram_wready) begin\n"
                "            axi_data_bram_bvalid  <= 1'b1;\n"
                "            axi_data_bram_awready <= 1'b0;\n"
                "            axi_data_bram_wready  <= 1'b0;\n"
                "        end\n"
                "    end",
                "    always_ff @(posedge clk_i or negedge rst_n) begin\n"
                "        if (!rst_n) begin\n"
                "            axi_data_bram_bvalid <= 1'b0;\n"
                "            awready_q <= 1'b1;\n"
                "            wready_q  <= 1'b1;\n"
                "        end else if (axi_data_bram_bvalid && axi_data_bram_bready) begin\n"
                "            axi_data_bram_bvalid <= 1'b0;\n"
                "            awready_q <= 1'b1;\n"
                "            wready_q  <= 1'b1;\n"
                "        end else if (we) begin\n"
                "            axi_data_bram_bvalid <= 1'b1;\n"
                "            awready_q <= 1'b0;\n"
                "            wready_q  <= 1'b0;\n"
                "        end\n"
                "    end",
            ),
            (
                "    assign raddr                 = raddr_q;            // BRAM sabit, geçerli adresten okur\n"
                "    assign axi_data_bram_rdata   = rdata;              // BRAM registered çıkışı (raddr_q sabitken sabit kalır)",
                "    // Handshake kenarinda henuz raddr_q guncellenmedigi icin makroya\n"
                "    // dogrudan AXI adresi verilir; sonraki cevrimlerde kayitli adres tutulur.\n"
                "    assign raddr = (rstate == R_IDLE)\n"
                "                 ? axi_data_bram_araddr[ADDR_WIDTH+1:2] : raddr_q;\n"
                "    assign mem_re = axi_data_bram_arvalid && axi_data_bram_arready;\n"
                "    assign axi_data_bram_rdata = rdata_latch;",
            ),
            (
                "    always_ff @(posedge clk_i or negedge rst_n) begin\n"
                "        if (!rst_n) begin\n"
                "            rstate  <= R_IDLE;",
                "    // Makro sonucu AR handshake'inden bir cevrim sonra sabitlenir.\n"
                "    // RVALID stall olsa bile AXI RDATA artik makro csb davranisindan etkilenmez.\n"
                "    always_ff @(posedge clk_i or negedge rst_n) begin\n"
                "        if (!rst_n) rdata_latch <= '0;\n"
                "        else if (rstate == R_WAIT) rdata_latch <= rdata;\n"
                "    end\n\n"
                "    always_ff @(posedge clk_i or negedge rst_n) begin\n"
                "        if (!rst_n) begin\n"
                "            rstate  <= R_IDLE;",
            ),
        ],
    ),
    # --- (a) AXI4-Lite yanit kodlari -------------------------------------
    resp_patch("Peripherals/GPIO/GPIO_AXI4_Lite.sv", "GPIO_AXI4_Lite_asic.sv",
               ["bresp", "rresp"],
               ["            bresp   <= 0;\n", "            rresp   <= 0;\n"]),
    resp_patch("Peripherals/Timer/Timer_AXI4_Lite.sv", "Timer_AXI4_Lite_asic.sv",
               ["bresp", "rresp"],
               ["            bresp     <= 0;\n", "            rresp     <= 0;\n"]),
    resp_patch("Peripherals/QSPI/QSPI_Master_AXI4_Lite.sv", "QSPI_Master_AXI4_Lite_asic.sv",
               ["bresp", "rresp"],
               ["            bresp <= 2'b00;\n", "            rresp <= 2'b00;\n"]),
    resp_patch("Peripherals/UART_GU/UART_GU_AXI4-Lite.sv", "UART_GU_AXI4_Lite_asic.sv",
               ["bresp", "rresp"],
               ["            bresp   <= 0;\n", "            rresp   <= 0;\n"]),
    resp_patch("Peripherals/UART_YZ/UART_YZ_AXI4-Lite.sv", "UART_YZ_AXI4_Lite_asic.sv",
               ["bresp", "rresp"],
               ["            bresp   <= 0;\n", "            rresp   <= 0;\n"]),
    # --- Instruction RAM: gercek read-enable + DMA/write arbitraji -------
    dict(
        src="Memory/Instrurction_RAM_AXI4-Lite_Wrapper/instr_bram_axi_ctrl.sv",
        dst="instr_bram_axi_ctrl_asic.sv",
        why=(
            "IKI DUZELTME.\n"
            "//\n"
            "//  1) AXI RRESP yalniz reset dalinda suruluyordu; surekli OKAY\n"
            "//     atamasina cevrildi.\n"
            "//\n"
            "//  2) Instruction SRAM read portu ARVALID'den bagimsiz olarak HER\n"
            "//     CEVRIM acikti. CPU Boot ROM'dan calisirken bile QSPI DMA'nin\n"
            "//     yazdigi IMEM adresiyle hayali bir read cakisip OpenRAM'in\n"
            "//     tanimsiz ayni-adres cift-port durumunu uretebiliyordu. Gercek\n"
            "//     read-enable yalniz AR handshake'inde darbe olur. DMA veya AXI\n"
            "//     write ayni adrese denk gelirse yazma (DMA geri basilamaz)\n"
            "//     oncelik alir ve ARREADY bir cevrim dusurulur; farkli adresli\n"
            "//     read/write eszamanli kalir. AXI AW/W kanallari iki VALID\n"
            "//     birlikteyken kabul edilir; DMA ile AXI write cakisirsa geri\n"
            "//     basilabilen AXI write bekletilir."
        ),
        subs=[
            (
                "    logic [ADDR_WIDTH-1:0] addr_cnt;",
                "    logic [ADDR_WIDTH-1:0] addr_cnt;\n"
                "    logic                  mem_re;\n"
                "    logic                  arready_q;\n"
                "    logic                  awready_q, wready_q;\n"
                "    logic                  read_conflict;",
            ),
            (
                "    .we(we),\n"
                "    .be(be),",
                "    .we(we),\n"
                "    .re(mem_re),\n"
                "    .be(be),",
            ),
            (
                "assign axi_instr_bram_bresp = 0;",
                "assign axi_instr_bram_bresp = 2'b00;",
            ),
            (
                "assign bram_we = axi_instr_bram_awvalid && axi_instr_bram_wvalid && axi_instr_bram_awready && axi_instr_bram_wready;",
                "// AW/W bagimsizdir; tampon yoksa yalniz ortak VALID aninda kabul et.\n"
                "// DMA geri basilamadigi icin ayni cevrimde AXI write'i beklet.\n"
                "assign axi_instr_bram_awready = awready_q && axi_instr_bram_wvalid && !dma_valid_i;\n"
                "assign axi_instr_bram_wready  = wready_q  && axi_instr_bram_awvalid && !dma_valid_i;\n\n"
                "assign bram_we = axi_instr_bram_awvalid && axi_instr_bram_wvalid && axi_instr_bram_awready && axi_instr_bram_wready;",
            ),
            (
                "always_ff @(posedge clk_i or negedge rst_n) begin\n"
                "    if (!rst_n) begin\n"
                "        axi_instr_bram_bvalid  <= 0;\n"
                "        axi_instr_bram_awready <= 1;\n"
                "        axi_instr_bram_wready  <= 1;\n"
                "    end\n"
                "    // ÖNCELİK 1: B handshake - response kabul edildi, sıfırla\n"
                "    else if (axi_instr_bram_bvalid && axi_instr_bram_bready) begin\n"
                "        axi_instr_bram_bvalid  <= 0;\n"
                "        axi_instr_bram_awready <= 1;\n"
                "        axi_instr_bram_wready  <= 1;\n"
                "    end\n"
                "    // ÖNCELİK 2: AW+W handshake - slave hazırken (awready=1, wready=1) kabul et\n"
                "    else if (axi_instr_bram_awvalid && axi_instr_bram_awready &&\n"
                "             axi_instr_bram_wvalid  && axi_instr_bram_wready) begin\n"
                "        axi_instr_bram_bvalid  <= 1;\n"
                "        axi_instr_bram_awready <= 0;\n"
                "        axi_instr_bram_wready  <= 0;\n"
                "    end\n"
                "end",
                "always_ff @(posedge clk_i or negedge rst_n) begin\n"
                "    if (!rst_n) begin\n"
                "        axi_instr_bram_bvalid <= 0;\n"
                "        awready_q <= 1;\n"
                "        wready_q  <= 1;\n"
                "    end else if (axi_instr_bram_bvalid && axi_instr_bram_bready) begin\n"
                "        axi_instr_bram_bvalid <= 0;\n"
                "        awready_q <= 1;\n"
                "        wready_q  <= 1;\n"
                "    end else if (bram_we) begin\n"
                "        axi_instr_bram_bvalid <= 1;\n"
                "        awready_q <= 0;\n"
                "        wready_q  <= 0;\n"
                "    end\n"
                "end",
            ),
            (
                "assign raddr = axi_instr_bram_araddr[ADDR_WIDTH+1:2];\n\n"
                "logic pending_r;",
                "assign raddr = axi_instr_bram_araddr[ADDR_WIDTH+1:2];\n"
                "// DMA'nin ready'si yoktur; ayni-adres cakismasinda write onceliklidir.\n"
                "assign read_conflict = we && (waddr == raddr);\n"
                "assign axi_instr_bram_arready = arready_q && !read_conflict;\n"
                "assign mem_re = axi_instr_bram_arvalid && axi_instr_bram_arready;\n\n"
                "logic pending_r;",
            ),
            (
                "        axi_instr_bram_arready    <= 1;\n"
                "        axi_instr_bram_rresp      <= 0;",
                "        arready_q                 <= 1;",
            ),
            (
                "            axi_instr_bram_arready <= 0;",
                "            arready_q              <= 0;",
            ),
            (
                "            axi_instr_bram_arready <= 1;",
                "            arready_q              <= 1;",
            ),
            (
                "\nendmodule",
                "\n    // ASIC yamasi: AXI OKAY yaniti surekli surulur.\n"
                "    assign axi_instr_bram_rresp = 2'b00;\n\n"
                "endmodule",
            ),
        ],
    ),
    # --- ASIC top: asenkron assert / senkron deassert reset --------------
    dict(
        src="Top_Module/Top_module.sv",
        dst="Top_module_asic.sv",
        why=(
            "UC DUZELTME.\n"
            "//\n"
            "//  1) RESET DAGITIMI SILIKON-GUVENLI HALE GETIRILDI.\n"
            "//    Harici rst_ni daha once 4.662 fana dogrudan gidiyor; pre-PnR\n"
            "//    STA'da TT 75 ns / SS 106 ns slew ve -111 ns recovery slack\n"
            "//    uretiyordu. Blanket false-path bu gercek problemi gizliyordu.\n"
            "//    Iki floplu synchronizer dis reseti yalniz iki async reset pinine\n"
            "//    baglar: assert yine asenkron, deassert iki clk_i kenariyla\n"
            "//    senkrondur. Butun ic bloklar rst_sys_ni kullanir; ic reset agaci\n"
            "//    normal zamanlama/DRC onarimiyla bufferlanabilir.\n"
            "//\n"
            "//  2) DATA YOLUNDAN INSTRUCTION RAM OKUMASI TAMAMLANDI.\n"
            "//    Interconnect 0x1000_0000..0x1000_FFFF read adreslerini M8'e\n"
            "//    decode ediyordu, ancak M8 AR/R portlari top seviyesinde bagli\n"
            "//    degildi; bu adrese CPU load yapinca ARREADY sonsuza kadar 0\n"
            "//    kaliyordu. Uygulama linker script'i .rodata'yi ve .data load\n"
            "//    imajini tam bu IMEM bolgesine koydugu icin yol gercekten gerekir.\n"
            "//    Instruction fetch ve data read, tek SRAM read denetleyicisine\n"
            "//    iki-master AXI read arbitriyle baglandi; data read onceligi\n"
            "//    instruction prefetch'in data load'u ac birakmasini onler."
        ),
        subs=[
            (
                "\n\n);\n\n    //  INSTRUCTION AR PORTLARI",
                "\n\n);\n\n"
                "    // ASIC reset synchronizer: async assert, iki-kademeli sync deassert.\n"
                "    // ASYNC_REG/keep, iki flopun optimizasyonda birlestirilmesini onler.\n"
                "    (* async_reg = \"true\", keep = \"true\" *) logic [1:0] rst_sync_q;\n"
                "    logic rst_sys_ni;\n\n"
                "    always_ff @(posedge clk_i or negedge rst_ni) begin\n"
                "        if (!rst_ni) rst_sync_q <= 2'b00;\n"
                "        else         rst_sync_q <= {rst_sync_q[0], 1'b1};\n"
                "    end\n"
                "    assign rst_sys_ni = rst_sync_q[1];\n\n"
                "    //  INSTRUCTION AR PORTLARI",
            ),
            (".rst_n(rst_ni)", ".rst_n(rst_sys_ni)", 12),
            (".rst_ni(rst_ni)", ".rst_ni(rst_sys_ni)", 2),
            # --- Ortak I2C RTL'ine ASIC sistem saati aktarilir ---
            # Gerekce ve formul icin
            # i2c_clk_freq_hz() basligina bakin.
            (
                "I2C_Master_AXI4_Lite i2c_master_inst(",
                f"I2C_Master_AXI4_Lite #(.CLK_FREQ_HZ({_I2C_CLK_HZ})) "
                f"i2c_master_inst(",
            ),
            (
                "    logic        axi_instr_bram_rready;\n"
                "    logic [31:0] axi_instr_bram_awaddr;",
                "    logic        axi_instr_bram_rready;\n\n"
                "    // CPU data portunun IMEM read kanali (interconnect M8).\n"
                "    logic [31:0] axi_instr_data_araddr;\n"
                "    logic        axi_instr_data_arvalid;\n"
                "    logic        axi_instr_data_arready;\n"
                "    logic [31:0] axi_instr_data_rdata;\n"
                "    logic [ 1:0] axi_instr_data_rresp;\n"
                "    logic        axi_instr_data_rvalid;\n"
                "    logic        axi_instr_data_rready;\n\n"
                "    // Iki read masterindan Instruction RAM denetleyicisine giden kanal.\n"
                "    logic [31:0] axi_instr_mem_araddr;\n"
                "    logic        axi_instr_mem_arvalid;\n"
                "    logic        axi_instr_mem_arready;\n"
                "    logic [31:0] axi_instr_mem_rdata;\n"
                "    logic [ 1:0] axi_instr_mem_rresp;\n"
                "    logic        axi_instr_mem_rvalid;\n"
                "    logic        axi_instr_mem_rready;\n\n"
                "    logic [31:0] axi_instr_bram_awaddr;",
            ),
            (
                "instr_bram_axi_ctrl #(\n",
                "// Instruction fetch ve data load tek IMEM AXI read portunu paylasir.\n"
                "axi_read_arbiter2 instr_read_arbiter_inst (\n"
                "    .clk_i(clk_i), .rst_ni(rst_sys_ni),\n"
                "    .m0_araddr(axi_instr_bram_araddr),\n"
                "    .m0_arvalid(axi_instr_bram_arvalid),\n"
                "    .m0_arready(axi_instr_bram_arready),\n"
                "    .m0_rdata(axi_instr_bram_rdata),\n"
                "    .m0_rresp(axi_instr_bram_rresp),\n"
                "    .m0_rvalid(axi_instr_bram_rvalid),\n"
                "    .m0_rready(axi_instr_bram_rready),\n"
                "    .m1_araddr(axi_instr_data_araddr),\n"
                "    .m1_arvalid(axi_instr_data_arvalid),\n"
                "    .m1_arready(axi_instr_data_arready),\n"
                "    .m1_rdata(axi_instr_data_rdata),\n"
                "    .m1_rresp(axi_instr_data_rresp),\n"
                "    .m1_rvalid(axi_instr_data_rvalid),\n"
                "    .m1_rready(axi_instr_data_rready),\n"
                "    .s_araddr(axi_instr_mem_araddr),\n"
                "    .s_arvalid(axi_instr_mem_arvalid),\n"
                "    .s_arready(axi_instr_mem_arready),\n"
                "    .s_rdata(axi_instr_mem_rdata),\n"
                "    .s_rresp(axi_instr_mem_rresp),\n"
                "    .s_rvalid(axi_instr_mem_rvalid),\n"
                "    .s_rready(axi_instr_mem_rready)\n"
                ");\n\n"
                "instr_bram_axi_ctrl #(\n",
            ),
            (
                "    .axi_instr_bram_araddr (axi_instr_bram_araddr),\n"
                "    .axi_instr_bram_arvalid(axi_instr_bram_arvalid),\n"
                "    .axi_instr_bram_arready(axi_instr_bram_arready),\n\n"
                "    .axi_instr_bram_rdata  (axi_instr_bram_rdata),\n"
                "    .axi_instr_bram_rresp  (axi_instr_bram_rresp),\n"
                "    .axi_instr_bram_rvalid (axi_instr_bram_rvalid),\n"
                "    .axi_instr_bram_rready (axi_instr_bram_rready),",
                "    .axi_instr_bram_araddr (axi_instr_mem_araddr),\n"
                "    .axi_instr_bram_arvalid(axi_instr_mem_arvalid),\n"
                "    .axi_instr_bram_arready(axi_instr_mem_arready),\n\n"
                "    .axi_instr_bram_rdata  (axi_instr_mem_rdata),\n"
                "    .axi_instr_bram_rresp  (axi_instr_mem_rresp),\n"
                "    .axi_instr_bram_rvalid (axi_instr_mem_rvalid),\n"
                "    .axi_instr_bram_rready (axi_instr_mem_rready),",
            ),
            (
                "    .axi_m8_bready (axi_instr_bram_bready),\n"
                "    .axi_m8_arready(0),\n"
                "    .axi_m8_rdata  (0),\n"
                "    .axi_m8_rresp  (0),\n"
                "    .axi_m8_rvalid (0),",
                "    .axi_m8_bready (axi_instr_bram_bready),\n"
                "    .axi_m8_araddr (axi_instr_data_araddr),\n"
                "    .axi_m8_arvalid(axi_instr_data_arvalid),\n"
                "    .axi_m8_arready(axi_instr_data_arready),\n"
                "    .axi_m8_rdata  (axi_instr_data_rdata),\n"
                "    .axi_m8_rresp  (axi_instr_data_rresp),\n"
                "    .axi_m8_rvalid (axi_instr_data_rvalid),\n"
                "    .axi_m8_rready (axi_instr_data_rready),",
            ),
        ],
    ),
    # --- YZ hizlandirici: MAC yolunun boru hattina alinmasi ---------------
    dict(
        src="AI_Accelerator/conv_accelerator.v",
        dst="conv_accelerator_asic.v",
        why=(
            "MAC YOLU IKI EVREYE BOLUNDU (zamanlama).\n"
            "//\n"
            "//  SORUN: `acc[ci] <= acc[ci] + (ram_rdata - INPUT_ZP) * w_dout[...]`\n"
            "//  ifadesi bir SRAM okumasindan sonra 9x8 isaretli carpma VE 32-bit\n"
            "//  toplamayi TEK cevrimde yapiyor. FPGA'da bu yol DSP48E1 hard-makrolarina\n"
            "//  gidiyordu; SKY130'da standart hucre agacina donusuyor ve 20 ns'lik\n"
            "//  periyodu asiyor. Post-CTS olcumunde tasarimin butun setup ihlalleri\n"
            "//  (254 uc) tam olarak bu yollardaydi.\n"
            "//\n"
            "//  COZUM: carpim ile birikim ayri evrelere alindi --\n"
            "//     evre A (v_s2): prod[c]  <= (ram_rdata - INPUT_ZP) * w[c]\n"
            "//     evre B (v_s3): acc[c]   <= acc[c] + prod[c]\n"
            "//  Ayni islem FC birikimi icin de yapildi (f_prod / f_v3).\n"
            "//\n"
            "//  BIT-EXACT MI? Evet. Ara registerlar `signed [31:0]` olarak\n"
            "//  tanimlandi; orijinalde de ifade 32-bit LHS baglaminda\n"
            "//  degerlendiriliyordu, dolayisiyla kirpma davranisi ayni.\n"
            "//\n"
            "//  CEVRIM MALIYETI: boru hatti bir evre uzadigi icin bosaltma (drain)\n"
            "//  sayaclari 2'den 3 cevrime cikarildi. Cikarim basina toplam maliyet\n"
            "//  500 konvolusyon pozisyonu + 1 FC = +501 cevrim (45.517 -> 46.018,\n"
            "//  %1,1). Verim (tap basina 1 cevrim) DEGISMEDI."
        ),
        subs=[
            # 0) bias'lar: $readmemh ASIC akisinda SESSIZCE basarisiz oluyor
            ('        $readmemh("biases.hex",    biases);\n'
             '        $readmemh("fc_biases.hex", fc_biases);',
             bias_literals()),
            # 1) yeni evre registerlari
            ("    reg v_s1, v_s2;",
             "    reg v_s1, v_s2, v_s3, v_s2d;\n"
             "\n"
             "    // ASIC yamasi: carpim sonucunu tutan ara evre (bkz. dosya basi)\n"
             "    reg signed [31:0] prod [0:N_CH-1];\n"
             "\n"
             "    // ASIC yamasi -- SRAM CIKISI KAYIT KADEMESI (bkz. dosya basi)\n"
             "    reg  [7:0]  rd_q;            // ram_rdata'nin kayitli kopyasi\n"
             "    reg  [63:0] wd_q;            // ona hizali agirlik kelimesi"),
            ("    reg f_v1, f_v2;",
             "    reg f_v1, f_v2, f_v3, f_v2d;\n"
             "\n"
             "    // ASIC yamasi: FC carpim sonucunu tutan ara evre\n"
             "    reg signed [31:0] f_prod [0:N_CLASS-1];\n"
             "\n"
             "    // ASIC yamasi -- conv-buf SRAM cikisi kayit kademesi\n"
             "    reg  signed [7:0]  cb_q;     // cbuf_rdata'nin kayitli kopyasi\n"
             "    reg         [31:0] fcw_q;    // ona hizali FC agirlik kelimesi"),
            # 2) reset
            ("            v_s1 <= 0; v_s2 <= 0;\n"
             "            fc_idx <= 0; fc_drain <= 0; f_v1 <= 0; f_v2 <= 0;",
             "            v_s1 <= 0; v_s2 <= 0; v_s3 <= 0; v_s2d <= 0;   // ASIC yamasi\n"
             "            rd_q <= 0; wd_q <= 0; cb_q <= 0; fcw_q <= 0;   // ASIC yamasi\n"
             "            fc_idx <= 0; fc_drain <= 0; f_v1 <= 0; f_v2 <= 0; f_v3 <= 0; f_v2d <= 0;"),
            ("            for (ci = 0; ci < N_CH;    ci = ci + 1) wb_prod[ci]  <= 0;",
             "            for (ci = 0; ci < N_CH;    ci = ci + 1) wb_prod[ci]  <= 0;\n"
             "            for (ci = 0; ci < N_CH;    ci = ci + 1) prod[ci]     <= 0;   // ASIC yamasi\n"
             "            for (ci = 0; ci < N_CLASS; ci = ci + 1) f_prod[ci]   <= 0;   // ASIC yamasi"),
            # 3) konvolusyon MAC'i
            ("            v_s2 <= v_s1;\n"
             "            if (v_s2) begin\n"
             "                // (q_in - INPUT_ZP) * w,  INPUT_ZP=0 => ram_rdata dogrudan\n"
             "                for (ci = 0; ci < N_CH; ci = ci + 1)\n"
             "                    acc[ci] <= acc[ci] +\n"
             "                        ($signed({1'b0, ram_rdata}) - INPUT_ZP) * $signed(w_dout[8*ci +: 8]);\n"
             "            end",
             "            v_s2  <= v_s1;\n"
             "            v_s2d <= v_s2;                     // ASIC yamasi: SRAM kayit evresi\n"
             "            v_s3  <= v_s2d;                    // ASIC yamasi: birikim evresi\n"
             "\n"
             "            // ASIC yamasi -- evre A0: SRAM/ROM cikisini SADECE KAYDET.\n"
             "            //   SRAM dout'u dusen kenarda gecerli oldugu icin bu yakalama\n"
             "            //   penceresi T/2'dir; icinde yalnizca tel ve kurulum suresi\n"
             "            //   vardir, carpma YOKTUR.\n"
             "            if (v_s2) begin\n"
             "                rd_q <= ram_rdata;\n"
             "                wd_q <= w_dout;\n"
             "            end\n"
             "\n"
             "            // ASIC yamasi -- evre A: carpim (artik TAM cevrim butcesi var)\n"
             "            //   (q_in - INPUT_ZP) * w,  INPUT_ZP=0 => rd_q dogrudan\n"
             "            if (v_s2d) begin\n"
             "                for (ci = 0; ci < N_CH; ci = ci + 1)\n"
             "                    prod[ci] <=\n"
             "                        ($signed({1'b0, rd_q}) - INPUT_ZP) * $signed(wd_q[8*ci +: 8]);\n"
             "            end\n"
             "\n"
             "            // ASIC yamasi -- evre B: birikim\n"
             "            if (v_s3) begin\n"
             "                for (ci = 0; ci < N_CH; ci = ci + 1)\n"
             "                    acc[ci] <= acc[ci] + prod[ci];\n"
             "            end"),
            # 4) FC MAC'i
            ("            f_v2 <= f_v1;\n"
             "            if (f_v2) begin\n"
             "                // FC girisi conv cikisi; in_zp = C_OUT_ZP. (cbuf_rdata - C_OUT_ZP) * w\n"
             "                for (ci = 0; ci < N_CLASS; ci = ci + 1)\n"
             "                    fc_acc[ci] <= fc_acc[ci] +\n"
             "                        ($signed(cbuf_rdata) - C_OUT_ZP) * $signed(fcw_dout[8*ci +: 8]);\n"
             "            end",
             "            f_v2  <= f_v1;\n"
             "            f_v2d <= f_v2;                     // ASIC yamasi: SRAM kayit evresi\n"
             "            f_v3  <= f_v2d;                    // ASIC yamasi: birikim evresi\n"
             "\n"
             "            // ASIC yamasi -- evre A0: conv-buf SRAM cikisini SADECE KAYDET\n"
             "            if (f_v2) begin\n"
             "                cb_q  <= cbuf_rdata;\n"
             "                fcw_q <= fcw_dout;\n"
             "            end\n"
             "\n"
             "            // ASIC yamasi -- evre A: carpim (tam cevrim butcesi)\n"
             "            //   FC girisi conv cikisi; in_zp = C_OUT_ZP.\n"
             "            if (f_v2d) begin\n"
             "                for (ci = 0; ci < N_CLASS; ci = ci + 1)\n"
             "                    f_prod[ci] <=\n"
             "                        ($signed(cb_q) - C_OUT_ZP) * $signed(fcw_q[8*ci +: 8]);\n"
             "            end\n"
             "\n"
             "            // ASIC yamasi -- evre B: birikim\n"
             "            if (f_v3) begin\n"
             "                for (ci = 0; ci < N_CLASS; ci = ci + 1)\n"
             "                    fc_acc[ci] <= fc_acc[ci] + f_prod[ci];\n"
             "            end"),
            # 5) bosaltma sayaclari 2 -> 3 cevrim
            ("                    if (drain_cnt == 2'd1) state <= S_CONV_RQ;",
             "                    // ASIC yamasi: MAC iki evre uzadi, bosaltma 4 cevrim\n"
             "                    if (drain_cnt == 2'd3) state <= S_CONV_RQ;"),
            ("                    if (fc_drain == 2'd1) state <= S_FC_STORE;",
             "                    // ASIC yamasi: MAC iki evre uzadi, bosaltma 4 cevrim\n"
             "                    if (fc_drain == 2'd3) state <= S_FC_STORE;"),
        ],
    ),
]


BANNER = """// ===========================================================================
//  OTOMATIK URETILMIS YAMALI KOPYA -- ELLE DUZENLEME
//
//  Ureten : asic/scripts/patch_rtl.py
//  Kaynak : main_codes/rtl/desgin_sources/{src}
//  SHA256 : {sha256}
//
//  Orijinal dosyaya DOKUNULMAMISTIR. ASIC akisi (asic/filelist.f) orijinalin
//  yerine bu kopyayi kullanir; FPGA/Vivado akisi orijinali kullanmaya devam eder.
//
//  YAPILAN DEGISIKLIK: {why}
// ===========================================================================

"""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true",
                    help="uretilmis kopyalari kaynaklardan yeniden hesaplayip dogrula")
    args = ap.parse_args()
    if not args.check:
        DST.mkdir(parents=True, exist_ok=True)
    total = 0
    stale = []
    for p in PATCHES:
        src = SRC / p["src"]
        if not src.is_file():
            sys.exit(f"HATA: kaynak dosya yok: {src}")
        text = src.read_text()
        for sub in p["subs"]:
            old, new = sub[:2]
            expected_count = sub[2] if len(sub) == 3 else 1
            n = text.count(old)
            if n != expected_count:
                sys.exit(f"HATA: {p['src']} icinde yamanacak metin {n} kez geciyor "
                         f"({expected_count} bekleniyordu).\n      Ust akis dosyasi degismis olabilir.\n"
                         f"      Aranan: {old[:70]!r}")
            text = text.replace(old, new)
        source_hash = hashlib.sha256(src.read_bytes()).hexdigest()
        expected = BANNER.format(src=p["src"], sha256=source_hash, why=p["why"]) + text
        out = DST / p["dst"]
        if args.check:
            if not out.is_file() or out.read_text() != expected:
                stale.append(p["dst"])
        else:
            out.write_text(expected)
        action = "dogrulandi" if args.check else "uretildi"
        print(f"  {p['dst']:38s} <- {p['src']}  ({len(p['subs'])} degisiklik, {action})")
        total += len(p["subs"])
    if stale:
        sys.exit("HATA: bayat/eksik yamali RTL: " + ", ".join(stale) +
                 "\n      `make vendor` ile yeniden uretin.")
    print(f"  toplam {len(PATCHES)} dosya, {total} metin degisikligi")


if __name__ == "__main__":
    main()
