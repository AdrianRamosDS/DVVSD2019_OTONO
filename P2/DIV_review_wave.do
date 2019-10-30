onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Top Module} /TB_Divider_module/DUV/clk
add wave -noupdate -expand -group {Top Module} /TB_Divider_module/DUV/rst
add wave -noupdate -expand -group {Top Module} /TB_Divider_module/DUV/start
add wave -noupdate -expand -group {Top Module} -radix decimal /TB_Divider_module/DUV/Dividendo
add wave -noupdate -expand -group {Top Module} -radix decimal /TB_Divider_module/DUV/Divisor
add wave -noupdate -expand -group {Top Module} -radix decimal /TB_Divider_module/DUV/Result
add wave -noupdate -expand -group {Top Module} -radix decimal /TB_Divider_module/DUV/Reminder
add wave -noupdate -expand -group {Top Module} /TB_Divider_module/DUV/Ready
add wave -noupdate -expand -group Counter /TB_Divider_module/DUV/Counter/enb
add wave -noupdate -expand -group Counter -radix decimal /TB_Divider_module/DUV/Counter/Counting_logic
add wave -noupdate -expand -group Mux2Dividendo /TB_Divider_module/DUV/DIVIDENDO_INPUT/Selector
add wave -noupdate -expand -group Mux2Dividendo -radix decimal /TB_Divider_module/DUV/DIVIDENDO_INPUT/Data_0
add wave -noupdate -expand -group Mux2Dividendo -radix decimal /TB_Divider_module/DUV/DIVIDENDO_INPUT/Data_1
add wave -noupdate -expand -group Mux2Dividendo -radix decimal /TB_Divider_module/DUV/DIVIDENDO_INPUT/Mux_Output
add wave -noupdate -expand -group {Dividendo RGSTR} /TB_Divider_module/DUV/DIVIDENDO_RGSTR/enb
add wave -noupdate -expand -group {Dividendo RGSTR} /TB_Divider_module/DUV/DIVIDENDO_RGSTR/sync_rst
add wave -noupdate -expand -group {Dividendo RGSTR} -radix decimal /TB_Divider_module/DUV/DIVIDENDO_RGSTR/data
add wave -noupdate -expand -group {Dividendo RGSTR} -radix decimal /TB_Divider_module/DUV/DIVIDENDO_RGSTR/out
add wave -noupdate -expand -group SUMADOR(Restador) -radix decimal /TB_Divider_module/DUV/General_Adder/A_input
add wave -noupdate -expand -group SUMADOR(Restador) -radix decimal /TB_Divider_module/DUV/General_Adder/B_input
add wave -noupdate -expand -group SUMADOR(Restador) -radix decimal /TB_Divider_module/DUV/General_Adder/C_output
add wave -noupdate -expand -group {Reminder RGSTR} /TB_Divider_module/DUV/RESIDUO_RGSTR/enb
add wave -noupdate -expand -group {Reminder RGSTR} /TB_Divider_module/DUV/RESIDUO_RGSTR/sync_rst
add wave -noupdate -expand -group {Reminder RGSTR} -radix decimal /TB_Divider_module/DUV/RESIDUO_RGSTR/data
add wave -noupdate -expand -group {Reminder RGSTR} -radix decimal /TB_Divider_module/DUV/RESIDUO_RGSTR/out
add wave -noupdate -expand -group {Resultado RGSTR} /TB_Divider_module/DUV/RESULTADO_RGSTR/enb
add wave -noupdate -expand -group {Resultado RGSTR} /TB_Divider_module/DUV/RESULTADO_RGSTR/sync_rst
add wave -noupdate -expand -group {Resultado RGSTR} -radix decimal /TB_Divider_module/DUV/RESULTADO_RGSTR/data
add wave -noupdate -expand -group {Resultado RGSTR} -radix decimal /TB_Divider_module/DUV/RESULTADO_RGSTR/out
add wave -noupdate -expand -group {Control Unit} /TB_Divider_module/DUV/CONTROL_UNIT/start
add wave -noupdate -expand -group {Control Unit} /TB_Divider_module/DUV/CONTROL_UNIT/count_flag
add wave -noupdate -expand -group {Control Unit} /TB_Divider_module/DUV/CONTROL_UNIT/enb_mux
add wave -noupdate -expand -group {Control Unit} /TB_Divider_module/DUV/CONTROL_UNIT/enb_sync_rst
add wave -noupdate -expand -group {Control Unit} /TB_Divider_module/DUV/CONTROL_UNIT/enb_reg
add wave -noupdate -expand -group {Control Unit} /TB_Divider_module/DUV/CONTROL_UNIT/enb_ready
add wave -noupdate -expand -group {Control Unit} /TB_Divider_module/DUV/CONTROL_UNIT/enb_count
add wave -noupdate -expand -group {Control Unit} /TB_Divider_module/DUV/CONTROL_UNIT/State
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {65 ps} 0}
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
WaveRestoreZoom {0 ps} {120 ps}
