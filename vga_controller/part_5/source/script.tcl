set master_path [lindex [get_service_paths master] 0] 
set mpath [claim_service master $master_path “”]
# Locate JTAG path
set jpath [lindex [get_service_paths jtag_debug] 0]
# Reset system
jtag_debug_reset_system $jpath
puts "System reset......"
# Test clock is running and reset is high
set clk [jtag_debug_sense_clock $jpath]
if {$clk == 1} {
 puts "Clocking running properly."
} {else
 puts "Clocking appears to not be running."
}
set rst [jtag_debug_sample_reset $jpath]
puts "Reset level is $rst (should be 1)."

master_write_32 $mpath 0x00000000 0x55555555
master_read_32  $mpath 0x00000000 1

#0
master_write_32 $mpath 0x40000000 0x00000000 
#1
master_write_32 $mpath 0x40000004 0x00000000
#2
master_write_32 $mpath 0x40000008 0x00001000
#3
master_write_32 $mpath 0x4000000c 0x00000008

master_write_32 $mpath 0x40000018 0x00000084

master_read_32  $mpath 0x40000000 8
close_service master $mpath
