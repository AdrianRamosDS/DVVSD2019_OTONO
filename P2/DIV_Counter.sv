module DIV_Counter
#(
	parameter WORD_LENGTH = 65535, //Numero de bits o ciclos
	parameter NBitsForCounter = 16 //tamaño del contador
)
(
	input clk, rst, enb, sync_rst,
	
	output [15:0]Counting_output,
	output flag_mux, //Selector de mux de retro
	output flag_SM //Salida hacia la entrada de sm
);

bit SM_bit;
bit retro_bit;

logic [NBitsForCounter-1 : 0] Counting_logic;

	always_ff@(posedge clk or negedge rst) begin
		if (rst == 1'b0)
			Counting_logic <= {NBitsForCounter{1'b0}};
		else begin
				if(enb == 1'b1) begin
					if(sync_rst == 0)
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
assign Counting_output=Counting_logic;

endmodule
