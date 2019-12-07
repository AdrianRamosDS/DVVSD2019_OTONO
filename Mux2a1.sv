module Mux2a1
import mxv_pkg::*;
(
	input Selector,
	input uint8_t Data_0,
	input uint8_t Data_1,

	output uint8_t Mux_Output
);

uint8_t Mux_Output_log;

always_comb begin: ThisIsaMUX

	if (Selector == 1'b1)
		Mux_Output_log = Data_1;
	else
		Mux_Output_log = Data_0;

end// end always

assign Mux_Output = Mux_Output_log;

endmodule
