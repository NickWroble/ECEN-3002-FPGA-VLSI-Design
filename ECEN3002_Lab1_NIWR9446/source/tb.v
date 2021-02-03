`timescale 1ns / 100ps
module tb();

    logic 			CLOCK_50;
    logic 	[3:0] 	KEY;
    logic 	[9:0] 	SW;
    logic 	[9:0] 	LEDR;

    ECEN3002_Lab1 DUT(.*);

	always # 10 CLOCK_50 = ~CLOCK_50;

	initial begin

		//verify counting up
		CLOCK_50 			= 1'b1;
		KEY				 	= 3'b111; //must all be set to one since active low
		SW				 	= 10'b00_0000_0000;
		#10_000;

		 
 		//verify counting down for 5_000 ns
				KEY		[2:0] 	= 3'b011;
		#5_000;

		//veirfy SW to set counter value 
				KEY 	[2:0] 	= 3'b101; 
		#100	SW		[9:0]	= 10'd234; //counter should be set to this value and count up
		#100 	KEY		[2:0] 	= 3'b111; // resume normal counting
		
		#10_000;


				KEY		[2:0] 	= 3'b110; //verify reset
		#1_000;


		

		$stop;
	end
    
endmodule