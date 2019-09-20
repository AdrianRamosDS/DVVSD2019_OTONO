module PISO_LSB #(parameter WORD_LENGTH = 8)
(
	input clk,
	input rst,
	input load,
	input shift,
	input [WORD_LENGTH-1:0] parallelInput,

	output serialOutput
);

logic [WORD_LENGTH-1:0] shiftRegister_logic;

always_ff@(posedge clk, negedge rst) begin: register

	if(rst == 1'b0)
		shiftRegister_logic <= {WORD_LENGTH{1'b0}};
	else
		if(load == 1'b1) begin
			shiftRegister_logic <= parallelInput;
			end
	else if(shift == 1'b1) begin
			shiftRegister_logic <= (shiftRegister_logic >> 1'b1); 
			end

end: register

assign serialOutput = shiftRegister_logic[0];

endmodule
