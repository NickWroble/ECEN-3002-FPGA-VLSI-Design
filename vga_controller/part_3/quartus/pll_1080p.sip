set_global_assignment -entity "pll_1080p" -library "lib_pll_1080p" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll_1080p" -library "lib_pll_1080p" -name IP_TOOL_VERSION "20.1"
set_global_assignment -entity "pll_1080p" -library "lib_pll_1080p" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll_1080p" -name SPD_FILE [file join $::quartus(sip_path) "pll_1080p.spd"]

set_global_assignment -library "lib_pll_1080p" -name MISC_FILE [file join $::quartus(sip_path) "pll_1080p_sim/pll_1080p.vo"]
