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
	
	input[31:0] mem_data_lo_write_i,
	input[31:0] mem_data_hi_write_i,
	input 		mem_hilo_write_en_i,
	input[5:0]	  	  stall,

	output reg[4:0]   addr_write_o,
	output reg        reg_write_en_o,
	output reg[31:0]  data_write_o,
	
	output reg[31:0]  wb_data_lo_write_o,
	output reg[31:0]  wb_data_hi_write_o,
	output reg        wb_hilo_write_en_o
	
);


	always @ (posedge clk) begin
		if(rst == `RstEnable) begin
			addr_write_o <= `NOPRegAddr;
			reg_write_en_o <= `WriteDisable;
			data_write_o <= `ZeroWord;
			wb_data_hi_write_o <= `ZeroWord;
			wb_data_lo_write_o <= `ZeroWord;
			wb_hilo_write_en_o <= `WriteDisable;
		end else if(stall[4] == `Stop && stall[5] == `NoStop) begin
			addr_write_o <= `NOPRegAddr;
			reg_write_en_o <= `WriteDisable;
			data_write_o <= `ZeroWord;
			wb_data_hi_write_o <= `ZeroWord;
			wb_data_lo_write_o <= `ZeroWord;
			wb_hilo_write_en_o <= `WriteDisable;
		end else if(stall[4] == `NoStop) begin
			addr_write_o <= addr_write_i;
			reg_write_en_o <= mem_write_en_i;
			data_write_o <= data_write_i;
			wb_data_hi_write_o <= mem_data_hi_write_i;
			wb_data_lo_write_o <= mem_data_lo_write_i;
			wb_hilo_write_en_o <= mem_hilo_write_en_i;
		end  
	end     
endmodule
