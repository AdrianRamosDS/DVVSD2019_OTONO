onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {TOP MODULE}
add wave -noupdate -expand -group Matriz_x_Vector_module /TB_Matriz_x_Vector/DUV/clk
add wave -noupdate -expand -group Matriz_x_Vector_module /TB_Matriz_x_Vector/DUV/rst
add wave -noupdate -expand -group Matriz_x_Vector_module /TB_Matriz_x_Vector/DUV/Rx_flag
add wave -noupdate -expand -group Matriz_x_Vector_module -color Gold -radix hexadecimal /TB_Matriz_x_Vector/DUV/FIFO_input
add wave -noupdate -expand -group Matriz_x_Vector_module /TB_Matriz_x_Vector/DUV/flag_Tx
add wave -noupdate -expand -group Matriz_x_Vector_module -color {Blue Violet} -radix unsigned /TB_Matriz_x_Vector/DUV/Data_Tx
add wave -noupdate /TB_Matriz_x_Vector/DUV/push_input
add wave -noupdate -divider {STATE MACHINES}
add wave -noupdate -group {N Register} /TB_Matriz_x_Vector/DUV/N_module/enb
add wave -noupdate -group {N Register} /TB_Matriz_x_Vector/DUV/N_module/Sync_rst
add wave -noupdate -group {N Register} -radix decimal /TB_Matriz_x_Vector/DUV/N_module/Data_Input
add wave -noupdate -group {N Register} -radix decimal /TB_Matriz_x_Vector/DUV/N_module/Data_Output
add wave -noupdate -group {N Register} -radix decimal /TB_Matriz_x_Vector/DUV/N_module/Data_logic
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/rst
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/start
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/enb_CMD2
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/flag_cont
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/contador_mux_flag
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/flag_finish_SEND
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/enb_sync_rst
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/enb_cont
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/enb_POP
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/enb_cont_mux
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/enb_con_0a12
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/enb_sync_rst_Tx
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/flag_SM_cmd_MxV
add wave -noupdate -group {Control Unit MxV} /TB_Matriz_x_Vector/DUV/MxV_Control_Unit/State
add wave -noupdate -group {Contador SM} /TB_Matriz_x_Vector/DUV/contador_SM/enb
add wave -noupdate -group {Contador SM} /TB_Matriz_x_Vector/DUV/contador_SM/sync_rst_enb
add wave -noupdate -group {Contador SM} -radix decimal /TB_Matriz_x_Vector/DUV/contador_SM/N_input
add wave -noupdate -group {Contador SM} /TB_Matriz_x_Vector/DUV/contador_SM/Flag
add wave -noupdate -group {Contador SM} -radix decimal /TB_Matriz_x_Vector/DUV/contador_SM/Counting
add wave -noupdate -group {Comando 1} -radix hexadecimal /TB_Matriz_x_Vector/DUV/CMD1_State_Machine/UART_Rx
add wave -noupdate -group {Comando 1} /TB_Matriz_x_Vector/DUV/CMD1_State_Machine/Flag_Rx
add wave -noupdate -group {Comando 1} /TB_Matriz_x_Vector/DUV/CMD1_State_Machine/flag_RESEND
add wave -noupdate -group {Comando 1} /TB_Matriz_x_Vector/DUV/CMD1_State_Machine/enable_CMD2
add wave -noupdate -group {Comando 1} /TB_Matriz_x_Vector/DUV/CMD1_State_Machine/enable_cont
add wave -noupdate -group {Comando 1} /TB_Matriz_x_Vector/DUV/CMD1_State_Machine/enable_reg_N
add wave -noupdate -group {Comando 1} /TB_Matriz_x_Vector/DUV/CMD1_State_Machine/State
add wave -noupdate -group {Comando 2} -radix hexadecimal /TB_Matriz_x_Vector/DUV/CMD2_State_Machine/UART_Rx
add wave -noupdate -group {Comando 2} /TB_Matriz_x_Vector/DUV/CMD2_State_Machine/Flag_Rx
add wave -noupdate -group {Comando 2} /TB_Matriz_x_Vector/DUV/CMD2_State_Machine/enable_cont
add wave -noupdate -group {Comando 2} /TB_Matriz_x_Vector/DUV/CMD2_State_Machine/State
add wave -noupdate -group {Comando 3} -radix hexadecimal /TB_Matriz_x_Vector/DUV/CMD3_State_Machine/UART_Rx
add wave -noupdate -group {Comando 3} /TB_Matriz_x_Vector/DUV/CMD3_State_Machine/Flag_Rx
add wave -noupdate -group {Comando 3} -radix decimal /TB_Matriz_x_Vector/DUV/CMD3_State_Machine/N_input
add wave -noupdate -group {Comando 3} /TB_Matriz_x_Vector/DUV/CMD3_State_Machine/enable_FIFO
add wave -noupdate -group {Comando 3} /TB_Matriz_x_Vector/DUV/CMD3_State_Machine/enable_cont_SM
add wave -noupdate -group {Comando 3} /TB_Matriz_x_Vector/DUV/CMD3_State_Machine/matrix_end_flag_wire
add wave -noupdate -group {Comando 3} /TB_Matriz_x_Vector/DUV/CMD3_State_Machine/enable_FIFO_flag_wire
add wave -noupdate -group {Comando 3} /TB_Matriz_x_Vector/DUV/CMD3_State_Machine/enable_cont_fila
add wave -noupdate -group {Comando 3} /TB_Matriz_x_Vector/DUV/CMD3_State_Machine/select_FIFO_wire
add wave -noupdate -group {Comando 3} /TB_Matriz_x_Vector/DUV/CMD3_State_Machine/State
add wave -noupdate -group {Comando 4} -radix hexadecimal /TB_Matriz_x_Vector/DUV/CMD4_State_Machine/UART_Rx
add wave -noupdate -group {Comando 4} /TB_Matriz_x_Vector/DUV/CMD4_State_Machine/Flag_Rx
add wave -noupdate -group {Comando 4} -radix decimal /TB_Matriz_x_Vector/DUV/CMD4_State_Machine/N_input
add wave -noupdate -group {Comando 4} /TB_Matriz_x_Vector/DUV/CMD4_State_Machine/enable_FIFO
add wave -noupdate -group {Comando 4} /TB_Matriz_x_Vector/DUV/CMD4_State_Machine/enable_MxV
add wave -noupdate -group {Comando 4} /TB_Matriz_x_Vector/DUV/CMD4_State_Machine/enable_cont_SM
add wave -noupdate -group {Comando 4} /TB_Matriz_x_Vector/DUV/CMD4_State_Machine/matrix_end_flag_wire
add wave -noupdate -group {Comando 4} /TB_Matriz_x_Vector/DUV/CMD4_State_Machine/enable_FIFO_flag_wire
add wave -noupdate -group {Comando 4} /TB_Matriz_x_Vector/DUV/CMD4_State_Machine/enable_cont_fila
add wave -noupdate -group {Comando 4} /TB_Matriz_x_Vector/DUV/CMD4_State_Machine/select_FIFO_wire
add wave -noupdate -group {Comando 4} /TB_Matriz_x_Vector/DUV/CMD4_State_Machine/State
add wave -noupdate -divider {RAM MEMORY}
add wave -noupdate -group {Mux 8a1 Registros} -radix decimal /TB_Matriz_x_Vector/DUV/Mux_8a1_module/A_input
add wave -noupdate -group {Mux 8a1 Registros} -radix decimal /TB_Matriz_x_Vector/DUV/Mux_8a1_module/B_input
add wave -noupdate -group {Mux 8a1 Registros} -radix decimal /TB_Matriz_x_Vector/DUV/Mux_8a1_module/C_input
add wave -noupdate -group {Mux 8a1 Registros} -radix decimal /TB_Matriz_x_Vector/DUV/Mux_8a1_module/D_input
add wave -noupdate -group {Mux 8a1 Registros} -radix decimal /TB_Matriz_x_Vector/DUV/Mux_8a1_module/E_input
add wave -noupdate -group {Mux 8a1 Registros} -radix decimal /TB_Matriz_x_Vector/DUV/Mux_8a1_module/F_input
add wave -noupdate -group {Mux 8a1 Registros} -radix decimal /TB_Matriz_x_Vector/DUV/Mux_8a1_module/G_input
add wave -noupdate -group {Mux 8a1 Registros} -radix decimal /TB_Matriz_x_Vector/DUV/Mux_8a1_module/H_input
add wave -noupdate -group {Mux 8a1 Registros} /TB_Matriz_x_Vector/DUV/Mux_8a1_module/Sel
add wave -noupdate -group {Mux 8a1 Registros} -radix decimal /TB_Matriz_x_Vector/DUV/Mux_8a1_module/A_output
add wave -noupdate -expand -group {RAM MEMORY} /TB_Matriz_x_Vector/DUV/FINAL_RAM_MEMORY/we
add wave -noupdate -expand -group {RAM MEMORY} -radix decimal /TB_Matriz_x_Vector/DUV/FINAL_RAM_MEMORY/data
add wave -noupdate -expand -group {RAM MEMORY} /TB_Matriz_x_Vector/DUV/FINAL_RAM_MEMORY/read_addr
add wave -noupdate -expand -group {RAM MEMORY} /TB_Matriz_x_Vector/DUV/FINAL_RAM_MEMORY/write_addr
add wave -noupdate -expand -group {RAM MEMORY} -radix decimal /TB_Matriz_x_Vector/DUV/FINAL_RAM_MEMORY/q
add wave -noupdate -divider FIFOs
add wave -noupdate -expand -group F0 /TB_Matriz_x_Vector/DUV/F0_FIFO/push
add wave -noupdate -expand -group F0 /TB_Matriz_x_Vector/DUV/F0_FIFO/pop
add wave -noupdate -expand -group F0 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F0_FIFO/DataInput
add wave -noupdate -expand -group F0 /TB_Matriz_x_Vector/DUV/F0_FIFO/full
add wave -noupdate -expand -group F0 /TB_Matriz_x_Vector/DUV/F0_FIFO/empty
add wave -noupdate -expand -group F0 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F0_FIFO/DataOutput
add wave -noupdate -group F4 /TB_Matriz_x_Vector/DUV/F4_FIFO/push
add wave -noupdate -group F4 /TB_Matriz_x_Vector/DUV/F4_FIFO/pop
add wave -noupdate -group F4 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F4_FIFO/DataInput
add wave -noupdate -group F4 /TB_Matriz_x_Vector/DUV/F4_FIFO/full
add wave -noupdate -group F4 /TB_Matriz_x_Vector/DUV/F4_FIFO/empty
add wave -noupdate -group F4 /TB_Matriz_x_Vector/DUV/F4_FIFO/DataOutput
add wave -noupdate -expand -group F1 /TB_Matriz_x_Vector/DUV/F1_FIFO/push
add wave -noupdate -expand -group F1 /TB_Matriz_x_Vector/DUV/F1_FIFO/pop
add wave -noupdate -expand -group F1 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F1_FIFO/DataInput
add wave -noupdate -expand -group F1 /TB_Matriz_x_Vector/DUV/F1_FIFO/full
add wave -noupdate -expand -group F1 /TB_Matriz_x_Vector/DUV/F1_FIFO/empty
add wave -noupdate -expand -group F1 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F1_FIFO/DataOutput
add wave -noupdate -group F5 /TB_Matriz_x_Vector/DUV/F5_FIFO/push
add wave -noupdate -group F5 /TB_Matriz_x_Vector/DUV/F5_FIFO/pop
add wave -noupdate -group F5 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F5_FIFO/DataInput
add wave -noupdate -group F5 /TB_Matriz_x_Vector/DUV/F5_FIFO/full
add wave -noupdate -group F5 /TB_Matriz_x_Vector/DUV/F5_FIFO/empty
add wave -noupdate -group F5 /TB_Matriz_x_Vector/DUV/F5_FIFO/DataOutput
add wave -noupdate -group F2 /TB_Matriz_x_Vector/DUV/F2_FIFO/push
add wave -noupdate -group F2 /TB_Matriz_x_Vector/DUV/F2_FIFO/pop
add wave -noupdate -group F2 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F2_FIFO/DataInput
add wave -noupdate -group F2 /TB_Matriz_x_Vector/DUV/F2_FIFO/full
add wave -noupdate -group F2 /TB_Matriz_x_Vector/DUV/F2_FIFO/empty
add wave -noupdate -group F2 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F2_FIFO/DataOutput
add wave -noupdate -group F6 /TB_Matriz_x_Vector/DUV/F6_FIFO/push
add wave -noupdate -group F6 /TB_Matriz_x_Vector/DUV/F6_FIFO/pop
add wave -noupdate -group F6 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F6_FIFO/DataInput
add wave -noupdate -group F6 /TB_Matriz_x_Vector/DUV/F6_FIFO/full
add wave -noupdate -group F6 /TB_Matriz_x_Vector/DUV/F6_FIFO/empty
add wave -noupdate -group F6 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F6_FIFO/DataOutput
add wave -noupdate -group F3 /TB_Matriz_x_Vector/DUV/F3_FIFO/push
add wave -noupdate -group F3 /TB_Matriz_x_Vector/DUV/F3_FIFO/pop
add wave -noupdate -group F3 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F3_FIFO/DataInput
add wave -noupdate -group F3 /TB_Matriz_x_Vector/DUV/F3_FIFO/full
add wave -noupdate -group F3 /TB_Matriz_x_Vector/DUV/F3_FIFO/empty
add wave -noupdate -group F3 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F3_FIFO/DataOutput
add wave -noupdate -group F7 /TB_Matriz_x_Vector/DUV/F7_FIFO/push
add wave -noupdate -group F7 /TB_Matriz_x_Vector/DUV/F7_FIFO/pop
add wave -noupdate -group F7 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F7_FIFO/DataInput
add wave -noupdate -group F7 /TB_Matriz_x_Vector/DUV/F7_FIFO/full
add wave -noupdate -group F7 /TB_Matriz_x_Vector/DUV/F7_FIFO/empty
add wave -noupdate -group F7 -radix hexadecimal /TB_Matriz_x_Vector/DUV/F7_FIFO/DataOutput
add wave -noupdate -divider PROCESADORES
add wave -noupdate -expand -group {Procesador 0} /TB_Matriz_x_Vector/DUV/P0/rst
add wave -noupdate -expand -group {Procesador 0} /TB_Matriz_x_Vector/DUV/P0/sync_rst
add wave -noupdate -expand -group {Procesador 0} -radix hexadecimal /TB_Matriz_x_Vector/DUV/P0/Data_matrix
add wave -noupdate -expand -group {Procesador 0} -radix hexadecimal /TB_Matriz_x_Vector/DUV/P0/Data_vector
add wave -noupdate -expand -group {Procesador 0} -radix decimal /TB_Matriz_x_Vector/DUV/P0/Data_output
add wave -noupdate -expand -group {Procesador 1} /TB_Matriz_x_Vector/DUV/P1/sync_rst
add wave -noupdate -expand -group {Procesador 1} -radix hexadecimal /TB_Matriz_x_Vector/DUV/P1/Data_matrix
add wave -noupdate -expand -group {Procesador 1} -radix hexadecimal /TB_Matriz_x_Vector/DUV/P1/Data_vector
add wave -noupdate -expand -group {Procesador 1} -radix hexadecimal /TB_Matriz_x_Vector/DUV/P1/Data_output
add wave -noupdate -expand -group {Procesador 2} /TB_Matriz_x_Vector/DUV/P2/sync_rst
add wave -noupdate -expand -group {Procesador 2} -radix hexadecimal /TB_Matriz_x_Vector/DUV/P2/Data_matrix
add wave -noupdate -expand -group {Procesador 2} -radix hexadecimal /TB_Matriz_x_Vector/DUV/P2/Data_vector
add wave -noupdate -expand -group {Procesador 2} -radix hexadecimal /TB_Matriz_x_Vector/DUV/P2/Data_output
add wave -noupdate -expand -group {Procesador 3} /TB_Matriz_x_Vector/DUV/P3/sync_rst
add wave -noupdate -expand -group {Procesador 3} -radix hexadecimal /TB_Matriz_x_Vector/DUV/P3/Data_matrix
add wave -noupdate -expand -group {Procesador 3} -radix hexadecimal /TB_Matriz_x_Vector/DUV/P3/Data_vector
add wave -noupdate -expand -group {Procesador 3} -radix hexadecimal /TB_Matriz_x_Vector/DUV/P3/Data_output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {479 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 199
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
WaveRestoreZoom {185 ps} {517 ps}
