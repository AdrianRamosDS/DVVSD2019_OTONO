module OneShot
import mdr_pkg::*;
(
	input clk,
	input rst,
	input enb,
	input sync_rst,
	input Data_Input,
	output Oneshot
);

wire [DW-1:0] one2shot_wire;
wire [DW-1:0] Oneshot_wire;

PIPO_16 R1
(
	.clk(clk),	.rst(rst),	.enb(enb),	.sync_rst(sync_rst),	.data({DW{Data_Input}}),
	.out(one2shot_wire)
);

PIPO_16 R2
(
	.clk(clk),	.rst(rst),	.enb(enb),	.sync_rst(sync_rst),	.data(one2shot_wire),
	.out(Oneshot_wire)
);

assign Oneshot = |((~Oneshot_wire)&(|one2shot_wire));

endmodule
