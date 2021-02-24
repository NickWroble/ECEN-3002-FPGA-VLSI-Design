transcript on
if ![file isdirectory vga_controller_iputf_libs] {
	file mkdir vga_controller_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/quartus/vga_pll_sim/vga_pll.vo"

vlog -sv -work work +incdir+C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/source {C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/source/vga_reset.sv}
vlog -sv -work work +incdir+C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/source {C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/source/vga_controller.sv}
vlog -sv -work work +incdir+C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/source {C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/source/vga_pixel_gen.sv}
vlog -sv -work work +incdir+C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/source {C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/source/tb.sv}
vlog -sv -work work +incdir+C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/source {C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/source/vga_clock.sv}

vlog -sv -work work +incdir+C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/quartus/../source {C:/Users/nickw/Documents/GitHub/ECEN-3002/ECEN-3002-FPGA-VLSI_Design/vga_controller/part_2/vga_controller/quartus/../source/tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run -all
