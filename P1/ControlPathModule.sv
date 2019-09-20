module ControlPathModule
import seq_mult_pkg::*;
(
	input clk,
	input rst,
	input start,
	
	output ready_ctrl_sgnl,
	output load_ctrl_sgnl,
	output shift_ctrl_sgnl,
	output clear_ctrl_sgnl
);

wire counter_flag_w, start_count_flag_w;

MooreSM CONTROL_MODULE(
	.clk(clk), 
	.rst(rst),
	.start(start),
	.counter_flag(counter_flag_w),
	
	.start_count_flag(start_count_flag_w),
	.ready(ready_ctrl_sgnl),
	.load(load_ctrl_sgnl),
	.shift(shift_ctrl_sgnl),
	.clear(clear_ctrl_sgnl)
	
);

Counter CONTADOR
(
	.clk(clk),	.rst(rst),	.enable(start_count_flag_w),	.Sync_Reset(clear_ctrl_sgnl),
	.flag(counter_flag_w)
);

endmodule
