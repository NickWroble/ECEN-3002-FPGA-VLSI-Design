	//Nicholas Wroblewski
module ECEN3002_Lab1(

	//////////// CLOCK //////////
	input 		          		CLOCK_50,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// LED //////////
	output		     [9:0]		LEDR
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
logic 							rst;
logic 				[9:0] 		counter;
logic 				[22:0] 		clk_divider;
logic 							clk;

initial begin
	rst 		= 1'b0;
	counter 	= 10'd0;
	clk_divider = 23'd0;
	clk 		= 1'b0;
end

//=======================================================
//  Structural coding
//=======================================================

always @(posedge CLOCK_50) begin //clock divider 
	if(clk_divider == 6250000) begin //for use on the board
	//if(clk_divider == 10) begin  //for use on the test bench
		clk_divider = 0;
		clk = ~clk;
	end
	else 
		clk_divider = clk_divider + 1;
end

always @(posedge clk) begin
	if (~KEY[0]) begin //rst
		counter = 0;
	end
	else begin
		if(~KEY[1])begin //start counter based on switch position
			counter[9:0] = SW[9:0];
		end
		else begin
			if(KEY[2]) begin //change count up/count down based on third button
				counter = counter + 1;
			end
			else begin
				counter = counter - 1;
			end
		end
		
	end
end

assign LEDR[9:0] = counter[9:0];

endmodule