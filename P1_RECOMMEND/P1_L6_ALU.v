`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:45:31 10/20/2023 
// Design Name: 
// Module Name:    P1_L6_ALU 
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
module alu(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,
    output reg [31:0] C
    );

    always @(*) begin

        case(ALUOp)
        0:begin
            C = A + B;
        end

        1:begin 
            C = A - B;
        end

        2:begin
            C = A & B;
        end

        3:begin
            C = A | B;
        end

        4:begin
            C = A >> B;
        end

        5:begin
            C = $signed(A) >>> B;
        end

        6:begin
            C = A > B;
        end

        7:begin
            C = $signed (A) > $signed(B);
        end
        endcase


    end


endmodule
