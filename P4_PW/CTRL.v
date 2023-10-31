`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:49:47 10/31/2023 
// Design Name: 
// Module Name:    CTRL 
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
module CTRL(
    input [5:0] Op,             /*  输入信号    */
    input [5:0] Funct,
    output [7:0] NPCOp,         /*  输出信号    */
    output [7:0] RegDst,
    output [7:0] RegSrc,
    output RegWrite,
    output MemWrite,
    output [7:0] EXTOp,
    output [7:0] ALUSrc,
    output [7:0] ALUOp,
    output [7:0] DMSel
    );

    //////////////////////   与逻辑   //////////////////////
    // R型指令
        wire _add_ = (Op == 6'b000000) & (Funct == 6'b100000);
        wire _sub_ = (Op == 6'b000000) & (Funct == 6'b100010);
        wire _jr_  = (Op == 6'b000000) & (Funct == 6'b001000);

    // I型指令
        // 运算类
            wire _ori_ = (Op == 6'b001101);
            wire _lui_ = (Op == 6'b001111);
        // b型指令
            wire _beq_ = (Op == 6'b000100);
        // 访存类
            wire _lw_  = (Op == 6'b100011);
            wire _sw_  = (Op == 6'b101011);
    // j型指令
        wire _jal_ = (Op == 6'b000011);

    //////////////////////   或逻辑   //////////////////////
    assign RegDst[7] = 1'b0;
    assign RegDst[6] = 1'b0;
    assign RegDst[5] = 1'b0;
    assign RegDst[4] = 1'b0;
    assign RegDst[3] = 1'b0;
    assign RegDst[2] = 1'b0;
    assign RegDst[1] = _jal_;
    assign RegDst[0] = _add_ | _sub_;


    assign RegSrc[7] = 1'b0;
    assign RegSrc[6] = 1'b0;
    assign RegSrc[5] = 1'b0;
    assign RegSrc[4] = 1'b0;
    assign RegSrc[3] = 1'b0;
    assign RegSrc[2] = 1'b0;
    assign RegSrc[1] = _lui_ | _jal_;
    assign RegSrc[0] = _lw_  | _jal_;


    assign RegWrite = _add_  | _sub_ | _ori_ | _lui_ | _lw_ | _jal_;

    assign MemWrite = _sw_;


    assign EXTOp[7] = 1'b0;
    assign EXTOp[6] = 1'b0;
    assign EXTOp[5] = 1'b0;
    assign EXTOp[4] = 1'b0;
    assign EXTOp[3] = 1'b0;
    assign EXTOp[2] = 1'b0;
    assign EXTOp[1] = _lui_;
    assign EXTOp[0] = _beq_  | _lw_ | _sw_;


    assign ALUSrc[7] = 1'b0;
    assign ALUSrc[6] = 1'b0;
    assign ALUSrc[5] = 1'b0;
    assign ALUSrc[4] = 1'b0;
    assign ALUSrc[3] = 1'b0;
    assign ALUSrc[2] = 1'b0;
    assign ALUSrc[1] = 1'b0;
    assign ALUSrc[0] = _ori_ | _lw_ | _sw_;


    assign ALUOp[7] = 1'b0;
    assign ALUOp[6] = 1'b0;
    assign ALUOp[5] = 1'b0;
    assign ALUOp[4] = 1'b0;
    assign ALUOp[3] = 1'b0;
    assign ALUOp[2] = 1'b0;
    assign ALUOp[1] = _ori_;
    assign ALUOp[0] = _sub_;

    assign NPCOp[7] = 1'b0;
    assign NPCOp[6] = 1'b0;
    assign NPCOp[5] = 1'b0;
    assign NPCOp[4] = 1'b0;
    assign NPCOp[3] = 1'b0;
    assign NPCOp[2] = 1'b0;
    assign NPCOp[1] = _jal_ | _jr_;
    assign NPCOp[0] = _beq_ | _jr_;


    assign DMSel[7] = 1'b0;
    assign DMSel[6] = 1'b0;
    assign DMSel[5] = 1'b0;
    assign DMSel[4] = 1'b0;
    assign DMSel[3] = 1'b0;
    assign DMSel[2] = 1'b0;
    assign DMSel[1] = 1'b0;
    assign DMSel[0] = 1'b0;

endmodule
