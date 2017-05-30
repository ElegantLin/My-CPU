`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 01:57:10 PM
// Design Name: 
// Module Name: ex_mem
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


module ALU_MEM(

	input		clk,
	input       rst,
		
	input[4:0]  addr_write_i,
	input       mem_write_en_i,
	input[31:0] data_write_i, 	
	
	input[31:0] ex_data_hi_i,
	input[31:0] ex_data_lo_i,
	input		ex_write_hilo_en_i,
	
	output reg[4:0]      addr_write_o,
	output reg           mem_write_en_o,
	output reg[31:0]	 data_write_o,
	
	output reg[31:0]	 mem_data_hi_o,
	output reg[31:0]	 mem_data_lo_o,
	output reg			 mem_write_hilo_en_o
	
);


	always @ (posedge clk) begin
		if(rst == `RstEnable) begin
			addr_write_o <= `NOPRegAddr;
			mem_write_en_o <= `WriteDisable;
			data_write_o <= `ZeroWord;
			mem_data_hi_o <= `ZeroWord;
			mem_data_lo_o <= `ZeroWord;
			mem_write_hilo_en_o <= `WriteDisable;
		end else begin
			addr_write_o <= addr_write_i;
			mem_write_en_o <= mem_write_en_i;
			data_write_o <= data_write_i;
			mem_data_hi_o <= ex_data_hi_i;
			mem_data_lo_o <= ex_data_lo_i;
			mem_write_hilo_en_o <= `WriteEnable;			
		end    //if
	end      //always
			

endmodule