## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk_in]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_in]

##Quad SPI Flash
##Note that CCLK_0 cannot be placed in 7 series devices. You can access it using the
##STARTUPE2 primitive.
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports qspi_flash_io0_io]
set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports qspi_flash_io1_io]
set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports qspi_flash_io2_io]
set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports qspi_flash_io3_io]
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports qspi_flash_ss_io]


## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]