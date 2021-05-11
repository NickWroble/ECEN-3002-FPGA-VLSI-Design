module vga_pixel_gen(
    input       [11:0]  h_counter,
    input       [11:0]  v_counter,
    input               clk,
    input               rst,
    input       [31:0]  fifo_data,
    input               ready,
    output logic [7:0]  VGA_B,
    output logic [7:0]  VGA_R,
    output logic [7:0]  VGA_G
);
`include "vga_parameters.svh"

always @(posedge clk) 
    if(h_counter > H_ACTIVE_PIXEL_COUNT || v_counter > V_ACTIVE_LINE_COUNT && !ready) begin
        VGA_B <=0;
        VGA_G <=0;
        VGA_R <=0;
    end
    else begin
        {VGA_R,VGA_G,VGA_B} = fifo_data[23:0];
    end

endmodule