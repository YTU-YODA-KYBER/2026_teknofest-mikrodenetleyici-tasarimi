//=============================================================================
//  axil_coverage.svh  --  Fonksiyonel kapsam toplayici (butun bloklar icin)
//
//  DIKKAT -- coverpoint'ler covergroup'un KENDI sample argumanlarina bakar,
//  kapsayan sinifin uyesine DEGIL. Sinif uyesine bakan bir coverpoint
//  su uyariyla SESSIZCE ATILIR:
//     "Unsupported: 'covergroup' coverpoint referencing enclosing class
//      member; ignoring covergroup"
//  Kapsam raporunda covergroup hic gorunmez, sebebi de belli olmaz.
//
//  SLVERR / DECERR bin'leri BILEREK tanimlanmistir ve hicbir zaman dolmaz:
//  tasarimdaki slave'lerin hicbiri hata cevabi uretmiyor (bresp/rresp sabit
//  OKAY). Rapor bunlari "erisilemez" olarak isaretler; kapsam yuzdesini
//  yapay olarak dusurmelerine izin verilmez.
//=============================================================================
class axil_coverage extends uvm_subscriber #(axil_item);
    `uvm_component_utils(axil_coverage)

    covergroup cg_axil with function sample (
        bit          kind,
        bit [7:0]    offset,
        bit [1:0]    resp,
        int unsigned gap,
        bit [31:0]   wdata
    );
        option.per_instance = 1;

        cp_kind : coverpoint kind {
            bins okuma = { 1'b0 };
            bins yazma = { 1'b1 };
        }
        cp_offset : coverpoint offset {
            bins ofs_00    = { 8'h00 };
            bins ofs_04    = { 8'h04 };
            bins ofs_08    = { 8'h08 };
            bins ofs_0C    = { 8'h0C };
            bins ofs_10    = { 8'h10 };
            bins ofs_14    = { 8'h14 };
            bins ofs_18    = { 8'h18 };
            bins ofs_1C    = { 8'h1C };
            bins haritasiz = default;
        }
        cp_resp : coverpoint resp {
            bins okay   = { 2'b00 };
            bins slverr = { 2'b10 };   // ERISILEMEZ
            bins decerr = { 2'b11 };   // ERISILEMEZ
        }
        cp_gap : coverpoint gap {
            bins bitisik = { [0:1]  };
            bins kisa    = { [2:3]  };
            bins orta    = { [4:6]  };
            bins uzun    = { [7:64] };
        }
        cp_wdata : coverpoint wdata {
            bins sifir  = { 32'h0000_0000 };
            bins tumbir = { 32'hFFFF_FFFF };
            bins digeri = default;
        }
        x_kind_offset : cross cp_kind, cp_offset;
    endgroup

    function new(string name, uvm_component parent);
        super.new(name, parent);
        cg_axil = new();
    endfunction

    function void write(axil_item t);
        cg_axil.sample(bit'(t.kind), t.addr[7:0], t.resp, t.gap, t.wdata);
    endfunction
endclass
