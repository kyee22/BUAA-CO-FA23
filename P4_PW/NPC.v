`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:26:37 10/31/2023 
// Design Name: 
// Module Name:    NPC 
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
module NPC(
    input [31:0] PC,                    /*  输入信号    */
    input [31:0] extend_Imm,
    input [25:0] imm26,
    input is_eq,
    input [31:0] RegRD,
    input [7:0] NPCOp,  //控制信号
    output reg [31:0] NPC,              /*  输出信号    */
    output [31:0] PC_plus_4
    );

    assign PC_plus_4 = PC + 4;

    always @(*) begin
        case(NPCOp)
            /*                    非跳转类                         */
            0: begin
                NPC = PC + 4;
            end
            
            /*                       b类                         */
            1: begin // beq
                NPC = (is_eq == 1) ? PC + 4 + extend_Imm : PC + 4;
            end

            /*                       j类                         */
            2: begin // jal
                NPC = {{PC[31:28]},imm26,{2{1'b0}}};
            end

            /*                       jr类                        */
            3: begin // jr
                NPC = RegRD;
            end

        endcase
    end


endmodule
