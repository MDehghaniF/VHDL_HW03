quit -sim
.main clear

set PrefMain(saveLines) 1000000000

cd C:/FPGA/HW03/Sim
cmd /c "if exist work rmdir /S /Q work"
vlib work
vmap work

vcom -2008 ../Source/Module.vhd
vcom -2008 ../Source/Adder.vhd
vcom -2008 ../Test/Module_tb.vhd

vsim -t 100ps -vopt Module_tb -voptargs=+acc

config wave -signalnamewidth 1

# add wave -format Logic -radix decimal sim:/Module_tb/*
add wave -format Logic -radix hex sim:/Module_tb/ModuleInst/*


run -all








# do C:/FPGA/HW03/TCL/Module_tcl.tcl