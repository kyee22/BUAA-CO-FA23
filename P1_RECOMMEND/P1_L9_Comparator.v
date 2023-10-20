`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:54:04 10/12/2023 
// Design Name: 
// Module Name:    P1_L9_Comparator 
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
module comparator(
    input [3:0] A,
    input [3:0] B,
    output reg Out
    );


    function [1:0] bitCmp;//1:小于;2:等于;3:大于
        input a,b;

        begin
            if(a==b) bitCmp = 2;
            else if(a==1 && b==0) bitCmp=3;
            else if(a==0 && b==1) bitCmp=1;
        end
        
    endfunction


    always @(*) begin

        if (A[3]==0 && B[3]==1) Out = 0;
        else if(A[3]==1 && B[3]==0) Out = 1;
        else begin
            if ((bitCmp(A[2],B[2])==1) 
            || (bitCmp(A[2],B[2])==2 && bitCmp(A[1],B[1])==1) 
            || (bitCmp(A[2],B[2])==2 && bitCmp(A[1],B[1])==2 && bitCmp(A[0],B[0])==1))
                Out = 1;
            else 
                Out = 0;
        end

    end

endmodule
