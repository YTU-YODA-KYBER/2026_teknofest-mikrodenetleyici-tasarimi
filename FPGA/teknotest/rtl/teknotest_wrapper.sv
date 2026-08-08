module teknotest_wrapper(
    input clk_i, // Clock input
    input resetn_i, // Reset input (active low)

    input uart_rx_i, // UART RX Input (tb->dut)
    output uart_tx_o // UART TX Output (dut->tb)
);

top_module #(

.INIT_FILE_boot("helloworld.mem") // Boot kodunu Boot ROM'a yüklemek için gerekli bağlantıyı yapıyoruz

) CPU (
.clk_i(clk_i),
.rst_ni(resetn_i),
.UART_GU_rx(uart_rx_i),
.UART_GU_tx(uart_tx_o),


.interrupt_i(32'b0) // Interrupt sinyali için sıfır atıyoruz

);

endmodule;
