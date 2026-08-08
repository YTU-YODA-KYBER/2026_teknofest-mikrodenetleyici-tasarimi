//=============================================================================
//  axi_chk_pkg.sv  --  AXI protokol kontrolcusu global sayac / raporlama paketi
//
//  YTU YODA KYBER  |  TEKNOFEST 2026 Cip Tasarim Yarismasi
//
//  AMAC:
//    Tasarimdaki TUM AXI4-Lite arayuzlerine 'bind' ile baglanan protokol
//    kontrolculerinin ihlal sayaclarini tek merkezde toplar. Testbench,
//    simulasyon sonunda axi_chk_pkg::final_report() cagirarak tek satirlik
//    ozet alir ve ihlal varsa $fatal ile cikar.
//
//  KULLANIM (testbench sonunda):
//      if (axi_chk_pkg::final_report() != 0)
//          $fatal(1, "AXI protokol ihlali tespit edildi.");
//      $finish;
//=============================================================================
`timescale 1ns / 1ps

`ifndef AXI_CHK_PKG_SV
`define AXI_CHK_PKG_SV

package axi_chk_pkg;

    // ---- Global sayaclar (static, tum bind edilmis instance'lar paylasir) ----
    int unsigned g_error_count = 0;   // toplam protokol ihlali
    int unsigned g_check_count = 0;   // kosturulan checker instance sayisi
    int unsigned g_warn_count  = 0;   // uyari (stall watchdog vb.)

    // ---- Ihlal kaydi ----
    function automatic void bump_error();
        g_error_count = g_error_count + 1;
    endfunction

    function automatic void bump_warn();
        g_warn_count = g_warn_count + 1;
    endfunction

    function automatic void register_checker();
        g_check_count = g_check_count + 1;
    endfunction

    // ---- Simulasyon sonu ozet raporu ----
    //  Donus degeri: toplam ihlal sayisi (0 => temiz)
    function automatic int unsigned final_report();
        $display("");
        $display("======================================================================");
        $display("            AXI4-LITE PROTOKOL KONTROL OZETI");
        $display("======================================================================");
        $display("  Izlenen AXI arayuzu sayisi : %0d", g_check_count);
        $display("  Protokol ihlali            : %0d", g_error_count);
        $display("  Uyari (stall/watchdog)     : %0d", g_warn_count);
        if (g_error_count == 0)
            $display("  SONUC                      : GECTI  (0 ihlal)");
        else
            $display("  SONUC                      : KALDI  (%0d ihlal)", g_error_count);
        $display("======================================================================");
        $display("");
        return g_error_count;
    endfunction

endpackage : axi_chk_pkg

`endif
