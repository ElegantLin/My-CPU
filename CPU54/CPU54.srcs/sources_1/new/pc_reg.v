`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: Tongji University
// Engineer: Zonglin DI
// 
// Create Date: 05/28/2017 10:44:58 AM
// Design Name: 
// Module Name: pc_reg
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


module pc_reg(

	input						  clk,
	input 						  rst,

	//From Control
	input[5:0]	                  stall,
	input						  flush,   //pipeline flush sigal
	input[31:0]           	 	  new_pc,

	//From ID
	input 	                      branch_flag_i,
	input[31:0]		              branch_target_address_i,
	
	output reg[31:0]   			  pc,
	output reg                    ce	   //chip enable
);

	always @ (posedge clk) begin
		if (ce == `ChipDisable) begin
			pc <= 32'h0000_0000;
		end 
		else begin
			if(flush == 1'b1) begin
				pc <= new_pc;
			end 
			else if(stall[0] == `NoStop) begin
				if(branch_flag_i == `Branch) begin
					pc <= branch_target_address_i;
				end 
				else begin
		  		pc <= pc + 4'h4;
		  	end
			end
		end
	end

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			ce <= `ChipDisable;
		end else begin
			ce <= `ChipEnable;
		end
	end

endmodule