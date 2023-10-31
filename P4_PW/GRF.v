`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:14:18 10/31/2023 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input [4:0] A1,                 /*  输入信号    */
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD,
    input WE,
    input clk,
    input rst,
    input [31:0] PC,
    output [31:0] RegRD1,           /*  输出信号    */
    output [31:0] RegRD2
    );

reg [31:0] R [0:31];

// function 1: read data
assign RegRD1 = (A1 == 0) ? 0 : R[A1];
assign RegRD2 = (A2 == 0) ? 0 : R[A2];


// function 2: write data
integer i;
always @(posedge clk) begin
    //同步复位
    if (rst) begin
        for (i = 0; i < 32; i = i + 1) begin
            R[i] = 0;
        end
    end

    //(1)上升沿  +  (2)写使能有效
    else if (WE) begin
        R[A3] = (A3 == 0) ? 0 : WD;
        $display("@%h: $%d <= %h", PC, A3, WD);
    end
end

endmodule
