@echo off
set xv_path=D:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim openmips_min_sopc_tb_func_synth -key {Post-Synthesis:sim_1:Functional:openmips_min_sopc_tb} -tclbatch openmips_min_sopc_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0