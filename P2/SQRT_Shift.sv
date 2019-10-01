module SQRT_Shift
import mdr_pkg::*;
(
	input [DW-1:0] A_input,
	input [4:0]shift_num,
	input flag_lr,
	output logic [DW-1:0] B_output
);

always_comb begin
	if(flag_lr)
		B_output = A_input >> shift_num;
	else
		B_output = A_input << shift_num;
end

endmodule

