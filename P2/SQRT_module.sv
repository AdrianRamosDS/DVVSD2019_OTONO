module SQRT_module
import mdr_pkg::*;
(
	input 				clk, rst, start,
	input 	[DW-1:0] Data,
	input 	[DW-1:0] sumador_out,

	output				Ready,
	output 				op_sel,	
	output	[DW-1:0] Result,
	output	[DW-1:0] Reminder,
	output 	[DW-1:0]	mux2sum1,
	output 	[DW-1:0]	mux2sum2
);
wire count_flag_w, count_enb_w, sync_rst_enb_w, reg_enb_w, Q_reg_enb_w, R_reg_enb_w, shift_enb_w;
wire [4:0] count_shift_w;
wire [DW-1:0] muxQretro_w, muxR_retro_w, concat_out_w, D_out_w, Q_out_w, R_out_w, shift2or_w, i_shift2or_w, R_final_out_w;
wire [DW-1:0] Q_final_out_w, mux1or3_out_w, Qshifted2or_w, Qshifted1or3_w , or2sum_w;
wire [DW-1:0] mux2sum1_w, mux2sum2_w; 
//wire [DW-1:0] sumador_out;

SQRT_Control_Unit SQRT_Control_Unit // VERIFICADO
(
	.clk(clk),	.rst(rst),	.count_flag(count_flag_w),	.start(start),
	.enable_cont(count_enb_w), 
	.enable_sync_rst(sync_rst_enb_w),	
	.enable_reg(reg_enb_w),	
	.enable_ready(Ready),
	.enable_reg_Q(Q_reg_enb_w),	
	.enable_reg_R(R_reg_enb_w), 	
	.enable_shift(shift_enb_w)
);

SQRT_Counter Counter // VERIFICADO
(
	.clk(clk),	.rst(rst),	.enb(count_enb_w),	.sync_rst(sync_rst_enb_w),
	.Counting_output(count_shift_w),	.flag_mux(),	.flag_SM(count_flag_w) 
);

/*********************************************************/
Mux2a1_16 muxQ_retro_modulo // VERIFICADO
(
	.Data_0(16'b0000000000000000),	.Data_1(concat_out_w),	.Selector(reg_enb_w),
	.Mux_Output(muxQretro_w)
);
PIPO_16 Q_REG // VERIFICADO
(
	.clk(clk),	.rst(rst),	.enb(shift_enb_w),	.sync_rst(sync_rst_enb_w),		.data(muxQretro_w),
	.out(Q_out_w)
);
/*********************************************************/
Mux2a1_16  muxR_retro_modulo // VERIFICADO
(
	.Data_0(16'b0000000000000000),	.Data_1(sumador_out),	.Selector(reg_enb_w),
	.Mux_Output(muxR_retro_w)
);
PIPO_16 R_REG // VERIFICADO
(
	.clk(clk),	.rst(rst),	.enb(reg_enb_w),	.sync_rst(sync_rst_enb_w),		.data(muxR_retro_w),
	.out(R_out_w)
);
SQRT_Shift Shift_R // VERIFICADO
(
	.A_input(R_out_w),	.shift_num(2),	.flag_lr(0),
	.B_output(shift2or_w)
);
/*********************************************************/
PIPO_16 D_REG  // VERIFICADO
(
	.clk(clk),	.rst(rst),	.enb(shift_enb_w),	.sync_rst(sync_rst_enb_w),		.data(Data),
	.out(D_out_w)
);
SQRT_Shift Shift_contador // VERIFICADO
(
	.A_input(D_out_w),	.shift_num(count_shift_w),	.flag_lr(1),
	.B_output(i_shift2or_w)
);
/*********************************************************/
PIPO_16 R_FINAL_REG // VERIFICADO
(
	.clk(clk),	.rst(rst),	.enb(R_reg_enb_w),	.sync_rst(sync_rst_enb_w),		.data(muxR_retro_w),
	.out(R_final_out_w)
);
/*Demux Raiz_demux_residuo_neg_modulo // VERIFICADO no se necesita
(
	.A_input(R_final_out_w),	.Sel(R_final_out_w[15]),
	.B_output(),	.C_output(RAIZ_R_negativo_wire)
);*/

Concat_module Concat_module // VERIFICADO
(
	.A_input(Q_out_w),	.flag_lr(sumador_out[15]),
	.B_output(concat_out_w)
);
PIPO_16 Q_FINAL_REG //VERIFICADO
(
	.clk(clk),	.rst(rst),	.enb(Q_reg_enb_w),	.sync_rst(sync_rst_enb_w),		.data(concat_out_w),
	.out(Q_final_out_w)
);
/* **************************************************** */
SQRT_Shift Shift_Q //VERIFICADO
(
	.A_input(Q_out_w),	.shift_num(2),	.flag_lr(0),
	.B_output(Qshifted2or_w)
);
Mux2a1_16  Mux1or3 //VERIFICADO
(
	.Selector(R_out_w[15]),	.Data_0(1),	.Data_1(3),
	.Mux_Output(mux1or3_out_w)
);
Or_module Qshifted1or3 //VERIFICADO
(
	.A_input(Qshifted2or_w),	.B_input(mux1or3_out_w),
	.C_output(Qshifted1or3_w)
);

/* **************************************************** */

Or_module Qshifted1or0 //VERIFICADO
(
	.A_input({14'b00000000000000,i_shift2or_w[1:0]}),	.B_input(shift2or_w),
	.C_output(or2sum_w)
);
Mux2a1_16 Raiz_residuoNeg2suma_1_modulo //VERIFICADO
(
	.Data_0(or2sum_w), .Data_1({Q_final_out_w[14:0],1'b1}), .Selector(R_final_out_w[15]),
	.Mux_Output(mux2sum1_w)
);
Mux2a1_16 Raiz_residuoNeg2suma_2_modulo //VERIFICADO
(
	.Data_0(Qshifted1or3_w),	.Data_1(R_final_out_w),	.Selector(R_final_out_w[15]),
	.Mux_Output(mux2sum2_w)
);
/*Adder General_adder //VERIFICADO
(
	.A_input({{DW+1{1'b0}},mux2sum1_w}), .B_input({{DW+1{1'b0}},mux2sum2_w}), .Op_sel(R_out_w[15]),
	.C_output(sumador_out)
);*/

assign mux2sum1 = mux2sum1_w;
assign mux2sum2 = mux2sum2_w;
assign Result = Q_final_out_w;
assign Reminder = R_final_out_w;
assign op_sel = R_final_out_w[15];

/* **************************************************** */
endmodule
