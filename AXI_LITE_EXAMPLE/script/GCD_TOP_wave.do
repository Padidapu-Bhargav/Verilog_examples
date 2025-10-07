onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/ADDR_WIDTH
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/DATA_WIDTH
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/CONTROL_ADDR
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/A_ADDR
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/B_ADDR
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_ADDR
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/clk
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/rst
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AW_ADDR
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AW_PROT
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AW_VALID
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AW_READY
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/W_DATA
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/W_STRB
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/W_VALID
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/W_READY
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/B_RESP
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/B_valid
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/B_ready
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AR_ADDR
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AR_PROT
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AR_VALID
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AR_READY
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/R_DATA
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/R_RESP
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/R_VALID
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/R_READY
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/B_ready_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AW_ADDR_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AW_PROT_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AW_VALID_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/W_DATA_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/W_STRB_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/W_VALID_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AR_ADDR_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AR_PROT_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AR_VALID_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/AR_READY_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/R_DATA_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/R_RESP_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/R_VALID_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/R_READY_reg
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_A_data
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_A_valid
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_A_ready
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_B_data
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_B_valid
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_B_ready
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_data
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_valid
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_ready
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_state
add wave -noupdate -group GCD_TOP_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_next
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/ADDR_WIDTH
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/DATA_WIDTH
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/clk
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/rst
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/AW_ADDR
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/AW_PROT
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/AW_VALID
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/AW_READY
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/W_DATA
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/W_STRB
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/W_VALID
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/W_READY
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/B_RESP
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/B_valid
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/B_ready
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/AR_ADDR
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/AR_PROT
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/AR_VALID
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/AR_READY
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/R_DATA
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/R_RESP
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/R_VALID
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/R_READY
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/aw_addr_reg
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/aw_prot_reg
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/aw_valid_reg
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/w_data_reg
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/w_strb_reg
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/w_valid_reg
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/we
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/re
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/wr_state
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/wr_next
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/rd_state
add wave -noupdate -group MMI_DUT /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/rd_next
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/DW
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/clk
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/rst
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/A_data
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/A_valid
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/A_ready
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/B_data
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/B_valid
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/B_ready
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/GCD_data
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/GCD_valid
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/GCD_ready
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/A_data_reg
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/A_valid_reg
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/B_data_reg
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/B_valid_reg
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/opcode
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/A_have
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/B_have
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/current_state
add wave -noupdate -group GCD_DUT /GCD_TOP_TB/GCD_TOP_DUT/GCD_DUT/next_state
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/DATA_WIDTH
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/ADDR_WIDTH
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/DEPTH
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/clk
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/rst
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/we
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/write_addr
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/write_data
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/re
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/read_addr
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/read_data
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/mem
add wave -noupdate -group RAM /GCD_TOP_TB/GCD_TOP_DUT/MMI_DUT/u_ram_dual_port/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ps} {21972 ps}
