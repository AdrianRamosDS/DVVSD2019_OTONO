module SQRT_Counter
import mdr_pkg::*;
(
	input clk, rst, enb, sync_rst,
	output [4:0] Counting_output,
	output flag_mux,
	output flag_SM 
);

bit SM_bit;
bit retro_bit;

logic [SQRT_NBitsForCounter-1 : 0] Counting_logic;

	always_ff@(posedge clk or negedge rst) begin
		if (rst == 1'b0)
			Counting_logic <= 16;//{SQRT_NBitsForCounter{1'b0}};
		else begin
				if(enb == 1'b1) begin
					if(sync_rst == 0)
						Counting_logic <= Counting_logic - 2;
					else
						Counting_logic <= 0;
				end
		end
	end

//--------------------------------------------------------------------------------------------

always_comb
	if(Counting_logic == 2)
		SM_bit = 1;
	else
		SM_bit = 0;


//---------------------------------------------------------------------------------------------
assign flag_SM = SM_bit;
assign flag_mux = ~|Counting_logic[SQRT_NBitsForCounter-1:1];
assign Counting_output = Counting_logic;

endmodule
