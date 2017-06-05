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

	input						 clk,
	input 						 rst,
	
	//From ctrl.v
	input[5:0]               	 stall,	
	input 		                 flush,	
	
	//From mem.v	
	input[4:0]       		 	 mem_wd,		//write address
	input		                 mem_wreg,		//write enable
	input[31:0]					 mem_wdata,		//write data
	input[31:0]          		 mem_hi,		//write high reg
	input[31:0]		             mem_lo,		//write low reg
	input	                  	 mem_whilo,		//write high_low enable	
	
	input		                 mem_LLbit_we,	//write LLbit enable
	input	                     mem_LLbit_value,	//write LLbit data

	input		                 mem_cp0_reg_we,	//write cp0 enable
	input[4:0]	                 mem_cp0_reg_write_addr,//write cp0 address
	input[31:0] 		         mem_cp0_reg_data,	//write cp0 data

	//To write back
	output reg[4:0]		         wb_wd,			//write back address
	output reg                   wb_wreg,		//write back enable
	output reg[31:0]			 wb_wdata,		//write back data
	output reg[31:0]    	     wb_hi,			//write back hi reg
	output reg[31:0]	         wb_lo,			//write back low reg
	output reg                   wb_whilo,

	output reg                  wb_LLbit_we,
	output reg                  wb_LLbit_value,

	output reg                   wb_cp0_reg_we,
	output reg[4:0]              wb_cp0_reg_write_addr,
	output reg[`RegBus]          wb_cp0_reg_data								       
	
);


	always @ (posedge clk) begin
		if(rst == `RstEnable) begin
			wb_wd <= `NOPRegAddr;
			wb_wreg <= `WriteDisable;
		  wb_wdata <= `ZeroWord;	
		  wb_hi <= `ZeroWord;
		  wb_lo <= `ZeroWord;
		  wb_whilo <= `WriteDisable;
		  wb_LLbit_we <= 1'b0;
		  wb_LLbit_value <= 1'b0;		
			wb_cp0_reg_we <= `WriteDisable;
			wb_cp0_reg_write_addr <= 5'b00000;
			wb_cp0_reg_data <= `ZeroWord;			
		end else if(flush == 1'b1 ) begin
			wb_wd <= `NOPRegAddr;
			wb_wreg <= `WriteDisable;
		  wb_wdata <= `ZeroWord;
		  wb_hi <= `ZeroWord;
		  wb_lo <= `ZeroWord;
		  wb_whilo <= `WriteDisable;
		  wb_LLbit_we <= 1'b0;
		  wb_LLbit_value <= 1'b0;	
			wb_cp0_reg_we <= `WriteDisable;
			wb_cp0_reg_write_addr <= 5'b00000;
			wb_cp0_reg_data <= `ZeroWord;				  				  	  	
		end else if(stall[4] == `Stop && stall[5] == `NoStop) begin
			wb_wd <= `NOPRegAddr;
			wb_wreg <= `WriteDisable;
		  wb_wdata <= `ZeroWord;
		  wb_hi <= `ZeroWord;
		  wb_lo <= `ZeroWord;
		  wb_whilo <= `WriteDisable;	
		  wb_LLbit_we <= 1'b0;
		  wb_LLbit_value <= 1'b0;	
			wb_cp0_reg_we <= `WriteDisable;
			wb_cp0_reg_write_addr <= 5'b00000;
			wb_cp0_reg_data <= `ZeroWord;					  		  	  	  
		end else if(stall[4] == `NoStop) begin
			wb_wd <= mem_wd;
			wb_wreg <= mem_wreg;
			wb_wdata <= mem_wdata;
			wb_hi <= mem_hi;
			wb_lo <= mem_lo;
			wb_whilo <= mem_whilo;		
		  wb_LLbit_we <= mem_LLbit_we;
		  wb_LLbit_value <= mem_LLbit_value;		
			wb_cp0_reg_we <= mem_cp0_reg_we;
			wb_cp0_reg_write_addr <= mem_cp0_reg_write_addr;
			wb_cp0_reg_data <= mem_cp0_reg_data;			  		
		end    //if
	end      //always
			

endmodule