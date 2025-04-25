set_property PACKAGE_PIN W5 [get_ports CLK100MHZ]
set_property IOSTANDARD LVCMOS33 [get_ports CLK100MHZ]

set_clock_groups -asynchronous \
    -group [get_clocks -include_generated_clocks clk_200M_design_2_clk_wiz_0_0] \
    -group [get_clocks -include_generated_clocks clk_25M_design_2_clk_wiz_1_0] \
    -group [get_clocks -include_generated_clocks clk_10M_design_2_clk_wiz_0_0]

set_clock_groups -logically_exclusive \
    -group [get_clocks clk_25M_design_2_clk_wiz_1_0] \
    -group [get_clocks clk_10M_design_2_clk_wiz_0_0]

# CLOCK_DEDICATED_ROUTE ayarları
set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets design_2_i/clk_wiz_0/inst/clk_10M]
set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets design_2_i/clk_wiz_1/inst/clk_25M]
set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets design_2_i/clk_wiz_0/inst/clk_200M]

set_property ASYNC_REG true [get_cells design_2_i/user_glitchless_mux_0/inst/sel_sync_ff1_clk2_reg]
set_property ASYNC_REG true [get_cells design_2_i/user_glitchless_mux_0/inst/sel_sync_ff2_clk2_reg]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
