module Timer_module(
    // clock ve reset sinyalleri
    input wire clk,
    input wire rst_n,

    // WRITE ADRESS kanalları
    input wire [31:0] awaddr,
    input wire awvalid,
    output reg awready,

    // WRITE DATA kanalları
    input wire [31:0] wdata,
    input wire wvalid,
    output reg wready,

    // WRITE RESPONSE kanalları
    output reg [1:0] bresp,
    output reg bvalid,
    input wire bready,

    // READ ADRESS kanalları
    input wire [31:0] araddr,
    input wire arvalid,
    output reg arready,

    // READ DATA kanalları
    input wire rready,
    output reg [31:0] rdata,
    output reg [1:0] rresp,
    output reg rvalid
);
    
    // REGISTER TANIMLARI
    reg [31:0] TIM_PRE;
    reg [31:0] TIM_PRE_m;
    reg [31:0] TIM_ARE;
    reg [31:0] TIM_CLR;
    reg [31:0] TIM_ENA;
    reg [31:0] TIM_MOD;
    reg [31:0] TIM_CNT;
    reg [31:0] TIM_EVN;
    reg [31:0] TIM_EVC;


    always @(posedge clk or negedge rst_n) begin
        
        // ---------------------------------------------------------
        //                      RESET İŞLEMLERİ
        // ---------------------------------------------------------
        if (!rst_n) begin
            TIM_PRE   <= 32'h00000000;
            TIM_PRE_m <= 32'h00000000;
            TIM_ARE   <= 32'h00000000;
            TIM_CLR   <= 32'h00000000;
            TIM_ENA   <= 32'h00000000;
            TIM_MOD   <= 32'h00000000;
            TIM_CNT   <= 32'h00000000;
            TIM_EVN   <= 32'h00000000;
            TIM_EVC   <= 32'h00000000;
            
            awready <= 1'b1;
            wready  <= 1'b1;
            bresp   <= 2'b00;
            bvalid  <= 1'b0;
            
            arready <= 1'b1;
            rdata   <= 32'h00000000;
            rresp   <= 2'b00;
            rvalid  <= 1'b0;
        end 
        else begin

            // ---------------------------------------------------------
            //                      AXI YAZMA İŞLEMİ
            // ---------------------------------------------------------

            if (awvalid && wvalid && awready && wready) begin
                awready <= 1'b0;
                wready  <= 1'b0;
                bvalid  <= 1'b1; 
                
                case (awaddr[7:0])
                    8'h00: TIM_PRE_m <= wdata;
                    8'h04: TIM_ARE   <= wdata;
                    8'h08: TIM_CLR   <= wdata;
                    8'h0C: TIM_ENA   <= wdata;
                    8'h10: TIM_MOD   <= wdata;
                    8'h1C: TIM_EVC   <= wdata;
                    default: ;
                endcase
            end 
 
            else if (bvalid && bready) begin
                bvalid  <= 1'b0;
                awready <= 1'b1;
                wready  <= 1'b1;
            end

            // ---------------------------------------------------------
            //                  AXI OKUMA İŞLEMİ
            // ---------------------------------------------------------
            if (arvalid && arready) begin
                arready <= 1'b0;
                rvalid  <= 1'b1;
                
                case (araddr[7:0])
                    8'h00: rdata <= TIM_PRE_m;
                    8'h04: rdata <= TIM_ARE;
                    8'h08: rdata <= TIM_CLR;
                    8'h0C: rdata <= TIM_ENA;
                    8'h10: rdata <= TIM_MOD;
                    8'h14: rdata <= TIM_CNT;
                    8'h18: rdata <= TIM_EVN;
                    8'h1C: rdata <= TIM_EVC;
                    default: rdata <= 32'h00000000;
                endcase
            end 
            else if (rvalid && rready) begin
                rvalid  <= 1'b0;
                arready <= 1'b1;
            end

            // ---------------------------------------------------------
            //                      TIMER ÇEKİRDEĞİ
            // ---------------------------------------------------------
            if (TIM_CLR != 0) begin 
                TIM_CNT <= 32'h00000000;
                TIM_PRE <= TIM_PRE_m;
                TIM_CLR <= 32'h00000000; // Sayacı sıfırla ve komutu temizle
            end 
            else if (TIM_ENA != 0) begin
                
                if (TIM_EVC != 0) begin                   
                    TIM_EVN <= 32'h00000000;
                    TIM_EVC <= 32'h00000000; // Eventi sıfırla ve komutu temizle
                end
                
                // Sayma İşlemleri
                if (TIM_PRE == 0) begin 
                    TIM_PRE <= TIM_PRE_m;
    
                    case (TIM_MOD)
                        32'h00000001: begin // Yukarı Sayıcı
                            if (TIM_CNT >= TIM_ARE) begin 
                                TIM_EVN <= TIM_EVN + 1;
                                TIM_CNT <= 32'h00000000;
                            end else begin 
                                TIM_CNT <= TIM_CNT + 1;
                            end
                        end
                        32'h00000000: begin // Aşağı Sayıcı
                            if (TIM_CNT == 0) begin 
                                TIM_CNT <= TIM_ARE;
                                TIM_EVN <= TIM_EVN + 1;
                            end else begin 
                                TIM_CNT <= TIM_CNT - 1;
                            end
                        end
                        default: ;
                    endcase
                end else begin 
                    TIM_PRE <= TIM_PRE - 1;
                end
            end

        end//else
    end//always bloğu            

endmodule