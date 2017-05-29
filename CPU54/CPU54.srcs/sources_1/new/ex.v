`timescale 1ns / 1ps
`include"define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 01:09:59 PM
// Design Name: 
// Module Name: ex
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



module ALU(

	input		       rst,
	input[7:0]         aluop_i,
	input[2:0]         alusel_i,
	input[31:0]        reg1_i,
	input[31:0]        reg2_i,
	input[4:0]         addr_write_i,
	input              write_en_i,

	output reg[4:0]    addr_write_o,
	output reg         write_en_o,
	output reg[31:0]   data_write_o
	
);

reg[31:0] logicout;
reg[31:0] shiftres;
always @ (*) begin
    if(rst == `RstEnable) begin
        logicout <= `ZeroWord;
    end else begin
        case (aluop_i)
            `EXE_OR_OP:	begin
                logicout <= reg1_i | reg2_i;
            end
            
            `EXE_AND_OP: begin
                logicout <= reg1_i & reg2_i;
            end
            
            `EXE_NOR_OP: begin
                logicout <= ~(reg1_i | reg2_i);
            end
            
            `EXE_XOR_OP: begin
                logicout <= reg1_i ^ reg2_i;
            end
            
            default:	begin
                logicout <= `ZeroWord;
            end
        endcase
    end    //if
end      //always

always @(*) begin
    if(rst == `RstEnable) begin
        shiftres <= `ZeroWord;
    end else begin
        case (aluop_i)
            `EXE_SLL_OP: begin
                shiftres <= reg2_i << reg1_i[4:0];
            end
            
            `EXE_SRL_OP: begin
                shiftres <= reg2_i << reg1_i[4:0];
            end
            
            `EXE_SRA_OP: begin
                shiftres <= ({32{reg2_i[31]}} << (6'd32-{1'b0,reg1_i[4:0]})) | reg2_i >> reg1_i[4:0];
            end
            
            default: begin
                shiftres <= `ZeroWord;
            end
        endcase
    end
end

always @ (*) begin
	 addr_write_o <= addr_write_i;	 	 	
	 write_en_o <= write_en_i;
	 case ( alusel_i ) 
	 	`EXE_RES_LOGIC:	begin
	 		data_write_o <= logicout;
	 	end
	 	
	 	`EXE_RES_SHIFT: begin
	 	    data_write_o <= shiftres;
	 	end
	 	
	 	default:        begin
	 		data_write_o <= `ZeroWord;
	 	end
	 endcase
 end	

endmodule