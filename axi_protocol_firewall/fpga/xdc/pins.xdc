# Clock signal
set_property PACKAGE_PIN W5 [get_ports clock]
set_property IOSTANDARD LVCMOS33 [get_ports clock]

# Switches
set_property PACKAGE_PIN V17 [get_ports rstn_switch]
set_property IOSTANDARD LVCMOS33 [get_ports rstn_switch]
set_property PACKAGE_PIN V16 [get_ports clk_en]
set_property IOSTANDARD LVCMOS33 [get_ports clk_en]

##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports UART_rxd]
set_property IOSTANDARD LVCMOS33 [get_ports UART_rxd]
set_property PACKAGE_PIN A18 [get_ports UART_txd]
set_property IOSTANDARD LVCMOS33 [get_ports UART_txd]
