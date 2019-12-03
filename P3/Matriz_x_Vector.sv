/*
*
*
*/
module Matriz_x_Vector
import mxv_pkg::*;
(
		input clk,	rst,	Rx_flag,
		input uint8_t FIFO_input,
		
		output flag_Tx,
		output [DW-1:0]Data_Tx
);

wire enb_cont_wire,enb_POP_wire;
wire flag_reg_final_wire;
wire [3:0] contadorN_P0_w, contadorN_P1_w, contadorN_P2_w, contadorN_P3_w;
wire flag_2nda_ronda_P0_w, flag_2nda_ronda_P1_w, flag_2nda_ronda_P2_w, flag_2nda_ronda_P3_w;

uint8_t  vector_P0_w, vector_P1_w, vector_P2_w, vector_P3_w, vector1_2_mux_w, vector2_2_mux_w;  
uint16_t Register_0_output, Register_1_output, Register_2_output, Register_3_output, Register_4_output, Register_5_output, Register_6_output, Register_7_output;

uint8_t 	mux_P0_w, mux_P1_w, mux_P2_w, mux_P3_w;
uint16_t demux_P0_w, demux_P1_w, demux_P2_w, demux_P3_w;
uint8_t 	matrix0_P0_w, matrix4_P0_w, matrix1_P1_w, matrix5_P1_w, matrix2_P2_w, matrix6_P2_w, matrix3_P3_w, matrix7_P3_w;

wire [4:0] contadorN_wire;

uint16_t demux_reg0_wire, demux_reg1_wire, demux_reg2_wire, demux_reg3_wire, demux_reg4_wire, demux_reg5_wire, demux_reg6_wire, demux_reg7_wire;
uint16_t data_result_w;

wire [3:0]enb_P_wire;
wire enb_cont_mux_flag;
wire [2:0]sel_mux_wire;
wire contador_mux_flag_wire;
wire flag_cont_01_wire;
wire enb_we_wire;
wire flag_0a1_final_wire;
wire flag_P0_final_w, flag_P1_final_w, flag_P2_final_w, flag_P3_final_w;
wire enb_sync_rst_wire;
wire enb_con_0a12_wire;
wire flag_finish_SEND_w;
wire [4:0]read_address_ram_wire;
wire flag_con_0a12_wire;
wire enb_sync_rst_Tx_wire;

wire enb_CMD2_w, flag_cmd_w, enb_N_reg_w, sel_FIFOVector_w, enb_MxV_w;
wire [2:0] CMD_selector_w;
wire [3:0]enb_cont_w;
wire [DW-1:0] N_w;
wire [DW-1:0] CMD1_Received_Data_w, CMD2_Received_Data_w, CMD3_Received_Data_w, CMD4_Received_Data_w;

wire [7:0] sel_FIFO_wire;
wire [8:0] push_input;


//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////								CONTADORES Tx							////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
Counter TX_contador_0a12_module
(									// checar este contador, solo se active en segunda ronda
	.clk(clk),	.rst(rst),	.enb(enb_con_0a12_wire|enb_CMD2_w|enb_POP_wire),	.sync_rst(enb_POP_wire),	.N_input(18),
	.Flag(flag_con_0a12_wire),	.Counting()
);

assign flag_Tx = flag_con_0a12_wire;

Counter TX_contador_N_module
(
	.clk(clk),	.rst(rst),	.enb(flag_con_0a12_wire|enb_POP_wire|enb_sync_rst_Tx_wire),	.sync_rst(enb_POP_wire|enb_sync_rst_Tx_wire),//c1: que se deje de contar en su valor limite
	.N_input(N_w),	//c2: habilita l segunda ronda
	.Flag(flag_finish_SEND_w),//c3: que este activo solo en el estado PROCESS
	.Counting(read_address_ram_wire)
);



