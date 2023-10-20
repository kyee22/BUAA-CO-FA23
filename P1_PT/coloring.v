`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:22:16 10/16/2023 
// Design Name: 
// Module Name:    coloring 
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
module coloring(
    input clk,
    input rst_n,
    input [1:0] color,
    output reg check
    );

    reg [31:0] state;

    initial begin
        state = 0;
        check = 0;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state = 0;
            check = 0;
        end
        else begin



        case(state) 
        
        0: begin
            if(color == 0) state <= 1;
            else if(color == 1) state <= 2;
            else if(color == 2) state <= 3;

            check <= 0;
        end

        1: begin
            if(color == 0) begin
                state <= 11;
                check <= 0;
            end

            else if (color == 1) begin
                state <= 1;
                check <= 1;
            end

            else if(color == 2) begin
                state <= 12;
                check <= 0;
            end
 
        end

        2: begin
            if(color == 0) begin
                state <= 2;
                check <= 1;
            end

            else if(color == 1) begin
                state <= 21;
                check <= 0;
            end

            else if(color == 2) begin
                state <= 22;
                check <= 0;
            end

        end

        3: begin
            if(color == 0) begin
                state <= 31;
                check <= 0;
            end

            else if(color == 1) begin
                state <= 32;
                check <= 0;
            end

            else if(color == 2) begin
                state <= 33;
                check <= 0;
            end

        end

        11: begin
            if(color == 0) begin
                state <= 11;
                check <= 1;
            end

            else if(color == 1) begin
                state <= 11;
                check <= 1;
            end

            else if(color == 2) begin
                state <= 12;
                check <= 0;
            end

        end

        12: begin
            if(color == 0) begin
                state <= 31;
                check <= 0;
            end

            else if(color == 1) begin
                state <= 32;
                check <= 0;
            end

            else if(color == 2) begin
                state <= 33;
                check <= 0;
            end

        end

        21: begin
            if(color == 0) begin
                state <= 21;
                check <= 1;
            end

            else if(color == 1) begin
                state <= 21;
                check <= 1;
            end

            else if(color == 2) begin
                state <= 22;
                check <= 0;
            end

        end

        22: begin
            if(color == 0) begin
                state <= 31;
                check <= 0;
            end

            else if(color == 1) begin
                state <= 32;
                check <= 0;
            end

            else if(color == 2) begin
                state <= 33;
                check <= 0;
            end

        end

        31: begin
            if(color == 0) begin
                state <= 11;
                check <= 0;
            end

            else if(color == 1) begin
                state <= 31;
                check <= 1;
            end

            else if(color == 2) begin
                state <= 12;
                check <= 0;
            end

        end

        32: begin
            if(color == 0) begin
                state <= 32;
                check <= 1;
            end

            else if(color == 1) begin
                state <= 21;
                check <= 0;
            end

            else if(color == 2) begin
                state <= 22;
                check <= 0;
            end

        end

        33: begin
            if(color == 0) begin
                state <= 31;
                check <= 0;
            end

            else if(color == 1) begin
                state <= 32;
                check <= 0;
            end

            else if(color == 2) begin
                state <= 33;
                check <= 1;
            end

        end

        endcase
        end
    end


endmodule
