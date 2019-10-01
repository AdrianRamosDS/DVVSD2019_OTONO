module Or_module
import mdr_pkg::*;
(
	// Input Ports
	input [DW-1:0]A_input,
	input [DW-1:0]B_input,
	
	// Output Ports
	output logic [DW-1:0]C_output
);
assign C_output = A_input|B_input;

endmodule

