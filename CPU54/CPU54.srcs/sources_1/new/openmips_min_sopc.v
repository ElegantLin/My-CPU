`timescale 1ns / 1ps
`include"define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 02:28:36 PM
// Design Name: 
// Module Name: openmips_min_sopc
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


module openmips_min_sopc(

	input wire			clk,
	input wire			rst
	
);

  wire[31:0] inst_addr;
  wire[31:0] inst;
  wire rom_ce;
 

 openmips openmips0(
		.clk(clk),
		.rst(rst),
	
		.rom_addr_o(inst_addr),
		.rom_data_i(inst),
		.rom_en_o(rom_ce)
	
	);
	
	inst_rom inst_rom0(
		.addr_i(inst_addr),
		.rom_en_i(rom_ce),
		
		.inst_o(inst)	
	);


endmodule
