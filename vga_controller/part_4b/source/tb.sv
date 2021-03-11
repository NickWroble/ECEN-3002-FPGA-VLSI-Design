`timescale 1ns / 100ps

module tb();
	logic 		          		CLOCK_50;
	logic 		     [3:0]		KEY;
	logic 			 [9:0] 		SW;

	logic		          		VGA_BLANK_N;
	logic		          		VGA_CLK;
	logic		          		VGA_HS;
	logic		     [7:0]		VGA_R;
	logic		     [7:0]		VGA_G;
	logic		     [7:0]		VGA_B;
	logic		          		VGA_SYNC_N;
	logic		          		VGA_VS;
	

    vga_controller DUT(.*);

	always # 10 CLOCK_50 = ~CLOCK_50;

	initial begin
        CLOCK_50 = 0;
		SW[0] = 0;
		$stop;
	end
    
endmodule