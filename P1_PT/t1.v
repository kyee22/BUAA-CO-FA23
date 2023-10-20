`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:02:54 10/16/2023 
// Design Name: 
// Module Name:    t1 
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
module dotProduct(
    input [31:0] vector_a,
    input [31:0] vector_b,
    output [5:0] result
    );

    wire [31:0] ttt = vector_a & vector_b;
    assign result = cnt(ttt);

    function [5:0] cnt;
        input [31:0] in;

        integer i;

        begin
            cnt = 0;
            if (in[0] == 1'b1) cnt = cnt + 5'b00001;
            if (in[1] == 1'b1) cnt = cnt + 5'b00001;
            if (in[2] == 1'b1) cnt = cnt + 5'b00001;
            if (in[3] == 1'b1) cnt = cnt + 5'b00001;
            if (in[4] == 1'b1) cnt = cnt + 5'b00001;
            if (in[5] == 1'b1) cnt = cnt + 5'b00001;
            if (in[6] == 1'b1) cnt = cnt + 5'b00001;
            if (in[7] == 1'b1) cnt = cnt + 5'b00001;

            if (in[8] == 1'b1) cnt = cnt + 5'b00001;
            if (in[9] == 1'b1) cnt = cnt + 5'b00001;

            if (in[10] == 1'b1) cnt = cnt + 5'b00001;
            if (in[11] == 1'b1) cnt = cnt + 5'b00001;
            if (in[12] == 1'b1) cnt = cnt + 5'b00001;
            if (in[13] == 1'b1) cnt = cnt + 5'b00001;

            if (in[14] == 1'b1) cnt = cnt + 5'b00001;
            if (in[15] == 1'b1) cnt = cnt + 5'b00001;
            if (in[16] == 1'b1) cnt = cnt + 5'b00001;
            if (in[17] == 1'b1) cnt = cnt + 5'b00001;
            if (in[18] == 1'b1) cnt = cnt + 5'b00001;

            if (in[19] == 1'b1) cnt = cnt + 5'b00001;
            if (in[20] == 1'b1) cnt = cnt + 5'b00001;
            if (in[21] == 1'b1) cnt = cnt + 5'b00001;
            if (in[22] == 1'b1) cnt = cnt + 5'b00001;
                    
            if (in[23] == 1'b1) cnt = cnt + 5'b00001;

            if (in[24] == 1'b1) cnt = cnt + 5'b00001;
            if (in[25] == 1'b1) cnt = cnt + 5'b00001;
            if (in[26] == 1'b1) cnt = cnt + 5'b00001;
            if (in[27] == 1'b1) cnt = cnt + 5'b00001;

            if (in[28] == 1'b1) cnt = cnt + 5'b00001;
            if (in[29] == 1'b1) cnt = cnt + 5'b00001;
            if (in[30] == 1'b1) cnt = cnt + 5'b00001;
            if (in[31] == 1'b1) cnt = cnt + 5'b00001;


        end
        
    endfunction


  
  





endmodule
