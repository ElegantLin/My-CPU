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
`define EXE_ORI  6'b001_101
`define EXE_NOP  6'b000_000


//AluOp
`define EXE_OR_OP    8'b0010_0101
`define EXE_NOP_OP   8'b0000_0000

//AluSel
`define EXE_RES_LOGIC 3'b001
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

