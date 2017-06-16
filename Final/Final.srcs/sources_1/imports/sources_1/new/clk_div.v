`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2017 03:55:34 PM
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input clkin,
    output clkout);

    reg clkout;
    reg[2:0] temp;
always @(posedge clkin) begin
    temp<=temp+1;
    if(temp==2) begin
        clkout<=~clkout;
        temp<=0;
    end else 
        clkout<=clkout;
    end
endmodule
