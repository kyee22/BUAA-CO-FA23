`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:09:29 10/10/2023 
// Design Name: 
// Module Name:    P1_L0_gray 
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
module gray(
    input Clk,
    input Reset,
    input En,
    output [2:0] Output,
    output reg Overflow
    );

    reg [2:0] cur[7:0];
    reg [2:0] BinaryCnt;

    initial begin
        Overflow = 0;
        BinaryCnt = 0;
        cur[0] = 3'b000;
        cur[1] = 3'b001;
        cur[2] = 3'b011;
        cur[3] = 3'b010;
        cur[4] = 3'b110;
        cur[5] = 3'b111;
        cur[6] = 3'b101;
        cur[7] = 3'b100;
    end

    assign Output = cur[BinaryCnt];

    always @(posedge Clk) begin
        if(Reset) begin
            Overflow = 0;
            BinaryCnt = 0;
        end

        else if(En) begin
            BinaryCnt <= BinaryCnt + 1;
            if(BinaryCnt == 7) begin
                Overflow <= 1;
            end
        end
    end




endmodule
