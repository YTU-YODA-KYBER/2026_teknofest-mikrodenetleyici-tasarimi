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
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parents[2]
SRC = ROOT / "FPGA/main_codes/rtl/desgin_sources"
DST = ROOT / "asic_rtl/patched"

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


PATCHES = [
    # --- (c) ucuncu taraf: obi_to_axi -----------------------------------
    dict(
        src="CPU/openhw_obi_to_axi/obi_to_axi.sv",
        dst="obi_to_axi_asic.sv",
        why=(
            "IKI DUZELTME.\n"
            "//\n"
            "//  1) SIFIR GENISLIKLI PARCA-SECIM\n"
            "//     AxiDataWidth == ObiCfg.DataWidth (bu tasarimda ikisi de 32) iken\n"
            "//     $clog2(AxiDataWidth/ObiCfg.DataWidth) = $clog2(1) = 0 olur; sifir\n"
            "//     genislikli parca-secim SystemVerilog'da gecersizdir (LRM 11.5.1).\n"
            "//     Vivado hos goruyor, tam bir SV on ucu olan slang hata veriyor.\n"
            "//     Ilgili `if` dali bu yapilandirmada HIC alinmadigi icin genislik\n"
            "//     ifadesi en az 1 olacak sekilde sarmalanmistir.\n"
            "//\n"
            "//  2) SURULMEYEN obi_rsp_o.r.r_optional\n"
            "//     Bu alan yalnizca UseAtop / RUserWidth generate dallarinda\n"
            "//     suruluyor; ikisi de kapali oldugu icin hicbir surucusu yoktu.\n"
            "//     Kapali durum icin acik bir `else` dali eklendi."
        ),
        subs=[
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
    resp_patch("Memory/Instrurction_RAM_AXI4-Lite_Wrapper/instr_bram_axi_ctrl.sv",
               "instr_bram_axi_ctrl_asic.sv",
               ["axi_instr_bram_rresp"],
               ["        axi_instr_bram_rresp      <= 0;\n"]),
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
            # 1) yeni evre registerlari
            ("    reg v_s1, v_s2;",
             "    reg v_s1, v_s2, v_s3;\n"
             "\n"
             "    // ASIC yamasi: carpim sonucunu tutan ara evre (bkz. dosya basi)\n"
             "    reg signed [31:0] prod [0:N_CH-1];"),
            ("    reg f_v1, f_v2;",
             "    reg f_v1, f_v2, f_v3;\n"
             "\n"
             "    // ASIC yamasi: FC carpim sonucunu tutan ara evre\n"
             "    reg signed [31:0] f_prod [0:N_CLASS-1];"),
            # 2) reset
            ("            v_s1 <= 0; v_s2 <= 0;\n"
             "            fc_idx <= 0; fc_drain <= 0; f_v1 <= 0; f_v2 <= 0;",
             "            v_s1 <= 0; v_s2 <= 0; v_s3 <= 0;   // ASIC yamasi: v_s3\n"
             "            fc_idx <= 0; fc_drain <= 0; f_v1 <= 0; f_v2 <= 0; f_v3 <= 0;"),
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
             "            v_s2 <= v_s1;\n"
             "            v_s3 <= v_s2;                      // ASIC yamasi: yeni evre\n"
             "\n"
             "            // ASIC yamasi -- evre A: yalnizca carpim (kayitli)\n"
             "            //   (q_in - INPUT_ZP) * w,  INPUT_ZP=0 => ram_rdata dogrudan\n"
             "            if (v_s2) begin\n"
             "                for (ci = 0; ci < N_CH; ci = ci + 1)\n"
             "                    prod[ci] <=\n"
             "                        ($signed({1'b0, ram_rdata}) - INPUT_ZP) * $signed(w_dout[8*ci +: 8]);\n"
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
             "            f_v2 <= f_v1;\n"
             "            f_v3 <= f_v2;                      // ASIC yamasi: yeni evre\n"
             "\n"
             "            // ASIC yamasi -- evre A: yalnizca carpim (kayitli)\n"
             "            //   FC girisi conv cikisi; in_zp = C_OUT_ZP.\n"
             "            if (f_v2) begin\n"
             "                for (ci = 0; ci < N_CLASS; ci = ci + 1)\n"
             "                    f_prod[ci] <=\n"
             "                        ($signed(cbuf_rdata) - C_OUT_ZP) * $signed(fcw_dout[8*ci +: 8]);\n"
             "            end\n"
             "\n"
             "            // ASIC yamasi -- evre B: birikim\n"
             "            if (f_v3) begin\n"
             "                for (ci = 0; ci < N_CLASS; ci = ci + 1)\n"
             "                    fc_acc[ci] <= fc_acc[ci] + f_prod[ci];\n"
             "            end"),
            # 5) bosaltma sayaclari 2 -> 3 cevrim
            ("                    if (drain_cnt == 2'd1) state <= S_CONV_RQ;",
             "                    // ASIC yamasi: MAC bir evre uzadi, bosaltma 3 cevrim\n"
             "                    if (drain_cnt == 2'd2) state <= S_CONV_RQ;"),
            ("                    if (fc_drain == 2'd1) state <= S_FC_STORE;",
             "                    // ASIC yamasi: MAC bir evre uzadi, bosaltma 3 cevrim\n"
             "                    if (fc_drain == 2'd2) state <= S_FC_STORE;"),
        ],
    ),
]


BANNER = """// ===========================================================================
//  OTOMATIK URETILMIS YAMALI KOPYA -- ELLE DUZENLEME
//
//  Ureten : asic/scripts/patch_rtl.py
//  Kaynak : main_codes/rtl/desgin_sources/{src}
//
//  Orijinal dosyaya DOKUNULMAMISTIR. ASIC akisi (asic/filelist.f) orijinalin
//  yerine bu kopyayi kullanir; FPGA/Vivado akisi orijinali kullanmaya devam eder.
//
//  YAPILAN DEGISIKLIK: {why}
// ===========================================================================

"""


def main():
    DST.mkdir(parents=True, exist_ok=True)
    total = 0
    for p in PATCHES:
        src = SRC / p["src"]
        if not src.is_file():
            sys.exit(f"HATA: kaynak dosya yok: {src}")
        text = src.read_text()
        for old, new in p["subs"]:
            n = text.count(old)
            if n != 1:
                sys.exit(f"HATA: {p['src']} icinde yamanacak metin {n} kez geciyor "
                         f"(1 bekleniyordu).\n      Ust akis dosyasi degismis olabilir.\n"
                         f"      Aranan: {old[:70]!r}")
            text = text.replace(old, new)
        (DST / p["dst"]).write_text(BANNER.format(src=p["src"], why=p["why"]) + text)
        print(f"  {p['dst']:38s} <- {p['src']}  ({len(p['subs'])} degisiklik)")
        total += len(p["subs"])
    print(f"  toplam {len(PATCHES)} dosya, {total} metin degisikligi")


if __name__ == "__main__":
    main()
