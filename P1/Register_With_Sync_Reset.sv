module Register_With_Sync_Reset #(	parameter DW = 16 )
(
	input clk,
	input rst,
	input enable,
	input Sync_Reset,
	input [DW-1:0] Data_Input,
	
	output [DW-1:0] Data_Output
);

logic [DW-1:0] Data_reg;

always_ff@(posedge clk or negedge rst) begin: REGISTER
	
	if(rst == 1'b0)
		Data_reg <= {DW {1'b0}};
	else
		if(Sync_Reset == 1'b1) 
				Data_reg <= {DW {1'b0}};
		else
			if(enable == 1'b1)
				Data_reg <= Data_Input;
			else
				Data_reg <= Data_reg;
				
end: REGISTER

assign Data_Output = Data_reg;

endmodule
