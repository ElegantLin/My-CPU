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
	wire[4:0] mem_wb_write_addr;
    wire mem_wb_write_en;
    wire[31:0] mem_wb_write_data;
    
    wire[31:0] alu_mem_write_hi;
    wire[31:0] alu_mem_write_lo;
    wire       alu_mem_write_hilo_en;
    
    wire[31:0] mem_write_hi;
    wire[31:0] mem_write_lo;
    wire       mem_write_hilo_en;
    
    wire       mem_wb_write_hilo_en;
    wire[31:0] mem_wb_write_hi;
    wire[31:0] mem_wb_write_lo;
    
    wire       wb_hilo_write_en;
    wire[31:0] wb_hilo_write_hi;
    wire[31:0] wb_hilo_write_lo;
    
    wire[31:0] hilo_alu_hi;
    wire[31:0] hilo_alu_lo;
	
	wire[5:0] id_ctrl;
	wire[5:0] alu_ctrl;
	wire[5:0] ctrl_out_stall;
	
	wire[1:0] cnt_ex_exmem;
	wire[63:0] hilo_temp_ex_exmem;
	wire[1:0] cnt_exmem_ex;
	wire[63:0] hilo_temp_exmem_ex;
	
	PC_REG pc_reg0(
		.clk(clk),
		.rst(rst),
		.pc(pc),
		.stall(ctrl_out_stall),
		.rom_en_o(rom_en_o)		
	);
	assign rom_addr_o = pc;
	
	IF_ID if_id0(
		.clk(clk),
		.rst(rst),
		.stall(ctrl_out_stall),
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
        
        .mem_reg_write_en_i(mem_wb_write_en),
        .mem_data_write_i(mem_wb_write_data),
        .mem_addr_write_i(mem_wb_write_addr),
        
		.reg1_read_en_o(reg1_read_en),
		.reg2_read_en_o(reg2_read_en), 	  

		.reg1_read_addr_o(reg1_addr),
		.reg2_read_addr_o(reg2_addr), 
	  
		.stallreq(id_ctrl),
		
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
		.stall(ctrl_out_stall),
		
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
		
		.mem_write_hilo_en_i(mem_wb_write_hilo_en),
        .mem_data_lo_write_i(mem_wb_write_lo),
        .mem_data_hi_write_i(mem_wb_write_hi),
        
        .wb_write_hilo_en_i(wb_hilo_write_en),
        .wb_data_lo_write_i(wb_hilo_write_lo),
        .wb_data_hi_write_i(wb_hilo_write_hi),
        
        .data_hi_write_i(hilo_alu_hi),
        .data_lo_write_i(hilo_alu_lo),
        
		.addr_write_o(alu_mem_write_addr),
		.write_en_o(alu_mem_write_en),
		.data_write_o(alu_mem_write_data),
		
		.ex_write_hilo_en_o(alu_mem_write_hilo_en),
		.ex_data_lo_write_o(alu_mem_write_lo),
		.ex_data_hi_write_o(alu_mem_write_hi),
		
		.stallreq(alu_ctrl),
		
		.hilo_double_temp_i(hilo_temp_exmem_ex),
		.cnt_i(cnt_exmem_ex),
		.cnt_o(cnt_ex_exmem),
		.hilo_double_temp_o(hilo_temp_ex_exmem)
	);	
	

	
	ALU_MEM alu_mem0(
		.clk(clk),
		.rst(rst),
		.addr_write_i(alu_mem_write_addr),
		.mem_write_en_i(alu_mem_write_en),
		.data_write_i(alu_mem_write_data),
		
		.ex_write_hilo_en_i(alu_mem_write_hilo_en),
		.ex_data_hi_i(alu_mem_write_hi),
		.ex_data_lo_i(alu_mem_write_lo),
		.stall(ctrl_out_stall),
	
		.addr_write_o(mem_write_addr),
		.mem_write_en_o(mem_write_en),
		.data_write_o(mem_write_data),
		
		.mem_data_hi_o(mem_write_hi),
		.mem_data_lo_o(mem_write_lo),
		.mem_write_hilo_en_o(mem_write_hilo_en),
		
		.cnt_i(cnt_ex_exmem),
		.hilo_i(hilo_temp_ex_exmem),
		.cnt_o(cnt_exmem_ex),
		.hilo_o(hilo_temp_exmem_ex)
	);
	
	mem mem0(
		.rst(rst),
		.addr_write_i(mem_write_addr),
		.mem_write_en_i(mem_write_en),
		.data_write_i(mem_write_data),
		
		.hi_write_i(mem_write_hi),
		.lo_write_i(mem_write_lo),
		.write_hilo_en_i(mem_write_hilo_en),
		
		.addr_write_o(mem_wb_write_addr),
		.mem_write_en_o(mem_wb_write_en),
		.data_write_o(mem_wb_write_data),
		
		.write_hilo_en_o(mem_wb_write_hilo_en),
		.hi_write_o(mem_wb_write_hi),
		.lo_write_o(mem_wb_write_lo)
	);

	mem_wb mem_wb0(
		.clk(clk),
		.rst(rst),

		.addr_write_i(mem_wb_write_addr),
		.mem_write_en_i(mem_wb_write_en),
		.data_write_i(mem_wb_write_data),
		
		.mem_data_lo_write_i(mem_wb_write_lo),
		.mem_data_hi_write_i(mem_wb_write_hi),
		.mem_hilo_write_en_i(mem_wb_write_hilo_en),
		.stall(ctrl_out_stall),
		.addr_write_o(reg_write_addr),
		.reg_write_en_o(reg_write_en),
		.data_write_o(reg_write_data),
		
		.wb_data_lo_write_o(wb_hilo_write_lo),
		.wb_data_hi_write_o(wb_hilo_write_hi),
		.wb_hilo_write_en_o(wb_hilo_write_en)							       	
	);
	
	hilo_reg hilo_reg0(
	    .clk(clk),
	    .rst(rst),
	    .we(wb_hilo_write_en),
	    .hi_data_write_i(wb_hilo_write_hi),
	    .lo_data_write_i(wb_hilo_write_lo),
	    
	    .hi_data_read_o(hilo_alu_hi),
	    .lo_data_read_o(hilo_alu_lo)
	 );
	 
	 CTRL ctrl0(
		.rst(rst),
		.stallreq_from_id(id_ctrl),
		.stallreq_from_ex(alu_ctrl),
		.stall(ctrl_out_stall)
	);
endmodule
