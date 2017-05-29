`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 12:43:50 PM
// Design Name: 
// Module Name: id_ex
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


module ID_ALU(

	input		      clk,
	input		      rst,
	
	input[7:0]        id_aluop_i,
	input[2:0]        id_alusel_i,
	input[31:0]       id_reg1_i,
	input[31:0]       id_reg2_i,
	input[4:0]        addr_write_i,
	input             reg_write_en_i,	
	
	output reg[7:0]   alu_aluop_o,
	output reg[2:0]   alu_alusel_o,
	output reg[31:0]  alu_reg1_o,
	output reg[31:0]  alu_reg2_o,
	output reg[4:0]   addr_write_o,
	output reg        reg_write_en_o
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			alu_aluop_o <= `EXE_NOP_OP;
			alu_alusel_o <= `EXE_RES_NOP;
			alu_reg1_o <= `ZeroWord;
			alu_reg2_o <= `ZeroWord;
			addr_write_o <= `NOPRegAddr;
			reg_write_en_o <= `WriteDisable;
		end else begin		
			alu_aluop_o <= id_aluop_i;
			alu_alusel_o <= id_alusel_i;
			alu_reg1_o <= id_reg1_i;
			alu_reg2_o <= id_reg2_i;
			addr_write_o <= addr_write_i;
			reg_write_en_o <= reg_write_en_i;		
		end
	end
	
endmodule