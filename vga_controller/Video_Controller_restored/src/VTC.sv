
module VTC (
    input       VGA_CLK,
    input       a_reset,
    output   logic   VGA_VS,
    output   logic   VGA_HS,
    output   logic   [11:0]dx,
    output   logic  [11:0]dy
);
`include "parameters.vh"

always @(posedge VGA_CLK) begin
    if(!a_reset) begin
        dx <= 0;
        dy <= 0;        
    end
    else if(dx<H_BACK) begin
        dx <= dx + 1;
       
    end
    else if(dx == (H_BACK) ) begin
        dx <= 0;
        if(dy<V_BACK)
            begin
                dy <= dy + 1;
            end
        else begin
             dy <= 0;
        end
    end
   

     if( !(dx >H_FRONT && dx <= H_SYNC) )begin
            VGA_HS <=LOW;
        end
        else begin
            VGA_HS <=HIGH;
        end
    if( !(dy > V_FRONT && dy <= V_SYNC) )begin
            VGA_VS <=LOW;
        end
        else begin
            VGA_VS <=HIGH;
        end
end
endmodule