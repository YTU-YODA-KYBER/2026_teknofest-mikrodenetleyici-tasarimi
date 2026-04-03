
module GPIO_AXI4_Lite(

    // clock ve reset sinyalleri
    input wire clk_i,
    input wire rst_n,


    input [31:0] GPIO_IDR,
    output reg [31:0] GPIO_ODR,


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
    
    always@(posedge clk_i, negedge rst_n)begin
        if(!rst_n)begin
            GPIO_ODR <= 0;
        
            awready <= 1'b1;
            wready <= 1'b1;
            bresp <= 2'b00;
            bvalid <= 1'b0;
            arready <= 1'b1;
            rdata <= 32'h0000;
            rresp <= 2'b00;
            rvalid <= 1'b0;
        end
        else begin
        
            // ---------------------------------------------------------
            //                      AXI YAZMA İŞLEMİ
            // ---------------------------------------------------------
            if (awvalid && wvalid && awready && wready) begin
                awready <= 1'b0;
                wready  <= 1'b0;
                bvalid  <= 1'b1; 
                
                if (awaddr[3:0] == 4'h4)begin
                    GPIO_ODR <= {16'h0000,wdata[15:0]};
                    end
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
                
                case (araddr[3:0])
                    4'h0:  rdata[31:0] <= GPIO_IDR;
                    4'h4:  rdata[31:0] <= GPIO_ODR; 
                    default: rdata <= 32'd0;               
                endcase           
            end 
                else if (rvalid && rready) begin
                    rvalid  <= 1'b0;
                    arready <= 1'b1;
                end
        end//else       
    end//always bloğu
    
endmodule
