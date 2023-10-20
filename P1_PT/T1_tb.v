`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:10:15 10/16/2023
// Design Name:   T1_postTest
// Module Name:   E:/CO/co-lab/P1_PT/T1_tb.v
// Project Name:  P1_PT
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: T1_postTest
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module T1_tb;

	// Inputs
	reg [31:0] vector_a;
	reg [31:0] vector_b;

	// Outputs
	wire [5:0] result;

	// Instantiate the Unit Under Test (UUT)
	dotProduct uut (
		.vector_a(vector_a), 
		.vector_b(vector_b), 
		.result(result)
	);

	initial begin
		// Initialize Inputs
		vector_a = 0;
		vector_b = 0;

		// Wait 100 ns for global reset to finish
		#100;
		vector_a = 3;
		vector_b = 6;
		#100
		vector_a = 13;
		vector_b = 15;
		#100
		vector_a = 33;
		vector_b = 31;
		#100
		vector_a = 14;
		vector_b = 15;

        
		// Add stimulus here

	end
      
endmodule

