`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:51:32 10/31/2023 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [31:0] MemAddr,           /*  输入信号    */
    input [31:0] MemData,
    input MemW,
    input clk,
    input rst,
    input [31:0] PC,
    input [7:0] DMSel,//控制信号
    output [31:0] MemRD             /*  输出信号    */
    );

    reg [31:0] M [0:4095];

    integer i = 0;
    initial begin
        for (i = 0; i < 4096; i = i + 1) begin
            M[i] = 0;
        end
    end

    assign MemRD = M[MemAddr[13:2]];

    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 4096; i = i + 1) begin
                M[i] = 0;
            end
        end

        else if (MemW) begin
            M[MemAddr[13:2]] = MemData;
            $display("@%h: *%h <= %h", PC, MemAddr, MemData);
        end
    end





endmodule
