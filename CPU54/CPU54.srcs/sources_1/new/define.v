`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2017 10:03:11 AM
// Design Name: 
// Module Name: define
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
`define RstEnable 1'b1
`define RstDisable 1'b0
`define ZeroWord 32'h0000_0000
`define WriteEnable 1'b1
`define WriteDisable 1'b0
`define ReadEnable 1'b1
`define ReadDisable 1'b0
/* `define AluOpBus 7:0
`define AluSelBus 2:0 */
`define InstValid 1'b0
`define InstInvalid 1'b1
`define Stop 1'b1
`define NoStop 1'b0
/* `define InDelaySlot 1'b1
`define NotInDelaySlot 1'b0
`define Branch 1'b1
`define NotBranch 1'b0
`define InterruptAssert 1'b1
`define InterruptNotAssert 1'b0
`define TrapAssert 1'b1
`define TrapNotAssert 1'b0 */
`define True_v 1'b1
`define False_v 1'b0
`define ChipEnable 1'b1
`define ChipDisable 1'b0

//Instructions
`define EXE_AND  6'b100_100
`define EXE_OR   6'b100_101
`define EXE_XOR  6'b100_110
`define EXE_NOR  6'b100_111
`define EXE_ANDI 6'b001_100
`define EXE_ORI  6'b001_101
`define EXE_XORI 6'b001_110
`define EXE_LUI  6'b001_111

`define EXE_SLL     6'b000_000
`define EXE_SLLV    6'b000_100
`define EXE_SRL     6'b000_010
`define EXE_SRLV    6'b000_110
`define EXE_SRA     6'b000_011
`define EXE_SRAV    6'b000_111
`define EXE_SYNC    6'b001_111
`define EXE_PREF    6'b110_011

`define EXE_MOVZ    6'b001_010
`define EXE_MOVN    6'b001_011
`define EXE_MFHI    6'b010_000
`define EXE_MTHI    6'b010_001
`define EXE_MFLO    6'b010_010
`define EXE_MTLO    6'b010_011

`define EXE_SLT     6'b101_010
`define EXE_SLTU    6'b101_011
`define EXE_SLTI    6'b001_010
`define EXE_SLTIU   6'b001_011
`define EXE_ADD     6'b100_000
`define EXE_ADDU    6'b100_001
`define EXE_SUB     6'b100_010
`define EXE_SUBU    6'b100_011
`define EXE_ADDI    6'b001_000
`define EXE_ADDIU   6'b001_001
`define EXE_CLZ     6'b100_000
`define EXE_CLO     6'b100_001
`define EXE_MULT    6'b011_000
`define EXE_MULTU   6'b011_001
`define EXE_MUL     6'b000_010
`define EXE_MADD	6'b000_000
`define EXE_MADDU	6'b000_001
`define EXE_MSUB	6'b000_100
`define EXE_MSUBU	6'b000_101
`define EXE_DIV		6'b011_010
`define EXE_DIVU	6'b011_011

`define DivFree				2'b00
`define DivByZero			2'b01
`define DivOn				2'b10
`define DivEnd				2'b11
`define DivResultReady		1'b1
`define DivResultNotReady	1'b0
`define DivStart			1'b1
`define DivStop				1'b0

`define EXE_NOP  6'b000_000
`define SSNOP 32'b00000000000000000000000001000000

`define EXE_SPECIAL_INST 6'b000000
`define EXE_REGIMM_INST 6'b000001
`define EXE_SPECIAL2_INST 6'b011100


//AluOp
`define EXE_AND_OP   8'b0010_0100
`define EXE_OR_OP    8'b0010_0101
`define EXE_XOR_OP   8'b0010_0110
`define EXE_NOR_OP   8'b0010_0111
`define EXE_ANDI_OP  8'b0101_1001
`define EXE_ORI_OP   8'b0101_1010
`define EXE_XORI_OP  8'b0101_1011
`define EXE_LUI_OP   8'b0101_1100   

`define EXE_SLL_OP   8'b0111_1100
`define EXE_SLLV_OP  8'b0000_0100
`define EXE_SRL_OP   8'b0000_0010
`define EXE_SRLV_OP  8'b0000_0110
`define EXE_SRA_OP   8'b0000_0011
`define EXE_SRAV_OP  8'b0000_0111

`define EXE_MOVZ_OP  8'b0000_1010
`define EXE_MOVN_OP  8'b0000_1011
`define EXE_MFHI_OP  8'b0001_0000
`define EXE_MTHI_OP  8'b0001_0001
`define EXE_MFLO_OP  8'b0001_0010
`define EXE_MTLO_OP  8'b0001_0011

`define EXE_SLT_OP   8'b0010_1010
`define EXE_SLTU_OP  8'b0010_1011
`define EXE_SLTI_OP  8'b0101_0111
`define EXE_SLTIU_OP 8'b0101_1000   
`define EXE_ADD_OP   8'b0010_0000
`define EXE_ADDU_OP  8'b0010_0001
`define EXE_SUB_OP   8'b0010_0010
`define EXE_SUBU_OP  8'b0010_0011
`define EXE_ADDI_OP  8'b0101_0101
`define EXE_ADDIU_OP 8'b0101_0110
`define EXE_CLZ_OP   8'b1011_0000
`define EXE_CLO_OP   8'b1011_0001

`define EXE_MULT_OP  8'b0001_1000
`define EXE_MULTU_OP 8'b0001_1001
`define EXE_MUL_OP   8'b1010_1001
`define EXE_MADD_OP  8'b1010_0110
`define EXE_MADDU_OP 8'b1010_1000
`define EXE_MSUB_OP  8'b1010_1010
`define EXE_MSUBU_OP 8'b1010_1011

`define EXE_NOP_OP   8'b0000_0000
`define EXE_DIV_OP   8'b0001_1010
`define EXE_DIVU_OP  8'b0001_1011

//AluSel
`define EXE_RES_LOGIC       3'b001
`define EXE_RES_SHIFT       3'b010
`define EXE_RES_NOP         3'b000
`define EXE_RES_MOVE        3'b011
`define EXE_RES_ARITHMETIC  3'b100	
`define EXE_RES_MUL         3'b101	


//Instructions Mem
`define InstAddrBus 31:0
`define InstBus 31:0
`define InstMemNum 131071
`define InstMemNumLog2 17


//Genereal Registers
`define RegAddrBus 4:0
`define RegBus 31:0
`define RegWidth 32
`define DoubleRegWidth 64
`define DoubleRegBus 63:0
`define RegNum 32
`define RegNumLog2 5
`define NOPRegAddr 5'b00000

