/****************************************************************************************************************************************
* Nombre del módulo: MDR_TopModule.sv
* Descripción:			Realiza multiplicación, división y raíz cuadrada de números de 16 bits cada uno
* Autor:					Adrián Ramos Pérez
* Fecha:					29/08/2019
******************************************************************************************************************************************/
module MDR_TopModule
import mdr_pkg::*;
(
	input clk,
	input rst,
	input Start,
	input [1:0]Op,
	input Load,
	input [DW-1:0] Data,
	
	output error,
	output Load_X,
	output Load_Y,
	output Ready,
	output [DW-1:0] Result,
	output [DW-1:0] Reminder,
	
	output [6:0] Unidades_7seg, 
	output [6:0] Decenas_7seg, 
	output [6:0] Centenas_7seg, 
	output [6:0] UniMillar_7seg, 
	output [6:0] DecMillar_7seg
	
);

wire [3:0] Unidades_w, Decenas_w, Centenas_w, UniMillar_w, DecMillar_w;

MDR MDR
(
	.clk(clk),	.rst(rst),	.Start(Start),	.Op(Op),	.Load(Load),	.Data(Data),
	.error(error),
	.Load_X(Load_X),
	.Load_Y(Load_Y),
	.Ready(Ready),
	.Result(Result),
	.Reminder(Reminder)
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
