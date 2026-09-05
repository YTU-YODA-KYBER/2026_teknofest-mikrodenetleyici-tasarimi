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

    // TX: MUX DEGIL -- her modda GENEL UART surer.
    //
    // NEDEN DEGISTI (sartname Bolum 4.2.2 madde 5):
    //   "CPU kesme servisi (ISR) ile sonucu alip GENEL UART uzerinden
    //    yazdiracaktir."
    //   Onceki 2:1 mux, YZ modunda (GPIO_IDR[1:0]==2) fiziksel TX pinini
    //   UART_YZ_TX'e baglıyordu. Sonuc: genel UART'a yazilan bayt karttan
    //   hic cikmiyordu ve firmware sonucu UART_YZ'den basmak zorunda
    //   kaliyordu (FPGA/firmware/main_app.c yz_putc) -- yani sartnamenin
    //   acikca istedigi yol fiziksel olarak kapaliydi.
    //
    // NEDEN GUVENLI:
    //   YZ arayuzu TEK YONLUDUR. Host 1960 baytlik ses ozniteligini cipe
    //   GONDERIR; bu baytlar UART_RX'ten gelir ve donanimda DMA ile YZ RAM'e
    //   yazilir. UART_YZ'nin GONDERECEGI bir sey yoktur -- tasarimda
    //   UART_YZ_TX'i tuketen tek yer bu mux'ti. Yani TX tarafinda gercekte
    //   TEK surucu vardir ve mux gereksizdir.
    //
    //   Idle davranisi da korunur: UART_GU'nun tx cikisi reset'te 1
    //   (UART_GU_AXI4-Lite.sv:164) ve cerceve disinda 1'dir (:233), yani
    //   eski daldaki acik `1'b1` idle degeri kendiliginden saglanir.
    //
    //   TX ve RX ayri fiziksel pinlerdir (full-duplex): host veri
    //   gonderirken cipin sonucu basmasi cakisma yaratmaz.
    //
    // UART_YZ_TX portu ARAYUZ KARARLILIGI icin korunmustur (Top_module
    // baglantisi degismesin diye); bilerek kullanilmamaktadir.
    assign UART_TX = UART_GU_TX;

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
