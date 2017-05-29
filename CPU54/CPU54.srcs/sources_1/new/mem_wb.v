`timescale 1ns / 1ps
`include"define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 02:05:09 PM
// Design Name: 
// Module Name: mem_wb
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

module mem_wb(

	input		clk,
	input 		rst,
	
	input[4:0]  addr_write_i,
	input       mem_write_en_i,
	input[31:0] data_write_i,

	output reg[4:0]   addr_write_o,
	output reg        reg_write_en_o,
	output reg[31:0]  data_write_o	       
	
);


	always @ (posedge clk) begin
		if(rst == `RstEnable) begin
			addr_write_o <= `NOPRegAddr;
			reg_write_en_o <= `WriteDisable;
			data_write_o <= `ZeroWord;	
		end else begin
			addr_write_o <= addr_write_i;
			reg_write_en_o <= mem_write_en_i;
			data_write_o <= data_write_i;
		end  
	end     
endmodule