CounterParameter #(.NBitsForCounter(3))contador_SM
(
	.clk(clk),	.rst(rst),	.enb( ((|enb_cont_w) & Rx_flag|flag_cmd_w) & ~enb_CMD2_w),	.sync_rst_enb(0),	.N_input(4),
	.Flag(),	.Counting(CMD_selector_w)
);
Demux1a4 Demux_Comandos
(
	.Selector(CMD_selector_w),	 .Data_input(FIFO_input),
	.Data_out_0(CMD1_Received_Data_w),	.Data_out_1(CMD2_Received_Data_w),	.Data_out_2(CMD3_Received_Data_w),	.Data_out_3(CMD4_Received_Data_w)
);
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////        MÁQUINAS DE ESTADO     //////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
CMD1_Control CMD1_State_Machine
(
	.clk(clk),	.rst(rst),	.UART_Rx(CMD1_Received_Data_w),	.Flag_Rx(Rx_flag),	.flag_RESEND(flag_finish_SEND_w),
	.enable_CMD2(enb_CMD2_w),	
	.enable_cont(enb_cont_w[0]),		
	.enable_reg_N(enb_N_reg_w) /* enb del counter para indicar cuál máquina se utilizará*/
);
CMD2_Control CMD2_State_Machine
(
	.clk(clk),	.rst(rst),	.UART_Rx(CMD2_Received_Data_w),	.Flag_Rx(Rx_flag),
	.enable_cont(enb_cont_w[1])
);
CMD3_Control CMD3_State_Machine
(
	.clk(clk),	.rst(rst),	.UART_Rx(CMD3_Received_Data_w),	.Flag_Rx(Rx_flag),	.N_input(N_w[3:0]),
	.enable_FIFO(sel_FIFO_wire),//comenzar a contar ciclos
	.enable_cont_SM(enb_cont_w[2]) //limpiar registros

);
CMD4_Control CMD4_State_Machine
(
	.clk(clk),	.rst(rst),	.UART_Rx(CMD4_Received_Data_w),	.Flag_Rx(Rx_flag),	.N_input(N_w[3:0]),
	.enable_FIFO(sel_FIFOVector_w),//comenzar a contar ciclos
	.enable_MxV(enb_MxV_w),
	.enable_cont_SM(enb_cont_w[3]) //limpiar registros
);

MxV_Control_Unit MxV_Control_Unit
(
	.clk(clk),	.rst(rst),	.start(enb_MxV_w & Rx_flag),	.enb_CMD2(enb_CMD2_w),	.flag_cont(flag_reg_final_wire),	.contador_mux_flag(contador_mux_flag_wire),
	.flag_finish_SEND(flag_finish_SEND_w),
	
	.enb_sync_rst(enb_sync_rst_wire),	.enb_cont(enb_cont_wire),	.enb_POP(enb_POP_wire), 	.enb_cont_mux(enb_cont_mux_flag),
	.enb_con_0a12(enb_con_0a12_wire),	.enb_sync_rst_Tx(enb_sync_rst_Tx_wire),
	.flag_SM_cmd_MxV(flag_cmd_w)
);


Shift_Register enb_FIFO
(
	.clk(clk),	.rst(rst),	.load(0),	.shift(enb_cont_wire),	.Parallel_in(),	.Serial_in(enb_cont_wire),
	.Right(0), //corrimiento hacia la derecha (1).
	.sync_rst_enb(enb_sync_rst_wire),////////////////////////////////////////////bandera de contador P3
	.Parallel_Out(enb_P_wire)
);
 
assign push_input = ({sel_FIFOVector_w,sel_FIFO_wire}&{9{Rx_flag}});


