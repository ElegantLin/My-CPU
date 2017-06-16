`include "defines.v"
`timescale 1ns/1ps

module openmips_min_sopc_tb();

  reg     CLOCK_50;
  reg     rst;
  //integer file_output;
  
       
  initial begin
	//file_output = $fopen("D:/Computer Architecture/My-CPU/TestResult/beq.txt");
    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
  end
      
  initial begin
    rst = `RstEnable;
    #195 rst= `RstDisable;
    #1000000000 $stop;
  end
   
   openmips_min_sopc openmips_min_sopc0(
          .clk(CLOCK_50),
          .rst(rst)    
      );
      
   /*always@(posedge CLOCK_50) begin
		$fdisplay(file_output,"pc = %h", openmips_min_sopc0.openmips0.id0.pc_i);
		$fdisplay(file_output,"instr = %h", openmips_min_sopc0.openmips0.id0.inst_i);
		$fdisplay(file_output,"regfiles0 = %h", openmips_min_sopc0.openmips0.regfile1.regs[0]);
   		$fdisplay(file_output,"regfiles1 = %h", openmips_min_sopc0.openmips0.regfile1.regs[1]);
		$fdisplay(file_output,"regfiles2 = %h", openmips_min_sopc0.openmips0.regfile1.regs[2]);
		$fdisplay(file_output,"regfiles3 = %h", openmips_min_sopc0.openmips0.regfile1.regs[3]);
		$fdisplay(file_output,"regfiles4 = %h", openmips_min_sopc0.openmips0.regfile1.regs[4]);
		$fdisplay(file_output,"regfiles5 = %h", openmips_min_sopc0.openmips0.regfile1.regs[5]);
		$fdisplay(file_output,"regfiles6 = %h", openmips_min_sopc0.openmips0.regfile1.regs[6]);
		$fdisplay(file_output,"regfiles7 = %h", openmips_min_sopc0.openmips0.regfile1.regs[7]);
		$fdisplay(file_output,"regfiles8 = %h", openmips_min_sopc0.openmips0.regfile1.regs[8]);
		$fdisplay(file_output,"regfiles9 = %h", openmips_min_sopc0.openmips0.regfile1.regs[9]);
		$fdisplay(file_output,"regfiles10 = %h", openmips_min_sopc0.openmips0.regfile1.regs[10]);
		$fdisplay(file_output,"regfiles11 = %h", openmips_min_sopc0.openmips0.regfile1.regs[11]);
		$fdisplay(file_output,"regfiles12 = %h", openmips_min_sopc0.openmips0.regfile1.regs[12]);
		$fdisplay(file_output,"regfiles13 = %h", openmips_min_sopc0.openmips0.regfile1.regs[13]);
		$fdisplay(file_output,"regfiles14 = %h", openmips_min_sopc0.openmips0.regfile1.regs[14]);
		$fdisplay(file_output,"regfiles15 = %h", openmips_min_sopc0.openmips0.regfile1.regs[15]);
		$fdisplay(file_output,"regfiles16 = %h", openmips_min_sopc0.openmips0.regfile1.regs[16]);
		$fdisplay(file_output,"regfiles17 = %h", openmips_min_sopc0.openmips0.regfile1.regs[17]);
		$fdisplay(file_output,"regfiles18 = %h", openmips_min_sopc0.openmips0.regfile1.regs[18]);
		$fdisplay(file_output,"regfiles19 = %h", openmips_min_sopc0.openmips0.regfile1.regs[19]);
		$fdisplay(file_output,"regfiles20 = %h", openmips_min_sopc0.openmips0.regfile1.regs[20]);
		$fdisplay(file_output,"regfiles21 = %h", openmips_min_sopc0.openmips0.regfile1.regs[21]);
		$fdisplay(file_output,"regfiles22 = %h", openmips_min_sopc0.openmips0.regfile1.regs[22]);
		$fdisplay(file_output,"regfiles23 = %h", openmips_min_sopc0.openmips0.regfile1.regs[23]);
		$fdisplay(file_output,"regfiles24 = %h", openmips_min_sopc0.openmips0.regfile1.regs[24]);
		$fdisplay(file_output,"regfiles25 = %h", openmips_min_sopc0.openmips0.regfile1.regs[25]);
		$fdisplay(file_output,"regfiles26 = %h", openmips_min_sopc0.openmips0.regfile1.regs[26]);
		$fdisplay(file_output,"regfiles27 = %h", openmips_min_sopc0.openmips0.regfile1.regs[27]);
		$fdisplay(file_output,"regfiles28 = %h", openmips_min_sopc0.openmips0.regfile1.regs[28]);
		$fdisplay(file_output,"regfiles29 = %h", openmips_min_sopc0.openmips0.regfile1.regs[29]);
		$fdisplay(file_output,"regfiles30 = %h", openmips_min_sopc0.openmips0.regfile1.regs[30]);
		$fdisplay(file_output,"regfiles31 = %h", openmips_min_sopc0.openmips0.regfile1.regs[31]);
	end
   */
  

endmodule