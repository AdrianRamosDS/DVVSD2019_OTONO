module UART #(	parameter BAUD_RATE = 115200)
(
	input clk,	rst,	Serial_Data_Rx,	Transmit,
	input [7:0]Data_In,
	
	output [7:0]Received_Data,
	output Rx_Interrupt, // data_receive Indica cuando el modulo ha recibido un dato 
	output Serial_Output_Tx // TX envia bit por bit el dato a transmitir
);

wire Rx_Interrupt_w;
wire [7:0] Received_Data_w;
wire Rx_load_w,	Rx_shift_w,	TX_load_wire,	TX_shift_wire;
wire [10:0] TxReg_Pout_wire;
wire [7:0] shift_2_final_wire;
wire reset_reg_wire;

assign Serial_Output_Tx = TxReg_Pout_wire[0];



UART_Tx Tx_Control_Unit
(
	.clk(clk),	.reset(rst),	.sendData(Transmit),
	.sendReady(),	.SR_TX_load(TX_load_wire),	.SR_TX_shift(TX_shift_wire)
);
UART_ShiftRegister_Tx #(.WORD_LENGTH(11)) Shift_Tx
(
	.clk(clk),	.reset(rst),	.SyncReset(1'b0),	
	.load(TX_load_wire),	//Activo en alto
	.shift(TX_shift_wire),	//Shift activo en alto
	.Parallel_in({1'b1,^Data_In,Data_In,1'b0}),
	.Serial_in(1'b1),
	.Right(1'b1), //corrimiento hacia la derecha (1).
	.Parallel_Out(TxReg_Pout_wire)
);
///////////////////////////////////////////////
////		RX			///////////////////////////
///////////////////////////////////////////
UART_Rx Rx_Control_Unit
(
	.clk(clk), .reset(rst),	.Rx_flag(Serial_Data_Rx), //Bit de start en fram de Rx_flag (0)
	.data_Rx_flag(Rx_load_w), 	.reset_count(reset_reg_wire),	.shift_Rx_flag(Rx_shift_w) 
);	 
UART_ShiftRegister_Rx #(.WORD_LENGTH(8))
Shift_Rx
(
	.clk(clk),	.reset(rst),	.SyncReset(1'b0),		.load(),		.shift(Rx_shift_w),	.Parallel_in(),	.Serial_in(Serial_Data_Rx),	.Right(1'b1), 
	.Parallel_Out(shift_2_final_wire)
);
UART_PIPO #(.WORD_LENGTH(9)) REG_FINAL
(
	.clk(clk),	.reset(rst),	.enable(Rx_load_w),	.Sync_Reset(1'b0),	.Data_Input(shift_2_final_wire),
	.Data_Output(Received_Data_w)
);
	 
UART_PIPO #(.WORD_LENGTH(1))
registro_RX_flag
(
	.clk(clk),	.reset(rst),	.enable(reset_reg_wire|Rx_load_w),	.Sync_Reset(reset_reg_wire),
	.Data_Input(Rx_load_w),
	.Data_Output(Rx_Interrupt_w)
);	 
	 
assign Received_Data = Received_Data_w;
assign Rx_Interrupt = Rx_Interrupt_w;

endmodule
