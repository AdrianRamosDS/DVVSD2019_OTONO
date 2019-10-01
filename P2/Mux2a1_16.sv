module Mux2a1_16
import mdr_pkg::*;
(
	input Selector,
	input [DW-1:0] Data_0,
	input [DW-1:0] Data_1,

	output [DW-1:0] Mux_Output
);

logic [DW-1:0] Mux_Output_log;

always_comb begin: ThisIsaMUX

	if (Selector == 1'b1)
		Mux_Output_log = Data_1;
	else
		Mux_Output_log = Data_0;

end// end always

assign Mux_Output = Mux_Output_log;

endmodule
