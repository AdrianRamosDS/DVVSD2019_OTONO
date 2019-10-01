module PIPO_16
import mdr_pkg::*;
(
input 			 clk,
input 			 rst,
input 			 enb,
input				 sync_rst,
input	 [DW-1:0] data,
output [DW-1:0] out
);

logic [DW-1:0] rgstr_r;

always_ff@(posedge clk or negedge rst) begin: Register
	
	if(!rst)
        rgstr_r  <= {DW{1'b0}};
   else 
		if (enb) begin: Enable
			if(sync_rst)
				rgstr_r <= {DW{1'b0}};
			else
				rgstr_r  <= data;
		end: Enable

end: Register

assign out = rgstr_r;

endmodule