////////////////////////////////////////////
///////    REGISTRO N        ///////////////
////////////////////////////////////////////
Register N_module
(
	.clk(clk),	.rst(rst),	.enb(enb_N_reg_w),	.Sync_rst(1'b0),
	.Data_Input(CMD1_Received_Data_w),
	.Data_Output(N_w)
);
//////////////////////////////////////////////////////////////////
////////////////////// MEMORIA RAM PARA RESULTADO FINAL /////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
Mux8a1 Mux_8a1_module
(
	.A_input(Register_0_output),	.B_input(Register_1_output),	.C_input(Register_2_output),	.D_input(Register_3_output),
	.E_input(Register_4_output),	.F_input(Register_5_output),	.G_input(Register_6_output),	.H_input(Register_7_output), 
	.Sel(sel_mux_wire), 
	.A_output(data_result_w)
);
simple_dual_port_ram_single_clock_16bits FINAL_RAM_MEMORY
(					//((contadorN_P0_w>=N_input-1)?1:0)&enb_POP_wire&(~(flag_0a1_final_wire&flag_P3_final_w))), //enb_we_wire   
	.clk(clk),	.we(enb_cont_mux_flag),	.data(data_result_w),	.read_addr(read_address_ram_wire),	.write_addr(sel_mux_wire),	
	.q(Data_Tx)
);

Counter contadorMux8_1_module
(
	.clk(clk),	.rst(rst),	.enb(enb_cont_mux_flag),///////////////////////      enb_cont_mux_flag
	.sync_rst(0),
	.N_input(N_w-1), //CAMBIE ERA N
	.Flag(contador_mux_flag_wire),
	.Counting(sel_mux_wire)
);

Counter contador_4_N_module
(
	.clk(clk),	.rst(rst),	.enb(enb_cont_wire),	.sync_rst(enb_sync_rst_wire),	.N_input(N_w + N_w + 7),
	.Flag(flag_reg_final_wire),
	.Counting(contadorN_wire)
);
/////////////////CONTADORES Processor////////////////////
Counter contador_N_P0_module
(
	.clk(clk),	.rst(rst),	.enb(((~flag_P0_final_w)|((N_w>4)?1'b1:1'b0))&(enb_P_wire[0]&enb_cont_wire)|enb_sync_rst_wire),
	.sync_rst(enb_sync_rst_wire),			//c1: que se deje de contar en su valor limite
	.N_input(N_w+1),	//c2: habilita l segunda ronda
	.Flag(flag_P0_final_w),//c3: que este activo solo en el estado PROCESS
	.Counting(contadorN_P0_w)
);

Counter contador_0a1_P0_module
(
	.clk(clk),	.rst(rst),	.enb(flag_P0_final_w&((N_w>4)?1'b1:1'b0)|enb_sync_rst_wire),// checar este contador, solo se active en segunda ronda
	.sync_rst(enb_sync_rst_wire),
	.N_input(1),
	.Flag(),
	.Counting(flag_2nda_ronda_P0_w)
);

Counter contador_N_P1_module
(
	.clk(clk),	.rst(rst),	.enb(((~flag_P1_final_w)|((N_w>4)?1'b1:1'b0))&(enb_P_wire[1]&enb_cont_wire)|enb_sync_rst_wire),
	.sync_rst(enb_sync_rst_wire),
	.N_input(N_w+1),
	.Flag(flag_P1_final_w),
	.Counting(contadorN_P1_w)
);

Counter contador_0a1_P1_module
(
	.clk(clk),	.rst(rst),	.enb(flag_P1_final_w&((N_w>4)?1'b1:1'b0)|enb_sync_rst_wire),	.sync_rst(enb_sync_rst_wire),	.N_input(1),
	.Flag(),	.Counting(flag_2nda_ronda_P1_w)
);

Counter contador_N_P2_module
(
	.clk(clk),	.rst(rst),	.enb(((~flag_P2_final_w)|((N_w>4)?1'b1:1'b0))&(enb_P_wire[2]&enb_cont_wire)|enb_sync_rst_wire),
	.sync_rst(enb_sync_rst_wire),	.N_input(N_w+1),
	.Flag(flag_P2_final_w),	.Counting(contadorN_P2_w)
);

Counter contador_0a1_P2_module
(
	.clk(clk),	.rst(rst),	.enb(flag_P2_final_w&((N_w>4)?1'b1:1'b0)|enb_sync_rst_wire),	.sync_rst(enb_sync_rst_wire),	.N_input(1),
	.Flag(),	.Counting(flag_2nda_ronda_P2_w)
);

Counter contador_N_P3_module
(
	.clk(clk),	.rst(rst),	.enb(((~flag_P3_final_w)|((N_w>4)?1'b1:1'b0))&(enb_P_wire[3]&enb_cont_wire)|enb_sync_rst_wire),
	.sync_rst(enb_sync_rst_wire),	.N_input(N_w+1),
	.Flag(flag_P3_final_w),	.Counting(contadorN_P3_w)
);

Counter contador_0a1_P3_module
(
	.clk(clk),	.rst(rst),	.enb(flag_P3_final_w&((N_w>4)?1'b1:1'b0)|enb_sync_rst_wire),	.sync_rst(enb_sync_rst_wire),
	.N_input(1),	.Flag(flag_0a1_final_wire),
	.Counting(flag_2nda_ronda_P3_w)
);

//////////////////////////////////////////////////////////

FIFO Vector_1_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[8]),	.pop(enb_POP_wire&enb_P_wire[0]),	.DataInput(FIFO_input),	.full(),	.empty(),
	.DataOutput(vector1_2_mux_w)
);

