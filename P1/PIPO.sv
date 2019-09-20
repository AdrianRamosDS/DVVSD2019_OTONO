module PIPO #(parameter DW = 8)
(
input 			 clk,
input 			 rst,
input 			 enb,
input	 [DW-1:0] data,
output [DW-1:0] out
);

logic [DW-1:0] rgstr_r;

always_ff@(posedge clk or negedge rst) begin: register
	
	if(!rst)
        rgstr_r  <= '0;
    else if (enb)
        rgstr_r  <= data;

end: register

assign out = rgstr_r;

endmodule
