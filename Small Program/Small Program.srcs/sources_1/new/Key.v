`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2017 02:07:32 AM
// Design Name: 
// Module Name: Key
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


//按键检测模块 延时消抖
	module Key
(	input clk,
	input rst,
	
	input left,
	input right,
	input up,
	input down,
	
	output reg[2:0] direction
);

	reg [31:0]clk_cnt;
	reg left_key_last;
	reg right_key_last;
	reg up_key_last;
	reg down_key_last;
	
	always@(posedge clk or negedge rst) begin
		if(!rst) begin
			clk_cnt <= 0;
			direction <= 3'b0;
					
			left_key_last <= 0;
			right_key_last <= 0;
			up_key_last <= 0;
			down_key_last <= 0;					
		end	
		else begin
			if(clk_cnt == 5_0000) begin
				clk_cnt <= 0;
				left_key_last <= left;
				right_key_last <= right;
				up_key_last <= up;
				down_key_last <= down;
					
				if(left_key_last == 0 && left == 1) 
					direction <= 3'b001;
				if(right_key_last == 0 && right == 1)
					direction <= 3'b010;
				if(up_key_last == 0 && up == 1)
					direction <= 3'b011;
				if(down_key_last == 0 && down == 1)
					direction <= 3'b100;
			end						
			else begin
				clk_cnt <= clk_cnt + 1;
				direction <= 3'b000;
			end
		end	
	end				
endmodule
