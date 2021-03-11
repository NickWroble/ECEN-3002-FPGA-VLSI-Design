module vga_pixel_gen_rom(
    input   rst,
    input   clk,
    input   [11:0] h_counter,
    input   [11:0] v_counter,

    output   [7:0] vga_r,
    output   [7:0] vga_g,
    output   [7:0] vga_b
);

`include "vga_parameters.svh"

logic   [15:0]   address;
logic   [23:0]  q;

logic   [8:0]   xpos; //max is 320
logic   [7:0]   ypos; // max is 180

logic   [7:0]   r;
logic   [7:0]   g;
logic   [7:0]   b;

assign  vga_r   = r;
assign  vga_g   = g;
assign  vga_b   = b;

initial begin
    address = 0;
    xpos    = 0;
    ypos    = 0;
    r       = 0;
    g       = 0;
    b       = 0;
end

image get_image(
    .*
);

always @(*) begin
    if((h_counter < H_ACTIVE_PIXEL_COUNT && v_counter < V_ACTIVE_LINE_COUNT) && ~rst)begin
        r   <=  q[23:16];
        g   <=  q[15:8];
        b   <=  q[7:0];
    end
    else begin
        r   <=  0;
        g   <=  0;
        b   <=  0;
    end
end

always @(*) begin
    case ({rst, h_counter > H_ACTIVE_PIXEL_COUNT, v_counter > V_ACTIVE_LINE_COUNT})
        3'b000: address <=  xpos + 320 * ypos;//gets the address for the pixel of the 320x180 display
        default: address <= 65535;
    endcase    
end

always @(*) begin //xpos driver
    if(h_counter > H_ACTIVE_PIXEL_COUNT - 1)
        xpos <= 0;
    else
        xpos <= h_counter / 4;
end

always @(*) begin //ypos driver
    if(v_counter > V_ACTIVE_LINE_COUNT - 1)
        ypos <= 0;
    else
        ypos <= v_counter / 4;
end

endmodule