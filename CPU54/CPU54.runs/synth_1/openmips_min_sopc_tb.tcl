# 
# Synthesis run script generated by Vivado
# 

set_param simulator.modelsimInstallPath D:/modeltech_pe_10.5c/win32pe
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7vx485tffg1157-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {D:/Computer Architecture/My-CPU/CPU54/CPU54.cache/wt} [current_project]
set_property parent.project_path {D:/Computer Architecture/My-CPU/CPU54/CPU54.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo {d:/Computer Architecture/My-CPU/CPU54/CPU54.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/define.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/regfile.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/pc_reg.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/LLbit_reg.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/if_id.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/id_ex.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/id.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/ex_mem.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/ex.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/div.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/ctrl.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/cp0_reg.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/hilo_reg.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/mem_wb.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/mem.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/data_ram.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/inst_rom.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/openmips.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/openmips_min_sopc.v}
  {D:/Computer Architecture/My-CPU/CPU54/CPU54.srcs/sources_1/new/openmips_min_sopc_tb.v}
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}

synth_design -top openmips_min_sopc_tb -part xc7vx485tffg1157-1


write_checkpoint -force -noxdef openmips_min_sopc_tb.dcp

catch { report_utilization -file openmips_min_sopc_tb_utilization_synth.rpt -pb openmips_min_sopc_tb_utilization_synth.pb }
