quit -sim
.main clear

set PrefMain(saveLines) 1000000000

cd C:/FPGA/HW03/Sim
cmd /c "if exist work rmdir /S /Q work"
vlib work
vmap work

vcom -2008 ../Source/*.vhd
vcom -2008 ../Test/RAM2_tb.vhd

vsim -t 100ps -vopt RAM2_tb -voptargs=+acc

config wave -signalnamewidth 1

# add wave -format Logic -radix decimal sim:/RAM2_tb/*
add wave -format Logic -radix hex sim:/RAM2_tb/RAM2Inst/*


run -all








# do C:/FPGA/HW02/TCL/RAM2_tcl.tcl