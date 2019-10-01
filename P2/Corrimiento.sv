module Corrimiento
(
	// Input Ports
	input [3:0]A_input,

	// Output Ports
	output [3:0]B_output
);

logic [3:0]aux_wire;
//En este case, la entrada que tengamos se revisa
//Si es mayor o igual a 5, se le suma 3 y si el numero no cabe en 4 bits,
//se trunca a los bits menos significativos
always_comb begin
 case (A_input)
	4'b0000: aux_wire = 4'b0000;
   4'b0001: aux_wire = 4'b0001;
   4'b0010: aux_wire = 4'b0010;
   4'b0011: aux_wire = 4'b0011;
   4'b0100: aux_wire = 4'b0100;
	
   4'b0101: aux_wire = 4'b1000;
   4'b0110: aux_wire = 4'b1001;
   4'b0111: aux_wire = 4'b1010;
   4'b1000: aux_wire = 4'b1011;
   4'b1001: aux_wire = 4'b1100;
   default: aux_wire = 4'b0000;
 endcase
end

assign B_output=aux_wire;

endmodule
