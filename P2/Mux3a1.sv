module Mux3a1
import mdr_pkg::*;
(
	input [1:0]		  Sel,
	input [DW_DBL:0] A_Input,
	input [DW_DBL:0] B_Input,
	input [DW_DBL:0] C_Input,
	output [DW_DBL:0] Output_Data
);

wire [DW_DBL:0] Mux1_w;

Mux2a1 Mux1
(
	.Selector(Sel[1]),  .Data_0(A_Input),	.Data_1(B_Input),
	.Mux_Output(Mux1_w)
);

Mux2a1 Mux_2
(
	.Selector(Sel[0]), .Data_0(Mux1_w),	.Data_1(C_Input),
	.Mux_Output(Output_Data)
);

endmodule
