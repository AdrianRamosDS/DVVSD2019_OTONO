module to_A2 #( parameter DW = 8)
(
	input 		 [DW-1:0] data,
	output logic [DW-1:0] A2_data
);

bit [DW-1:0] comp2_number;

always_comb begin: comp2_always
		
		A2_data = ~(data - 1'b1);

end: comp2_always

endmodule 