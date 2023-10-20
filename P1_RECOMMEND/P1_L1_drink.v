`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:52:05 10/20/2023 
// Design Name: 
// Module Name:    P1_L1_drink 
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
module drink(
    input clk,
    input reset,
    input [1:0] coin,
    output reg drink,
    output reg [1:0] back
    );

    reg [31:0] state;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state = 0;
            drink <= 0;
            back <= 0;
        end

        else begin
            case(state)
            0: begin
                if(coin==0) begin
                    state <= 0;
                    drink <= 0;
                    back <= 0;
                end 
                else if(coin==1) begin
                    state <= 5;
                    drink <= 0;
                    back <= 0;
                end
                else if(coin==2) begin
                    state <= 10;
                    drink <= 0;
                    back <= 0;
                end
                else if(coin==3) begin
                    state <= 0;
                    drink <= 0;
                    back <= 0;
                end
            end

            5: begin
                if(coin==0) begin
                    state <= 5;
                    drink <= 0;
                    back <= 0;
                end 
                else if(coin==1) begin
                    state <= 10;
                    drink <= 0;
                    back <= 0;
                end
                else if(coin==2) begin
                    state <= 15;
                    drink <= 0;
                    back <= 0;
                end
                else if(coin==3) begin
                    state <= 0;
                    drink <= 0;
                    back <= 1;
                end
            end

            10: begin
                if(coin==0) begin
                    state <= 10;
                    drink <= 0;
                    back <= 0;
                end 
                else if(coin==1) begin
                    state <= 15;
                    drink <= 0;
                    back <= 0;
                end
                else if(coin==2) begin
                    state <= 0;
                    drink <= 1;
                    back <= 0;
                end
                else if(coin==3) begin
                    state <= 0;
                    drink <= 0;
                    back <= 2;
                end
            end

            15: begin
                if(coin==0) begin
                    state <= 15;
                    drink <= 0;
                    back <= 0;
                end 
                else if(coin==1) begin
                    state <= 0;
                    drink <= 1;
                    back <= 0;
                end
                else if(coin==2) begin
                    state <= 0;
                    drink <= 1;
                    back <= 1;
                end
                else if(coin==3) begin
                    state <= 0;
                    drink <= 0;
                    back <= 3;
                end
            end
            endcase
        end

    end


endmodule
