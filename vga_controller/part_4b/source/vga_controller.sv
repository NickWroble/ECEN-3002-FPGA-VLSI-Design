
module vga_controller(
	input 		          		CLOCK_50,
	input 		     [3:0]		KEY,
	input			 [9:0] 		SW,

	output		          		VGA_BLANK_N,
	output		          		VGA_CLK,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		     [7:0]		VGA_G,
	output		     [7:0]		VGA_B,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS
);

logic 	clk,
		rst,
		vga_h_sync,
		vga_v_sync,
		pll_lock;

logic	[7:0]	vga_r;
logic   [7:0] 	vga_g;
logic 	[7:0] 	vga_b;
logic 	[11:0] 	h_counter;
logic 	[11:0]  v_counter;

assign 	VGA_R 		= vga_r,
		VGA_G		= vga_g,
		VGA_B		= vga_b,
		VGA_CLK 	= clk,
		VGA_HS 		= vga_h_sync,
		VGA_VS 		= vga_v_sync,
		VGA_SYNC_N 	= 1'b0, //tie low
		VGA_BLANK_N = 1'b1; //tie high


vga_clock clock_gen(
	.*
);

vga_pixel_gen_rom pixel_gen(
    .*
);

vga_reset reset(
	.clock(		clk), 
	.ext_reset(	SW[0]), 
	.lock(		pll_lock), 
	.reset_out(	rst)
);

endmodule