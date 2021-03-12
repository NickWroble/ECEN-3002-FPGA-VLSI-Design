#user defines
set ISSP_KEY 0
set ISSP_SW 1

project_open ECEN3002_Lab2

set hardware_name [lindex [get_hardware_names] 0]

set device_name [lindex [get_device_names -hardware_name $hardware_name] 1]

start_insystem_source_probe -device_name $device_name -hardware_name $hardware_name

#--------------------- BEGIN TEST ------------------------------------#
puts "BEGIN TEST"
puts "Restting device..."
write_source_data -instance_index $ISSP_KEY -value 110
after 500

puts "Testing normal operation for 5 seconds..."
#let it run normally for a bit
    write_source_data -instance_index $ISSP_KEY -value 111
    after 5000

puts "Testing reset..."
#perform a reset
    write_source_data -instance_index $ISSP_KEY -value 110
    #and wait a few seconds
    after 3000
    #and end reset
    write_source_data -instance_index $ISSP_KEY -value 111

puts "Load 2347 on to counter..."
#perform a load function
    #dec 2347
    write_source_data -instance_index $ISSP_SW -value 100100101011
    write_source_data -instance_index $ISSP_KEY -value 101
    #allow time for the value to load 
    after 1000
    write_source_data -instance_index $ISSP_KEY -value 111 
    #let it count up for a bit
    after 5000

puts "Count backwards..."
#count backwards from 0x3FF
    write_source_data -instance_index $ISSP_SW -value 1111111111
    write_source_data -instance_index $ISSP_KEY -value 101 
    #allow time for the value to load 
    after 1000
    write_source_data -instance_index $ISSP_KEY -value 011
    after 10000

write_source_data -instance_index $ISSP_KEY -value 110
puts "TEST ENDED"

#----------------------- END TEST ------------------------------------#

end_insystem_source_probe

project_close
