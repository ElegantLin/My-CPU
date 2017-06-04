`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: Tongji University
// Engineer: Zonglin DI
// 
// Create Date: 05/28/2017 10:44:58 AM
// Design Name: 
// Module Name: pc_reg
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


module PC_REG(
    input               clk,
    input               rst,
	input  wire[5:0]	stall,
    output  reg[31:0]   pc,
    output  reg         rom_en_o
    );
    
    always@(posedge clk)
	begin
        if(rst == `RstEnable) begin
            rom_en_o <= `ChipDisable;
    end
	else begin
	rom_en_o <=  `ChipEnable;
	end
	end
	
	always@(posedge clk)
	begin
		if(rom_en_o == `ChipDisable) begin
			pc <= `ZeroWord;
	end
	else if(stall[0] == `NoStop) begin
		pc <= pc + 4'h4;
	end
	end
endmodule
