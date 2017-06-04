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
	input[5:0]			stall,
	
	output reg[4:0]      addr_write_o,
	output reg           mem_write_en_o,
	output reg[31:0]	 data_write_o,
	
	output reg[31:0]	 mem_data_hi_o,
	output reg[31:0]	 mem_data_lo_o,
	output reg			 mem_write_hilo_en_o,
	
	input[63:0]			 hilo_i,
	input[1:0]			 cnt_i,
	output reg[63:0]	 hilo_o,
	output reg[1:0]		 cnt_o
);


	always @ (posedge clk) begin
		if(rst == `RstEnable) begin
			addr_write_o <= `NOPRegAddr;
			mem_write_en_o <= `WriteDisable;
			data_write_o <= `ZeroWord;
			mem_data_hi_o <= `ZeroWord;
			mem_data_lo_o <= `ZeroWord;
			mem_write_hilo_en_o <= `WriteDisable;
			hilo_o <= {`ZeroWord, `ZeroWord};
			cnt_o <= 2'b00;
		end else if(stall[3] == `Stop && stall[4] == `NoStop) begin
			addr_write_o <= `NOPRegAddr;
			mem_write_en_o <= `WriteDisable;
			data_write_o <= `ZeroWord;
			mem_data_hi_o <= `ZeroWord;
			mem_data_lo_o <= `ZeroWord;
			mem_write_hilo_en_o <= `WriteDisable;
			hilo_o <= hilo_i;
			cnt_o <= cnt_i;
		end else if(stall[3] == `NoStop) begin
			addr_write_o <= addr_write_i;
			mem_write_en_o <= mem_write_en_i;
			data_write_o <= data_write_i;
			mem_data_hi_o <= ex_data_hi_i;
			mem_data_lo_o <= ex_data_lo_i;
			mem_write_hilo_en_o <= ex_write_hilo_en_i;
			hilo_o <= {`ZeroWord, `ZeroWord};
			cnt_o <= 2'b00;
		end else begin
			hilo_o <= hilo_i;
			cnt_o <= cnt_i;
		end
	end      //always
			

endmodule