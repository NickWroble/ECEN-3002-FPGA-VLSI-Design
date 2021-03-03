`include "vga_parameters.svh"

module vga_pixel_gen(
    input   rst,
    input   clk,
    input   gray_enable,
    input   [11:0] h_counter,
    input   [11:0] v_counter,
    input           v_sync,
    input [9:0] SW,
    input [3:0] KEY,

    output   [7:0] green,
    output   [7:0] blue,
    output   [7:0] red
);

`include "vga_parameters.svh"

logic   [7:0]   r;
logic   [7:0]   g;
logic   [7:0]   b;

logic   [10:0]  xpos_1;
logic   [10:0]  ypos_1;

logic   [10:0]  xpos_2;
logic   [10:0]  ypos_2;

logic box_1_write_en;
assign box_1_write_en = ((xpos_1 < h_counter) && (ypos_1 < v_counter)) && ((xpos_1 + BOX_WIDTH_1 > h_counter) && (ypos_1 + BOX_HEIGHT_1 > v_counter));

logic box_2_write_en;
assign box_2_write_en = ((xpos_2 < h_counter) && (ypos_2 < v_counter)) && ((xpos_2 + BOX_WIDTH_2 > h_counter) && (ypos_2 + BOX_HEIGHT_2 > v_counter));

assign  red     = r;
assign  green   = g;
assign  blue    = b;

initial begin
    r = 0;
    g = 0;
    b = 0;
    xpos_1 = 0;
    ypos_1 = 0;
    xpos_2 = 1280 - BOX_WIDTH_2;
    ypos_2 = 720 - BOX_HEIGHT_2;
end

always @(*) begin //color driver for both boxes based on x and y position
    casex ({SW[8], box_1_write_en, SW[7], box_2_write_en}) // box 2, sw 7 is used to change color
        4'b01xx: begin
            r <= 8'hFF;
            g <= 0;
            b <= 0;
        end
        4'bxx01: begin
            r <= 0;
            g <= 0;
            b <= 8'hFF;
        end
        4'b11xx: begin
            r <= 0;
            g <= 8'hFF;
            b <= 0;
        end
        4'bxx11: begin
            r <= 8'hFF;
            g <= 8'hFF;
            b <= 8'hFF;
        end
        default: begin
            r <= 0;
            g <= 0;
            b <= 0;
        end
    endcase
end

always @(posedge v_sync) begin //xpos_1 driver
    casex ({SW[1], ~KEY[3], ~KEY[0], xpos_1 > H_ACTIVE_PIXEL_COUNT, SW[9]})
    // move enable, move left, move right, if in active display area, movement speed
    //if the none of the below are satisfied, box stays stands still
    5'b1_0100: xpos_1 <= xpos_1 + 2; //move right slow
    5'b1_0101: xpos_1 <= xpos_1 + 6; //move right fast
    5'b1_1000: xpos_1 <= xpos_1 - 2; //move left slow
    5'b1_1001: xpos_1 <= xpos_1 - 6; //move left fast
    5'b1_101x: xpos_1 <= H_ACTIVE_PIXEL_COUNT; //if moving left and end of screen
    5'b1_011x: xpos_1 <= 0; //if moving right and end of screen
    endcase
end

always @(posedge v_sync) begin //ypos_1 driver
    casex ({SW[1], ~KEY[2], ~KEY[1], ypos_1 > V_ACTIVE_LINE_COUNT, SW[9]})
    // move enable, move left, move right, if in active display area, movement speed
    //if the none of the below are satisfied, box stays stands still
    5'b1_0100: ypos_1 <= ypos_1 + 2; //move up slow
    5'b1_0101: ypos_1 <= ypos_1 + 6; //move up fast
    5'b1_1000: ypos_1 <= ypos_1 - 2; //move down slow
    5'b1_1001: ypos_1 <= ypos_1 - 6; //move down fast
    5'b1_101x: ypos_1 <= V_ACTIVE_LINE_COUNT; //if moving left and end of screen
    5'b1_011x: ypos_1 <= 0; //if moving right and end of screen 
    endcase
end

always @(posedge v_sync) begin //xpos_2 driver
    casex ({SW[2], ~KEY[3], ~KEY[0], xpos_2 > H_ACTIVE_PIXEL_COUNT, SW[9]})
    // move enable, move left, move right, if in active display area, movement speed
    //if the none of the below are satisfied, box stays stands still
    5'b1_0100: xpos_2 <= xpos_2 + 2; //move right slow
    5'b1_0101: xpos_2 <= xpos_2 + 6; //move right fast
    5'b1_1000: xpos_2 <= xpos_2 - 2; //move left slow
    5'b1_1001: xpos_2 <= xpos_2 - 6; //move left fast
    5'b1_101x: xpos_2 <= H_ACTIVE_PIXEL_COUNT; //if moving left and end of screen
    5'b1_011x: xpos_2 <= 0; //if moving right and end of screen
    endcase
end

always @(posedge v_sync) begin //ypos_2 driver
    casex ({SW[2], ~KEY[2], ~KEY[1], ypos_2 > V_ACTIVE_LINE_COUNT, SW[9]})
    // move enable, move left, move right, if in active display area, movement speed
    //if the none of the below are satisfied, box stays stands still
    5'b1_0100: ypos_2 <= ypos_2 + 2; //move up slow
    5'b1_0101: ypos_2 <= ypos_2 + 6; //move up fast
    5'b1_1000: ypos_2 <= ypos_2 - 2; //move down slow
    5'b1_1001: ypos_2 <= ypos_2 - 6; //move down fast
    5'b1_101x: ypos_2 <= V_ACTIVE_LINE_COUNT; //if moving left and end of screen
    5'b1_011x: ypos_2 <= 0; //if moving right and end of screen 
    endcase
end

endmodule