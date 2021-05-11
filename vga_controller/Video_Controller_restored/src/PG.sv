module PG (
    input       [11:0] dx,
    input       [11:0] dy,
    input              VGA_CLK,
    input              a_reset,
    input        [3:0] KEY,
    input        [31:0]fifo_data,
    input           ready,
    input           valid,         
    output logic       VGA_BLANK_N,
    output logic [7:0] VGA_B,
    output logic [7:0] VGA_R,
    output logic [7:0] VGA_G
);
`include "parameters.vh"

assign VGA_BLANK_N = HIGH;




always @(VGA_CLK) 
    if(dx > H_ACTIVE || dy > V_ACTIVE && !ready) begin
        VGA_B <=0;
        VGA_G <=0;
        VGA_R <=0;
    end
    else begin
        {VGA_R,VGA_G,VGA_B} = fifo_data[23:0];
    end





// output to VGA conenctor
// set syn to 1 or 0
// horizontal counteer value or 0-1/4 of way across and set RGB     

endmodule