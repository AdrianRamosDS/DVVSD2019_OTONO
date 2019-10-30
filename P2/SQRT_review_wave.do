onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Top Module SQRT} /TB_SQRT_module/DUV/clk
add wave -noupdate -expand -group {Top Module SQRT} /TB_SQRT_module/DUV/rst
add wave -noupdate -expand -group {Top Module SQRT} /TB_SQRT_module/DUV/start
add wave -noupdate -expand -group {Top Module SQRT} -radix decimal /TB_SQRT_module/DUV/Data
add wave -noupdate -expand -group {Top Module SQRT} /TB_SQRT_module/DUV/Ready
add wave -noupdate -expand -group {Top Module SQRT} /TB_SQRT_module/DUV/op_sel
add wave -noupdate -expand -group {Top Module SQRT} -radix decimal /TB_SQRT_module/DUV/Result
add wave -noupdate -expand -group {Top Module SQRT} -radix decimal /TB_SQRT_module/DUV/Reminder
add wave -noupdate -expand -group {Top Module SQRT} -radix decimal /TB_SQRT_module/DUV/sumador_out
add wave -noupdate -expand -group Sumador -radix decimal /TB_SQRT_module/DUV/General_adder/A_input
add wave -noupdate -expand -group Sumador -radix decimal /TB_SQRT_module/DUV/General_adder/B_input
add wave -noupdate -expand -group Sumador /TB_SQRT_module/DUV/General_adder/Op_sel
add wave -noupdate -expand -group Sumador -radix decimal /TB_SQRT_module/DUV/General_adder/C_output
add wave -noupdate -expand -group {SQRT Control Unit} /TB_SQRT_module/DUV/SQRT_Control_Unit/count_flag
add wave -noupdate -expand -group {SQRT Control Unit} /TB_SQRT_module/DUV/SQRT_Control_Unit/start
add wave -noupdate -expand -group {SQRT Control Unit} /TB_SQRT_module/DUV/SQRT_Control_Unit/enable_cont
add wave -noupdate -expand -group {SQRT Control Unit} /TB_SQRT_module/DUV/SQRT_Control_Unit/enable_sync_rst
add wave -noupdate -expand -group {SQRT Control Unit} /TB_SQRT_module/DUV/SQRT_Control_Unit/enable_reg
add wave -noupdate -expand -group {SQRT Control Unit} /TB_SQRT_module/DUV/SQRT_Control_Unit/enable_ready
add wave -noupdate -expand -group {SQRT Control Unit} /TB_SQRT_module/DUV/SQRT_Control_Unit/enable_reg_Q
add wave -noupdate -expand -group {SQRT Control Unit} /TB_SQRT_module/DUV/SQRT_Control_Unit/enable_reg_R
add wave -noupdate -expand -group {SQRT Control Unit} /TB_SQRT_module/DUV/SQRT_Control_Unit/enable_shift
add wave -noupdate -expand -group {SQRT Control Unit} /TB_SQRT_module/DUV/SQRT_Control_Unit/State
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {64 ps} 0}
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
WaveRestoreZoom {0 ps} {112 ps}
