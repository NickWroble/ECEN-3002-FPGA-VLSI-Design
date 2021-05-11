
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module Video_Controller(

	//////////// CLOCK //////////
	input 		          		CLOCK_50,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,

		//////////// VGA //////////
	output		 logic         		VGA_BLANK_N,
	output		 logic    [7:0]		VGA_B,
	output		 logic         		VGA_CLK,
	output		 logic    [7:0]		VGA_G,
	output		 logic         		VGA_HS,
	output		 logic    [7:0]		VGA_R,
	output		 logic         		VGA_SYNC_N,
	output		 logic         		VGA_VS
);
`include "vga_parameters.svh"

//=======================================================
//  REG/WIRE declarations
//=======================================================
logic 	locked_VGA,
		locked_DRAM,
		a_reset,
		ready,
		valid,
		clk_vga;

logic [11:0]	h_counter;
logic [11:0] 	v_counter;
logic [31:0]	fifo_data;

assign VGA_SYNC_N = 1'b0;
assign VGA_BLANK_N = 1'b1;
assign VGA_CLK = clk_vga;

//=======================================================
//  Structural coding
//=======================================================
platform U1(
	.clk_clk(CLOCK_50),
	.new_sdram_controller_0_wire_addr(DRAM_ADDR[12:0]),
	.new_sdram_controller_0_wire_ba(DRAM_BA[1:0]),
	.new_sdram_controller_0_wire_cas_n(DRAM_CAS_N), 
	.new_sdram_controller_0_wire_cke(DRAM_CKE), 
	.new_sdram_controller_0_wire_cs_n(DRAM_CS_N),
	.new_sdram_controller_0_wire_dq(DRAM_DQ[15:0]),
	.new_sdram_controller_0_wire_dqm({DRAM_UDQM,DRAM_LDQM}), 
	.new_sdram_controller_0_wire_ras_n(DRAM_RAS_N), 
	.new_sdram_controller_0_wire_we_n(DRAM_WE_N),
	.pio_0_external_connection_export(LEDR[9:0]),
	.pll_0_locked_export(locked_DRAM), 
	.pll_0_outclk1_clk(DRAM_CLK),
	.pll_1_locked_export(locked_VGA), 
	.pll_1_outclk1_clk(clk_vga),  
	.fifo_0_out_valid(valid),
	.fifo_0_out_data(fifo_data),
	.fifo_0_out_ready(ready),
    .reset_reset_n(rst));

vga_reset U2(
	.rst(~KEY[0]),
    .locked(locked_DRAM & locked_VGA),
    .VGA_CLK(clk_vga),
    .a_reset(a_reset)
);		
vga_clock U3(
    .rst(a_reset),
    .clk(CLOCK_50),
    .vga_h_sync(VGA_HS),
    .vga_v_sync(VGA_VS),
    .h_counter(h_counter),
    .v_counter(v_counter)
);
vga_pixel_gen U4(
    .h_counter(h_counter),
    .v_counter(v_counter),
    .clk(CLOCK_50),
    .rst(a_reset),
    .fifo_data(fifo_data),
    .ready(ready),
    .VGA_B(VGA_B),
    .VGA_R(VGA_R),
    .VGA_G(VGA_G)
);

endmodule