FIFO Vector_2_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[8]),	.pop(flag_2nda_ronda_P0_w&enb_POP_wire),	.DataInput(FIFO_input),	 .full(),	.empty(),
	.DataOutput(vector2_2_mux_w)
);

Mux2a1 MUX_Vector
(
	.Data_0(vector1_2_mux_w),	.Data_1(vector2_2_mux_w),	.Selector(flag_2nda_ronda_P0_w),
	.Mux_Output(vector_P0_w)
);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//       PROCESSOR 0			/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
FIFO F0_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[0]),	.pop(enb_POP_wire&enb_P_wire[0]),	.DataInput(FIFO_input),
	.DataOutput(matrix0_P0_w),	.full(),	.empty()
);
FIFO F4_FIFO
(
	.clk(clk),	.rst(rst),.push(push_input[4]),	.pop(flag_2nda_ronda_P0_w&enb_POP_wire&enb_P_wire[0]),	.DataInput(FIFO_input),
	.DataOutput(matrix4_P0_w),	.full(),	.empty()
);
Mux2a1 MUX_P0
(
	.Data_0(matrix0_P0_w),	.Data_1(matrix4_P0_w),	.Selector(flag_2nda_ronda_P0_w),
	.Mux_Output(mux_P0_w)
);
Processor P0
(
	.clk(clk),	.rst(rst),	.sync_rst(~|contadorN_P0_w),	.Data_matrix(mux_P0_w),	.Data_vector(vector_P0_w),
	.Data_output(demux_P0_w)
);
Demux1a2 Demux_P0_module
(
	.Data_input(demux_P0_w),	.Selector(flag_2nda_ronda_P0_w),
	.Data_out_0(demux_reg0_wire),	.Data_out_1(demux_reg4_wire)
);
Register_DBL_DW Register_0_module
(
	.clk(clk),	.rst(rst),	.enb((contadorN_wire==(N_w+2))?1'b1:1'b0),	.Sync_rst(1'b0),	.Data_Input(demux_reg0_wire),
	.Data_Output(Register_0_output)
);
Register_DBL_DW Register_4_module
(
	.clk(clk),	.rst(rst),	.enb((contadorN_wire==(N_w+N_w+4))?1'b1:1'b0),	.Sync_rst(1'b0),	.Data_Input(demux_reg4_wire),
	.Data_Output(Register_4_output)
);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//       PROCESSOR 1		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
FIFO F1_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[1]),	.pop(enb_POP_wire&enb_P_wire[1]),	.DataInput(FIFO_input),	
	.DataOutput(matrix1_P1_w),	.full(),	.empty()
);
FIFO F5_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[5]),	.pop(flag_2nda_ronda_P1_w&enb_POP_wire&enb_P_wire[1]),	.DataInput(FIFO_input),	
	.DataOutput(matrix5_P1_w),	.full(),	.empty()
);
Mux2a1 MUX_P1
(
	.Data_0(matrix1_P1_w),	.Data_1(matrix5_P1_w),	.Selector(flag_2nda_ronda_P1_w),
	.Mux_Output(mux_P1_w)
);
Processor P1
(
	.clk(clk),	.rst(rst),	.sync_rst(~|contadorN_P1_w),	.Data_matrix(mux_P1_w),	.Data_vector(vector_P1_w),
	.Data_output(demux_P1_w)
);
Demux1a2 Demux_P1_module
(
	.Data_input(demux_P1_w),	.Selector(flag_2nda_ronda_P1_w),
	.Data_out_0(demux_reg1_wire),	.Data_out_1(demux_reg5_wire)
);
Register_DBL_DW Register_1_module
(
	.clk(clk),	.rst(rst),	.enb((contadorN_wire==(N_w+3))?1'b1:1'b0),	.Sync_rst(1'b0),	.Data_Input(demux_reg1_wire),
	.Data_Output(Register_1_output)
);
Register_DBL_DW Register_5_module
(
	.clk(clk),	.rst(rst),	.enb((contadorN_wire==(N_w+N_w+5))?1'b1:1'b0),	.Sync_rst(1'b0),	.Data_Input(demux_reg5_wire),
	.Data_Output(Register_5_output)
);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//       PREOCESSOR 2		////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
FIFO F2_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[2]),	.pop(enb_POP_wire&enb_P_wire[2]),	.DataInput(FIFO_input),
	.DataOutput(matrix2_P2_w),	.full(),	.empty()
);
FIFO F6_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[6]),	.pop(flag_2nda_ronda_P2_w&enb_POP_wire&enb_P_wire[2]),	.DataInput(FIFO_input),
	.DataOutput(matrix6_P2_w),	.full(),	.empty()
);
Mux2a1 MUX_P2
(
	.Data_0(matrix2_P2_w),	.Data_1(matrix6_P2_w),	.Selector(flag_2nda_ronda_P2_w),
	.Mux_Output(mux_P2_w)
);



