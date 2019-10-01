module DIVIDER_module
import mdr_pkg::*;
(
	input 		    clk,
	input			    rst,
	input			    start,
	input  [DW-1:0] adder_out,
	input  [DW-1:0] Dividendo,
	input  [DW-1:0] Divisor,
	output [DW-1:0] Result,
	output [DW-1:0] Reminder,
	output 			 Ready,
	output [DW-1:0] mux2resta,
	output [DW-1:0] mux2resta2
);
wire mux_enb_w, sync_rst_enb_w;
wire [DW-1:0] dividendo_out_w, adder_out_w, mux2resta_w, reminder_mux_out_w, reminder_out_w;

DIV_Control_Unit CONTROL_UNIT( //Verificado
	.clk(clk),	.rst(rst),	.count_flag(~adder_out[15]),	.start(start),
	.enb_mux(mux_enb_w),
	.enb_sync_rst(sync_rst_enb_w), 
	.enb_reg(), 
	.enb_ready(),
	.enb_count()
);

DIV_Counter Counter //Verificado
(
	.clk(clk),	.rst(rst),	.enb(~adder_out[15]),	.sync_rst(sync_rst_enb_w),
   .Counting_output(Result),	.flag_mux(),	.flag_SM()
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

PIPO_16 RESIDUO //Verificado
(
	.clk(clk),	.rst(rst),	.enb(adder_out[15]),	.sync_rst(sync_rst_enb_w),		.data(reminder_mux_out_w),
	.out(reminder_out_w)	
);
/* *********************************************************************** */
/*Adder_16 General_Adder
(
	.A_input(mux2resta_w),	.B_input(Divisor),	.Op_sel(1'b0),
	.C_output(adder_out_w)
);*/

assign mux2resta = mux2resta_w;
assign mux2resta2 = Divisor;

endmodule 