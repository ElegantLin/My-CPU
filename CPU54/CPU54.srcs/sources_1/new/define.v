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
`define     RstEnable       1'b1
`define     RstDisable      1'b0
`define     ZeroWord        32'h0000_0000
`define     WriteEnable     1'b1
`define     WriteDisable    1'b0
`define     ReadEnable      1'b1
`define     ReadDisabel     1'b0
`define     AluOpBus        7:0
`define     AluSelBus       2:0
`define     InstValid       1'b0
`define     InstInvalid     1'b1
`define     True_v          1'b1
`define     False_v         1'b0
`define     ChipEnable      1'b1
`define     ChipDisable     1'b0


`define     EXE_ORI         6'b001101
`define     EXE_NOP         6'b000000

//ALU Operation
`define     EXE_OR_OP       8'b0010_0101
`define     EXE_NOP_OP      8'b0000_0000

//ALU Selector
`define     EXE_RES_LOGIC   3'b001
`define     EXE_RES_NOP     3'b000

`define     InstAddrBus     31:0
`define     InstBus         31:0

`define     InstMemNum      131071     //ROM size 128K     
`define     InstMemNumLog2  17

`define     RegAddrBus      4:0
`define     RegBus          31:0
`define     RegWidth        32
`define     DoubleRegBus    63:0
`define     DoubleRegWidth  64
`define     RegNum          32
`define     RegNumLog2      5
`define     NOPRegAddr      5'b00000

