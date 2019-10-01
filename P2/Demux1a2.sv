module Demux1a2
import mdr_pkg::*;
(
	input [DW_DBL:0] Data_input,
	input Selector,

	output [DW_DBL:0] Data_out_0,
	output [DW_DBL:0] Data_out_1
);

assign Data_out_0 = Data_input & ~{DW_DBL+1{Selector}};
assign Data_out_1 = Data_input & {DW_DBL+1{Selector}};

endmodule 
