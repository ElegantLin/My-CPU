`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2017 06:06:47 PM
// Design Name: 
// Module Name: tb
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


module tb();

  reg     CLOCK_50;
  reg     rst;
  wire vsync;
  wire[11:0] color_out;
  wire[7:0] seg_out;
  wire[3:0] sel;
  wire hsync;
  //integer file_output;
  
       
  initial begin
	//file_output = $fopen("D:/Computer Architecture/My-CPU/TestResult/beq.txt");
    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
  end
      
  initial begin
    rst = 1'b1;
    #195 rst= 1'b0;
    #1000000000 $stop;
  end
   
Small_Program_Top top1(
      .clk(CLOCK_50),
      .rst(rst),
      .left(0),
      .right(0),
      .up(0),
      .down(0),
      .hsync(hsync),
      .vsync(vsync),
      .color_out(color_out),
      .seg_out(seg_out),
      .sel(sel)
      );
      
endmodule
