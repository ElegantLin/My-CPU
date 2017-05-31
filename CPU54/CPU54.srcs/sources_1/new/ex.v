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
	output reg[31:0]   data_write_o,
	
	input[31:0]		   data_hi_write_i,
	input[31:0]		   data_lo_write_i,
	
	input			   mem_write_hilo_en_i,
	input[31:0]		   mem_data_lo_write_i,
	input[31:0]        mem_data_hi_write_i,
	
	input			   wb_write_hilo_en_i,
	input[31:0]		   wb_data_lo_write_i,
	input[31:0]        wb_data_hi_write_i,
	
	output reg 		   ex_write_hilo_en_o,
	output reg[31:0]   ex_data_lo_write_o,
	output reg[31:0]   ex_data_hi_write_o
	
);

reg[31:0] logicout;
reg[31:0] shiftres;
reg[31:0] moveres;
reg[31:0] HI;
reg[31:0] LO;

always @ (*) begin
	if(rst == `RstEnable) 
		begin
			{HI, LO} <= {`ZeroWord, `ZeroWord};
		end
	else if(mem_write_hilo_en_i == `WriteEnable)
		begin
			{HI, LO} <= {mem_data_hi_write_i, mem_data_lo_write_i};
		end
	else if(wb_write_hilo_en_i == `WriteEnable)
		begin
			{HI, LO} <= {wb_data_hi_write_i, wb_data_lo_write_i};
		end
	else
		begin
			{HI, LO} <= {data_hi_write_i, data_lo_write_i};
		end
	end

always @ (*) begin
	if(rst == `RstEnable)
		begin
			moveres <= `ZeroWord;
		end
	else
		begin
			moveres <= `ZeroWord;
			case(aluop_i)
				`EXE_MFHI_OP: begin
					moveres <= HI;
				end
				
				`EXE_MFLO_OP: begin
					moveres <= LO;
				end
				
				`EXE_MOVZ_OP: begin
					moveres <= reg1_i;
				end
				
				`EXE_MOVN_OP: begin
					moveres <= reg1_i;
				end
				
				default: begin
				end
			endcase
		end
	end
		

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
		
		`EXE_RES_MOVE: begin
			data_write_o <= moveres;
		end
	 	
	 	default:        begin
	 		data_write_o <= `ZeroWord;
	 	end
	 endcase
 end

always @ (*) begin
	if(rst == `RstEnable) begin
		ex_write_hilo_en_o <= `WriteDisable;
		ex_data_lo_write_o <= `ZeroWord;
		ex_data_hi_write_o <= `ZeroWord;
	end
	else if(aluop_i == `EXE_MTHI_OP) begin
		ex_write_hilo_en_o <= `WriteEnable;
		ex_data_hi_write_o <= reg1_i;
		ex_data_lo_write_o <= LO;
	end
	else if(aluop_i == `EXE_MTLO_OP) begin
		ex_write_hilo_en_o <= `WriteEnable;
		ex_data_hi_write_o <= HI;
		ex_data_lo_write_o <= reg1_i;
	end 
	else begin
		ex_write_hilo_en_o <= `WriteDisable;
		ex_data_hi_write_o <= `ZeroWord;
		ex_data_lo_write_o <= `ZeroWord;
	end
end

endmodule