`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2017 02:26:24 AM
// Design Name: 
// Module Name: Apple
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Apple(
    input clk,
    input rst,
    input signal,
    
    output reg[5:0] apple_x,
    output reg[4:0] apple_y
    );
    reg [31:0]clk_cnt;
    reg [10:0]random_num;
        
    always@(posedge clk)
        random_num <= random_num + 999;
    
    always@(posedge clk or negedge rst) begin
                if(!rst) begin
                    clk_cnt <= 0;
                    apple_x <= 24;
                    apple_y <= 10;
                end
                else begin
                    clk_cnt <= clk_cnt+1;
                    if(clk_cnt == 250_000) begin
                        clk_cnt <= 0;
                        if(signal) begin
                            apple_x <= (random_num[10:5] > 38) ? (random_num[10:5] - 25) : (random_num[10:5] == 0) ? 1 : random_num[10:5];
                            apple_y <= (random_num[4:0] > 28) ? (random_num[4:0] - 3) : (random_num[4:0] == 0) ? 1:random_num[4:0];
                        end
                     end
                 end
            end
     endmodule
