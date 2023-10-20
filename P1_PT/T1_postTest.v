`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:08:12 10/16/2023 
// Design Name: 
// Module Name:    T1_postTest 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dotProduct(
    input [31:0] vector_a,
    input [31:0] vector_b,
    output reg [5:0] result
    );

    integer i;

    wire [31:0] and_value = vector_a & vector_b;

    initial begin
        result = 0;
    end

    always @(*) begin
        result = 0;
        for (i = 0; i < 32; i = i + 1) begin
            result = (vector_a[i] & vector_b[i]) + result;
        end
    end

endmodule
