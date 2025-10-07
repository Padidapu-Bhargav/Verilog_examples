# ==============================
# Makefile for GCD Simulation
# ==============================

# Variables

# TOP       = GCD_AXI_TB
# SRC       = ../src/GCD.sv GCD_AXI_TB.sv

# TOP       = tb_Memory_mapped_interface
# SRC       = ../src/Memory_mapped_interface.sv ../src/ram_dual_port.sv memory_mapped_TB.sv

TOP       = GCD_TOP_TB
SRC       = GCD_TOP_TB.sv ../src/GCD_TOP.sv ../src/GCD.sv ../src/Memory_mapped_interface.sv ../src/ram_dual_port.sv 

WORK      = work
# WAVE_DO   = wave.do
# WAVE_DO   = m_m_i_wave.do
WAVE_DO   = GCD_TOP_wave.do
# Default target: compile + open GUI
all: gui

# Compile sources (always rebuild)
comp:
	rm -rf $(WORK)
	vlib $(WORK)
	vlog -sv -work $(WORK) $(SRC)

# Open simulation in GUI (loads wave.do and runs automatically)
gui: comp
	vsim -voptargs=+acc -do "do $(WAVE_DO); run -all" $(WORK).$(TOP)

# Console mode (headless run, saves waveform)
sim: comp
	vsim -c -do "do $(WAVE_DO); run -all; quit -f;" $(WORK).$(TOP)

# Cleanup
clean:
	rm -rf transcript vsim.wlf $(WORK) *.log *.jou

.PHONY: all comp sim gui clean
