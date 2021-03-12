`timescale 1ns / 100ps

module tb();
	//////////// CLOCK //////////
	logic 		          		CLOCK_50;

	//////////// KEY //////////
	logic 		     [3:0]		KEY;

	//////////// VGA //////////
	logic		          		VGA_BLANK_N;
	logic		     [7:0]		VGA_B;
	logic		          		VGA_CLK;
	logic		     [7:0]		VGA_G;
	logic		          		VGA_HS;
	logic		     [7:0]		VGA_R;
	logic		          		VGA_SYNC_N;
	logic		          		VGA_VS;

    vga_controller DUT(.*);

	always # 10 CLOCK_50 = ~CLOCK_50;

	initial begin
        CLOCK_50 = 0;
		KEY[0] = 1;
		#100000;
		$stop;
	end
    
endmodule