module A2_double_in
import mdr_pkg::*;
(
	input [DW-1:0]				Data_0_a2, Data_1_a2,
	output logic [DW-1:0]	Data_0, Data_1
);

assign Data_0 = Data_0_a2[DW-1]?(~Data_0_a2)+1'b1:Data_0_a2;
assign Data_1 = Data_1_a2[DW-1]?(~Data_1_a2)+1'b1:Data_1_a2;

endmodule
