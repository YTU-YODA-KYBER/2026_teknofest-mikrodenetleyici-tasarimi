module boot_rom #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10,
    parameter INIT_FILE  = "boot_code.mem"
)(
    input  logic                  clk,

    input  logic [ADDR_WIDTH-1:0] addr_a,
    output logic [DATA_WIDTH-1:0] rdata_a,

    input  logic [ADDR_WIDTH-1:0] addr_b,
    output logic [DATA_WIDTH-1:0] rdata_b
);

    localparam int DEPTH = 1 << ADDR_WIDTH;

    (* rom_style = "block" *)
    logic [DATA_WIDTH-1:0] rom [0:DEPTH-1];

    initial begin
        // $readmemh yalnizca hex dosyasindaki kelimeleri doldurur; ROM'un geri
        // kalani simulasyonda X olarak kalir. CV32E40P prefetch buffer'i son
        // gecerli komuttan sonra da spekulatif getirme yaptigi icin bu X'ler
        // AXI okuma kanalina cikip XCK_07 ihlaline yol aciyordu. Gercek
        // donanimda BRAM icerigi konfigurasyon sonrasi 0'dir; modeli esitliyoruz.
        for (int i = 0; i < DEPTH; i++) rom[i] = '0;
        $readmemh(INIT_FILE, rom);
    end

    always_ff @(posedge clk) begin
        rdata_a <= rom[addr_a];
        rdata_b <= rom[addr_b];
    end

endmodule
