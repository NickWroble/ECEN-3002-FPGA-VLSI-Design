transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/nickw/Desktop/ECEN_3002_FPGA_VLSI/ECEN3002_Lab1_NIWR9446/source {C:/Users/nickw/Desktop/ECEN_3002_FPGA_VLSI/ECEN3002_Lab1_NIWR9446/source/ECEN3002_Lab1.sv}

vlog -sv -work work +incdir+C:/Users/nickw/Desktop/ECEN_3002_FPGA_VLSI/ECEN3002_Lab1_NIWR9446/quartus/../source {C:/Users/nickw/Desktop/ECEN_3002_FPGA_VLSI/ECEN3002_Lab1_NIWR9446/quartus/../source/tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run -all
