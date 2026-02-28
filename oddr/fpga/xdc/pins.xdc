# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk_in]
set_property IOSTANDARD LVCMOS33 [get_ports clk_in]


#Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports clk_out]					
set_property IOSTANDARD LVCMOS33 [get_ports clk_out]
#Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {en[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {en[0]}]


## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]


## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
