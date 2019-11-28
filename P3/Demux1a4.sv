module Demux1a4
import mxv_pkg::*;
(
	input  [1:0] Selector,
	input  uint8_t Data_input,
	output uint8_t Data_out_0, Data_out_1, Data_out_2, Data_out_3
);
always@(*) begin
	unique case(Selector)
			2'b00: Data_out_0 = Data_input;
			2'b01: Data_out_1 = Data_input;
			2'b10: Data_out_2 = Data_input;
			2'b11: Data_out_3 = Data_input;
			default:
			begin
				Data_out_0 = 0;
				Data_out_1 = 0;
				Data_out_2 = 0;
				Data_out_3 = 0;
			end
		endcase	
end
endmodule 
