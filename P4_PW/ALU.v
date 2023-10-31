`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:02:34 10/31/2023 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,                 /*  输入信号    */
    input [31:0] B,
    input [7:0] ALUOp, //控制信号
    output reg [31:0] res,          /*  输出信号    */
    output is_eq
    );

    always @(*) begin
        case(ALUOp)
            0: begin
                res =  A + B;
            end
            
            1: begin
                res = A - B;
            end

            2: begin
                res = A | B;
            end
        endcase    
    end

    assign is_eq = (A == B);


endmodule
