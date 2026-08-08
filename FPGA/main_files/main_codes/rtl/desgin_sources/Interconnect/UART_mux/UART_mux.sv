module uart_mux (
    input  logic [31:0] GPIO_IDR,

    // fiziksel pinler (XDC bunlara baglanacak)
    output logic UART_TX,
    input  logic UART_RX,

    // GU baglanti
    input  logic UART_GU_TX,
    output logic UART_GU_RX,

    // YZ baglanti
    input  logic UART_YZ_TX,
    output logic UART_YZ_RX
);

    // TX: gercek 2:1 mux sart (tek fiziksel pin, iki olasi surucu)
    assign UART_TX = (GPIO_IDR[1:0] == 2'd1) ? UART_GU_TX :
                      (GPIO_IDR[1:0] == 2'd2) ? UART_YZ_TX :
                                                 1'b1;        // idle-high (bos/beklenmedik durum)

    // RX: mux DEGIL, fan-out. Tek kaynak, iki hedefe kopyalanir -- cakisma yok.
    //
    // Genel UART HER MODDA dinler. Sebebi: YZ modunda gelen ses verisi
    // donanim tarafinda DMA ile YZ RAM'e yaziliyor ama YZ RAM'in CPU
    // portu yok. Yazilim gerceklemesinin AYNI 1960 bayti gorebilmesi icin
    // CPU'nun bu baytlari genel UART'tan okumasi gerekiyor. Boylece tek
    // gonderim iki yolu birden besler -- yazilim ile donanim garantili
    // ayni ornegi isler. Baytlari okumak yazilimin tercihidir; okumayan
    // uygulamalar (main_app.c, main_boot.c) bu degisiklikten etkilenmez.
    assign UART_GU_RX = UART_RX;
    // YZ tarafi degismedi: GU modunda DMA'ya cop bayt gitmemeli.
    assign UART_YZ_RX = (GPIO_IDR[1:0] == 2'd2) ? UART_RX : 1;

endmodule
