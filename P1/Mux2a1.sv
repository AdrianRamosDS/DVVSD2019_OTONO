module Mux2a1
(
	input Selector,
	input [15:0] Data_0,
	input [15:0] Data_1,

	output [15:0] Mux_Output
);

logic [15:0] Mux_Output_log;

always_comb begin: ThisIsaMUX

	if (Selector == 1'b1)
		Mux_Output_log = Data_1;
	else
		Mux_Output_log = Data_0;

end// end always

assign Mux_Output = Mux_Output_log;

endmodule
