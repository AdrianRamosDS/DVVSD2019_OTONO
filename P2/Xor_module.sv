module Xor_module
import mdr_pkg::*;
(
	input [DW-1:0] Data_0,
	input [DW-1:0]	Data_1,
	output [DW-1:0]Data_output
);

assign Data_output = Data_0 ^ Data_1;

endmodule
