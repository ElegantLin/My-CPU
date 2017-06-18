
`include "defines.v"

module data_ram(

	input	wire										clk,
	input wire										ce,
	input wire										we,
	input wire[`DataAddrBus]			addr,
	input wire[3:0]								sel,
	input wire[`DataBus]						data_i,
	
	output reg[`DataBus]					data_o,
	output wire[`DataBus]                   check,
	
	input wire[2:0]                        direction,
	output wire                             signal,
	output reg[15:0]                       point,
	input wire[7:0]                        AppleX,
	input wire[7:0]                        AppleY,
	inout wire[1:0]                        gamestatus,
	output [7:0]                        snake
);

	reg[`ByteWidth]  data_mem0[0:`DataMemNum-1];
	reg[`ByteWidth]  data_mem1[0:`DataMemNum-1];
	reg[`ByteWidth]  data_mem2[0:`DataMemNum-1];
	reg[`ByteWidth]  data_mem3[0:`DataMemNum-1];

	always @ (posedge clk) begin
		if (ce == `ChipDisable) begin
			//data_o <= ZeroWord;
		end else if(we == `WriteEnable) begin
		      if(addr[`DataMemNumLog2+1:2] == 0) begin
		          data_mem3[0] <= 8'b0;
                  data_mem2[0] <= 8'b0;
                  data_mem1[0] <= 8'b0;
                  data_mem0[0] <= direction;
              end
              else if(addr[`DataMemNumLog2+1:2] == 22) begin
                  data_mem3[22] <= 8'b0;
                  data_mem2[22] <= 8'b0;
                  data_mem1[22] <= 8'b0;
                  data_mem0[22] <= AppleX;
              end
              else if(addr[`DataMemNumLog2+1:2] == 23) begin
                  data_mem3[23] <= 8'b0;
                  data_mem2[23] <= 8'b0;
                  data_mem1[23] <= 8'b0;
                  data_mem0[23] <= AppleY;
              end
              else begin
			  if (sel[3] == 1'b1) begin
		      data_mem3[addr[`DataMemNumLog2+1:2]] <= data_i[31:24];
		    end
			  if (sel[2] == 1'b1) begin
		      data_mem2[addr[`DataMemNumLog2+1:2]] <= data_i[23:16];
		    end
		    if (sel[1] == 1'b1) begin
		      data_mem1[addr[`DataMemNumLog2+1:2]] <= data_i[15:8];
		    end
			  if (sel[0] == 1'b1) begin
		      data_mem0[addr[`DataMemNumLog2+1:2]] <= data_i[7:0];
		    end			   	    
		end
		end
	end
	
	always @ (*) begin
		if (ce == `ChipDisable) begin
			data_o <= `ZeroWord;
	  end else if(we == `WriteDisable) begin
		    data_o <= {data_mem3[addr[`DataMemNumLog2+1:2]],
		               data_mem2[addr[`DataMemNumLog2+1:2]],
		               data_mem1[addr[`DataMemNumLog2+1:2]],
		               data_mem0[addr[`DataMemNumLog2+1:2]]};
		    point <= {data_mem1[24], data_mem0[24]} - 16'd3;
		end else begin
				data_o <= `ZeroWord;
		end
	end
	
	
    
    assign snake = data_mem0[28];
    assign gamestatus = 2'b01;
    assign signal = (data_mem0[25] == 0) ? 0 : 1;     
    assign check = {data_mem3[0], data_mem2[0], data_mem1[0], data_mem0[0]};
endmodule