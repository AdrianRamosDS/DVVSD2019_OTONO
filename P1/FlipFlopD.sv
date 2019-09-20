module FlipFlopD #(parameter DW = 8)
(
	input clk,
	input rst,
	input enb,
	input data,
	output out
);

logic ff_d_r;

always_ff@(posedge clk or negedge rst) begin: FlipFlop
	
	if(!rst)
        ff_d_r  <= '0;
    else if (enb)
        ff_d_r  <= data;

end: FlipFlop 

assign out = ff_d_r;

endmodule
