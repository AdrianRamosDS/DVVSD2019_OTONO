onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/clk
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/rst
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Start
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Load
add wave -noupdate -expand -group {MDR Top Module} -color Violet /TB_MDR/DUV/Op
add wave -noupdate -expand -group {MDR Top Module} -color Violet -radix decimal /TB_MDR/DUV/Data
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/error
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Load_X
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Load_Y
add wave -noupdate -expand -group {MDR Top Module} /TB_MDR/DUV/Ready
add wave -noupdate -expand -group {MDR Top Module} -color Red -radix decimal /TB_MDR/DUV/Result
add wave -noupdate -expand -group {MDR Top Module} -color Red -radix decimal /TB_MDR/DUV/Reminder
add wave -noupdate -expand -group {Result Mux} /TB_MDR/DUV/Result_Mux/Sel
add wave -noupdate -expand -group {Result Mux} -radix decimal /TB_MDR/DUV/Result_Mux/A_Input
add wave -noupdate -expand -group {Result Mux} -radix decimal /TB_MDR/DUV/Result_Mux/B_Input
add wave -noupdate -expand -group {Result Mux} -radix decimal /TB_MDR/DUV/Result_Mux/C_Input
add wave -noupdate -expand -group {Result Mux} -radix decimal /TB_MDR/DUV/Result_Mux/Output_Data
add wave -noupdate -expand -group {Result Register} /TB_MDR/DUV/Result_Register/enb
add wave -noupdate -expand -group {Result Register} /TB_MDR/DUV/Result_Register/sync_rst
add wave -noupdate -expand -group {Result Register} -radix decimal /TB_MDR/DUV/Result_Register/data
add wave -noupdate -expand -group {Result Register} -radix decimal /TB_MDR/DUV/Result_Register/out
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
add wave -noupdate -expand -group {General State Machine } -radix binary /TB_MDR/DUV/Control_Unit/load_op
add wave -noupdate -expand -group {General State Machine } -color {Dark Orchid} /TB_MDR/DUV/Control_Unit/State
add wave -noupdate -divider {DATA REGISTERS}
add wave -noupdate -expand -group {X Register} /TB_MDR/DUV/Data_X_Register/enb
add wave -noupdate -expand -group {X Register} /TB_MDR/DUV/Data_X_Register/sync_rst
add wave -noupdate -expand -group {X Register} -radix decimal /TB_MDR/DUV/Data_X_Register/data
add wave -noupdate -expand -group {X Register} -radix decimal /TB_MDR/DUV/Data_X_Register/out
add wave -noupdate -expand -group {Y Register} /TB_MDR/DUV/Data_Y_Register/enb
add wave -noupdate -expand -group {Y Register} /TB_MDR/DUV/Data_Y_Register/sync_rst
add wave -noupdate -expand -group {Y Register} -radix decimal /TB_MDR/DUV/Data_Y_Register/data
add wave -noupdate -expand -group {Y Register} -radix decimal /TB_MDR/DUV/Data_Y_Register/out
add wave -noupdate -divider MULTIPLCATION
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/start
add wave -noupdate -group {Multiplier Module} -radix decimal /TB_MDR/DUV/MULTIPLIER/adder_out
add wave -noupdate -group {Multiplier Module} -radix decimal /TB_MDR/DUV/MULTIPLIER/Multiplicando
add wave -noupdate -group {Multiplier Module} -radix decimal /TB_MDR/DUV/MULTIPLIER/Multiplicador
add wave -noupdate -group {Multiplier Module} /TB_MDR/DUV/MULTIPLIER/Ready
add wave -noupdate -group {Multiplier Module} -radix decimal /TB_MDR/DUV/MULTIPLIER/Result
add wave -noupdate -group {Multiplier Module} -radix decimal /TB_MDR/DUV/MULTIPLIER/demux_out_1
add wave -noupdate -group {Multiplier Module} -radix decimal /TB_MDR/DUV/MULTIPLIER/SorA2sum
add wave -noupdate -group {Multiplier Module} -radix decimal /TB_MDR/DUV/MULTIPLIER/A
add wave -noupdate -group {Multiplier Module} -radix decimal /TB_MDR/DUV/MULTIPLIER/S
add wave -noupdate -group {Multiplier Module} -radix decimal /TB_MDR/DUV/MULTIPLIER/P
add wave -noupdate -group {Multiplier Control Unit} /TB_MDR/DUV/MULTIPLIER/MULT_CONTROL_UNIT/flag_cont
add wave -noupdate -group {Multiplier Control Unit} /TB_MDR/DUV/MULTIPLIER/MULT_CONTROL_UNIT/start
add wave -noupdate -group {Multiplier Control Unit} /TB_MDR/DUV/MULTIPLIER/MULT_CONTROL_UNIT/enable_cont
add wave -noupdate -group {Multiplier Control Unit} /TB_MDR/DUV/MULTIPLIER/MULT_CONTROL_UNIT/enable_sync_rst
add wave -noupdate -group {Multiplier Control Unit} /TB_MDR/DUV/MULTIPLIER/MULT_CONTROL_UNIT/enable_reg
add wave -noupdate -group {Multiplier Control Unit} /TB_MDR/DUV/MULTIPLIER/MULT_CONTROL_UNIT/enable_ready
add wave -noupdate -group {Multiplier Control Unit} /TB_MDR/DUV/MULTIPLIER/MULT_CONTROL_UNIT/enable_shift
add wave -noupdate -group {Multiplier Control Unit} /TB_MDR/DUV/MULTIPLIER/MULT_CONTROL_UNIT/State
add wave -noupdate -divider DIVISION
add wave -noupdate -group {Divider Module} /TB_MDR/DUV/DIVIDER/start
add wave -noupdate -group {Divider Module} -radix decimal /TB_MDR/DUV/DIVIDER/Dividendo
add wave -noupdate -group {Divider Module} -radix decimal /TB_MDR/DUV/DIVIDER/Divisor
add wave -noupdate -group {Divider Module} -radix decimal /TB_MDR/DUV/DIVIDER/adder_out
add wave -noupdate -group {Divider Module} /TB_MDR/DUV/DIVIDER/Ready
add wave -noupdate -group {Divider Module} -radix decimal /TB_MDR/DUV/DIVIDER/Result
add wave -noupdate -group {Divider Module} -radix decimal /TB_MDR/DUV/DIVIDER/Reminder
add wave -noupdate -group {Divider Module} -radix decimal /TB_MDR/DUV/DIVIDER/mux2resta
add wave -noupdate -group {Divider Module} -radix decimal /TB_MDR/DUV/DIVIDER/mux2resta2
add wave -noupdate -group {Divider Control Unit} /TB_MDR/DUV/DIVIDER/CONTROL_UNIT/count_flag
add wave -noupdate -group {Divider Control Unit} /TB_MDR/DUV/DIVIDER/CONTROL_UNIT/enb_mux
add wave -noupdate -group {Divider Control Unit} /TB_MDR/DUV/DIVIDER/CONTROL_UNIT/enb_sync_rst
add wave -noupdate -group {Divider Control Unit} /TB_MDR/DUV/DIVIDER/CONTROL_UNIT/enb_reg
add wave -noupdate -group {Divider Control Unit} /TB_MDR/DUV/DIVIDER/CONTROL_UNIT/enb_ready
add wave -noupdate -group {Divider Control Unit} /TB_MDR/DUV/DIVIDER/CONTROL_UNIT/enb_count
add wave -noupdate -group {Divider Control Unit} -color {Blue Violet} /TB_MDR/DUV/DIVIDER/CONTROL_UNIT/State
add wave -noupdate -divider {SQUARE ROOT}
add wave -noupdate -expand -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/start
add wave -noupdate -expand -group {SQRT Module} -radix decimal /TB_MDR/DUV/SQUARE_ROOT/Data
add wave -noupdate -expand -group {SQRT Module} -radix decimal /TB_MDR/DUV/SQUARE_ROOT/sumador_out
add wave -noupdate -expand -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/Ready
add wave -noupdate -expand -group {SQRT Module} /TB_MDR/DUV/SQUARE_ROOT/op_sel
add wave -noupdate -expand -group {SQRT Module} -radix decimal /TB_MDR/DUV/SQUARE_ROOT/Result
add wave -noupdate -expand -group {SQRT Module} -radix decimal /TB_MDR/DUV/SQUARE_ROOT/Reminder
add wave -noupdate -expand -group {SQRT Module} -radix decimal /TB_MDR/DUV/SQUARE_ROOT/mux2sum1
add wave -noupdate -expand -group {SQRT Module} -radix decimal /TB_MDR/DUV/SQUARE_ROOT/mux2sum2
add wave -noupdate -expand -group {SQRT Control Unit} /TB_MDR/DUV/SQUARE_ROOT/SQRT_Control_Unit/count_flag
add wave -noupdate -expand -group {SQRT Control Unit} /TB_MDR/DUV/SQUARE_ROOT/SQRT_Control_Unit/start
add wave -noupdate -expand -group {SQRT Control Unit} /TB_MDR/DUV/SQUARE_ROOT/SQRT_Control_Unit/enable_cont
add wave -noupdate -expand -group {SQRT Control Unit} /TB_MDR/DUV/SQUARE_ROOT/SQRT_Control_Unit/enable_sync_rst
add wave -noupdate -expand -group {SQRT Control Unit} /TB_MDR/DUV/SQUARE_ROOT/SQRT_Control_Unit/enable_reg
add wave -noupdate -expand -group {SQRT Control Unit} /TB_MDR/DUV/SQUARE_ROOT/SQRT_Control_Unit/enable_ready
add wave -noupdate -expand -group {SQRT Control Unit} /TB_MDR/DUV/SQUARE_ROOT/SQRT_Control_Unit/enable_reg_Q
add wave -noupdate -expand -group {SQRT Control Unit} /TB_MDR/DUV/SQUARE_ROOT/SQRT_Control_Unit/enable_reg_R
add wave -noupdate -expand -group {SQRT Control Unit} /TB_MDR/DUV/SQUARE_ROOT/SQRT_Control_Unit/enable_shift
add wave -noupdate -expand -group {SQRT Control Unit} -color {Blue Violet} /TB_MDR/DUV/SQUARE_ROOT/SQRT_Control_Unit/State
add wave -noupdate -divider SUMADOR
add wave -noupdate -expand -group {Sumador Único} -radix decimal /TB_MDR/DUV/General_Adder/A_input
add wave -noupdate -expand -group {Sumador Único} -radix decimal /TB_MDR/DUV/General_Adder/B_input
add wave -noupdate -expand -group {Sumador Único} /TB_MDR/DUV/General_Adder/Op_sel
add wave -noupdate -expand -group {Sumador Único} -radix decimal /TB_MDR/DUV/General_Adder/C_output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {385 ps} 0}
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
WaveRestoreZoom {121 ps} {569 ps}
