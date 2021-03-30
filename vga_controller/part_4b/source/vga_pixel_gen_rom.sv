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

logic   [17:0]  address;
logic   [11:0]  q;

logic   [9:0]   xpos; //max is 640
logic   [8:0]   ypos; // max is 360

logic   [3:0]   r;
logic   [3:0]   g;
logic   [3:0]   b;

//logic blank = (h_counter > H_ACTIVE_PIXEL_COUNT) && (v_counter > V_ACTIVE_LINE_COUNT);

assign  vga_r   = {r, 4'b0000};
assign  vga_g   = {g, 4'b0000};
assign  vga_b   = {b, 4'b0000};

initial begin
    address = 0;
    xpos    = 0;
    ypos    = 0;
    r       = 0;
    g       = 0;
    b       = 0;
end

image get_image(
    .address(address),
    .clock(clk),
    .q(q)
);

always @(*) begin
    if((h_counter < H_ACTIVE_PIXEL_COUNT && v_counter < V_ACTIVE_LINE_COUNT) && ~rst)begin
        r   <=  q[11:8];
        g   <=  q[7:4];
        b   <=  q[3:0];
    end
    else begin
        r   <=  0;
        g   <=  0;
        b   <=  0;
    end
end

always @(*) begin
    casex ({rst, h_counter > H_ACTIVE_PIXEL_COUNT, v_counter > V_ACTIVE_LINE_COUNT})
        3'b000: address <=  xpos + (640 * ypos);//gets the address for the pixel of the 640x360 display
        3'b1xx: address <= 0;
    endcase    
end

always @(*) begin //xpos driver
    if(h_counter > H_ACTIVE_PIXEL_COUNT - 1)
        xpos <= 0;
    else
        xpos <= h_counter / 2;
end

always @(*) begin //ypos driver
    if(v_counter > V_ACTIVE_LINE_COUNT - 1)
        ypos <= 0;
    else
        ypos <= v_counter / 2;
end

// assign vga_r = (h_counter > H_ACTIVE_PIXEL_COUNT) & (v_counter > V_ACTIVE_LINE_COUNT) ? 0:  {q[11:8], 4'b0000};

endmodule