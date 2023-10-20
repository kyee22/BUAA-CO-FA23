`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:08:26 10/20/2023 
// Design Name: 
// Module Name:    P1_L7_string2 
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
module string2(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );

    reg [31:0] state;
    assign isDigit = ("0" <= in && in <= "9");
    assign isOperator = (in == "+") || (in == "*");

    assign out = (state == 11);

    initial begin
        state = 0;
    end

    always @(posedge clk or posedge clr)begin
        if(clr) begin
            state = 0;
        end

        else begin
            case(state)
            0:begin     // ...
                if(isDigit) state <= 11;
                else if(isOperator) state <= 77;
                else if(in == "(") state <= 21;
                else if(in == ")") state <= 77;
                else state <= 77;
            end

            11:begin    // 1 ...
                if(isDigit) state <= 77;
                else if(isOperator) state <= 12;
                else if(in == "(") state <= 77;
                else if(in == ")") state <= 77;
                else state <= 77;
            end

            12:begin    //1 + ...
                if(isDigit) state <= 11;
                else if(isOperator) state <= 77;
                else if(in == "(") state <= 21;
                else if(in == ")") state <= 77;
                else state <= 77;
            end

            21:begin    // ( ...
                if(isDigit) state <= 22;
                else if(isOperator) state <= 77;
                else if(in == "(") state <= 77;
                else if(in == ")") state <= 77;
                else state <= 77;
            end

            22:begin    // ( 1 ...
                if(isDigit) state <= 77;
                else if(isOperator) state <= 23;
                else if(in == "(") state <= 77;
                else if(in == ")") state <= 11;
                else state <= 77;
            end

            23:begin    // ( 1 + ...
                if(isDigit) state <= 22;
                else if(isOperator) state <= 77;
                else if(in == "(") state <= 77;
                else if(in == ")") state <= 77;
                else state <= 77;
            end

            77: begin
                state <= 77;
            end

            default:begin
                state <= state;
            end

            endcase
        end
    end


endmodule
