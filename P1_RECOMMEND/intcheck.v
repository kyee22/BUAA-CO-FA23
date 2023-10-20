`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:16:29 09/28/2023 
// Design char: 
// Module char:    intcheck 
// Project char: 
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
module intcheck(
    input clk,
    input reset,
    input [7:0] in,
    output out
    );

    wire isSpace = (in == " ") || (in == "\t");
    wire isAlphaOrUnderline = ("a" <= in && in <= "z") || ("A" <= in && in <= "Z") || (in == "_");
    wire isDigit = "0" <= in && in <= "9";

    reg [3:0] isMatched;
    reg [7:0] state;
    reg [7:0] char[0:2];
    reg [31:0] charCount;

    initial begin
        state <= 0;
        isMatched <= 4'b0000;
        charCount <= 0;
        char[0] <= 0;
        char[1] <= 0;
        char[2] <= 0;
    end

    assign out = (state != 0) ? 0 : 
                (isMatched == 4'b0001) ? 1 : 0;

    always @(posedge clk) begin
        if(reset) begin
            state <= 0;
            isMatched <= 0;
            charCount <= 0;
            char[0] <= 0;
            char[1] <= 0;
            char[2] <= 0;
        end

        else begin
            case(state)
                0: begin
                        isMatched <= 0;
                        charCount <= 0;
                        char[0] <= 0;
                        char[1] <= 0;
                        char[2] <= 0;
                        if(isSpace)state <= 0;
                        else if(in == "i")state <= 1;
                        else if(in == ";")state <= 0;
                        else state <= 30;
                    end

                1: begin
                    if(in == "n") state <= 2;
                    else if(in == ";")state <= 0;
                    else state <= 30;
                end

                2: begin
                    if(in == "t") state <= 3;
                    else if(in == ";")state <= 0;
                    else state <= 30;
                end

                3: begin
                    if(isSpace)state <= 4;
                    else if(in == ";") state <= 0;
                    else state <= 30;
                end

                4: begin
                    if(isSpace) state <= 4;
                    else if(isDigit) state <= 30;
                    else if(isAlphaOrUnderline) begin
                        char[0] <= in;
                        char[1] <= 0;
                        char[2] <= 0;
                        charCount <= 1;
                        state <= 5;
                    end
                    else if(in == ";") state <= 0;
                    else state <= 30;
                end

                5: begin
                    if(isDigit || isAlphaOrUnderline) begin
                        if(charCount <= 32'b1111_1111_1111_1110)charCount <= charCount + 1;

                        if(charCount + 1 == 2) char[1] <= in;
                        if(charCount + 1 == 3) char[2] <= in;
                        state <= 5;
                    end
                    else begin
                        if(char[0] == "i" && char[1] == "n" && char[2] == "t" && charCount == 3)begin
                            state <= 30;
                        end
                        else begin
                            isMatched <= 1;

                            if(isSpace)state <= 6;
                            else if(in == ",")state <= 7;
                            else if(in == ";")state <= 0;
                            else state <= 30;
                        end
                    end
                end
                
                6: begin//reading " " - MATCH!
                    if(isSpace)state <= 6;
                    else if(in == ",") state <= 7;
                    else if(in == ";") state <= 0;
                    else state <= 30;
                end

                7: begin //reading "," - NOT MATCH!
                    if(isSpace)state <= 7;
                    else if(isAlphaOrUnderline) begin
                        char[0] <= in;
                        char[1] <= 0;
                        char[2] <= 0;
                        charCount <= 1;
                        state <= 5;
                    end
                    // else if(in == ";") state <= 0;
                    //                                ↖ bug is here!!!   
                    else if(in == ";") begin
                        isMatched <= 0;
                        state <= 0;
                    end
                    else state <= 30;
                end

                30: begin
                    if(in == ";")begin
                        state <= 0;
                        isMatched <= 0;
                    end
                    else state <= 30;
                end
            endcase
        end
    end

endmodule
