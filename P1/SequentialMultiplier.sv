/****************************************************************************************************************************************
* Nombre del módulo: SequentialMultiplier.sv
* Descripción:			Realiza multiplicación secuencial de dos números de N bits cada uno a complemento A2 y expresa el resultado a 2N bits en A2 también
* Entradas:				clk, reset, start, Multiplicando, Multiplicador
* Salidas:				Ready y Producto de la multiplicación a 16 bits
* Autor:					Adrián Ramos Pérez
* Fecha:					06/03/2019
******************************************************************************************************************************************/
module SequentialMultiplier
import seq_mult_pkg::*;
(
	input clk,
	input rst,
	input start,
	input [DW-1:0] Multiplier_INPUT,
	input [DW-1:0] Multiplicand_INPUT,
	
	output Ready,
	output [2*DW-1:0] Producto
);


wire ready_w, load_w, shift_w, clear_w;

/********** DATA PATH *********************/
DataPathModule DATA_PATH_MODULE
(
	.clk(clk),	.rst(rst),	.start(start), 	.Multiplier_INPUT(Multiplier_INPUT),	.Multiplicand_INPUT(Multiplicand_INPUT),
	.ready_ctrl_sgnl(ready_w),
	.load_ctrl_sgnl(load_w),
	.shift_ctrl_sgnl(shift_w),
	.clear_ctrl_sgnl(clear_w),
	
	.Ready(Ready),
	.Producto(Producto)
);

/********** CONTROL PATH *********************/
ControlPathModule CONTROL_PATH_MODULE
(	
	.clk(clk),	.rst(rst),	.start(start),
	
	.ready_ctrl_sgnl(ready_w),
	.load_ctrl_sgnl(load_w),
	.shift_ctrl_sgnl(shift_w),
	.clear_ctrl_sgnl(clear_w)
);

endmodule
