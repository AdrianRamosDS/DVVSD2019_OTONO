module Sumador
(
	input [15:0] Input_1,
	input [15:0] Input_2,
	output [15:0] Suma
);

logic [15:0] suma;
always_comb begin: adder

	suma = Input_1 + Input_2;

end: adder

assign Suma = suma;

endmodule 