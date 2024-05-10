quit -sim
.main clear

set PrefMain(saveLines) 1000000000

cd C:/FPGA/HW03/Sim
cmd /c "if exist work rmdir /S /Q work"
vlib work
vmap work

vcom -2008 ../Source/Adder.vhd
vcom -2008 ../Test/Adder_tb.vhd

vsim -t 100ps -vopt Adder_tb -voptargs=+acc

config wave -signalnamewidth 1

# add wave -format Logic -radix decimal sim:/Adder_tb/*
add wave -format Logic -radix hex sim:/Adder_tb/AdderInst/*


run -all








# do C:/FPGA/HW02/TCL/Adder_tcl.tcl