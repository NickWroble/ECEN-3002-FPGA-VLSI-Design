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

logic   [5:0]   address;
logic   [23:0]  q;

logic   [2:0]   xpos; //xpos and y pos keep track of an 8 x 8 pixel buffer
logic   [2:0]   ypos; //uses all 64 words of the ROM as a buffer

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
    if(rst)
        address <= 0;
    else
        address <=  xpos + 8 * ypos; //gets the address of the 8 x 8 pixel 
end

always @(posedge clk) begin //xpos driver
        if(h_counter == 0 || rst)
            xpos <= 0;
        else if(h_counter == 160)
            xpos <= 1;
        else if(h_counter == 320)
            xpos <= 2;
        else if(h_counter == 480)
            xpos <= 3;
        else if(h_counter == 640)
            xpos <= 4;
        else if(h_counter == 800)
            xpos <= 5;
        else if(h_counter == 960)
            xpos <= 6;
        else if(h_counter == 1120)
            xpos <= 7;
        else if(h_counter == 1280)
            xpos <= 0;
end

always @(posedge clk) begin //ypos driver
        if(v_counter == 0 || rst)
            ypos <= 0;
        else if(v_counter == 90)
            ypos <= 1;
        else if(v_counter == 180)
            ypos <= 2;
        else if(v_counter == 270)
            ypos <= 3;
        else if(v_counter == 360)
            ypos <= 4;
        else if(v_counter == 450)
            ypos <= 5;
        else if(v_counter == 540)
            ypos <= 6;
        else if(v_counter == 630)
            ypos <= 7;
        else if(v_counter == 720 + 1)
            ypos <= 0;
end

endmodule