/****************************************************************************************************************************************
* Nombre del módulo: MDR.sv
* Descripción:			Realiza multiplicación, división y raíz cuadrada de números de 16 bits cada uno
* Autor:					Adrián Ramos Pérez
* Fecha:					27/03/2019
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

// Retro signals from Datapath to Controlpath 
wire op_ready_signal_w, mult_op_ready_w, div_op_ready_w, sqrt_op_ready_w;

// Data signals
wire Op_sel_w;
wire  sqrt_op_sel_w, adder_op_sel_w;
wire [DW-1:0] 		sqrt_operando1_w, sqrt_operando2_w, div_operando1_w, div_operando2_w;
wire [DW-1:0] 		Div_Result_w, Sqrt_Result_w;
wire [DW-1:0] Data_X_w, Data_Y_w;
wire [DW_DBL:0] Mult_operando1_w, Mult_operando2_w, Mult_Result_w, adder_input_1_w, adder_input_2_w;
wire [DW_DBL:0] adder_out_w, adder_out_2mult_w, adder_out_2div_w, adder_out_2sqrt_w;

/* ******** DATA PATH ******************** */

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

OneShot OneShot_module
(
	.clk(clk),	.rst(rst),	.enb(1'b1),	.sync_rst(0),	.Data_Input({DW{Load}}),
	.Oneshot(oneshot2SM_load)
);

////////////////////////////////////////////////////////////////////////////////////////////
/************* MÓDULOS ARITMÉTICOS ********************************************************/

Multiplicator_module MULTIPLIER
(
	.clk(clk),	.rst(rst),	.start(),	.Multiplicando(),	.Multiplicador(),		.adder_out(adder_out_2mult_w),
	.Result(Mult_Result_w),	.Ready(mult_op_ready_w),	.demux_out_1(),	.SorA2sum()
);
DIVIDER_module DIVIDER
(
	.clk(clk),	.rst(rst),	.start(),	.Dividendo(),	.Divisor(),		.adder_out(adder_out_2div_w),
	.Result(Div_Result_w),	.Reminder(),	.Ready(div_op_ready_w),	.mux2resta(div_operando1_w),	.mux2resta2(div_operando2_w)
);
SQRT_module SQUARE_ROOT
(
	.clk(clk),	.rst(rst),	.start(),	.Data(),		.sumador_out(adder_out_2sqrt_w),
	.Result(Sqrt_Result_w),	.Reminder(),	.Ready(sqrt_op_ready_w),	.mux2sum1(sqrt_operando1_w),	.mux2sum2(sqrt_operando2_w), .op_sel(sqrt_op_sel_w)
);
////////////////////////////////////////////////////////////////////////////////////////////

/****** SUMADOR ÚNICO **********************+***************************/
Mux3a1 Adder_Input_1
(	
	.Sel(Op_sel_w),	.A_Input(Mult_operando1_w),	.B_Input({{DW+1{1'b0}},div_operando1_w}),	.C_Input({{DW+1{1'b0}},sqrt_operando1_w}),
	.Output_Data(adder_input_1_w)
);
Mux3a1 Adder_Input_2
(	
	.Sel(Op_sel_w),	.A_Input(Mult_operando2_w),	.B_Input({{DW+1{1'b0}},div_operando2_w}),	.C_Input({{DW+1{1'b0}},sqrt_operando2_w}),
	.Output_Data(adder_input_2_w)
);
Mux3a1 Adder_Suma_o_Resta
(							// Suma				Resta				Suma o resta
	.Sel(Op_sel_w),	.A_Input(1),	.B_Input(0),	.C_Input(sqrt_op_sel_w),
	.Output_Data(adder_op_sel_w)
);
Adder General_Adder
(
	.A_input(adder_input_1_w),	.B_input(adder_input_2_w),	.Op_sel(adder_op_sel_w),
	.C_output(adder_out_w)
);
Demux1a3 Adder_Demux
(	
	.A_input(adder_out_w),		.Sel(),		
	.A_output(adder_out_2mult_w),	.B_output(adder_out_2div_w),	.C_output(adder_out_2sqrt_w)
);
/* ********** CONTROL PATH ****************************************************/


Mux3a1 Mux_for_op_ready_signal
(
	.Sel(Op_sel_w),	.A_Input(mult_op_ready_w),	.B_Input(div_op_ready_w),	.C_Input(sqrt_op_ready_w),
	.Output_Data(op_ready_signal_w)
);

MDR_Control_Unit Control_Unit
(
	.clk(clk),	.rst(rst),	.start(Start),	.load(~oneshot2SM_load),	.ready(op_ready_signal_w),	.error(error2SM_wire),
	.enable_sync_rst(sync_rst_enb_w),
	.enable_operacion(SM_enable_operacion_wire),
	.enable_ready(ready_w),
	.enable_error(error_wire),
	.load_x(load_X_w),
	.load_Y(load_Y_w),
	.load_op(load_Op_w)
);


//Aquí se dividen las entradas: todas las de control (Op y Load) se van al control path y Data se va al data path.

/*
DataPathModule DATA_PATH_MODULE
(
	.clk(clk),	.rst(rst),	.start(start),	 .Data(Data),
	.ready_ctrl_sgnl(ready_w),
	.load_ctrl_sgnl(load_w),
	.shift_ctrl_sgnl(shift_w),
	.clear_ctrl_sgnl(clear_w),
	
	.error(error),
	.Load_X(Load_X),
	.Load_Y(Load_Y),
	.Ready(Ready),
	.Result(Result),
	.Reminder(Reminder)
);

/* 
ControlPathModule CONTROL_PATH_MODULE
(	
	.clk(clk),	.rst(rst),	.start(start),	 .Op(Op),  .Load(Load),	
	
	.ready_ctrl_sgnl(ready_w),
	.load_ctrl_sgnl(load_w),
	.shift_ctrl_sgnl(shift_w),
	.clear_ctrl_sgnl(clear_w)
); */

endmodule
