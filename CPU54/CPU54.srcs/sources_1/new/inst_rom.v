`timescale 1ns / 1ps
`include"define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 02:22:52 PM
// Design Name: 
// Module Name: inst_rom
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


module inst_rom(

	input               rom_en_i,
	input[31:0]			addr_i,
	output reg[31:0]	inst_o
	
);

	reg[31:0]  inst_mem[0:`InstMemNum-1];

	initial $readmemh ("D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/inst_rom.data", inst_mem );

	always @ (*) begin
		if (rom_en_i == `ChipDisable) begin
			inst_o <= `ZeroWord;
	  end else begin
		  inst_o <= inst_mem[addr_i[`InstMemNumLog2+1:2]];
		end
	end

endmodule
