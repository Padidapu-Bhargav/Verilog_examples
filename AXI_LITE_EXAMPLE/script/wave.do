onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/ADDR_WIDTH
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/DATA_WIDTH
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/clk
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/rst
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/AW_ADDR
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/AW_PROT
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/AW_VALID
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/AW_READY
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/W_DATA
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/W_STRB
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/W_VALID
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/W_READY
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/B_RESP
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/B_valid
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/B_ready
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/AR_ADDR
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/AR_PROT
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/AR_VALID
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/AR_READY
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/R_DATA
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/R_RESP
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/R_VALID
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/R_READY
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/aw_addr_reg
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/aw_prot_reg
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/aw_valid_reg
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/aw_ready_reg
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/w_data_reg
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/w_strb_reg
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/w_valid_reg
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/w_ready_reg
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/we
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/re
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/wr_state
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/wr_next
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/rd_state
add wave -noupdate -expand -group DUT -radix unsigned /tb_Memory_mapped_interface/DUT/rd_next
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/DATA_WIDTH
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/ADDR_WIDTH
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/clk
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/rst
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/we
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/write_addr
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/write_data
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/re
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/read_addr
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/read_data
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/mem_1
add wave -noupdate -expand -group RAM -radix unsigned /tb_Memory_mapped_interface/DUT/u_ram_dual_port/mem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12327 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {161933 ps} {186215 ps}
