module Demux1a3
import mdr_pkg::*;
(
	input [DW_DBL:0] A_input,
	input [1:0]      Sel,

	output [DW_DBL:0]A_output,
	output [DW_DBL:0]B_output,
	output [DW_DBL:0]C_output,
	output [DW_DBL:0]D_output
);

assign  A_output = A_input & ~{DW_DBL{Sel[0]}} & ~{DW_DBL{Sel[1]}};
assign  B_output = A_input & {DW_DBL{Sel[0]}}  & ~{DW_DBL{Sel[1]}};
assign  C_output = A_input & ~{DW_DBL{Sel[0]}} & {DW_DBL{Sel[1]}};
assign  D_output = A_input & {DW_DBL{Sel[0]}}  & {DW_DBL{Sel[1]}};

endmodule
