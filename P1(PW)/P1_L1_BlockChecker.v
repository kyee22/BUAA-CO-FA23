`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:53:40 10/10/2023 
// Design Name: 
// Module Name:    P1_L1_BlockChecker 
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
module BlockChecker(
    input clk,
    input reset,
    input [7:0] in,
    output result
    );

    reg [31:0] top;
    reg [31:0] state;

    assign result = (top == 0) ? 1 : 0;

    function [7:0] toLower;
        input [7:0] a;

        begin
            if("A" <= a && a <= "Z") toLower = a - "A" + "a";
            else toLower = a;
        end

    endfunction



    always @(posedge clk or posedge reset) begin
        if (reset) begin
            top <= 0;
            state <= 0;
        end

        else begin
            case (state) 
            // reading space/void
            0: begin
                if(in == " ") state <= 0;
                else if (toLower(in) == "b") state <= 11;
                else if (toLower(in) == "e") state <= 21;
                else state <= 31;
            end

            //reading "begin"
            11: begin
                if(in == " ") state <= 0;
                else if (toLower(in) == "e") state <= 12;
                else state <= 31;
            end

            12: begin
                if(in == " ") state <= 0;
                else if (toLower(in) == "g") state <= 13;
                else state <= 31;
            end

            13: begin
                if(in == " ") state <= 0;
                else if (toLower(in) == "i") state <= 14;
                else state <= 31;
            end

            14: begin
                if(in == " ") state <= 0;
                else if (toLower(in) == "n") begin
                    state <= 15;
                    top <= top + 1;
                end
                else state <= 31;
            end

            15: begin
                if(in == " ") begin
                    state <= 0;
                end
                else begin
                    state <= 31;
                    top <= top - 1;
                end
            end

            //reading "end"
            21: begin
                if(in == " ") state <= 0;
                else if (toLower(in) == "n") state <= 22;
                else state <= 31;
            end

            22: begin
                if(in == " ") state <= 0;
                else if (toLower(in) == "d") begin
                    state <= 23;
                    top <= top - 1;
                end
                else state <= 31;
            end

            23: begin
                if(in == " ") begin 
                    if ($signed(top) < $signed(0)) state <= 41;
                    else state <= 0;
                end
                else begin
                    state <= 31;
                    top <= top + 1;
                end
            end

            //reading <other word>
            31: begin
                if(in == " ") state <= 0;
                else state <= 31;
            end

            //error
            41: begin
                state <= 41;
            end

           
            endcase
        end
    end

    // assign isAlpha = ("a" <= in && in <= "z") || ("A" <= in && in <= "Z");
    // assign isSpace = (in == " ");

    // reg [31:0] beginCnt;
    // reg [31:0] endCnt;
    // reg [31:0] beginIndex[31:0];
    // reg [31:0] endIndex[31:0];
    // reg [31:0] wordCnt;
    // reg [31:0] letterCnt;


    // integer i,flag;

    // always @(*) begin
    //     if (beginCnt != endCnt) begin
    //         result = 0;
    //     end
    //     else begin
    //         flag = 0;
    //         for(i = 0 ; i < beginCnt ; i = i + 1) begin
    //             if (beginIndex[i] >= endIndex[i]) begin
    //                 flag = 1;
    //             end
    //         end

    //         if (flag) result = 0;
    //         else result = 1;
    //     end
    // end

    // always @(posedge clk) begin
    //     if (clk) begin

    //     end

    //     else begin
    //         if (is)
    //     end
    // end

    
endmodule
