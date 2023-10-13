`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:59:33 10/10/2023
// Design Name:   BlockChecker
// Module Name:   E:/ISE/iseFILES/P1/BlockChecker_tb.v
// Project Name:  P1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: BlockChecker
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module BlockChecker_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] in;

	// Outputs
	wire result;

	// Instantiate the Unit Under Test (UUT)
	BlockChecker uut (
		.clk(clk), 
		.reset(reset), 
		.in(in), 
		.result(result)
	);

	reg [0:1023] S = "Hello world，begin comPuTer orGANization End";
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		in = 0;

		// Wait 100 ns for global reset to finish
		#20;
		reset = 0;
		while(!S[0:7]) S = S << 8;

		for(; S[0:7]; S = S << 8) begin
			in = S[0:7];
			#100;
		end
        
		// Add stimulus here

	end
    
	always #50 clk=~clk;
endmodule

