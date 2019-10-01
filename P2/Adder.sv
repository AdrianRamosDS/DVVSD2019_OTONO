module Adder
import mdr_pkg::*;
(
	input [DW_DBL:0]A_input,
	input [DW_DBL:0]B_input,
	input Op_sel,
	output logic [DW_DBL:0]C_output
);

always_comb	begin
	if(Op_sel == 1'b1)
		C_output = A_input + B_input;
	else
		C_output = A_input - B_input;
end

endmodule
