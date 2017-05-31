`timescale 1ns / 1ps
`include"define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 02:00:39 PM
// Design Name: 
// Module Name: mem
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


module mem(

	input 		  rst,
		
	input[4:0]    addr_write_i,
	input         mem_write_en_i,
	input[31:0]	  data_write_i,
	
	input[31:0]	  hi_write_i,
	input[31:0]   lo_write_i,
	input		  write_hilo_en_i,
	
	output reg[4:0]   addr_write_o,
	output reg        mem_write_en_o,
	output reg[31:0]  data_write_o,
	
	output reg[31:0]  hi_write_o,
	output reg[31:0]  lo_write_o,
	output reg		  write_hilo_en_o
	
);

	
	always @ (*) begin
		if(rst == `RstEnable) begin
			addr_write_o <= `NOPRegAddr;
			mem_write_en_o <= `WriteDisable;
			data_write_o <= `ZeroWord;
			hi_write_o <= `ZeroWord;
			lo_write_o <= `ZeroWord;
			write_hilo_en_o <= `WriteDisable;
		end else begin
			addr_write_o <= addr_write_i;
			mem_write_en_o <= mem_write_en_i;
			data_write_o <= data_write_i;
			hi_write_o <= hi_write_i;
			lo_write_o <= lo_write_i;
			write_hilo_en_o <= write_hilo_en_i;
		end    //if
	end      //always
			

endmodule