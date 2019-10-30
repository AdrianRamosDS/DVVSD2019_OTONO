onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group CONTROL_UNIT /TB_Multiplicator_module/DUV/MULT_CONTROL_UNIT/clk
add wave -noupdate -expand -group CONTROL_UNIT /TB_Multiplicator_module/DUV/MULT_CONTROL_UNIT/rst
add wave -noupdate -expand -group CONTROL_UNIT /TB_Multiplicator_module/DUV/MULT_CONTROL_UNIT/flag_cont
add wave -noupdate -expand -group CONTROL_UNIT /TB_Multiplicator_module/DUV/MULT_CONTROL_UNIT/start
add wave -noupdate -expand -group CONTROL_UNIT /TB_Multiplicator_module/DUV/MULT_CONTROL_UNIT/enable_cont
add wave -noupdate -expand -group CONTROL_UNIT /TB_Multiplicator_module/DUV/MULT_CONTROL_UNIT/enable_sync_rst
add wave -noupdate -expand -group CONTROL_UNIT /TB_Multiplicator_module/DUV/MULT_CONTROL_UNIT/enable_reg
add wave -noupdate -expand -group CONTROL_UNIT /TB_Multiplicator_module/DUV/MULT_CONTROL_UNIT/enable_ready
add wave -noupdate -expand -group CONTROL_UNIT /TB_Multiplicator_module/DUV/MULT_CONTROL_UNIT/enable_shift
add wave -noupdate -expand -group CONTROL_UNIT -color Gold /TB_Multiplicator_module/DUV/MULT_CONTROL_UNIT/State
add wave -noupdate -expand -group Final_Register /TB_Multiplicator_module/DUV/Final_Register/clk
add wave -noupdate -expand -group Final_Register /TB_Multiplicator_module/DUV/Final_Register/rst
add wave -noupdate -expand -group Final_Register /TB_Multiplicator_module/DUV/Final_Register/enb
add wave -noupdate -expand -group Final_Register /TB_Multiplicator_module/DUV/Final_Register/sync_rst
add wave -noupdate -expand -group Final_Register /TB_Multiplicator_module/DUV/Final_Register/data
add wave -noupdate -expand -group Final_Register -radix decimal /TB_Multiplicator_module/DUV/Final_Register/out
add wave -noupdate -expand -group Final_Register /TB_Multiplicator_module/DUV/Final_Register/rgstr_r
add wave -noupdate -group P_RGSTR /TB_Multiplicator_module/DUV/P_REG/enb
add wave -noupdate -group P_RGSTR /TB_Multiplicator_module/DUV/P_REG/sync_rst
add wave -noupdate -group P_RGSTR -radix decimal -childformat {{{/TB_Multiplicator_module/DUV/P_REG/data[32]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[31]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[30]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[29]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[28]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[27]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[26]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[25]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[24]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[23]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[22]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[21]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[20]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[19]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[18]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[17]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[16]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[15]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[14]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[13]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[12]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[11]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[10]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[9]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[8]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[7]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[6]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[5]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[4]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[3]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[2]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[1]} -radix decimal} {{/TB_Multiplicator_module/DUV/P_REG/data[0]} -radix decimal}} -subitemconfig {{/TB_Multiplicator_module/DUV/P_REG/data[32]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[31]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[30]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[29]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[28]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[27]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[26]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[25]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[24]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[23]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[22]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[21]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[20]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[19]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[18]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[17]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[16]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[15]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[14]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[13]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[12]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[11]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[10]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[9]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[8]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[7]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[6]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[5]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[4]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[3]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[2]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[1]} {-height 15 -radix decimal} {/TB_Multiplicator_module/DUV/P_REG/data[0]} {-height 15 -radix decimal}} /TB_Multiplicator_module/DUV/P_REG/data
add wave -noupdate -group P_RGSTR /TB_Multiplicator_module/DUV/P_REG/out
add wave -noupdate -group P_RGSTR /TB_Multiplicator_module/DUV/P_REG/rgstr_r
add wave -noupdate -group Mux_P_Input /TB_Multiplicator_module/DUV/P_INPUT/Selector
add wave -noupdate -group Mux_P_Input /TB_Multiplicator_module/DUV/P_INPUT/Data_0
add wave -noupdate -group Mux_P_Input /TB_Multiplicator_module/DUV/P_INPUT/Data_1
add wave -noupdate -group Mux_P_Input /TB_Multiplicator_module/DUV/P_INPUT/Mux_Output
add wave -noupdate -group Mux_P_Input /TB_Multiplicator_module/DUV/P_INPUT/Mux_Output_log
add wave -noupdate -group S_RGSTR /TB_Multiplicator_module/DUV/S_REG/enb
add wave -noupdate -group S_RGSTR /TB_Multiplicator_module/DUV/S_REG/sync_rst
add wave -noupdate -group S_RGSTR -radix decimal /TB_Multiplicator_module/DUV/S_REG/data
add wave -noupdate -group S_RGSTR /TB_Multiplicator_module/DUV/S_REG/out
add wave -noupdate -group S_RGSTR /TB_Multiplicator_module/DUV/S_REG/rgstr_r
add wave -noupdate -group A_RGSTR /TB_Multiplicator_module/DUV/A_REG/enb
add wave -noupdate -group A_RGSTR /TB_Multiplicator_module/DUV/A_REG/sync_rst
add wave -noupdate -group A_RGSTR -radix binary /TB_Multiplicator_module/DUV/A_REG/data
add wave -noupdate -group A_RGSTR /TB_Multiplicator_module/DUV/A_REG/out
add wave -noupdate -group A_RGSTR /TB_Multiplicator_module/DUV/A_REG/rgstr_r
add wave -noupdate -radix decimal /TB_Multiplicator_module/DUV/Result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {87 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {66 ps} {102 ps}
