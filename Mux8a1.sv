module Mux8a1(A_input,B_input,C_input,D_input,E_input,F_input,G_input,H_input, Sel, A_output);
import mxv_pkg::*;

	input uint16_t A_input,B_input,C_input,D_input,E_input,F_input,G_input,H_input;
	input [2:0] Sel;

	output uint16_t A_output;

always@(*) begin
	unique case(Sel)
			3'b000: A_output = A_input;
			3'b001: A_output = B_input;
			3'b010: A_output = C_input;
			3'b011: A_output = D_input;
			3'b100: A_output = E_input;
			3'b101: A_output = F_input;
			3'b110: A_output = G_input;
			3'b111: A_output = H_input;
			default:
			begin
				A_output = 16'b0000000000000000;
			end
		endcase	
end

endmodule
