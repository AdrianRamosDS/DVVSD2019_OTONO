onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/clk
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/rst
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Start
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Load
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Op
add wave -noupdate -expand -group {MDR Top Module} -radix decimal /TB_MDR/DUV/Data
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/error
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Load_X
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Load_Y
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Ready
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Result
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Reminder
add wave -noupdate -divider MULTIPLCATION
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/start
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/adder_out
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/Multiplicando
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/Multiplicador
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/Ready
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/Result
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/demux_out_1
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/SorA2sum
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/A
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/S
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/P
add wave -noupdate -divider DIVISION
add wave -noupdate -group {Divider Module} /TB_MDR/DUV/DIVIDER/start
add wave -noupdate -group {Divider Module} /TB_MDR/DUV/DIVIDER/Dividendo
add wave -noupdate -group {Divider Module} /TB_MDR/DUV/DIVIDER/Divisor
add wave -noupdate -group {Divider Module} /TB_MDR/DUV/DIVIDER/adder_out
add wave -noupdate -group {Divider Module} /TB_MDR/DUV/DIVIDER/Ready
add wave -noupdate -group {Divider Module} /TB_MDR/DUV/DIVIDER/Result
add wave -noupdate -group {Divider Module} /TB_MDR/DUV/DIVIDER/Reminder
add wave -noupdate -group {Divider Module} /TB_MDR/DUV/DIVIDER/mux2resta
add wave -noupdate -group {Divider Module} /TB_MDR/DUV/DIVIDER/mux2resta2
add wave -noupdate -divider {SQUARE ROOT}
add wave -noupdate -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/start
add wave -noupdate -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/Data
add wave -noupdate -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/sumador_out
add wave -noupdate -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/Ready
add wave -noupdate -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/op_sel
add wave -noupdate -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/Result
add wave -noupdate -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/Reminder
add wave -noupdate -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/mux2sum1
add wave -noupdate -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/mux2sum2
add wave -noupdate -divider SUMADOR
add wave -noupdate -expand -group {Sumador Único} /TB_MDR/DUV/Adder_Suma_o_Resta/Sel
add wave -noupdate -expand -group {Sumador Único} /TB_MDR/DUV/Adder_Suma_o_Resta/A_Input
add wave -noupdate -expand -group {Sumador Único} /TB_MDR/DUV/Adder_Suma_o_Resta/B_Input
add wave -noupdate -expand -group {Sumador Único} /TB_MDR/DUV/Adder_Suma_o_Resta/C_Input
add wave -noupdate -expand -group {Sumador Único} /TB_MDR/DUV/Adder_Suma_o_Resta/Output_Data
add wave -noupdate -expand -group {Sumador Único} /TB_MDR/DUV/Adder_Suma_o_Resta/Mux1_w
add wave -noupdate -divider CONTROL
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/load
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/ready
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/error
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/enable_sync_rst
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/enable_operacion
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/enable_reg
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/enable_ready
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/enable_error
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/load_x
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/load_Y
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/load_op
add wave -noupdate -expand -group {General State Machine } /TB_MDR/DUV/Control_Unit/State
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 165
configure wave -valuecolwidth 84
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
WaveRestoreZoom {0 ps} {128 ps}
