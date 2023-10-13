`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:31 10/10/2023 
// Design Name: 
// Module Name:    P1_L0_expr 
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
module expr(
    input clk,
    input clr,
    input [7:0] in,
    output out
    );

    reg [31:0] state;

    initial begin
        state = 0;
    end

    assign isDigit = ("0" <= in && in <= "9");
    assign isOp = (in == "+" || in == "*");


    assign out = (state == 1) ? 1 : 0;

    always @(posedge clk or posedge clr) begin
        if (clr) begin
            state <= 0;
        end

        else begin
            case (state)
            0: begin
                if(isDigit) state <= 1;
                else state <= 3;
            end

            1: begin
                if(isOp) state <= 2;
                else state <= 3;
            end

            2: begin
                if(isDigit) state <= 1;
                else state <= 3;
            end

            3: begin
                state <= 3;
            end
            endcase
        end

    end


endmodule
