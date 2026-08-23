//=============================================================================
//  axil_seq_lib.svh  --  Butun bloklarda ortak dizi kutuphanesi
//
//  Diziler blok bilgisini DISARIDAN alir (base_addr + offsets kuyrugu), bu
//  sayede yedi blogun hepsinde ayni kod calisir. Blok bazinda degisen tek
//  sey testin doldurdugu ofset listeleridir.
//=============================================================================

//---- Tek islem: butun ust seviye dizilerin yapi tasi -------------------------
class axil_single_seq extends uvm_sequence #(axil_item);
    `uvm_object_utils(axil_single_seq)

    rand axil_kind_e  kind;
    rand bit [31:0]   addr;
    rand bit [31:0]   wdata;
    rand int unsigned gap;
    rand int unsigned beats;

    bit [31:0] rdata;   // dizi bittikten sonra okunur
    bit [1:0]  resp;

    constraint c_defaults { gap inside {[0:3]}; beats == 1; }

    function new(string name = "axil_single_seq");
        super.new(name);
    endfunction

    task body();
        axil_item it;
        it = axil_item::type_id::create("it");
        start_item(it);
        it.kind       = kind;
        it.addr       = addr;
        it.wdata      = wdata;
        it.gap        = gap;
        it.beats      = beats;
        finish_item(it);
        rdata = it.rdata;
        resp  = it.resp;
    endtask
endclass


//---- Ortak taban: ofset listesi tasiyan diziler ------------------------------
virtual class axil_map_seq extends uvm_sequence #(axil_item);

    bit [31:0] base_addr = 32'h0000_0000;
    bit [31:0] offsets[$];

    function new(string name = "axil_map_seq");
        super.new(name);
    endfunction

    // Tek islem yardimcisi
    task automatic do_op(axil_kind_e k, bit [31:0] off, bit [31:0] data,
                         int unsigned g = 1, int unsigned nb = 1,
                         output bit [31:0] rd);
        axil_single_seq s;
        s = axil_single_seq::type_id::create("op");
        s.kind  = k;
        s.addr  = base_addr + off;
        s.wdata = data;
        s.gap   = g;
        s.beats = nb;
        s.start(m_sequencer);
        rd = s.rdata;
    endtask
endclass


//---- Reset sonrasi butun haritali register'lari oku --------------------------
class axil_reset_seq extends axil_map_seq;
    `uvm_object_utils(axil_reset_seq)
    function new(string name = "axil_reset_seq"); super.new(name); endfunction

    task body();
        bit [31:0] rd;
        foreach (offsets[i]) do_op(AXIL_READ, offsets[i], 32'h0, 1, 1, rd);
    endtask
endclass


//---- Yuruyen-1 / yuruyen-0 bit tarama ---------------------------------------
class axil_bitwalk_seq extends axil_map_seq;
    `uvm_object_utils(axil_bitwalk_seq)
    function new(string name = "axil_bitwalk_seq"); super.new(name); endfunction

    task body();
        bit [31:0] rd;
        foreach (offsets[i]) begin
            for (int b = 0; b < 32; b++) begin
                do_op(AXIL_WRITE, offsets[i], (32'h1 << b), 1, 1, rd);
                do_op(AXIL_READ,  offsets[i], 32'h0,        1, 0, rd);
            end
            do_op(AXIL_WRITE, offsets[i], 32'h0000_0000, 1, 1, rd);
            do_op(AXIL_WRITE, offsets[i], 32'hFFFF_FFFF, 1, 1, rd);
            do_op(AXIL_READ,  offsets[i], 32'h0,         1, 0, rd);
        end
    endtask
endclass


//---- Salt-okunur register'lara yazma denemesi -------------------------------
class axil_ro_seq extends axil_map_seq;
    `uvm_object_utils(axil_ro_seq)
    function new(string name = "axil_ro_seq"); super.new(name); endfunction

    task body();
        bit [31:0] rd;
        foreach (offsets[i]) begin
            do_op(AXIL_READ,  offsets[i], 32'h0,         1, 0, rd);
            do_op(AXIL_WRITE, offsets[i], 32'hDEAD_BEEF, 1, 1, rd);
            do_op(AXIL_READ,  offsets[i], 32'h0,         1, 0, rd);
            do_op(AXIL_WRITE, offsets[i], 32'hFFFF_FFFF, 1, 1, rd);
            do_op(AXIL_READ,  offsets[i], 32'h0,         1, 0, rd);
        end
    endtask
endclass


//---- Haritalanmamis ofsetlere erisim ----------------------------------------
class axil_unmapped_seq extends axil_map_seq;
    `uvm_object_utils(axil_unmapped_seq)
    function new(string name = "axil_unmapped_seq"); super.new(name); endfunction

    task body();
        bit [31:0] rd;
        foreach (offsets[i]) begin
            do_op(AXIL_READ,  offsets[i], 32'h0,         1, 0, rd);
            do_op(AXIL_WRITE, offsets[i], 32'h5A5A_5A5A, 1, 1, rd);
            do_op(AXIL_READ,  offsets[i], 32'h0,         1, 0, rd);
        end
    endtask
endclass


//---- Kisitli rastgele trafik -------------------------------------------------
class axil_random_seq extends axil_map_seq;
    `uvm_object_utils(axil_random_seq)

    // n_items TEST tarafindan verilir; randomize() ile kisit catismasi
    // yasanmasin diye burada bir kisit TANIMLANMAZ.
    int unsigned n_items = 40;
    bit [31:0]   wr_offsets[$];   // yazilabilir ofsetler (bos ise hepsi)

    function new(string name = "axil_random_seq"); super.new(name); endfunction

    task body();
        axil_item  it;
        bit [31:0] off;
        repeat (n_items) begin
            it = axil_item::type_id::create("rnd");
            start_item(it);
            if (!it.randomize() with { beats == 1; })
                `uvm_error("RAND", "axil_item randomize basarisiz")
            if (it.kind == AXIL_WRITE && wr_offsets.size() > 0)
                off = wr_offsets[$urandom_range(0, wr_offsets.size()-1)];
            else
                off = offsets[$urandom_range(0, offsets.size()-1)];
            it.addr = base_addr + off;
            finish_item(it);
        end
    endtask
endclass


//---- Stres: bosluksuz ve VALID'i el sikismadan sonra tutan trafik ------------
//
//  beats > 1 AXI'de tamamen yasaldir: master VALID'i indirmeden ayni
//  yukseltme uzerinde ikinci bir islem sunar (boru hatli bir CPU/DMA
//  master'inin kuyrugu doluyken yaptigi sey). Kabul kosulunu kendi
//  *ready'siyle nitelemeyen bir slave burada KILITLENIR; bu dizinin amaci
//  tam olarak o sinifi bulmaktir.
class axil_stress_seq extends axil_map_seq;
    `uvm_object_utils(axil_stress_seq)

    int unsigned n_items = 12;
    int unsigned beats   = 2;   // ayni VALID uzerinde 2 islem

    function new(string name = "axil_stress_seq"); super.new(name); endfunction

    task body();
        bit [31:0] rd;
        for (int i = 0; i < n_items; i++) begin
            do_op((i % 2) ? AXIL_READ : AXIL_WRITE,
                  offsets[i % offsets.size()],
                  32'h0000_1234 + i, 0, beats, rd);
        end
    endtask
endclass
