`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:08:37 10/20/2023 
// Design Name: 
// Module Name:    P1_L2_check110011 
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
module fsm(
    input clk,
    input reset,
    input in,
    output out
    );

    reg [5:0] buffer;

    initial begin
        buffer = 6'b000000;
    end

    assign out = (buffer == 6'b110011);

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            buffer <= 6'b000000;
        end

        else begin
            buffer <= (buffer << 1) | (in);
        end
    end


endmodule
