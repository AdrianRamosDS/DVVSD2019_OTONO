module Matriz_x_Vector_Top_Module
import mxv_pkg::*;
(
	input clk_50MHz, rst,
	input Serial_Data_Rx,
	output Serial_Data_Tx,
	output [2:0] CMD_out
);
wire clk_w; 
wire Pll_clk_w;
wire enb_CMD2_w, enb_MxV_w, Rx_flag_w, sel_FIFOVector_w, sel_FIFO_w;
wire N_w, flag_Tx_w, flag_RESEND_w, flag_cmd_w;
wire [DW-1:0]	Received_Data_w,	Data_Tx_w;

/*clk_gen	clk_gen_inst 	//	PLL Para bajar la frecuencia de operación del módulo MxV
(
	.areset (!rst),	.inclk0 (clk_50MHz),
	.c0 (Pll_clk_w)
);*/
ClkDivider Baude_Rate_16bits	//Para que la UART trabaje a 115200 baudios
(
	.clk(clk_50MHz),	.rst(rst),
	.Flag_toggle(clk_w)
);	

Matriz_x_Vector MxV_module
(
		.clk(clk_w),	.rst(rst),	.Rx_flag(Rx_flag_w),	.FIFO_input(Received_Data_w),	
		.flag_Tx(flag_Tx_w),		.Data_Tx(Data_Tx_w),	.CMD_out(CMD_out)
);

UART UART_module
(
	.clk(clk_w),	.rst(rst),	.Serial_Data_Rx(Serial_Data_Rx),	.Transmit(flag_Tx_w),	.Data_In(Data_Tx_w),
	.Received_Data(Received_Data_w),		.Rx_Interrupt(Rx_flag_w),		.Serial_Output_Tx(Serial_Data_Tx) 
);
endmodule
