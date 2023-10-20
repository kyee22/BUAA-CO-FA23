`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:30:20 10/20/2023
// Design Name:   VoterPlus
// Module Name:   E:/CO/co-lab/P1_RECOMMEND/P1_L1_vote_plus_tb.v
// Project Name:  P1_RECOMMEND
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: VoterPlus
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module P1_L1_vote_plus_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [31:0] np;
	reg [7:0] vip;
	reg vvip;

	// Outputs
	wire [7:0] result;

	// Instantiate the Unit Under Test (UUT)
	VoterPlus uut (
		.clk(clk), 
		.reset(reset), 
		.np(np), 
		.vip(vip), 
		.vvip(vvip), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		np = 0;
		vip = 0;
		vvip = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset=0;
		np = 32'b0000_0000_0000_0000_0000_0000_1111_1100;
		vip = 8'b0101_1010;
		vvip = 1;
		#100
		np = 32'b0000_0000_0000_0000_0000_0000_1111_0000;
		vip = 8'b0000_1010;
		vvip = 0;
        
		// Add stimulus here

	end

	always #50 clk=~clk;
      
endmodule

