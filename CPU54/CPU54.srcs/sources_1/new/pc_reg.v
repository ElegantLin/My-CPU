`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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


module pc_reg(
    input                       clk,
    input                       rst,
    output  reg[`InstAddrBus]   pc,
    output  reg                 ce
    );
    
    always@(posedge clk)
	begin
        if(rst == `RstEnable) begin
            ce <= `ChipDisable;
    end
	else begin
	ce <=  `ChipEnable;
	end
	end
	
	always@(posedge clk)
	begin
		if(ce == `ChipDisable) begin
			pc <= `ZeroWord;
	end
	else begin
		pc <= pc + 4'h4;
	end
	end
endmodule
