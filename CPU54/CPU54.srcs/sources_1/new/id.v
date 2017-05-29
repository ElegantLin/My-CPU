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

//Instruction Decode
module ID(

	input 				rst,
	input[31:0]			instr_addr_i,
	input[31:0]     	instr_i,

	input[31:0]     	reg1_data_i,
	input[31:0]     	reg2_data_i,

	//送到regfile的信息
	output reg      	reg1_read_en_o,
	output reg      	reg2_read_en_o,     
	output reg[4:0] 	reg1_read_addr_o,
	output reg[4:0] 	reg2_read_addr_o, 	      
	
	//送到执行阶段的信息
	output reg[7:0] 	aluop_o,
	output reg[2:0] 	alusel_o,
	output reg[31:0]  	reg1_o,
	output reg[31:0]    reg2_o,
	output reg[4:0]     addr_write_o,
	output reg          reg_write_en_o
);

  wire[5:0] op = instr_i[31:26];
  wire[4:0] op2 = instr_i[10:6];
  wire[5:0] op3 = instr_i[5:0];
  wire[4:0] op4 = instr_i[20:16];
  reg[31:0]	imm;
  reg instvalid;
  
 
	always @ (*) begin	
		if (rst == `RstEnable) begin
			aluop_o <= `EXE_NOP_OP;
			alusel_o <= `EXE_RES_NOP;
			addr_write_o <= `NOPRegAddr;
			reg_write_en_o <= `WriteDisable;
			instvalid <= `InstValid;
			reg1_read_en_o <= 1'b0;
			reg2_read_en_o <= 1'b0;
			reg1_read_addr_o <= `NOPRegAddr;
			reg2_read_addr_o <= `NOPRegAddr;
			imm <= 32'h0;			
	  end else begin
			aluop_o <= `EXE_NOP_OP;
			alusel_o <= `EXE_RES_NOP;
			addr_write_o <= instr_i[15:11];
			reg_write_en_o <= `WriteDisable;
			instvalid <= `InstInvalid;	   
			reg1_read_en_o <= 1'b0;
			reg2_read_en_o <= 1'b0;
			reg1_read_addr_o <= instr_i[25:21];
			reg2_read_addr_o <= instr_i[20:16];		
			imm <= `ZeroWord;
			
		  case (op)
		  	`EXE_ORI:begin            
		  		reg_write_en_o <= `WriteEnable;	
				aluop_o <= `EXE_OR_OP;
		  		alusel_o <= `EXE_RES_LOGIC; 
				reg1_read_en_o <= `ReadEnable;	
				reg2_read_en_o <= `ReadDisable;	  	
				imm <= {16'h0, instr_i[15:0]};
				addr_write_o <= instr_i[20:16];
				instvalid <= `InstValid;	
		  	end 							 
		    default:begin
		    end
		  endcase		  //case op			
		end       //if
	end         //always
	

	always @ (*) begin
		if(rst == `RstEnable) begin
			reg1_o <= `ZeroWord;
	  end else if(reg1_read_en_o == `ReadEnable) begin
	  	reg1_o <= reg1_data_i;
	  end else if(reg1_read_en_o == `ReadDisable) begin
	  	reg1_o <= imm;
	  end else begin
	    reg1_o <= `ZeroWord;
	  end
	end
	
	always @ (*) begin
		if(rst == `RstEnable) begin
			reg2_o <= `ZeroWord;
	  end else if(reg2_read_en_o == `ReadEnable) begin
	  	reg2_o <= reg2_data_i;
	  end else if(reg2_read_en_o == `ReadDisable) begin
	  	reg2_o <= imm;
	  end else begin
	    reg2_o <= `ZeroWord;
	  end
	end

endmodule