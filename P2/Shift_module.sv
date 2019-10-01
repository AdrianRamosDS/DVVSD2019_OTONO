module Shift_module
import mdr_pkg::*;
(
	input [DW_DBL:0]			A_input,
	output logic[DW_DBL:0]	B_output
);

always_comb begin

	if(A_input[DW_DBL])
		B_output = {1'b1, A_input[DW_DBL:1]};
	else
		B_output = {1'b0, A_input[DW_DBL:1]};
end

endmodule 