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
input clkin, //Input Clock
input rst,    //Async Reset signal, active high
output clkout
); //Output signal divided by two
reg clkout;
always @ (posedge clkin or posedge rst)
    if(rst)
        clkout <= 1'b0;
    else
        clkout <= ~clkout;
endmodule