Register Register_Vector_P0P1_module
(
	.clk(clk),	.rst(rst),	.enb(1'b1),	.Sync_rst(~|contadorN_P0_w),	.Data_Input(vector_P0_w),
	.Data_Output(vector_P1_w)
);
Register Register_Vector_P1P2_module
(
	.clk(clk),	.rst(rst),	.enb(1'b1),	.Sync_rst(~|contadorN_P1_w),	.Data_Input(vector_P1_w),
	.Data_Output(vector_P2_w)
);
Register Register_Vector_P2P3_module
(
	.clk(clk),	.rst(rst),	.enb(1'b1),	.Sync_rst(~|contadorN_P2_w),	.Data_Input(vector_P2_w),
	.Data_Output(vector_P3_w)
);

Processor P2
(
	.clk(clk),	.rst(rst),	.sync_rst(~|contadorN_P2_w),	.Data_matrix(mux_P2_w),	.Data_vector(vector_P2_w),
	.Data_output(demux_P2_w)
);
Demux1a2 Demux_P2_module
(
	.Data_input(demux_P2_w),	.Selector(flag_2nda_ronda_P2_w),
	.Data_out_0(demux_reg2_wire),	.Data_out_1(demux_reg6_wire)
);

Register_DBL_DW Register_2_module
(
	.clk(clk),	.rst(rst),	.enb((contadorN_wire==(N_w+4))?1'b1:1'b0),	.Sync_rst(1'b0),
	.Data_Input(demux_reg2_wire),
	.Data_Output(Register_2_output)
);

Register_DBL_DW Register_6_module
(
	.clk(clk),	.rst(rst),	.enb((contadorN_wire==(N_w+N_w+6))?1'b1:1'b0),	.Sync_rst(1'b0),
	.Data_Input(demux_reg6_wire),
	.Data_Output(Register_6_output)
);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//       PROCESSOR 3			//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
FIFO F3_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[3]),	.pop(enb_POP_wire&enb_P_wire[3]),	.DataInput(FIFO_input),
	.DataOutput(matrix3_P3_w),	.full(),	.empty()
);
FIFO F7_FIFO
(	
	.clk(clk),	.rst(rst),	.push(push_input[7]),	.pop(flag_2nda_ronda_P3_w&enb_POP_wire&enb_P_wire[3]),	.DataInput(FIFO_input),
	.DataOutput(matrix7_P3_w),	.full(),	.empty()
);
Mux2a1 MUX_P3
(
	.Data_0(matrix3_P3_w),	.Data_1(matrix7_P3_w),	.Selector(flag_2nda_ronda_P3_w),
	.Mux_Output(mux_P3_w)
);
Processor P3
(
	.clk(clk),	.rst(rst),	.sync_rst(~|contadorN_P3_w),	.Data_matrix(mux_P3_w),	.Data_vector(vector_P3_w),
	.Data_output(demux_P3_w)
);
Demux1a2	Demux_P3_module
(
	.Data_input(demux_P3_w),	.Selector(flag_2nda_ronda_P3_w),
	.Data_out_0(demux_reg3_wire),	.Data_out_1(demux_reg7_wire)
);

Register_DBL_DW	Register_3_module
(
	.clk(clk),		.rst(rst),	.enb((contadorN_wire == (N_w+5))?1'b1:1'b0),	.Sync_rst(1'b0),	.Data_Input(demux_reg3_wire),
	.Data_Output(Register_3_output)
);

Register_DBL_DW Register_7_module
(
	.clk(clk),		.rst(rst),		.enb((contadorN_wire == (N_w+N_w+7))?1'b1:1'b0),		.Sync_rst(1'b0),		.Data_Input(demux_reg7_wire),
	.Data_Output(Register_7_output)
);



endmodule
