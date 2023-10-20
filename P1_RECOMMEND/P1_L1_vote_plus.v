`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:25:49 10/20/2023 
// Design Name: 
// Module Name:    P1_L1_vote_plus 
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
module VoterPlus(
    input clk,
    input reset,
    input [31:0] np,
    input [7:0] vip,
    input vvip,
    output reg [7:0] result
    );

    reg [31:0] np_rec;
    reg [7:0] vip_rec;
    reg vvip_rec;


    initial begin
        result = 0;
    end

    integer i;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            result = 0;
            np_rec = 0;
            vip_rec = 0;
            vvip_rec = 0;
        end

        else begin

            // result = 0;

            for(i=0; i < 32; i = i + 1) begin
                if(np[i] && !np_rec[i]) begin
                    result = result + 1;
                    np_rec[i] = 1;
                end
            end

            for(i=0; i < 8; i = i + 1) begin
                if(vip[i]  && !vip_rec[i]) begin
                    result = result + 4;
                    vip_rec[i] = 1;
                end
            end

            if(vvip && !vvip_rec) begin
                result = result + 16;  
                vvip_rec = 1;
            end

        end

    end




endmodule
