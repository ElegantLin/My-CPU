`timescale 1ns / 1ps
`include"define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 02:07:43 PM
// Design Name: 
// Module Name: openmips
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


module openmips(

	input			      clk,
	input 				  rst,
	input[31:0]           rom_data_i,
	output[31:0]          rom_addr_o,
	output                rom_en_o
	
);
	wire[31:0] pc;
	wire[31:0] if_id_instr_addr;
    wire[31:0] if_id_instr;
    wire reg1_read_en;
    wire reg2_read_en;
    wire[31:0] reg1_data;
    wire[31:0] reg2_data;
    wire[4:0] reg1_addr;
    wire[4:0] reg2_addr;
    wire[7:0] id_aluop;
    wire[2:0] id_alusel;
    wire[31:0] id_reg1;
    wire[31:0] id_reg2;
    wire[4:0] id_addr_write;
    wire id_write_en;
	wire[4:0] reg_write_addr;
    wire reg_write_en;
    wire[31:0] reg_write_data;
    wire[7:0] aluop;
    wire[2:0] alusel;
    wire[31:0] alureg1;
    wire[31:0] alureg2;
    wire alu_write_en;
    wire[4:0] alu_write_addr;
	wire[4:0] alu_mem_write_addr;
    wire[31:0] alu_mem_write_data;
    wire alu_mem_write_en;
    wire[4:0] mem_write_addr;
    wire mem_write_en;
    wire[31:0] mem_write_data;
	wire[4:0] mem_wr_write_addr;
    wire mem_wr_write_en;
    wire[31:0] mem_wr_write_data;
	
	PC_REG pc_reg0(
		.clk(clk),
		.rst(rst),
		.pc(pc),
		.rom_en_o(rom_en_o)		
	);
	assign rom_addr_o = pc;
	
	IF_ID if_id0(
		.clk(clk),
		.rst(rst),
		.instr_addr_i(pc),
		.instr_i(rom_data_i),
		.instr_addr_o(if_id_instr_addr),
		.instr_o(if_id_instr)      	
	);
	

	
	ID id0(
		.rst(rst),
		.instr_addr_i(if_id_instr_addr),
		.instr_i(if_id_instr),

		.reg1_data_i(reg1_data),
		.reg2_data_i(reg2_data),
        
        .ex_reg_write_en_i(alu_mem_write_en),
        .ex_data_write_i(alu_mem_write_data),
        .ex_addr_write_i(alu_mem_write_addr),
        
        .mem_reg_write_en_i(mem_wr_write_en),
        .mem_data_write_i(mem_wr_write_data),
        .mem_addr_write_i(mem_wr_write_addr),
        
		.reg1_read_en_o(reg1_read_en),
		.reg2_read_en_o(reg2_read_en), 	  

		.reg1_read_addr_o(reg1_addr),
		.reg2_read_addr_o(reg2_addr), 
	  
		.aluop_o(id_aluop),
		.alusel_o(id_alusel),
		.reg1_o(id_reg1),
		.reg2_o(id_reg2),
		.addr_write_o(id_addr_write),
		.reg_write_en_o(id_write_en)
	);


	
	Regfile regfile1(
		.clk (clk),
		.rst (rst),
		
		.we_i (reg_write_en),
		.addr_write_i (reg_write_addr),
		.data_write_i (reg_write_data),
		
		
		.re1 (reg1_read_en),
		.addr1_read_i (reg1_addr),
		.data1_read_o (reg1_data),
		.re2 (reg2_read_en),
		.addr2_read_i (reg2_addr),
		.data2_read_o (reg2_data)
	);
	

	
	ID_ALU id_alu0(
		.clk(clk),
		.rst(rst),
		
		.id_aluop_i(id_aluop),
		.id_alusel_i(id_alusel),
		.id_reg1_i(id_reg1),
		.id_reg2_i(id_reg2),
		.addr_write_i(id_addr_write),
		.reg_write_en_i(id_write_en),

		.alu_aluop_o(aluop),
		.alu_alusel_o(alusel),
		.alu_reg1_o(alureg1),
		.alu_reg2_o(alureg2),
		.addr_write_o(alu_write_addr),
		.reg_write_en_o(alu_write_en)
	);	
	

	
	ALU alu0(
		.rst(rst),
		.aluop_i(aluop),
		.alusel_i(alusel),
		.reg1_i(alureg1),
		.reg2_i(alureg2),
		.addr_write_i(alu_write_addr),
		.write_en_i(alu_write_en),
	  
		.addr_write_o(alu_mem_write_addr),
		.write_en_o(alu_mem_write_en),
		.data_write_o(alu_mem_write_data)
		
	);	
	

	
	ALU_MEM alu_mem0(
		.clk(clk),
		.rst(rst),
		.addr_write_i(alu_mem_write_addr),
		.mem_write_en_i(alu_mem_write_en),
		.data_write_i(alu_mem_write_data),
	
		.addr_write_o(mem_write_addr),
		.mem_write_en_o(mem_write_en),
		.data_write_o(mem_write_data)				       	
	);
	
	mem mem0(
		.rst(rst),
		.addr_write_i(mem_write_addr),
		.mem_write_en_i(mem_write_en),
		.data_write_i(mem_write_data),
		
		.addr_write_o(mem_wr_write_addr),
		.mem_write_en_o(mem_wr_write_en),
		.data_write_o(mem_wr_write_data)
	);

	mem_wb mem_wb0(
		.clk(clk),
		.rst(rst),

		.addr_write_i(mem_wr_write_addr),
		.mem_write_en_i(mem_wr_write_en),
		.data_write_i(mem_wr_write_data),
	
		.addr_write_o(reg_write_addr),
		.reg_write_en_o(reg_write_en),
		.data_write_o(reg_write_data)							       	
	);

endmodule
