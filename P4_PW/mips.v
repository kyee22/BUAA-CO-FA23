`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:37:35 10/31/2023 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );


    ///////  从每个模块的输出端口都引出一根wire  ///////
    //IFU
    wire [31:0] pc;
    wire [31:0] instr;
    //NPC
    wire [31:0] npc;
    wire [31:0] pc_plus_4;
    //MySpliter
    wire [5:0] op,funct;
    wire [4:0] rs,rt,rd;
    wire [4:0] shamt;
    wire [15:0] imm16;
    wire [25:0] imm26;
    //Ctrl
    wire reg_write,mem_write;
    wire [7:0] reg_dst,reg_src,npc_op,ext_op,alu_op,alu_src,dm_sel;
    //GRF
    wire [31:0] reg_rd_1,reg_rd_2;
    //ALU
    wire [31:0] res;
    wire is_eq;
    //DM
    wire [31:0] mem_rd;
    //EXT
    wire [31:0] extend_imm;

    IFU IFU(
        .NPC(npc),
        .clk(clk),
        .rst(reset),

        .Instr(instr),
        .PC(pc)
    );

    NPC NPC(
        .PC(pc),
        .extend_Imm(extend_imm),
        .imm26(imm26),
        .is_eq(is_eq),
        .RegRD(reg_rd_1),
        .NPCOp(npc_op),

        .NPC(npc),
        .PC_plus_4(pc_plus_4)
    
    );

    MySplitter MySplitter(
        .Instr(instr),

        .Op(op),
        .Rs(rs),
        .Rt(rt),
        .Rd(rd),
        .Funct(funct),
        .imm16(imm16),
        .imm26(imm26),
        .Shamt(shamt)
    );

    CTRL CTRL(
        .Op(op),
        .Funct(funct),

        .NPCOp(npc_op),
        .RegDst(reg_dst),
        .RegSrc(reg_src),
        .RegWrite(reg_write),
        .MemWrite(mem_write),
        .EXTOp(ext_op),
        .ALUSrc(alu_src),
        .ALUOp(alu_op),
        .DMSel(dm_sel)
    );

    wire [4:0] reg_addr;
    wire [4:0] const_1 = 31; 
    RegDstMUX RegDstMUX(
        .in1(rt),
        .in2(rd),
        .in3(const_1),

        .RegDst(reg_dst),

        .out(reg_addr)
    );

    wire [31:0] reg_data;
    RegSrcMUX RegSrcMUX(
        .in1(res),
        .in2(mem_rd),
        .in3(extend_imm),
        .in4(pc_plus_4),

        .RegSrc(reg_src),

        .out(reg_data)
    );

    GRF GRF(
        .PC(pc),
        .A1(rs),
        .A2(rt),
        .A3(reg_addr),

        .WD(reg_data),

        .clk(clk),
        .rst(reset),
        .WE(reg_write),

        .RegRD1(reg_rd_1),
        .RegRD2(reg_rd_2)
    );

    EXT EXT(
        .imm16(imm16),
        .EXTOp(ext_op),
        
        .extend_Imm(extend_imm)
    );

    wire [31:0] b_data;
    ALUSrcMUX ALUSrcMUX(
        .in1(reg_rd_2),
        .in2(extend_imm),

        .ALUSrc(alu_src),

        .out(b_data)
    );

    ALU ALU(
        .A(reg_rd_1),
        .B(b_data),

        .ALUOp(alu_op),

        .res(res),
        .is_eq(is_eq)
    );

    DM DM(
        .PC(pc),
        .MemAddr(res),
        .MemData(reg_rd_2),

        .DMSel(dm_sel),

        .MemW(mem_write),
        .clk(clk),
        .rst(reset),

        .MemRD(mem_rd)
    );



endmodule
