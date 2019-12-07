module Processor
import mxv_pkg::*;
(
	input 			 	clk, rst, sync_rst,
	input uint8_t 	 	Data_matrix, Data_vector,
	output uint16_t 	Data_output
);

always_ff@(posedge clk or negedge rst) begin
	
	if(rst == 1'b0)
		Data_output <= {DW_DBL{1'b0}};
	else	begin
		if (sync_rst  == 1'b1)
			Data_output <= '0;
		else	
			Data_output <= Data_output + (Data_matrix * Data_vector);
	end	
end

endmodule
