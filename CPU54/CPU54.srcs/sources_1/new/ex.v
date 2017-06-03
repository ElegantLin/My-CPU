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
	reg[31:0] arithres;
	reg[63:0] mulres;
	reg[31:0] HI;
	reg[31:0] LO;


	wire	  overflow_flag;
	wire	  reg1_eq_reg2;
	wire	  reg1_lt_reg2;
	wire[31:0] reg2_com;
	wire[31:0] reg1_not;
	wire[31:0] sumres;
	wire[31:0] operator1_mult;
	wire[31:0] operator2_mult;
	wire[63:0] hilo_temp;

	
	
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
					shiftres <= reg2_i >> reg1_i[4:0];
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
	
	assign reg2_com = ((aluop_i == `EXE_SUB_OP) || (aluop_i == `EXE_SUBU_OP) || (aluop_i == `EXE_SLT_OP)) ? (~reg2_i)+1:reg2_i;
	assign sumres = reg1_i + reg2_com;
	assign overflow_flag = ((!reg1_i[31] && !reg2_com[31]) && sumres[31]) || ((reg1_i[31] && reg2_com[31]) && (!sumres[31]));
	assign reg1_lt_reg2 = ((aluop_i == `EXE_SLT_OP)) ? ((reg1_i[31] && !reg2_i[31]) || (!reg1_i[31] && !reg2_i[31] && sumres[31]) 
							||(reg1_i[31] && reg2_i[31] && sumres[31])) : (reg1_i < reg2_i);
	assign reg1_not = ~reg1_i;
	
	always @ (*) 
		begin
			if(rst == `RstEnable)
				begin
					arithres <= `ZeroWord;
				end
				else
					begin
						case(aluop_i)
							`EXE_SLT_OP, `EXE_SLTU_OP:
								begin
									arithres <= reg1_lt_reg2;
								end
							`EXE_ADD_OP, `EXE_ADDI_OP, `EXE_ADDU_OP, `EXE_ADDIU_OP:
								begin
									arithres <= sumres;
								end
							`EXE_SUB_OP, `EXE_SUBU_OP:
								begin
									arithres <= sumres;
								end
							`EXE_CLZ_OP:		
								begin
									arithres <= reg1_i[31] ? 0 : reg1_i[30] ? 1 : reg1_i[29] ? 2 :
														 reg1_i[28] ? 3 : reg1_i[27] ? 4 : reg1_i[26] ? 5 :
														 reg1_i[25] ? 6 : reg1_i[24] ? 7 : reg1_i[23] ? 8 : 
														 reg1_i[22] ? 9 : reg1_i[21] ? 10 : reg1_i[20] ? 11 :
														 reg1_i[19] ? 12 : reg1_i[18] ? 13 : reg1_i[17] ? 14 : 
														 reg1_i[16] ? 15 : reg1_i[15] ? 16 : reg1_i[14] ? 17 : 
														 reg1_i[13] ? 18 : reg1_i[12] ? 19 : reg1_i[11] ? 20 :
														 reg1_i[10] ? 21 : reg1_i[9] ? 22 : reg1_i[8] ? 23 : 
														 reg1_i[7] ? 24 : reg1_i[6] ? 25 : reg1_i[5] ? 26 : 
														 reg1_i[4] ? 27 : reg1_i[3] ? 28 : reg1_i[2] ? 29 : 
														 reg1_i[1] ? 30 : reg1_i[0] ? 31 : 32 ;
								end
							`EXE_CLO_OP:		
								begin
									arithres <= (reg1_not[31] ? 0 : reg1_not[30] ? 1 : reg1_not[29] ? 2 :
														 reg1_not[28] ? 3 : reg1_not[27] ? 4 : reg1_not[26] ? 5 :
														 reg1_not[25] ? 6 : reg1_not[24] ? 7 : reg1_not[23] ? 8 : 
														 reg1_not[22] ? 9 : reg1_not[21] ? 10 : reg1_not[20] ? 11 :
														 reg1_not[19] ? 12 : reg1_not[18] ? 13 : reg1_not[17] ? 14 : 
														 reg1_not[16] ? 15 : reg1_not[15] ? 16 : reg1_not[14] ? 17 : 
														 reg1_not[13] ? 18 : reg1_not[12] ? 19 : reg1_not[11] ? 20 :
														 reg1_not[10] ? 21 : reg1_not[9] ? 22 : reg1_not[8] ? 23 : 
														 reg1_not[7] ? 24 : reg1_not[6] ? 25 : reg1_not[5] ? 26 : 
														 reg1_not[4] ? 27 : reg1_not[3] ? 28 : reg1_not[2] ? 29 : 
														 reg1_not[1] ? 30 : reg1_not[0] ? 31 : 32) ;
								end
							default:				
								begin
									arithres <= `ZeroWord;
								end
						endcase
					end
		end
		
	assign operator1_mult = (((aluop_i == `EXE_MUL_OP) || (aluop_i == `EXE_MULT_OP)) && (reg1_i[31] == 1'b1)) ? (~reg1_i + 1) : reg1_i;
	assign operator2_mult = (((aluop_i == `EXE_MUL_OP) || (aluop_i == `EXE_MULT_OP)) && (reg2_i[31] == 1'b1)) ? (~reg2_i + 1) : reg2_i;
	assign hilo_temp = operator1_mult * operator2_mult;

	always @ (*) 
		begin
			if(rst == `RstEnable) 
				begin
					mulres <= {`ZeroWord,`ZeroWord};
				end 
				else if ((aluop_i == `EXE_MULT_OP) || (aluop_i == `EXE_MUL_OP))
					begin
				if(reg1_i[31] ^ reg2_i[31] == 1'b1) begin
					mulres <= ~hilo_temp + 1;
				end else begin
				  mulres <= hilo_temp;
				end
			end else begin
					mulres <= hilo_temp;
			end
		end
	
			
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
		addr_write_o <= addr_write_i;
		if (((aluop_i == `EXE_ADD_OP) || (aluop_i == `EXE_ADDI_OP) || (aluop_i == `EXE_SUB_OP)) && (overflow_flag == 1'b1)) 
			begin
				write_en_o <= `WriteDisable;
			end else
				begin
					write_en_o <= write_en_i;
				end
			
			case(alusel_i)
				`EXE_RES_LOGIC:
					begin
						data_write_o <= logicout;
					end
				`EXE_RES_SHIFT:
					begin
						data_write_o <= shiftres;
					end
				`EXE_RES_MOVE:
					begin
						data_write_o <= moveres;
					end
				`EXE_RES_ARITHMETIC:
					begin
						data_write_o <= arithres;
					end
				`EXE_RES_MUL:
					begin
						data_write_o <= mulres[31:0];
					end
				default:
					begin
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
		else if((aluop_i == `EXE_MULT_OP) || (aluop_i == `EXE_MULTU_OP)) begin
			ex_write_hilo_en_o <= `WriteEnable;
			ex_data_hi_write_o <= mulres[63:32];
			ex_data_lo_write_o <= mulres[31:0];
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