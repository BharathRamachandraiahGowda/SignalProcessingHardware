transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/HDA/1_sem/SignalProcessingHardware/project/IQ_Mod_Demod/Quartus {D:/HDA/1_sem/SignalProcessingHardware/project/IQ_Mod_Demod/Quartus/IQ_mod_demod.sv}

vlog -sv -work work +incdir+D:/HDA/1_sem/SignalProcessingHardware/project/IQ_Mod_Demod/Quartus {D:/HDA/1_sem/SignalProcessingHardware/project/IQ_Mod_Demod/Quartus/IQ_mod_demod_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  IQ_mod_demod_tb

add wave *
view structure
view signals
run -all
