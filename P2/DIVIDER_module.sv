module DIVIDER_module
import mdr_pkg::*;
(
	input 		    clk, rst, start,
	input  [DW-1:0] Dividendo, Divisor,
	input  [DW-1:0] adder_out,

	output 			 Ready,
	output [DW-1:0] Result,
	output [DW-1:0] Reminder,
	output [DW-1:0] mux2resta,
	output [DW-1:0] mux2resta2
);
wire mux_enb_w, sync_rst_enb_w, result_enb, reminder_enb_w;
wire [DW-1:0] dividendo_out_w, mux2resta_w, reminder_mux_out_w, reminder_out_w, count2result_w;
//wire [DW-1:0] adder_out;

DIV_Control_Unit CONTROL_UNIT( //Verificado
	.clk(clk),	.rst(rst),	.count_flag(~adder_out[15]),	.start(start),
	.enb_mux(mux_enb_w),
	.enb_sync_rst(sync_rst_enb_w), 
	.enb_reg(reminder_enb_w), 
	.enb_ready(Ready),
	.enb_count(result_enb)
);

DIV_Counter Counter //Verificado
(
	.clk(clk),	.rst(rst),	.enb(~adder_out[15]),	.sync_rst(sync_rst_enb_w),
   .Counting_output(count2result_w),	.flag_mux(),	.flag_SM()
);

PIPO_16 DIVIDENDO_RGSTR //Verificado
(										
	.clk(clk),	.rst(rst),	.enb(1'b1),	.sync_rst(sync_rst_enb_w),		.data(adder_out),
	.out(dividendo_out_w)	
);
Mux2a1_16 DIVIDENDO_INPUT //Verificado
(
	.Selector(mux_enb_w),	.Data_0(Dividendo),	.Data_1(dividendo_out_w),
	.Mux_Output(mux2resta_w)
);
/* *********************************************************************** */
Mux2a1_16 Residuo_Input_Mux //Verificado
(
	.Selector(|adder_out),	.Data_0(16'b0000000000000000),	.Data_1(~(mux2resta_w)+1'b1),
	.Mux_Output(reminder_mux_out_w)
);

PIPO_16 RESIDUO_RGSTR //Verificado
(
	.clk(clk),	.rst(rst),	.enb(reminder_enb_w),	.sync_rst(sync_rst_enb_w),		.data(~(reminder_mux_out_w)+1),
	.out(Reminder)	
);
PIPO_16 RESULTADO_RGSTR //Verificado
(
	.clk(clk),	.rst(rst),	.enb(result_enb),	.sync_rst(sync_rst_enb_w),		.data(count2result_w),
	.out(Result)	
);
/* *********************************************************************** */
/*Adder General_Adder
(
	.A_input({{DW+1{1'b0}},mux2resta_w}),	.B_input({{DW+1{1'b0}},Divisor}),	.Op_sel(1'b0),
	.C_output(adder_out)
);*/

assign mux2resta = mux2resta_w;
assign mux2resta2 = Divisor;

endmodule 