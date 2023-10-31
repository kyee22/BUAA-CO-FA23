`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:08:49 10/31/2023 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] imm16,             /*  输入信号    */
    input [7:0] EXTOp,//控制信号
    output reg [31:0] extend_Imm    /*  输出信号    */
    );

    always @(*) begin
        case(EXTOp)
        0: begin
            extend_Imm = {{16{1'b0}},imm16};
        end

        1: begin
            extend_Imm = {{16{imm16[15]}},imm16};
        end

        2: begin
            extend_Imm = {imm16,{16{1'b0}}};
        end

        endcase
    end


endmodule
