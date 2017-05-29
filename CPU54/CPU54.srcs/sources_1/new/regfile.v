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

module Regfile(
    input           	clk,
    input           	rst,
    
	//write enable
    input           	we_i,           
    input[4:0]      	addr_write_i,
    input[31:0]     	data_write_i,
    
    //Read enable
    input           	re1,
    input[4:0]      	addr1_read_i,
    output reg[31:0]	data1_read_o,
    
    input               re2,
    input[4:0]      	addr2_read_i,
    output reg[31:0]    data2_read_o
    );
    
    reg[31:0] regs[31:0];         //32*32 registers
    
    always@(posedge clk) begin
        if(rst == `RstDisable) begin
            if((we_i == `WriteEnable) && (addr_write_i != 5'h0))   begin
                regs[addr_write_i] <= data_write_i;
            end
        end
    end 
    
    always@(*) begin
        if(rst == `RstEnable) begin
            data1_read_o <= `ZeroWord;
        end
        else if(addr1_read_i == 5'h0) begin
            data1_read_o <= `ZeroWord;
		
		/* To solve the proble of
		ori $1, $0, 0x1100
		ori $3, $0, 0xffff  */
        end else if((addr1_read_i == addr_write_i) && (we_i == `WriteEnable) && (re1 == `ReadEnable)) begin
            data1_read_o <= data_write_i;
        end else if(re1 == `ReadEnable) begin
            data1_read_o <= regs[addr1_read_i];
        end else begin
            data1_read_o <= `ZeroWord;
        end
    end
    
    always@(*) begin
        if(rst == `RstEnable) begin
            data2_read_o <= `ZeroWord;
        end
        else if(addr2_read_i == 5'h0) begin
            data2_read_o <= `ZeroWord;
        end else if((addr2_read_i == addr_write_i) && (we_i == `WriteEnable) && (re2 == `ReadEnable)) begin
            data2_read_o <= data_write_i;
        end else if(re2 == `ReadEnable) begin
            data2_read_o <= regs[addr2_read_i];
        end else begin
            data2_read_o <= `ZeroWord;
        end
    end

endmodule