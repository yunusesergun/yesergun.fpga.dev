# create_hooks.tcl
set script_dir [file dirname [info script]]
set xdc_file [file join $script_dir ../xdc/pins.xdc]

# Set property for the XDC file
set_property used_in_synthesis false [get_files $xdc_file]
