module Demux1a2
import mxv_pkg::*;
(
	input  Selector,
	input  uint16_t Data_input,
	output uint16_t Data_out_0,
	output uint16_t Data_out_1
);

assign Data_out_0 = Data_input & ~{DW_DBL{Selector}};
assign Data_out_1 = Data_input & {DW_DBL{Selector}};

endmodule 
