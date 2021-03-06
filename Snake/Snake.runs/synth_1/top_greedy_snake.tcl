# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_param simulator.modelsimInstallPath D:/modeltech_pe_10.5c/win32pe
set_msg_config -id {Common 17-41} -limit 10000000
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {D:/Computer Architecture/My-CPU/Snake/Snake.cache/wt} [current_project]
set_property parent.project_path {D:/Computer Architecture/My-CPU/Snake/Snake.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {d:/Computer Architecture/My-CPU/Snake/Snake.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  {D:/Computer Architecture/My-CPU/Snake/Snake.srcs/sources_1/new/VGA_Control.v}
  {D:/Computer Architecture/My-CPU/Snake/Snake.srcs/sources_1/new/clk_unit.v}
  {D:/Computer Architecture/My-CPU/Snake/Snake.srcs/sources_1/new/Seg_Display.v}
  {D:/Computer Architecture/My-CPU/Snake/Snake.srcs/sources_1/new/Snake_Eating_Apple.v}
  {D:/Computer Architecture/My-CPU/Snake/Snake.srcs/sources_1/new/Snake.v}
  {D:/Computer Architecture/My-CPU/Snake/Snake.srcs/sources_1/new/Key.v}
  {D:/Computer Architecture/My-CPU/Snake/Snake.srcs/sources_1/new/Game_Ctrl_Unit.v}
  {D:/Computer Architecture/My-CPU/Snake/Snake.srcs/sources_1/new/VGA_top.v}
  {D:/Computer Architecture/My-CPU/Snake/Snake.srcs/sources_1/new/top_greedy_snake.v}
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{D:/Computer Architecture/My-CPU/Snake/Snake.srcs/constrs_1/new/snake_basys3_xc.xdc}}
set_property used_in_implementation false [get_files {{D:/Computer Architecture/My-CPU/Snake/Snake.srcs/constrs_1/new/snake_basys3_xc.xdc}}]


synth_design -top top_greedy_snake -part xc7a100tcsg324-1


write_checkpoint -force -noxdef top_greedy_snake.dcp

catch { report_utilization -file top_greedy_snake_utilization_synth.rpt -pb top_greedy_snake_utilization_synth.pb }
