`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2017 03:09:50 PM
// Design Name: 
// Module Name: top
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

module top(
    input clk,
    input rst,
    output[7:0] o_seg,
    output[7:0] o_sel
);

wire clk50;
wire seg7_cs;
wire[31:0] addr;
clk_div clk_div0(
    .clkin(clk),
    .rst(rst),
    .clkout(clk50));

io_sel io_sel1(
    .addr(32'h10010000),
    .cs(1),
    .seg7_cs(seg7_cs)
    );

openmips_min_sopc openmips_min_sopc1(
    .clk(clk),
    .rst(rst),
    .data0(addr)
    );
    
seg7x16 seg7x16_1(
    .clk(clk),
    .reset(rst),
    .cs(1),
    .i_data(addr),
    .o_seg(o_seg),
    .o_sel(o_sel));

endmodule
