module MULT_Counter
#(
	parameter WORD_LENGTH = 17, //Numero de bits o ciclos
	parameter NBitsForCounter = 5 //tamaño del contador
)
(
	// Input Ports
	input clk,
	input reset,
	input enable, //Viene de la maquina de estados
	input SyncReset,

	// Output Ports
	output flag_mux, //Selector de mux de retro
	output flag_SM //Salida hacia la entrada de sm
);

bit SM_bit;
bit retro_bit;

logic [NBitsForCounter-1 : 0] Counting_logic;

always_ff@(posedge clk or negedge reset) begin
	if (reset == 1'b0)
		Counting_logic <= {NBitsForCounter{1'b0}};
	else begin
			if(enable == 1'b1) begin
				if(SyncReset == 0)
					Counting_logic <= Counting_logic + 1'b1;
				else
					Counting_logic <= 0;
			end
	end
end

//--------------------------------------------------------------------------------------------

always_comb begin
	if(Counting_logic == WORD_LENGTH-1)
		SM_bit = 1;
	else
		SM_bit = 0;
end 

//---------------------------------------------------------------------------------------------
assign flag_SM = SM_bit;
assign flag_mux = ~|Counting_logic[NBitsForCounter-1:1];

endmodule
