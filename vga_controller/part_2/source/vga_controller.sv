
module vga_controller(

	//////////// CLOCK //////////
	input 		          		CLOCK_50,

	//////////// KEY //////////
	input 		     [3:0]		KEY,
	input			 [9:0] 		SW,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS
);

//=======================================================
//  REG/WIRE declarations
//=======================================================
logic 	CLOCK_74_25,
		rst,
		vga_h_sync,
		vga_v_sync,
		gray, 
		pll_lock;

logic	[7:0]	vga_r;
logic   [7:0] 	vga_g;
logic 	[7:0] 	vga_b;
logic 	[11:0] 	h_counter;
logic 	[11:0]  v_counter;

assign VGA_R = vga_r;
assign VGA_G = vga_g;
assign VGA_B = vga_b;

always_ff @(negedge KEY[1]) begin
	gray <= ~gray;
end

assign 	VGA_CLK 	= CLOCK_74_25,
		VGA_HS 		= vga_h_sync,
		VGA_VS 		= vga_v_sync,
		VGA_SYNC_N 	= 1'b0, //tie low
		VGA_BLANK_N = 1'b1; //tie high


vga_clock clock_gen(
	.rst(			rst),
	.CLOCK_50(		CLOCK_50),

	.CLOCK_74_25	(CLOCK_74_25),
	.pll_lock(		pll_lock),
    .vga_h_sync(	vga_h_sync),
    .vga_v_sync(	vga_v_sync),
	.h_counter(		h_counter),
    .v_counter(		v_counter)
);

vga_pixel_gen pixel_gen(
	.gray_enable(	gray),
    .rst(			rst),
    .clk(			CLOCK_74_25),
    .h_counter(		h_counter),
    .v_counter(		v_counter),
	.v_sync(		vga_v_sync),
	.SW(			SW),
	.KEY(			KEY),
    .green(			vga_g),
    .blue(			vga_b),
    .red(			vga_r)
);

vga_reset reset(
	.clock(		CLOCK_74_25), 
	.ext_reset(	SW[0]), 
	.lock(		pll_lock), 
	.reset_out(	rst)
);

endmodule