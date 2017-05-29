`timescale 1ns / 1ps
`include "define.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 11:37:15 AM
// Design Name: 
// Module Name: id
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

//Instruction Decode
module ID(

    input 				rst,
    input[31:0]			instr_addr_i,
    input[31:0]     	instr_i,

    input[31:0]     	reg1_data_i,
    input[31:0]     	reg2_data_i,
    
    input               ex_reg_write_en_i,
    input[31:0]         ex_data_write_i,
    input[4:0]          ex_addr_write_i,
    
    input               mem_reg_write_en_i,
    input[31:0]         mem_data_write_i,
    input[4:0]          mem_addr_write_i,
    
    output reg      	reg1_read_en_o,
    output reg      	reg2_read_en_o,     
    output reg[4:0] 	reg1_read_addr_o,
    output reg[4:0] 	reg2_read_addr_o, 	      
    
    //送到执行阶段的信息
    output reg[7:0] 	aluop_o,
    output reg[2:0] 	alusel_o,
    output reg[31:0]  	reg1_o,
    output reg[31:0]    reg2_o,
    output reg[4:0]     addr_write_o,
    output reg          reg_write_en_o
);

  wire[5:0] op = instr_i[31:26];        //instruction code
  wire[4:0] op2 = instr_i[10:6];
  wire[5:0] op3 = instr_i[5:0];         //function code
  wire[4:0] op4 = instr_i[20:16];
  reg[31:0]	imm;
  reg instvalid;
  
 
    always @ (*) begin	
        if (rst == `RstEnable) 
            begin
                aluop_o <= `EXE_NOP_OP;
                alusel_o <= `EXE_RES_NOP;
                addr_write_o <= `NOPRegAddr;
                reg_write_en_o <= `WriteDisable;
                instvalid <= `InstValid;
                reg1_read_en_o <= 1'b0;
                reg2_read_en_o <= 1'b0;
                reg1_read_addr_o <= `NOPRegAddr;
                reg2_read_addr_o <= `NOPRegAddr;
                imm <= 32'h0;			
            end 
        else 
            begin
                aluop_o <= `EXE_NOP_OP;
                alusel_o <= `EXE_RES_NOP;
                addr_write_o <= instr_i[15:11];
                reg_write_en_o <= `WriteDisable;
                instvalid <= `InstInvalid;	   
                reg1_read_en_o <= 1'b0;
                reg2_read_en_o <= 1'b0;
                reg1_read_addr_o <= instr_i[25:21];
                reg2_read_addr_o <= instr_i[20:16];		
                imm <= `ZeroWord;
				case (op)
              `EXE_SPECIAL_INST: 
                begin
                    case(op2)
                        5'b00000:
                            begin
                                case(op3)
                                    `EXE_OR:
                                        begin
                                            reg_write_en_o <= `WriteEnable;	
                                            aluop_o <= `EXE_OR_OP;
                                            alusel_o <= `EXE_RES_LOGIC; 
                                            reg1_read_en_o <= `ReadEnable;    
                                            reg2_read_en_o <= `ReadEnable;
                                            instvalid <= `InstValid;
                                        end
                                    `EXE_AND:
                                        begin
                                            reg_write_en_o <= `WriteEnable;
                                            aluop_o <= `EXE_AND_OP;
                                            alusel_o <= `EXE_RES_LOGIC;
                                            reg1_read_en_o <= `ReadEnable;    
                                            reg2_read_en_o <= `ReadEnable;
                                            instvalid <= `InstValid;
                                        end 
                                    `EXE_XOR:
                                        begin
                                            reg_write_en_o <= `WriteEnable;
                                            aluop_o <= `EXE_XOR_OP;
                                            alusel_o <= `EXE_RES_LOGIC;
                                            reg1_read_en_o <= `ReadEnable;
                                            reg2_read_en_o <= `ReadEnable;
                                            instvalid <= `InstValid;
                                         end
                                    `EXE_NOR:
                                        begin
                                            reg_write_en_o <= `WriteEnable;
                                            aluop_o <= `EXE_NOR_OP;
                                            alusel_o <= `EXE_RES_LOGIC;
                                            reg1_read_en_o <= `ReadEnable;
                                            reg2_read_en_o <= `ReadEnable;
                                            instvalid <= `InstValid;
                                        end
                                    `EXE_SLLV:
                                        begin
                                            reg_write_en_o <= `WriteEnable;
                                            aluop_o <= `EXE_SLL_OP;
                                            alusel_o <= `EXE_RES_SHIFT;
                                            reg1_read_en_o <= `ReadEnable;
                                            reg2_read_en_o <= `ReadEnable;
                                            instvalid <= `InstValid;
                                        end
                                    `EXE_SRLV:
                                        begin
                                            reg_write_en_o <= `WriteEnable;
                                            aluop_o <= `EXE_SRL_OP;
                                            alusel_o <= `EXE_RES_SHIFT;
                                            reg1_read_en_o <= `ReadEnable;
                                            reg2_read_en_o <= `ReadEnable;
                                            instvalid <= `InstValid;
                                        end
                                    `EXE_SRAV:
                                        begin
                                            reg_write_en_o <= `WriteEnable;
                                            aluop_o <= `EXE_SRA_OP;
                                            alusel_o <= `EXE_RES_SHIFT;
                                            reg1_read_en_o <= `ReadEnable;
                                            reg2_read_en_o <= `ReadEnable;
                                            instvalid <= `InstValid;
                                        end
                                    `EXE_SYNC:
                                        begin
                                            reg_write_en_o <= `WriteEnable;
                                            aluop_o <= `EXE_NOP_OP;
                                            alusel_o <= `EXE_RES_NOP;
                                            reg1_read_en_o <= `ReadDisable;
                                            reg2_read_en_o <= `ReadEnable;
                                            instvalid <= `InstValid;
                                        end
                                    default:
                                        begin
                                        end
                                endcase
                            end
							default:
								begin
								end
						endcase
					end
                        `EXE_ORI:
                            begin            
                                reg_write_en_o <= `WriteEnable;	
                                aluop_o <= `EXE_OR_OP;
                                alusel_o <= `EXE_RES_LOGIC; 
                                reg1_read_en_o <= `ReadEnable;	
                                reg2_read_en_o <= `ReadDisable;	  	
                                imm <= {16'h0, instr_i[15:0]};
                                addr_write_o <= instr_i[20:16];
                                instvalid <= `InstValid;	
                            end
                        `EXE_ANDI:
                            begin
                                reg_write_en_o <= `WriteEnable;	
                                aluop_o <= `EXE_AND_OP;
                                alusel_o <= `EXE_RES_LOGIC; 
                                reg1_read_en_o <= `ReadEnable;	
                                reg2_read_en_o <= `ReadDisable;	  	
                                imm <= {16'h0, instr_i[15:0]};
                                addr_write_o <= instr_i[20:16];
                                instvalid <= `InstValid;	
                            end
                        `EXE_XORI:
                            begin
                                reg_write_en_o <= `WriteEnable;	
                                aluop_o <= `EXE_XOR_OP;
                                alusel_o <= `EXE_RES_LOGIC; 
                                reg1_read_en_o <= `ReadEnable;	
                                reg2_read_en_o <= `ReadDisable;	  	
                                imm <= {16'h0, instr_i[15:0]};
                                addr_write_o <= instr_i[20:16];
                                instvalid <= `InstValid;
                            end
                        `EXE_LUI:
                            begin
                                reg_write_en_o <= `WriteEnable;	
                                aluop_o <= `EXE_OR_OP;
                                alusel_o <= `EXE_RES_LOGIC; 
                                reg1_read_en_o <= `ReadEnable;	
                                reg2_read_en_o <= `ReadDisable;	  	
                                imm <= {instr_i[15:0], 16'h0};
                                addr_write_o <= instr_i[20:16];
                                instvalid <= `InstValid;
                            end
                        `EXE_PREF:
                            begin
                                reg_write_en_o <= `WriteDisable;	
                                aluop_o <= `EXE_NOP_OP;
                                alusel_o <= `EXE_RES_NOP; 
                                reg1_read_en_o <= `ReadDisable;	
                                reg2_read_en_o <= `ReadDisable;	  	
                                instvalid <= `InstValid;
                            end
                        default:
                            begin
                            end
                    endcase	
                    
                    if(instr_i[31:21] == 11'b0_00000_00000)
                        begin
                            if(op3 == `EXE_SLL)
                                begin
                                    reg_write_en_o <= `WriteEnable;
                                    aluop_o <= `EXE_SLL_OP;
                                    alusel_o <= `EXE_RES_SHIFT;
                                    reg1_read_en_o <= `ReadDisable;
                                    reg2_read_en_o <= `ReadEnable;
                                    imm[4:0] <= instr_i[10:6];
                                    addr_write_o <= instr_i[15:11];
                                    instvalid <= `InstValid;
                                end
                            else if(op3 == `EXE_SRL)
                                begin
                                    reg_write_en_o <= `WriteEnable;
                                    aluop_o <= `EXE_SRL_OP;
                                    alusel_o <= `EXE_RES_SHIFT;
                                    reg1_read_en_o <= `ReadDisable;
                                    reg2_read_en_o <= `ReadEnable;
                                    imm[4:0] <= instr_i[10:6];
                                    addr_write_o <= instr_i[15:11];
                                    instvalid <= `InstValid;
                                end
                            else if(op3 == `EXE_SRA)
                                begin
                                    reg_write_en_o <= `WriteEnable;
                                    aluop_o <= `EXE_SRA_OP;
                                    alusel_o <= `EXE_RES_SHIFT;
                                    reg1_read_en_o <= `ReadDisable;
                                    reg2_read_en_o <= `ReadEnable;
                                    imm[4:0] <= instr_i[10:6];
                                    addr_write_o <= instr_i[15:11];
                                    instvalid <= `InstValid;
                                end
                        end
                end    //if
    end         //always
    

    always @ (*) begin
        if(rst == `RstEnable) begin
            reg1_o <= `ZeroWord;
        end else if((reg1_read_en_o == `ReadEnable) && (ex_reg_write_en_i == `WriteEnable) && (ex_addr_write_i == reg1_read_addr_o))
           begin
               reg1_o <= ex_data_write_i;
        end else if((reg1_read_en_o == `ReadEnable) && (mem_reg_write_en_i == `WriteEnable) && (mem_addr_write_i == reg1_read_addr_o))
           begin
               reg1_o <= mem_data_write_i;
        end else if(reg1_read_en_o == `ReadEnable) 
           begin
               reg1_o <= reg1_data_i;
        end else if(reg1_read_en_o == `ReadDisable) 
           begin
               reg1_o <= imm;
        end else 
           begin
               reg1_o <= `ZeroWord;
      end
    end
    
    always @ (*) begin
        if(rst == `RstEnable) begin
            reg2_o <= `ZeroWord;
        end else if((reg2_read_en_o == `ReadEnable) && (ex_reg_write_en_i == `WriteEnable) && (ex_addr_write_i == reg2_read_addr_o))
            begin
                reg2_o <= ex_data_write_i;
        end else if((reg2_read_en_o == `ReadEnable) && (mem_reg_write_en_i == `WriteEnable) && (mem_addr_write_i == reg2_read_addr_o))
            begin
                reg2_o <= mem_data_write_i;
        end else if(reg2_read_en_o == `ReadEnable) 
            begin
               reg2_o <= reg2_data_i;
        end else if(reg2_read_en_o == `ReadDisable) 
            begin
               reg2_o <= imm;
        end else begin
               reg2_o <= `ZeroWord;
      end
    end

endmodule