module PIPO
import mdr_pkg::*;
(
input 			 clk,
input 			 rst,
input 			 enb,
input				 sync_rst,
input	 [DW_DBL:0] data,
output [DW_DBL:0] out
);

logic [DW_DBL:0] rgstr_r;

always_ff@(posedge clk or negedge rst) begin: Register
	
	if(!rst)
        rgstr_r  <= '0;
   else 
		if (enb) begin: Enable
			if(sync_rst)
				rgstr_r <= '0;
			else
				rgstr_r  <= data;
		end: Enable

end: Register

assign out = rgstr_r;

endmodule
