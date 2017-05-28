`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 11:37:15 AM
// Design Name: 
// Module Name: id
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


module id(
    input					rst,
	input[`InstAddrBus]		pc_i,
	input[`InstBus]			inst_i,
	
	//Read Regfile
	input[`RegBus]			reg1_data_i,
	input[`RegBus]			reg2_data_i,
	
	output reg				reg1_read_o,
	output reg				reg2_read_o,
	output reg[`RegAddrBus]	reg1_addr_o,
	output reg[`RegAddrBus]	reg2_addr_o,
	
	output reg[`AluOpBus]	aluop_o,
	output reg[`AluSelBus]	alusel_o,
	output reg[`RegBus]		reg1_o,
	output reg[`RegBus]		reg2_o,
	output reg[`RegAddrBus]	wd_o,
	output reg				wreg_o
    );
endmodule