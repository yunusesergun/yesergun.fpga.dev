# Generate .mcs
write_cfgmem -format mcs -size 16 -interface spix4 -loadbit "up 0x0 ./top_with_SW.bit" -file output.mcs -force
