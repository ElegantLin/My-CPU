`timescale 1ns / 1ps
`include"define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/30/2017 09:17:27 AM
// Design Name: 
// Module Name: hilo_reg
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


module hilo_reg(
    input           clk,
    input           rst,
    input           we,
    input[31:0]     hi_data_write_i,
    input[31:0]     lo_data_write_i,
    
    output reg[31:0]    hi_data_read_o,
    output reg[31:0]    lo_data_read_o
    );
    
    always@(posedge clk) begin
        if(rst == `RstEnable) begin
            hi_data_read_o <= `ZeroWord;
            lo_data_read_o <= `ZeroWord;
        end else if((we == `WriteEnable)) begin
            hi_data_read_o <= hi_data_write_i;
            lo_data_read_o <= lo_data_write_i;
        end
    end
endmodule
