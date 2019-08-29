/****************************************************************************************************************************************
* Nombre del módulo: SequentialMultiplier_TopModule.sv
* Descripción:			Realiza multiplicación secuencial de dos números de N bits cada uno a complemento A2 y expresa el resultado a 2N bits en A2 también
* Entradas:				clk, reset, start, Multiplicando, Multiplicador
* Salidas:				Ready,Signo, Producto de la multiplicación a 16 bits y salidas para display de 7 segmentos
* Autor:					Adrián Ramos Pérez
* Fecha:					29/08/2019
******************************************************************************************************************************************/
module SequentialMultiplier_TopModule 
import seq_mult_pkg::*;
(
	input clk,
	input rst,
	input start,
	input [DW-1:0] Multiplier_INPUT,
	input [DW-1:0] Multiplicand_INPUT,
	
	output Ready,
	output [6:0] Unidades_7seg, 
	output [6:0] Decenas_7seg, 
	output [6:0] Centenas_7seg, 
	output [6:0] UniMillar_7seg, 
	output [6:0] DecMillar_7seg
);

wire Pll_clk_w/*synthesis keep*/;
wire start_one_shot_w/*synthesis keep*/;
wire [3:0] Unidades_w, Decenas_w, Centenas_w, UniMillar_w, DecMillar_w;
wire [2*DW-1:0] Producto_w;

clk_gen	clk_gen_inst 
(
	.areset (!rst),
	.inclk0 (clk),
	.c0 (Pll_clk_w)
);

OneShot START_SHOT
(
	.clk(Pll_clk_w),	.rst(rst),	.signal(start),
	.oneShot(start_one_shot_w)
);

SequentialMultiplier SequentialMultiplier
(
	.clk(Pll_clk_w),	.rst(rst),	.start(start_one_shot_w),	.Multiplier_INPUT(Multiplier_INPUT),	.Multiplicand_INPUT(Multiplicand_INPUT),
	.Ready(Ready),	.Producto(Producto_w)
);


BCDa7segmentos BCDa7segmentos
(
	.A_input(Producto_w),
	
	.Unidades(Unidades_w),
	.Decenas(Decenas_w),
	.Centenas(Centenas_w),
	.UniMillar(UniMillar_w),
	.DecMillar(DecMillar_w)
);

Conv_BCD_7seg CONV7SEGMENTOS_UNIDADES
(
	.BCD_in(Unidades_w),
	.segmentos(Unidades_7seg)
);

Conv_BCD_7seg CONV7SEGMENTOS_DECENAS
(
	.BCD_in(Decenas_w),
	.segmentos(Decenas_7seg)
);

Conv_BCD_7seg CONV7SEGMENTOS_CENTENAS
(
	.BCD_in(Centenas_w),
	.segmentos(Centenas_7seg)
);

Conv_BCD_7seg CONV7SEGMENTOS_UNIMILLAR
(
	.BCD_in(UniMillar_w),
	.segmentos(UniMillar_7seg)
);

Conv_BCD_7seg CONV7SEGMENTOS_DECMILLAR
(
	.BCD_in(DecMillar_w),
	.segmentos(DecMillar_7seg)
);


endmodule

