module Multiplicator_module
import mdr_pkg::*;
(
	input 			  clk,
	input				  rst,
	input				  start,
	input	[DW_DBL:0] adder_out,
	input [DW-1:0]   Multiplicando,
	input [DW-1:0]   Multiplicador,
	output					 Ready,
	output	[DW_DBL-1:0] Result,
	output	[DW_DBL:0]	 demux_out_1,
	output	[DW_DBL:0]	 SorA2sum
);

logic [DW_DBL:0] A,S,P;
wire enb_w, count_enb_w, sync_rst_enb_w, shift_enb_w, xor_out_w, count_flag_w, MULcont2mux_wire, ready_enb_w; /* Señales de control de la máquina de estados */
wire [DW_DBL:0] A_out_w, S_out_w, P_out_w, MuxP_out_w, demux_out_0_w, demux_out_1_w, SorA2sum_w, adder_out_w, final_mux_out_w, shifted_data_w, final_rgstr_out_w;

assign A = {Multiplicando, 17'b00000000000000000};
assign S = {~(Multiplicando)+1'b1, 17'b00000000000000000};
assign P = {16'b0000000000000000, Multiplicador, 1'b0};

MULT_Control_Unit MULT_CONTROL_UNIT
(
	.clk(clk),	.rst(rst),	.flag_cont(count_flag_w),
	.start(start), // iniciar en idle desde maquina general
	
	.enable_cont(count_enb_w),
	.enable_sync_rst(sync_rst_enb_w),
	.enable_reg(enb_w),
	.enable_ready(ready_enb_w),
	.enable_shift(shift_enb_w)
);

PIPO A_REG	// 1st CHECK (inputs/outputs)
(
	.clk(clk),	.rst(rst),	.enb(enb_w),	.sync_rst(sync_rst_enb_w),		.data(A),
	.out(A_out_w)	
);

PIPO S_REG	// 1st CHECK (inputs/outputs)
(
	.clk(clk),	.rst(rst),	.enb(enb_w),	.sync_rst(sync_rst_enb_w),		.data(S),
	.out(S_out_w)
);

Mux2a1 P_INPUT
(
	.Selector(MULcont2mux_wire),	.Data_0(final_rgstr_out_w),	.Data_1(P_out_w),
	.Mux_Output(MuxP_out_w)
);

PIPO P_REG	// 1st CHECK (inputs/outputs)
(
	.clk(clk),	.rst(rst),	.enb(enb_w),	.sync_rst(sync_rst_enb_w),		.data(P),
	.out(P_out_w)
);

Xor_module Xor( //first check ddone
	.Data_0(MuxP_out_w[0]),	.Data_1(MuxP_out_w[1]),
	.Data_output(xor_out_w)
);

Mux2a1 S_OR_A_MUX
(
	.Selector(MuxP_out_w[0]),	.Data_0(S_out_w),	.Data_1(A_out_w),
	.Mux_Output(SorA2sum_w)
);


Demux1a2 Demux1a2
(
	.Selector(xor_out_w),	.Data_input(MuxP_out_w),
	.Data_out_0(demux_out_0_w),		.Data_out_1(demux_out_1_w)
);

/******** Bloque de salida ******/
Mux2a1 Final_MUX // 1st CHECK (inputs/outputs)
(
	.Selector(xor_out_w),	.Data_0(demux_out_0_w),	.Data_1(adder_out),
	.Mux_Output(final_mux_out_w)
);

Shift_module SHIFT_module // 1st CHECK (inputs/outputs)
(
	.A_input(final_mux_out_w),
	.B_output(shifted_data_w)
);

PIPO Final_Register 		// 1st CHECK (inputs/outputs)
(
	.clk(clk),	.rst(rst),	.enb(shift_enb_w),	.sync_rst(sync_rst_enb_w),		.data(shifted_data_w),
	.out(final_rgstr_out_w)
);
/* *********************************/

MULT_Counter Contador_modulo
(
	.clk(clk),	.reset(rst),	.enable(count_enb_w),	.SyncReset(sync_rst_enb_w),
	.flag_mux(MULcont2mux_wire),	.flag_SM(count_flag_w) //Salida hacia la entrada de sm
);

/*Adder General_Adder
(
	.A_input(demux_out_1_w),	.B_input(SorA2sum_w),	.Op_sel(1'b1),
	.C_output(adder_out_w)
);*/

assign Result = final_rgstr_out_w[17:1];
assign demux_out_1 = demux_out_1_w;
assign SorA2sum = SorA2sum_w;

endmodule 