//`include "vga_parameters.svh"
module vga_clock(
    input           rst,
    input           CLOCK_50,

    output          CLOCK_74_25,
    output          pll_lock,
    output          vga_h_sync,
    output          vga_v_sync,
    output [11:0]   h_counter,
    output [11:0]   v_counter
);

//`include "vga_parameters.svh"

//=======================================================
//  REG/WIRE declarations
//=======================================================
logic       h_sync, 
            v_sync,
            write_enable;

logic [11:0] h_count;
logic [11:0] v_count;

assign vga_h_sync = h_sync;
assign vga_v_sync = v_sync;

assign h_counter = h_count;
assign v_counter = v_count;

initial begin
    h_count = 0;
    v_count = 0;
    h_sync = 1;
    v_sync = 0;
end

//=======================================================
//  Structural coding
//=======================================================
always @(posedge CLOCK_74_25) begin //driver for h_count, counts total pixel across horizontal
    if(rst)
        h_count <= 0;
    else
        if(h_count == H_PIXEL_COUNT - 1)
            h_count <= 0;
        else  
            h_count <= h_count + 1;
end

always @(posedge CLOCK_74_25) begin //driver for v_count, counts total pixel across vertical
    if(rst) 
        v_count <= 0;
    else
        if(h_count == H_PIXEL_COUNT - 1) //if new line
            if(v_count == V_LINE_COUNT - 1) //if next picutre in video
                v_count <= 0;
            else
                v_count <= v_count + 1;
end


always @(*) begin //h_sync driver
    if(rst)
        h_sync <= 0;
    else
        if (h_count == H_ACTIVE_PIXEL_COUNT + H_FRONT_PORCH - 1)
            h_sync <= 1;
        else if(h_count == H_ACTIVE_PIXEL_COUNT + H_FRONT_PORCH + H_SYNC_PULSE_WIDTH - 1)
            h_sync <= 0;
end

always @(*) begin //v_sync driver
    if(rst)
        v_sync <= 0;
    else
        if (v_count == V_ACTIVE_LINE_COUNT + V_FRONT_PORCH - 1)
            v_sync <= 1;
        else if(v_count == V_ACTIVE_LINE_COUNT + V_FRONT_PORCH + V_SYNC_PULSE_WIDTH - 1)
            v_sync <= 0;
end

 `ifdef highres
    pll_1080p pll_gen(                  //generates 74.25 MHz clock
            .refclk(    CLOCK_50),   //  refclk.clk
            .rst(       1'b0),      //   reset.reset
            .outclk_0(  CLOCK_74_25), // outclk0.clk
            .locked(    pll_lock)    //  locked.export
    );
 `else
    pll_720p pll_gen(                  //generates 74.25 MHz clock
            .refclk(    CLOCK_50),   //  refclk.clk
            .rst(       1'b0),      //   reset.reset
            .outclk_0(  CLOCK_74_25), // outclk0.clk
            .locked(    pll_lock)    //  locked.export
    );
 `endif
//=======================================================
//  Submodule instantiation
//=======================================================
endmodule
