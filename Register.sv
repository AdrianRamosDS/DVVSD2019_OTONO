module Register
import mxv_pkg::*;
(
	input clk, rst, enb, Sync_rst,
	input [DW-1:0] Data_Input,
	output [DW-1:0] Data_Output
);

logic [DW-1:0] Data_logic;

always_ff@(posedge clk or negedge rst) begin: ThisIsARegister
	if(rst == 1'b0) 
	begin
		Data_logic <= {DW{1'b0}};
	end
	else
		if(enb == 1'b1) begin: enable
			if(Sync_rst == 1'b1)
			begin
				Data_logic <= {DW{1'b0}};
			end
			else 	begin: Synchronousrst	
				Data_logic <= Data_Input;	
			end: Synchronousrst
		end: enable
end: ThisIsARegister

assign Data_Output = Data_logic;

endmodule
