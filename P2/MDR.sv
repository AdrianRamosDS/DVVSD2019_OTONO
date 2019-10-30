/****************************************************************************************************************************************
* Nombre del módulo: MDR.sv
* Descripción:			Realiza multiplicación, división y raíz cuadrada de números de 16 bits cada uno
* Autor:					Adrián Ramos Pérez
* Fecha:					30/10/2019
******************************************************************************************************************************************/
module MDR
import mdr_pkg::*;
(
	input clk, rst, Start, Load,
	input [1:0]Op,
	input [DW-1:0] Data,
	output error, Load_X, Load_Y, Ready,
	output [DW-1:0] Result,
	output [DW-1:0] Reminder
);
// Control signals
wire ready_w, shift_w, clear_w, load_X_w, load_Y_w, load_Op_w, sync_rst_enb_w, oneshot2SM_load;
wire mult_enb_w, div_enb_w, root_enb_w, op_enb_w;
// Retro signals from Datapath to Controlpath 
wire op_ready_signal_w, mult_op_ready_w, div_op_ready_w, sqrt_op_ready_w;
// Data signals
wire [DW-1:0] Op_sel_w;
wire  sqrt_op_sel_w, adder_op_sel_w;
wire [DW-1:0] 	 sqrt_operando1_w, sqrt_operando2_w, div_operando1_w, div_operando2_w;
wire [DW-1:0] 	 Div_Result_w, Sqrt_Result_w, Final_Result_w, Final_Reminder_w, Div_Reminder_w, Sqrt_Reminder_w;
wire [DW-1:0] 	 Data_X_w, Data_Y_w, Data_X_a2_w, Data_Y_a2_w;
wire [DW_DBL-1:0]Mult_Result_w;
wire [DW_DBL:0] Mult_operando1_w, Mult_operando2_w, adder_input_1_w, adder_input_2_w;
wire [DW_DBL:0] adder_out_w, adder_out_2mult_w, adder_out_2div_w, adder_out_2sqrt_w;

/* ******** DATA PATH ******************** */
A2_double_in A2_decoder
(
	.Data_0_a2(Data_X_w),	.Data_1_a2(Data_Y_w),
	.Data_0(Data_X_a2_w),	.Data_1(Data_Y_a2_w)
);

