# Script for automatically doing the stuff I need to do every time I change something in the source
# This script does not work on non *nix machines for obvious reasons: it would make things more productive.

# Comple all the vhdl files
vcom *.vhd		

# Start the simulation (use eval since already in terminal, otherwise a new window will open)
eval vsim work.main

# Add the objects to the wave
add wave -r /* 			

# Force clock to be 10ns
force -freeze sim:/main/ck 1 0, 0 {5000 ps} -r 10ns