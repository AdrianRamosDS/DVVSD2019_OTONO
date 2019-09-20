module A2 #( parameter DW = 8)
(
	input [DW-1:0] A2_number,
	output [DW-1:0] decoded_data
);

bit [DW-1:0] comp2_number;

always_comb begin: comp2_always
	
	if(A2_number[7] == 1'b1)					/* SI ES NEGATIVO, SE CONVIERTE */		
		comp2_number = (~A2_number) + 1'b1;
		
	else												/* SI ES POSITIVO EL NÚMERO PASA COMO ESTÁ */
		comp2_number = A2_number;

end: comp2_always

assign decoded_data = comp2_number;

endmodule 