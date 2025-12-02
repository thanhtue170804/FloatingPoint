transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/Sign_Unit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/Normalizer.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/Mantissa_Normalisation.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/Mantissa_Multiplier.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/FP_Unit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/FP_Mul.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/FP_Div.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/Floating_Seperation.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/Adder_Exponent_Bias.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/FP_Add.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/FP_Sub.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/NR_Iteration.v}
vlib system
vmap system system

vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax {C:/altera/13.0sp1/Systemofchip/FP_Unit_ProMax/FP_Unit_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -L system -voptargs="+acc"  FP_Unit_tb

add wave *
view structure
view signals
run -all
