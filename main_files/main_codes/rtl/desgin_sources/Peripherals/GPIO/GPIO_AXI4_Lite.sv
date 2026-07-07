module GPIO_AXI4_Lite(

    // clock ve reset sinyalleri
    input logic clk_i,
    input logic rst_n,

    // GPIO I/O portları
    input  logic [31:0] GPIO_IDR,
    output logic [31:0] GPIO_ODR,

    // AW Portları
    input  logic [31:0] awaddr,
    input  logic        awvalid,
    output logic        awready,

    // WD Portları
    input  logic [31:0] wdata,
    input  logic        wvalid,
    output logic        wready,

    // B Portları
    output logic [ 1:0] bresp,
    output logic        bvalid,
    input  logic        bready,

    // AR Portları
    input  logic [31:0] araddr,
    input  logic        arvalid,
    output logic        arready,

    // R Portları
    input  logic        rready,
    output logic [31:0] rdata,
    output logic [ 1:0] rresp,
    output logic        rvalid,

    output logic        dma_enable_o,

    output logic [ 7:0] catode,
    output logic [ 7:0] anode
);

    logic [ 2:0] anode_select;
    logic [31:0] clk_div;
    logic [ 3:0] anim_select;
    logic        mode_select;


    always @(posedge clk_i or negedge rst_n) begin
        
        // ---------------------------------------------------------
        //                      RESET İŞLEMLERİ
        // ---------------------------------------------------------
        if(!rst_n)begin
            GPIO_ODR <= 0;
        
            bresp   <= 0;
            bvalid  <= 0;
            rdata   <= 0;
            rresp   <= 0;
            rvalid  <= 0;
            awready <= 1;
            wready  <= 1;
            arready <= 1;
        end
        else begin

            // ---------------------------------------------------------
            //                      AXI YAZMA İŞLEMİ
            // ---------------------------------------------------------

            if (awvalid && wvalid) begin
                awready <= 0;
                wready  <= 0;
                bvalid  <= 1; 
                
                if (awaddr[3:0] == 4'h4)begin
                    GPIO_ODR <= {16'h0000,wdata[15:0]};
                    end
            end 
            else if (bvalid && bready) begin
                awready <= 1;
                wready  <= 1;
                bvalid  <= 0;
            end


            // ---------------------------------------------------------
            //                  AXI OKUMA İŞLEMİ
            // ---------------------------------------------------------
            if (arvalid) begin
                arready <= 0;
                rvalid  <= 1;
                
                case (araddr[3:0])
                    4'h0:  rdata[31:0] <= GPIO_IDR;
                    4'h4:  rdata[31:0] <= GPIO_ODR; 
                endcase  
            end 
            else if (rvalid && rready) begin
                arready <= 1;
                rvalid  <= 0;
            end

            if(GPIO_IDR[1] == 1'b1)begin
                dma_enable_o <= 1'b1;
            end
            else begin
                dma_enable_o <= 1'b0;
            end

        end
    end  
    

    always@(*) begin
        anode = 8'b1111_1111;
        anode[anode_select] = 1'b0;
    end

    always @(posedge clk_i or negedge rst_n) begin

        if(!rst_n) begin
            clk_div <= 0;
            catode  <= 8'b1111_1111;
            anode_select  <= 0;
            anim_select   <= 0;
            mode_select   <= 0;
        end
        else begin

            if(clk_div[10:0] == 0) begin
                mode_select <= ~mode_select;

                if(anode_select == 7) anode_select <= 0;
                else anode_select <= anode_select +1;
            end

            if (clk_div == 0) begin
                clk_div <= 32'd5_000_000;
                if(anim_select == 7) anim_select <= 0;
                else anim_select <= anim_select +1;
            end
            else clk_div <= clk_div -1;

            if((GPIO_IDR == 1 && GPIO_ODR[2:0]) || GPIO_IDR == 2)begin
                case(anode_select)
                    0: begin
                        case(anim_select)
                            0:  catode <= 8'b0111_0001;
                            1:  catode <= 8'b0111_0011;
                            2:  catode <= 8'b0111_0111;
                            5:  catode <= 8'b1111_1110;
                            6:  catode <= 8'b1111_1100;
                            7:  catode <= 8'b1111_1000;
                            default: catode <= 8'b1111_1111;
                        endcase
                    end

                    1: begin
                        case(anim_select)
                            1: catode <= 8'b0111_0111;
                            2: catode <= 8'b0110_0111;
                            3: catode <= 8'b0100_0111;
                            4: catode <= 8'b1100_1110;
                            5: catode <= 8'b1101_1110;
                            6: catode <= 8'b1111_1110;
                            default: catode <= 8'b1111_1111;
                        endcase
                    end
                endcase

                case(GPIO_IDR[1:0])
                    1: begin
                        case(GPIO_ODR)
                            1: begin
                                case(anode_select)              //ERASE
                                    2: catode <= 8'b1111_1111;
                                    3: catode <= 8'b1000_0110;
                                    4: catode <= 8'b1001_0010;
                                    5: catode <= 8'b1000_1000;
                                    6: catode <= 8'b1100_1110;
                                    7: catode <= 8'b1000_0110;
                                endcase
                            end

                            2: begin
                                case(anode_select)              //SNDING
                                    2: catode <= 8'b1001_0000;
                                    3: catode <= 8'b1100_1000;
                                    4: catode <= 8'b1111_1001;
                                    5: catode <= 8'b1010_0001;
                                    6: catode <= 8'b1100_1000;
                                    7: catode <= 8'b1001_0010;
                                endcase
                            end
                        
                            3: begin
                                case(anode_select)              //FINISH
                                    2: catode <= 8'b1000_1001;
                                    3: catode <= 8'b1001_0010;
                                    4: catode <= 8'b1111_1001;
                                    5: catode <= 8'b1100_1000;
                                    6: catode <= 8'b1111_1001;
                                    7: catode <= 8'b1000_0111;
                                endcase
                            end

                            4: begin
                                case(anode_select)              //ERROR
                                    2: catode <= 8'b1111_1111;
                                    3: catode <= 8'b1100_1110;
                                    4: catode <= 8'b1100_0000;
                                    5: catode <= 8'b1100_1110;
                                    6: catode <= 8'b1100_1110;
                                    7: catode <= 8'b1000_0110;
                                endcase
                            end
                            default: begin
                                case(anode_select)              //BOOT
                                    2: catode <= 8'b1111_1111;
                                    3: catode <= 8'b1111_1111;
                                    4: catode <= 8'b1000_0111;
                                    5: catode <= 8'b1100_0000;
                                    6: catode <= 8'b1100_0000;
                                    7: catode <= 8'b1000_0011;
                                endcase
                            end
                        endcase
                    end
                    2: begin
                        case(anode_select)                      //YZUART
                            2: catode <= 8'b1000_0111;
                            3: catode <= 8'b1100_1110;
                            4: catode <= 8'b1000_1000;
                            5: catode <= 8'b1100_0001;
                            6: catode <= 8'b1010_0100;
                            7: catode <= 8'b1001_0001;
                       endcase
                    end
                endcase
            end else catode  <= 8'b1111_1111;
        end
    end

endmodule
