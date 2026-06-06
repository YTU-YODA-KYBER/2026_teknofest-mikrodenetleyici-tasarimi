// Add your memory initialization code here.

initial begin
    $readmemh("helloworld.mem", dut.CPU.boot_rom_ctrl_inst.boot_rom.rom);

    // DATARAM'ı sıfırla — X propagation'ı önlemek için
    for (int i = 0; i < 2048; i++)
        dut.CPU.data_bram_ctrl_inst.data_ram.ram[i] = 32'h0;  // kendi hiyerarşi yolunu kullan
end

// You MUST KEEP "helloworld.mem" file constant, since it will be automatically
// added to the Vivado project, you should only change boot ROM memory array path.
// Also you can add processes needed for your system to boot
