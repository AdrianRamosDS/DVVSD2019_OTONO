module Concat_module
import mdr_pkg::*;
(
	input [DW-1:0]			A_input,
	input flag_lr,
	output logic [DW-1:0]B_output
);

always_comb begin
	if(flag_lr)
		B_output = {A_input[DW-2:0],1'b0};
	else
		B_output = {A_input[DW-2:0],1'b1};
end

endmodule

