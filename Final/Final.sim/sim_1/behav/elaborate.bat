@echo off
set xv_path=D:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xelab  -wto 9f3aa1f91c154c0c9004de9438169d34 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot top_tb_behav xil_defaultlib.top_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
