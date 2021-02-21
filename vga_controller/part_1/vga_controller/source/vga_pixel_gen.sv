`include "vga_parameters.svh"

module vga_pixel_gen(
    input   rst,
    input   clk,
    input   gray_enable,
    input   [15:0] h_counter,
    input   [15:0] v_counter,

    output   [7:0] green,
    output   [7:0] blue,
    output   [7:0] red
);

`include "vga_parameters.svh"

logic   [7:0]   r;
logic   [7:0]   g;
logic   [7:0]   b;

assign  red     = r;
assign  green   = g;
assign  blue    = b;

initial begin
    r = 0;
    g = 0;
    b = 0;
end

always @(*) begin //simple pixel buffer driver for all three colors
    if(rst || h_counter > H_ACTIVE_PIXEL_COUNT || v_counter > V_ACTIVE_LINE_COUNT) begin //check if in current display area
        g <= 0;
        r <= 0;
        b <= 0;
    end
    else
        if(gray_enable) begin //Display gray color bars
            r <= h_counter & 8'b1110_0000;
            g <= h_counter & 8'b1110_0000;
            b <= h_counter & 8'b1110_0000;
        end
        else begin  //display color bars
            if(h_counter & 128)
                r <= 8'hFF;
            else
                r <= 8'b0;
            if(h_counter & 32)
                g <= 8'hFF;
            else
                g <= 8'b0;
            if(h_counter & 64)
                b <= 8'hFF;
            else
                b <= 8'b0;
        end 
end

endmodule