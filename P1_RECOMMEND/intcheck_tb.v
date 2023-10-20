`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:11:38 09/29/2023
// Design Name:   intcheck
// Module Name:   E:/ISE/iseFILES/P1_recommond/intcheck_tb.v
// Project Name:  P1_recommond
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: intcheck
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module intcheck_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] in;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	intcheck uut (
		.clk(clk), 
		.reset(reset), 
		.in(in), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		in = 0;

		// Wait 100 ns for global reset to finish
		#200;
		reset = 0;
		in="i";
		#100 in="n";
		#100 in="t";
		#100 in=" ";
		#100 in="0";
		#100 in=",";
		#100 in="a";
		#100 in="7";
		#100 in="b";
		#100 in=";";
		#100 in="i";
		#100 in="n";
		#100 in="t";
		#100 in=" ";
		#100 in="a";
		#100 in=",";
		#100 in="b";
		#100 in=",";
		#100 in="i";
		#100 in="n";
		#100 in="t";
		#100 in=";";
		#100 in="i";
		#100 in="n";
		#100 in="t";
		#100 in=" ";
		#100 in="i";
		#100 in="n";
		#100 in="t";
		#100 in=",";
		#100 in="a";
		#100 in=",";
		#100 in="b";
		#100 in=";";
		#100 in="t";
		#100 in=" ";
		#100 in="e";
		#100 in="[";
		#100 in="2";
		#100 in="]";
		#100 in=";";
		#100 in=";";
		#100 in="i";
		#100 in="n";
		#100 in="t";
		#100 in=" ";
		#100 in="f";
		#100 in=",";
		#100 in="i";
		#100 in="n";
		#100 in="t";
		#100 in=" ";
		#100 in="g";
		#100 in=";";
		#100 in="i";
        #100 in="n";
		#100 in="t";
		#100 in=" ";
		#100 in="i";
		#100 in="n";
		#100 in="t";
		#100 in=" ";
		#100 in="i";
		#100 in="n";
		#100 in="i";
		#100 in="n";
		#100 in="t";
		#100 in=" ";
		#100 in="f";
		#100 in=";";
		#100 in="i";
		#100 in="n";
		#100 in="t";
		#100 in=" ";
		#100 in="a";
		#100 in="=";
		#100 in="1";
		#100 in=";";
		#100 in="i";
		// Add stimulus here
		// int a=1;
		// int a b c;

	end

	always #50 clk=~clk;
      
endmodule

