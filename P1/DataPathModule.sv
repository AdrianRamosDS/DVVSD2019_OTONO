module DataPathModule
import seq_mult_pkg::*;
(
	input clk,
	input rst,
	input start,
	input [DW-1:0] Multiplier_INPUT,
	input [DW-1:0] Multiplicand_INPUT,
	input ready_ctrl_sgnl,
	input load_ctrl_sgnl,
	input shift_ctrl_sgnl,
	input clear_ctrl_sgnl,
	
	output Ready,
	output [2*DW-1:0] Producto
);

wire Mux_Selector_w, Output_Sign_w;
wire [DW-1:0] Multiplicando, Multiplicador, Multiplicando_A2, Multiplicador_A2;
wire [2*DW-1:0] Multiplicando_Shifted_w, Mux2Adder_w, Acumulacion_A2_w, Resultado;
wire [2*DW-1:0] Suma2Reg_w/*synthesis keep*/;
wire [2*DW-1:0] Acumulacion_w/*synthesis keep*/;

/************* REGISTRAR ENTRADAS *******************************/
PIPO #(.DW(DW)) FF_Multiplier
(
	.clk(clk),	.rst(rst),	.enb(1'b1),	.data(Multiplier_INPUT), 
	.out(Multiplicador)
);

PIPO #(.DW(DW)) FF_Multiplicand
(
	.clk(clk),	.rst(rst),	.enb(1'b1),	.data(Multiplicand_INPUT), 
	.out(Multiplicando)
);

/************ DECODIFICADO COMPLEMENTO A2 ************************/
A2 Multiplicando_A2Decoder
(
	.A2_number(Multiplicando),
	.decoded_data(Multiplicando_A2)
);

A2 Multiplicador_A2Decoder
(
	.A2_number(Multiplicador),
	.decoded_data(Multiplicador_A2)
);

/*************************************** */

PISO_LSB MULTIPLIER(
	.clk(clk),	.rst(rst),	.load(load_ctrl_sgnl),	.shift(shift_ctrl_sgnl),	.parallelInput(Multiplicador_A2),
	.serialOutput(Mux_Selector_w)					/* Sale el bit menos significativo únicamente */
);

PIPO_Shift2Left MULTIPLICAND(
	.clk(clk),	.rst(rst),	.load(load_ctrl_sgnl),	.shift(shift_ctrl_sgnl),	.parallelInput(Multiplicando_A2),
	.parallelOutput(Multiplicando_Shifted_w)
);

Mux2a1 Mux
(
	.Selector(Mux_Selector_w),	.Data_0(16'd0),	.Data_1(Multiplicando_Shifted_w),
	.Mux_Output(Mux2Adder_w)
);

Register_With_Sync_Reset ACUMULADOR
(
	.clk(clk),	.rst(rst),	.enable(1'b1),	.Sync_Reset(clear_ctrl_sgnl),	.Data_Input(Suma2Reg_w),
	.Data_Output(Acumulacion_w)
);

Sumador Sumador
(
	.Input_1(Mux2Adder_w),	.Input_2(Acumulacion_w),
	.Suma(Suma2Reg_w)
);


Signo_module SIGNO_MODULE
(
	.signo_1(Multiplicand_INPUT[DW-1]),	.signo_2(Multiplier_INPUT[DW-1]),
	.signo(Output_Sign_w)
);

to_A2 #(.DW(2*DW))A2_CODER
(
	.data(Acumulacion_w),
	.A2_data(Acumulacion_A2_w)
);

Mux2a1 Mux_Salida
(
	.Selector(Output_Sign_w),	.Data_0(Acumulacion_w),	.Data_1(Acumulacion_A2_w),
	.Mux_Output(Resultado)
);

PIPO #(.DW(2*DW)) SALIDA
(
	.clk(clk),	.rst(rst),	.enb(ready_ctrl_sgnl),	.data(Resultado), 
	.out(Producto)
);

PIPO #(.DW(1)) SALIDA_READY
(
	.clk(clk),	.rst(rst),	.enb(ready_ctrl_sgnl),	.data(ready_ctrl_sgnl), 
	.out(Ready)
);


endmodule
