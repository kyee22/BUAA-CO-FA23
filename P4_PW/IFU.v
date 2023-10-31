`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:38:38 10/31/2023 
// Design Name: 
// Module Name:    IFU 
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
module IFU(
    input [31:0] NPC,           /*      输入信号        */
    input clk,
    input rst,
    output [31:0] Instr,        /*      输出信号        */
    output reg [31:0] PC
    );

    reg [31:0] IM [0:4095];

    initial begin
        $readmemh("code.txt", IM);
        PC = 32'h3000;
    end

    
    //取指
    wire [31:0] temp = (PC - 32'h3000);
    assign Instr = IM[temp[13:2]];

    always @(posedge clk) begin
        if (rst) begin
            PC = 32'h3000;
        end

        else begin
            PC = NPC;
        end
    end






endmodule
