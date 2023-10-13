`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:59:01 10/10/2023 
// Design Name: 
// Module Name:    P1_L0_EXT 
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
module ext(
    input [15:0] imm,
    input [1:0] EOp,
    output reg [31:0] ext
    );

    always @(*) begin
        case (EOp)
           0: begin
                ext = {{16{imm[15]}},imm[15:0]};
           end
           1: begin
                ext = {{16{1'b0}}, imm[15:0]};
               //  ext = {16{1'b0},16{1'b1}};
           end

           2 :begin
                ext = {imm[15:0],{16{1'b0}}};
           end 

           3: begin
                ext = {{16{imm[15]}}, {imm[15:0]}}<<2;
           end
        endcase
    end


endmodule
