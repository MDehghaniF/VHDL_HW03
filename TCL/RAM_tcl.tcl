quit -sim
.main clear

set PrefMain(saveLines) 1000000000

cd C:/FPGA/HW03/Sim
cmd /c "if exist work rmdir /S /Q work"
vlib work
vmap work

vcom -2008 ../Source/*.vhd
vcom -2008 ../Test/RAM_tb.vhd

vsim -t 100ps -vopt RAM_tb -voptargs=+acc

config wave -signalnamewidth 1

# add wave -format Logic -radix decimal sim:/RAM_tb/*
add wave -format Logic -radix hex sim:/RAM_tb/RAMInst/*


run -all








# do C:/FPGA/HW02/TCL/RAM_tcl.tcl