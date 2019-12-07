module UART_PIPO
#(parameter WORD_LENGTH = 16)

(
	// Input Ports
	input clk,
	input reset,
	input enable,
	input Sync_Reset,
	input [WORD_LENGTH-1:0] Data_Input,
	
	// Output Ports
	output [WORD_LENGTH-1:0] Data_Output
);

logic [WORD_LENGTH-1:0] Data_logic;

always_ff@(posedge clk or negedge reset) begin: ThisIsARegister
	if(reset == 1'b0) 
	begin
		Data_logic <= {WORD_LENGTH{1'b0}};
	end
	else
		if(enable == 1'b1) begin: Enable
			if(Sync_Reset == 1'b1)
			begin
				Data_logic <= {WORD_LENGTH{1'b0}};
			end
			else 	begin: SynchronousReset	
				Data_logic <= Data_Input;	
			end: SynchronousReset
		end: Enable
end: ThisIsARegister

assign Data_Output = Data_logic;

endmodule
