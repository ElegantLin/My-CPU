`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 11:03:57 AM
// Design Name: 
// Module Name: regfile
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

module regfile(

	input						clk,
	input 						rst,
	
	input 						we,			//write enable
	input[4:0]					waddr,		//write address
	input[31:0]					wdata,		//write data
	
	//reg1
	input						re1,		//reg1 read enable
	input[4:0]			  		raddr1,		//reg1 read address
	output reg[31:0]         	rdata1,		//reg1 read data
	
	//reg2
	input						re2,		//reg2 read enable
	input[4:0]			  		raddr2,		//reg2 read address
	output reg[31:0]         	rdata2		//reg2 read data
	
);

	reg[31:0]  regs[31:0];

	always @ (posedge clk) begin
		if (rst == `RstDisable) begin
			if((we == `WriteEnable) && (waddr != 5'h0)) begin
				regs[waddr] <= wdata;
			end
		end
	end
	
	always @ (*) begin
		if(rst == `RstEnable) begin
			rdata1 <= `ZeroWord;
		end 
		else if(raddr1 == 5'h0) begin
	  		rdata1 <= `ZeroWord;
		end 
		else if((raddr1 == waddr) && (we == `WriteEnable) && (re1 == `ReadEnable)) begin
			rdata1 <= wdata;
		end 
		else if(re1 == `ReadEnable) begin
			rdata1 <= regs[raddr1];
	  end
	  else begin
			rdata1 <= `ZeroWord;
	  end
	end

	always @ (*) begin
		if(rst == `RstEnable) begin
			rdata2 <= `ZeroWord;
		end
		else if(raddr2 == 5'h0) begin
	  		rdata2 <= `ZeroWord;
		end
		else if((raddr2 == waddr) && (we == `WriteEnable)  && (re2 == `ReadEnable)) begin
			rdata2 <= wdata;
		end
		else if(re2 == `ReadEnable) begin
			rdata2 <= regs[raddr2];
		end
		else begin
	      rdata2 <= `ZeroWord;
		end
	end

endmodule