PIPO_16 Data_X_Register
(
	.clk(clk),	.rst(rst),	.enb(load_X_w),	.sync_rst(sync_rst_enb_w),	.data(Data),
	.out(Data_X_w)
);
PIPO_16 Data_Y_Register
(
	.clk(clk),	.rst(rst),	.enb(load_Y_w),	.sync_rst(sync_rst_enb_w),	.data(Data),
	.out(Data_Y_w)
);
PIPO_16 Op_Sel_Register
(
	.clk(clk),	.rst(rst),	.enb(load_Op_w),	.sync_rst(sync_rst_enb_w),	.data({{DW-2{1'b0}},Op}),
	.out(Op_sel_w)
);


/////////////      MÓDULOS ARITMÉTICOS    ///////////////////////////////////////////////////////
Multiplicator_module MULTIPLIER
(
	.clk(clk),	.rst(rst),	.start(mult_enb_w),	.Multiplicando(Data_X_a2_w),	.Multiplicador(Data_Y_a2_w),		.adder_out(adder_out_2mult_w),
	.Result(Mult_Result_w),	.Ready(mult_op_ready_w),	.demux_out_1(Mult_operando1_w),	.SorA2sum(Mult_operando2_w)
);
DIVIDER_module DIVIDER
(
	.clk(clk),	.rst(rst),	.start(div_enb_w),	.Dividendo(Data_X_a2_w),	.Divisor(Data_Y_a2_w),		.adder_out(adder_out_2div_w[15:0]),
	.Result(Div_Result_w),	.Reminder(Div_Reminder_w),	.Ready(div_op_ready_w),	.mux2resta(div_operando1_w),	.mux2resta2(div_operando2_w)
);
SQRT_module SQUARE_ROOT
(
	.clk(clk),	.rst(rst),	.start(root_enb_w),	.Data(Data_X_a2_w),		.sumador_out(adder_out_2sqrt_w[15:0]),
	.Result(Sqrt_Result_w),	.Reminder(Sqrt_Reminder_w),	.Ready(sqrt_op_ready_w),	.mux2sum1(sqrt_operando1_w),	.mux2sum2(sqrt_operando2_w), .op_sel(sqrt_op_sel_w)
);
////////////////////////////////////////////////////////////////////////////////////////////

/* ***** SUMADOR ÚNICO **********************+************************** */
Mux3a1 Adder_Input_1
(	
	.Sel(Op_sel_w[1:0]),	.A_Input(Mult_operando1_w),	.B_Input({{DW+1{1'b0}},div_operando1_w}),	.C_Input({{DW+1{1'b0}},sqrt_operando1_w}),
	.Output_Data(adder_input_1_w)
);
Mux3a1 Adder_Input_2
(	
	.Sel(Op_sel_w[1:0]),	.A_Input(Mult_operando2_w),	.B_Input({{DW+1{1'b0}},div_operando2_w}),	.C_Input({{DW+1{1'b0}},sqrt_operando2_w}),
	.Output_Data(adder_input_2_w)
);
Mux3a1 Adder_Suma_o_Resta
(							// Suma				Resta				Suma o resta
	.Sel(Op_sel_w[1:0]),	.A_Input(1),	.B_Input(0),	.C_Input(sqrt_op_sel_w),
	.Output_Data(adder_op_sel_w)
);
Adder General_Adder
(
	.A_input(adder_input_1_w),	.B_input(adder_input_2_w),	.Op_sel(adder_op_sel_w),
	.C_output(adder_out_w)
);
Demux1a3 Adder_Demux
(	
	.A_input(adder_out_w),		.Sel(Op_sel_w[1:0]),		
	.A_output(adder_out_2mult_w),	.B_output(adder_out_2div_w),	.C_output(adder_out_2sqrt_w)
);
/////////////////////////////////////////////////////////////////////////
PIPO_16 Ready_Register // Registro de Salida para Ready general
(
	.clk(clk),	.rst(rst),	.enb(ready_w),	.sync_rst(sync_rst_enb_w),	.data({{DW-1{1'b0}},ready_w}),
	.out(Ready)
);
Mux3a1 Result_Mux
(	
	.Sel(Op_sel_w[1:0]),	.A_Input({{1'b0},Mult_Result_w}),	.B_Input({{DW+1{1'b0}},Div_Result_w}),	.C_Input({{DW+1{1'b0}},Sqrt_Result_w}),
	.Output_Data(Final_Result_w)
);
PIPO_16 Result_Register // Registro de Salida para Result general
(
	.clk(clk),	.rst(rst),	.enb(ready_w),	.sync_rst(sync_rst_enb_w),	.data(Final_Result_w),
	.out(Result)
);
Mux3a1 Reminder_Mux
(	
	.Sel(Op_sel_w[1:0]),	.A_Input(0),	.B_Input(Div_Reminder_w),	.C_Input(Sqrt_Reminder_w),
	.Output_Data(Final_Reminder_w)
);
PIPO_16 Reminder_Register // Registro de Salida para Reminder general
(
	.clk(clk),	.rst(rst),	.enb(ready_w),	.sync_rst(sync_rst_enb_w),	.data(Final_Reminder_w),
	.out(Reminder)
);
/////////////////////////////////////////////////////////////////////////////
/* ********** CONTROL PATH ****************************************************/
Mux3a1 Mux_for_op_ready_signal
(
	.Sel(Op_sel_w),	.A_Input(mult_op_ready_w),	.B_Input(div_op_ready_w),	.C_Input(sqrt_op_ready_w),
	.Output_Data(op_ready_signal_w)
);

MDR_Control_Unit Control_Unit
(
	.clk(clk),	.rst(rst),	.start(Start),	.load(Load),	.ready(op_ready_signal_w),	.error(error2SM_wire),
	.enable_sync_rst(sync_rst_enb_w),
	.enable_operacion(op_enb_w),
	.enable_ready(ready_w),
	.enable_error(error_wire),
	.load_x(load_X_w),
	.load_Y(load_Y_w),
	.load_op(load_Op_w)
);
Demux1a3 Module_enable_Demux
(	
	.A_input(op_enb_w),		.Sel(Op_sel_w[1:0]),		
	.A_output(mult_enb_w),	.B_output(div_enb_w),	.C_output(root_enb_w)
);

assign Load_X = load_X_w;
assign Load_Y = load_Y_w;

endmodule
