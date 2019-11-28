module Matriz_x_Vector_Top_Module
import mxv_pkg::*;
(
	input clk, rst, start,
	input Serial_Data_Rx,
	output Serial_Data_Tx,
	output [2:0] Comando
);

wire enb_CMD2_w, enb_MxV_w, Rx_flag_w, sel_FIFOVector_w, sel_FIFO_w;
wire Received_Data_w, N_w, flag_Tx_w, flag_RESEND_w, flag_cmd_w;
wire [DW-1:0] Data_Tx_w; 

Matriz_x_Vector MxV_module
(
		.clk(clk),	.rst(rst),	.start(enb_MxV_w & Rx_flag_w),	.enb_CMD2(enb_CMD2_w),
		.push_input({sel_FIFOVector_w,sel_FIFO_w}&{9{Rx_flag_w}}), 		.FIFO_input(Received_Data_w),		.N_input(N_w),
		
		.flag_Tx(flag_Tx_w),		.flag_RESEND(flag_RESEND_w),		.flag_cmd(flag_cmd_w), .Data_Tx(Data_Tx_w)
);

endmodule
