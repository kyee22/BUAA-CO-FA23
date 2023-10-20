`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:26:52 10/20/2023
// Design Name:   string2
// Module Name:   E:/CO/co-lab/P1_RECOMMEND/P1_L7_string2_tb.v
// Project Name:  P1_RECOMMEND
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: string2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module P1_L7_string2_tb;

	// Inputs
	reg clk;
	reg clr;
	reg [7:0] in;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	string2 uut (
		.clk(clk), 
		.clr(clr), 
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		clr = 1;
		in = 0;

		// Wait 100 ns for global reset to finish
		#100;
		clr =0;
       in="(";
		#100 in="1";
		#100 in="+";
		#100 in="2";
		#100 in="+";
		#100 in="3";
		#100 in="+";
		#100 in="3";
		#100 in="*";
		#100 in="1";
		#100 in=")";
		// Add stimulus here

	end

	always #50 clk=~clk;
      
endmodule

