`timescale 1ns / 1ps
`include "define.v"

module CTRL(
	input rst,
	input stallreq_from_id,
	input stallreq_from_ex,
	output reg[5:0]  stall  
);


	always @ (*) begin
		if(rst == `RstEnable) begin
			stall <= 6'b000000;
		end else if(stallreq_from_ex == `Stop) begin
			stall <= 6'b001111;
		end else if(stallreq_from_id == `Stop) begin
			stall <= 6'b000111;			
		end else begin
			stall <= 6'b000000;
		end    //if
	end      //always
			

endmodule