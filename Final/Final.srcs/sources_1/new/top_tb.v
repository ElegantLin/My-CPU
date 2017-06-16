`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2017 04:17:39 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb();
    
    reg     CLOCK_50;
    reg     rst;
    wire[7:0] o_sel;
    wire[7:0] o_seg;
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

    
    top top1(
        .clk(CLOCK_50),
        .rst(rst),
        .o_seg(o_seg),
        .o_sel(o_sel)
    );
endmodule
