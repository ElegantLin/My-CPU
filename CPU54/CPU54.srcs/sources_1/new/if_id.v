`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 11:03:57 AM
// Design Name: 
// Module Name: if_id
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

//Instruction Fetch & Instruction Decode
module IF_ID(
    input               clk,
    input               rst,
	input[5:0]			stall,
    input[31:0]         instr_addr_i,
    input[31:0]         instr_i,
    output reg[31:0]    instr_addr_o,
    output reg[31:0]    instr_o
    );
    
    always@(posedge clk) begin
        if(rst == `RstEnable) begin
            instr_addr_o <= `ZeroWord;
            instr_o <= `ZeroWord;
        end
        else if(stall[1] == `Stop && stall[2] == `NoStop) begin
			instr_addr_o <= `ZeroWord;
            instr_o <= `ZeroWord;
		end else if(stall[1] == `NoStop) begin
            instr_addr_o <= instr_addr_i;
            instr_o <= instr_i;
        end
    end
endmodule
