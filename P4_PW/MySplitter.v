`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:02 10/31/2023 
// Design Name: 
// Module Name:    MySplitter 
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
module MySplitter(
    input [31:0] Instr,         /*  输入信号    */
    output [5:0] Op,            /*  输出信号    */
    output [4:0] Rs,
    output [4:0] Rt,
    output [4:0] Rd,
    output [5:0] Funct,
    output [15:0] imm16,
    output [25:0] imm26,
    output [4:0] Shamt
    );

    assign Op = Instr[31:26];
    assign Rs = Instr[25:21];
    assign Rt = Instr[20:16];
    assign Rd = Instr[15:11];
    assign Shamt = Instr[10:6];
    assign Funct = Instr[5:0];
    assign imm16 = Instr[15:0];
    assign imm26 = Instr[25:0];


endmodule
