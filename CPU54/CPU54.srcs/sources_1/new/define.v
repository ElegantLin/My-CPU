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
/* `define Stop 1'b1
`define NoStop 1'b0
`define InDelaySlot 1'b1
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

`define EXE_SLL  6'b000_000
`define EXE_SLLV 6'b000_100
`define EXE_SRL  6'b000_010
`define EXE_SRLV 6'b000_110
`define EXE_SRA  6'b000_011
`define EXE_SRAV 6'b000_111
`define EXE_SYNC 6'b001_111
`define EXE_PREF 6'b110_011

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

`define EXE_NOP_OP   8'b0000_0000

//AluSel
`define EXE_RES_LOGIC 3'b001
`define EXE_RES_SHIFT 3'b010
`define EXE_RES_NOP   3'b000


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

