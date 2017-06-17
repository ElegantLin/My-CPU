`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2017 10:33:49 AM
// Design Name: 
// Module Name: Small Program Top
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


module Small_Program_Top(
    input clk,
	input rst,
	
	input left,
	input right,
	input up,
	input down,

	output hsync,
	output vsync,
	output [11:0]color_out,
	output [7:0]seg_out,
	output [3:0]sel
    );
    wire[7:0]  direction;
    wire[7:0]  appleX;
    wire[7:0]  appleY;
    wire[15:0] point;
    wire[1:0]  game_status;
    wire[7:0]  snake;
    wire[9:0]  pos_x;
    wire[9:0]  pos_y;
    wire clk0;
    wire clk1;
    
    clk_div clk_div0(
    .clkin(clk),
    .clkout(clk0));
    
    clk_div clk_div1(
    .clkin(clk0),
    .clkout(clk1));
    
    Key key0(
    .clk(clk0),
    .rst(rst),
    .left(left),
    .right(right),
    .up(up),
    .down(down),
    .direction(direction));
    
    Apple apple0(
    .clk(clk0),
    .rst(rst),
    .signal(signal),
    .apple_x(appleX),
    .apple_y(appleY));
    
    openmips_min_sopc openmips_min_sopc0(
    .clk(clk0),
    .rst(rst),
    .direction(direction),
    .signal(signal),
    .point(point),
    .AppleX(appleX),
    .AppleY(appleY),
    .snake(snake),
    .gamestatus(game_status)
    );
    
   Seg_Display seg_display0
    (
    .clk(clk0),
    .rst(rst),
    .add_cube(signal),
    .game_status(game_status),
    .point(point),
    .seg_out(seg_out),
    .sel(sel)
    );
    
    VGA_Control vga1(
    .clk(clk1),
    .rst(rst),
    .snake(snake),
    .apple_x(appleX),
    .apple_y(appleY),
    .x_pos(pos_x),
    .y_pos(pos_y),
    .hsync(hsync),
    .vsync(vsync),
    .color_out(color_out));
    
    
endmodule
