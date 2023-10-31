`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:23:47 10/31/2023 
// Design Name: 
// Module Name:    MUX 
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
module RegDstMUX(
    input [4:0] in1,
    input [4:0] in2,
    input [4:0] in3,
    input [7:0] RegDst,
    output [4:0] out
    );
    assign out = (RegDst == 0) ? in1 :
                 (RegDst == 1) ? in2 : in3;

endmodule


module RegSrcMUX(
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [7:0] RegSrc,
    output [31:0] out
);
    assign out = (RegSrc == 0) ? in1 :
                 (RegSrc == 1) ? in2 :
                 (RegSrc == 2) ? in3 : in4;

endmodule

module ALUSrcMUX(
    input [31:0] in1,
    input [31:0] in2,

    input [7:0] ALUSrc,
    output [31:0] out
);

    assign out = (ALUSrc == 0) ? in1 : in2;

endmodule