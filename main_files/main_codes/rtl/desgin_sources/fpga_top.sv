module fpga_top (
    input  logic sys_clk,       // 100 MHz osilatörü
    input  logic sys_rst_btn,   // active LOW

    input  logic UART_RX,
    output logic UART_TX,

    input  logic [15:0] GPIO_IDR_pins,  // 16 switch (Basys3'te 32 pin yok)
    output logic [15:0] GPIO_ODR_pins,  // 16 LED
    output logic [ 7:0] anode,
    output logic [ 7:0] catode,

    output logic I2C_SCL,
    inout  logic I2C_SDA,
    output logic QSPI_SCLK,
    output logic QSPI_CS,
    inout  logic QSPI_IO0,
    inout  logic QSPI_IO1,
    inout  logic QSPI_IO2,
    inout  logic QSPI_IO3
);

// ----------------------------------------------------------------
// 1. CLOCK: 100 MHz → 50 MHz
// ----------------------------------------------------------------
logic clk_50mhz;
logic clk_locked;

clk_wiz_0 clk_wizard_inst (
    .clk_in1  (sys_clk),      // 100 MHz giriş
    .clk_out1 (clk_50mhz),   // 50 MHz çıkış
    .locked   (clk_locked),
    .resetn   (1'b1)          // wizard'ı hiç sıfırlama, locked sinyali yeterli
);

// ----------------------------------------------------------------
// 2. RESET: ACTIVE-LOW CPU_RESETN (debounce'lu)
// ----------------------------------------------------------------
logic [15:0] btn_debounce_cnt;
logic        btn_stable;

always_ff @(posedge clk_50mhz) begin
    if (sys_rst_btn == btn_stable) begin
        btn_debounce_cnt <= '0;
    end else begin
        btn_debounce_cnt <= btn_debounce_cnt + 1'b1;
        if (btn_debounce_cnt == 16'hFFFF) btn_stable <= sys_rst_btn;
    end
end

logic rst_sync_0, rst_sync_1;
always_ff @(posedge clk_50mhz or negedge btn_stable) begin
    if (!btn_stable) begin
        rst_sync_0 <= 1'b0;
        rst_sync_1 <= 1'b0;
    end else begin
        rst_sync_0 <= clk_locked;
        rst_sync_1 <= rst_sync_0;
    end
end

logic rst_n;
assign rst_n = rst_sync_1;

// ----------------------------------------------------------------
// 3. GPIO: 32-bit port'u 16-bit Basys3 pinlerine uyarla
// ----------------------------------------------------------------
logic [31:0] gpio_idr_internal;
logic [31:0] gpio_odr_internal;
assign gpio_idr_internal = {16'h0, GPIO_IDR_pins};  // üst 16 bit sıfır
assign GPIO_ODR_pins     = gpio_odr_internal[15:0]; // alt 16 bit LED'e

// ----------------------------------------------------------------
// 4. SOC
// ----------------------------------------------------------------
logic        uart_yz_tx_nc;            // çıkış, nowhere

top_module soc_inst (
    .clk_i        (clk_50mhz),   // ← wizard çıkışı, ham kart saati değil!
    .rst_ni       (rst_n),        // ← senkronize + locked reset

    .GPIO_IDR     (gpio_idr_internal),
    .GPIO_ODR     (gpio_odr_internal),
    .anode        (anode),
    .catode       (catode),

    .UART_TX      (UART_TX),
    .UART_RX      (UART_RX),
    .I2C_SCL      (I2C_SCL),
    .I2C_SDA      (I2C_SDA),
    .QSPI_SCLK    (QSPI_SCLK),
    .QSPI_CS      (QSPI_CS),
    .QSPI_IO0     (QSPI_IO0),
    .QSPI_IO1     (QSPI_IO1),
    .QSPI_IO2     (QSPI_IO2),
    .QSPI_IO3     (QSPI_IO3)
);

endmodule