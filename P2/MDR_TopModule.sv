/****************************************************************************************************************************************
* Nombre del módulo: MDR_TopModule.sv
* Descripción:			Realiza multiplicación, división y raíz cuadrada de números de 16 bits cada uno
* Autor:					Adrián Ramos Pérez
* Fecha:					30/10/2019
******************************************************************************************************************************************/
module MDR_TopModule
import mdr_pkg::*;
(
	input clk, rst, Start, Load,
	//input [1:0]Op,
	input [DW-1:0] Data,
	
	output error, Load_X, Load_Y, Ready,
	output [DW-1:0] Reminder,
	output [6:0] Unidades_7seg, Decenas_7seg, Centenas_7seg, UniMillar_7seg, DecMillar_7seg
);
wire oneShot_rst, oneShot_Start, oneShot_Load;
wire [3:0] Unidades_w, Decenas_w, Centenas_w, UniMillar_w, DecMillar_w;
wire [DW-1:0] Result;

OneShot OneShot_Start_module
(
	.clk(clk),	.rst(rst),	.enb(1'b1),	.sync_rst(0),	.Data_Input({DW{Start}}),
	.Oneshot(oneShot_Start)
);
OneShot OneShot_Load_module
(
	.clk(clk),	.rst(rst),	.enb(1'b1),	.sync_rst(0),	.Data_Input({DW{Load}}),
	.Oneshot(oneShot_Load)
);

MDR MDR
(
	.clk(clk),	.rst(rst),	.Start(oneShot_Start),	.Op(Data[1:0]),	.Load(oneShot_Load),	.Data(Data),
	.error(error),
	.Load_X(Load_X),
	.Load_Y(Load_Y),
	.Ready(Ready),
	.Result(Result),
	.Reminder(Reminder)
);

BCDa7segmentos BCDa7segmentos
(
	.A_input(Result),
	
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
