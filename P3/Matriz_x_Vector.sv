module Matriz_x_Vector
import mxv_pkg::*;
(
		input clk,	rst,	start, Rx_flag,
		input [8:0]push_input, //flag_fifo
		input uint8_t FIFO_input,
		input [4:0] N_input, 
		
		output flag_Tx, flag_RESEND,
		output [DW-1:0]Data_Tx
);



wire enb_cont_wire,enb_POP_wire;
wire flag_reg_final_wire;
wire [3:0] contadorN_P0_w, contadorN_P1_w, contadorN_P2_w, contadorN_P3_w;
wire flag_2nda_ronda_P0_w, flag_2nda_ronda_P1_w, flag_2nda_ronda_P2_w, flag_2nda_ronda_P3_w;

uint8_t  vector_2_P0_wire, vector_2_P1_wire, vector_2_P2_wire, vector_2_P3_wire, vector1_2_mux_wire, vector2_2_mux_wire;  
uint16_t Register_0_output, Register_1_output, Register_2_output, Register_3_output, Register_4_output, Register_5_output, Register_6_output, Register_7_output;

////////////			Processor 0				////////////////////////////////////////////////
uint8_t 	mux_2_P0_wire;
uint8_t 	matrix0_2_P0_wire;
uint8_t 	matrix4_2_P0_wire;
uint16_t P0_2_demux_wire;
////////////			Processor 1				////////////////////////////////////////////////
uint8_t 	mux_2_P1_wire;
uint8_t 	matrix1_2_P1_wire;
uint8_t 	matrix5_2_P1_wire;
uint16_t P1_2_demux_wire;
////////////			Processor 2				////////////////////////////////////////////////
uint8_t 	mux_2_P2_wire;
uint8_t 	matrix2_2_P2_wire;
uint8_t 	matrix6_2_P2_wire;
uint16_t P2_2_demux_wire;
////////////			Processor 3				////////////////////////////////////////////////
uint8_t mux_2_P3_wire;
uint8_t matrix3_2_P3_wire;
uint8_t matrix7_2_P3_wire;
wire [4:0] contadorN_wire;
uint16_t P3_2_demux_wire;

uint16_t demux_reg0_wire, demux_reg1_wire, demux_reg2_wire, demux_reg3_wire, demux_reg4_wire, demux_reg5_wire, demux_reg6_wire, demux_reg7_wire;
uint16_t data_result;

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
wire flag_finish_SEND_wire;
wire [4:0]read_address_ram_wire;
wire flag_con_0a12_wire;
wire enb_sync_rst_Tx_wire;

wire enb_CMD2_w, flag_cmd_w;
wire [2:0] CMD_selector_w;
wire [3:0]enb_cont_w;
wire [7:0] CMD1_Received_Data_w, CMD2_Received_Data_w, CMD3_Received_Data_w, CMD4_Received_Data_w;

//////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////								CONTADORES Tx							////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
Counter TX_contador_0a12_module
(									// checar este contador, solo se active en segunda ronda
	.clk(clk),	.rst(rst),	.enb(enb_con_0a12_wire|enb_CMD2|enb_POP_wire),	.sync_rst(enb_POP_wire),	.N_input(18),
	.Flag(flag_con_0a12_wire),	.Counting()
);

assign flag_Tx = flag_con_0a12_wire;

Counter TX_contador_N_module
(
	.clk(clk),	.rst(rst),	.enb(flag_con_0a12_wire|enb_POP_wire|enb_sync_rst_Tx_wire),	.sync_rst(enb_POP_wire|enb_sync_rst_Tx_wire),//c1: que se deje de contar en su valor limite
	.N_input(N_input),	//c2: habilita l segunda ronda
	.Flag(flag_finish_SEND_wire),//c3: que este activo solo en el estado PROCESS
	.Counting(read_address_ram_wire)
);

assign flag_RESEND = flag_finish_SEND_wire;

CounterParameter #(.NBitsForCounter(3))contador_SM
(
	.clk(clk),	.rst(rst),	.enb(((|enb_cont_w)&Rx_flag_w|flag_cmd_w)&~enb_CMD2_w),	.sync_rst_enb(0),	.N_input(4),
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
	.clk(clk),	.rst(rst),	.UART_Rx(CMD1_Received_Data_w),	.Flag_Rx(Rx_flag),	.flag_RESEND(flag_RESEND_wire),
	.enable_CMD2(enb_CMD2_w),	
	.enable_cont(enb_cont_w[0]),		
	.enable_reg_N(enable_reg_N_wire) /* enb del counter para indicar cuál máquina se utilizará*/
);
CMD2_Control CMD2_State_Machine
(
	.clk(clk),	.rst(rst),	.UART_Rx(CMD2_Received_Data_w),	.Flag_Rx(Rx_flag),
	.enable_cont(enb_cont_w[1])
);
CMD3_Control CMD3_State_Machine
(
	.clk(clk),	.rst(rst),	.UART_Rx(CMD3_Received_Data_w),	.Flag_Rx(Rx_flag),	.N_input(N_wire),
	.enable_FIFO(sel_FIFO_wire),//comenzar a contar ciclos
	.enable_cont_SM(enb_cont_w[2]) //limpiar registros

);
CMD4_Control CMD4_State_Machine
(
	.clk(clk),	.rst(rst),	.UART_Rx(CMD4_Received_Data_w),	.Flag_Rx(Rx_flag),	.N_input(N_wire),
	.enable_FIFO(sel_FIFOVector_wire),//comenzar a contar ciclos
	.enable_MxV(enable_MxV_wire),
	.enable_cont_SM(enb_cont_w[3]) //limpiar registros
);

Shift_Register enb_FIFO
(
	.clk(clk),	.rst(rst),	.load(0),	.shift(enb_cont_wire),	.Parallel_in(),	.Serial_in(enb_cont_wire),
	.Right(0), //corrimiento hacia la derecha (1).
	.sync_rst_enb(enb_sync_rst_wire),////////////////////////////////////////////bandera de contador P3
	.Parallel_Out(enb_P_wire)
);
 
MxV_Control_Unit MxV_Control_Unit
(
	.clk(clk),	.rst(rst),	.start(start),	.enb_CMD2(enb_CMD2_w),	.flag_cont(flag_reg_final_wire),	.contador_mux_flag(contador_mux_flag_wire),
	.flag_finish_SEND(flag_finish_SEND_wire),
	
	.enb_sync_rst(enb_sync_rst_wire),	.enb_cont(enb_cont_wire),	.enb_POP(enb_POP_wire), 	.enb_cont_mux(enb_cont_mux_flag),
	.enb_con_0a12(enb_con_0a12_wire),	.enb_sync_rst_Tx(enb_sync_rst_Tx_wire),
	.flag_SM_cmd_MxV(flag_cmd_w)
);

Mux8a1 Mux_8a1_module
(
	.A_input(Register_0_output),	.B_input(Register_1_output),	.C_input(Register_2_output),	.D_input(Register_3_output),
	.E_input(Register_4_output),	.F_input(Register_5_output),	.G_input(Register_6_output),	.H_input(Register_7_output), 
	.Sel(sel_mux_wire), 
	.A_output(data_result)
);
////////////////////// MEMORIA RAM PARA RESULTADO FINAL /////////////////////////////////////////////////////////////////////////////////////
simple_dual_port_ram_single_clock FINAL_RAM_MEMORY
(					//((contadorN_P0_w>=N_input-1)?1:0)&enb_POP_wire&(~(flag_0a1_final_wire&flag_P3_final_w))), //enb_we_wire   cambieeee
	.clk(clk),	.we(enb_cont_mux_flag),	.data(data_result),	.read_addr(read_address_ram_wire),	.write_addr(sel_mux_wire),	
	.q(Data_Tx)
);

Counter contadorMux8_1_module
(
	.clk(clk),	.rst(rst),	.enb(enb_cont_mux_flag),////////////////////////77cambie esto      enb_cont_mux_flag
	.sync_rst(0),
	.N_input(N_input-1), //CAMBIE ERA N
	.Flag(contador_mux_flag_wire),
	.Counting(sel_mux_wire)
);

Counter contador_4_N_module
(
	.clk(clk),	.rst(rst),	.enb(enb_cont_wire),	.sync_rst(enb_sync_rst_wire),	.N_input(N_input+N_input+7),
	.Flag(flag_reg_final_wire),
	.Counting(contadorN_wire)
);
/////////////////CONTADORES Processor////////////////////
Counter contador_N_P0_module
(
	.clk(clk),	.rst(rst),	.enb(((~flag_P0_final_w)|((N_input>4)?1:0))&(enb_P_wire[0]&enb_cont_wire)|enb_sync_rst_wire),
	.sync_rst(enb_sync_rst_wire),			//c1: que se deje de contar en su valor limite
	.N_input(N_input+1),	//c2: habilita l segunda ronda
	.Flag(flag_P0_final_w),//c3: que este activo solo en el estado PROCESS
	.Counting(contadorN_P0_w)
);

Counter contador_0a1_P0_module
(
	.clk(clk),	.rst(rst),	.enb(flag_P0_final_w&((N_input>4)?1:0)|enb_sync_rst_wire),// checar este contador, solo se active en segunda ronda
	.sync_rst(enb_sync_rst_wire),
	.N_input(1),
	.Flag(),
	.Counting(flag_2nda_ronda_P0_w)
);

Counter contador_N_P1_module
(
	.clk(clk),	.rst(rst),	.enb(((~flag_P1_final_w)|((N_input>4)?1:0))&(enb_P_wire[1]&enb_cont_wire)|enb_sync_rst_wire),
	.sync_rst(enb_sync_rst_wire),
	.N_input(N_input+1),
	.Flag(flag_P1_final_w),
	.Counting(contadorN_P1_w)
);

Counter contador_0a1_P1_module
(
	.clk(clk),	.rst(rst),	.enb(flag_P1_final_w&((N_input>4)?1:0)|enb_sync_rst_wire),	.sync_rst(enb_sync_rst_wire),	.N_input(1),
	.Flag(),	.Counting(flag_2nda_ronda_P1_w)
);

Counter contador_N_P2_module
(
	.clk(clk),	.rst(rst),	.enb(((~flag_P2_final_w)|((N_input>4)?1:0))&(enb_P_wire[2]&enb_cont_wire)|enb_sync_rst_wire),
	.sync_rst(enb_sync_rst_wire),	.N_input(N_input+1),
	.Flag(flag_P2_final_w),	.Counting(contadorN_P2_w)
);

Counter contador_0a1_P2_module
(
	.clk(clk),	.rst(rst),	.enb(flag_P2_final_w&((N_input>4)?1:0)|enb_sync_rst_wire),	.sync_rst(enb_sync_rst_wire),	.N_input(1),
	.Flag(),	.Counting(flag_2nda_ronda_P2_w)
);

Counter contador_N_P3_module
(
	.clk(clk),	.rst(rst),	.enb(((~flag_P3_final_w)|((N_input>4)?1:0))&(enb_P_wire[3]&enb_cont_wire)|enb_sync_rst_wire),
	.sync_rst(enb_sync_rst_wire),	.N_input(N_input+1),
	.Flag(flag_P3_final_w),	.Counting(contadorN_P3_w)
);

Counter contador_0a1_P3_module
(
	.clk(clk),	.rst(rst),	.enb(flag_P3_final_w&((N_input>4)?1:0)|enb_sync_rst_wire),	.sync_rst(enb_sync_rst_wire),
	.N_input(1),	.Flag(flag_0a1_final_wire),
	.Counting(flag_2nda_ronda_P3_w)
);

//////////////////////////////////////////////////////////

//Counter
//contador_0_1_module
//(
//	.clk(clk),	//Clock de sincronización
//	.rst(rst),	//rst activo en bajo	
//	.enb(flag_reg_final_wire),
//	.sync_rst(0),
//	.N_input(1),
//	.Flag(),
//	.Counting(flag_2nda_ronda_wire)
//);

//Counter
//contador_Process_module
//(
//	.clk(clk),	//Clock de sincronización
//	.rst(rst),	//rst activo en bajo	
//	.enb(flag_reg_final_wire),
//	.sync_rst(0),
//	.N_input(2),
//	.Flag(flag_cont_01_wire),
//	.Counting()
//);

FIFO Vector_1_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[8]),	.pop(enb_POP_wire&enb_P_wire[0]),	.DataInput(FIFO_input),	.full(),	.empty(),
	.DataOutput(vector1_2_mux_wire)
);

FIFO Vector_2_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[8]),	.pop(flag_2nda_ronda_P0_w&enb_POP_wire),	.DataInput(FIFO_input),	 .full(),	.empty(),
	.DataOutput(vector2_2_mux_wire)
);

Mux2a1 MUX_Vector
(
	.Data_0(vector1_2_mux_wire),	.Data_1(vector2_2_mux_wire),	.Selector(flag_2nda_ronda_P0_w),
	.Mux_Output(vector_2_P0_wire)
);

Register Register_Vector_P0P1_module
(
	.clk(clk),	.rst(rst),	.enb(1),	.Sync_rst(~|contadorN_P0_w),	.Data_Input(vector_2_P0_wire),
	.Data_Output(vector_2_P1_wire)
);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Processor 0
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
FIFO
M0_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[0]),	.pop(enb_POP_wire&enb_P_wire[0]),	.DataInput(FIFO_input),
	.DataOutput(matrix0_2_P0_wire),
	.full(),
	.empty()
);

FIFO
M4_FIFO
(
	.clk(clk),	.rst(rst),.push(push_input[4]),	.pop(flag_2nda_ronda_P0_w&enb_POP_wire&enb_P_wire[0]),	.DataInput(FIFO_input),
	.DataOutput(matrix4_2_P0_wire),
	.full(),
	.empty()
);

Mux2a1 MUX_P0
(
	.Data_0(matrix0_2_P0_wire),	.Data_1(matrix4_2_P0_wire),	.Selector(flag_2nda_ronda_P0_w),
	.Mux_Output(mux_2_P0_wire)
);


Processor P0_module
(
		.clk(clk),		.rst(rst),
		.sync_rst(~|contadorN_P0_w),
		.Data_matrix(mux_2_P0_wire),
		.Data_vector(vector_2_P0_wire),
		.Data_output(P0_2_demux_wire)
);

Demux1a2 Demux_P0_module
(
	.Data_input(P0_2_demux_wire),	.Selector(flag_2nda_ronda_P0_w),
	.Data_out_0(demux_reg0_wire),	.Data_out_1(demux_reg4_wire)
);

Register_DBL_DW Register_0_module
(
	.clk(clk),	.rst(rst),	.enb((contadorN_wire==(N_input+2))?1:0),//flag_P0_final_w
	.Sync_rst(0),
	.Data_Input(demux_reg0_wire),
	.Data_Output(Register_0_output)
);

Register_DBL_DW Register_4_module
(
	.clk(clk),	.rst(rst),	.enb((contadorN_wire==(N_input+N_input+4))?1:0),	.Sync_rst(0),	.Data_Input(demux_reg4_wire),
	.Data_Output(Register_4_output)
);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Processor 1
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FIFO M1_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[1]),	.pop(enb_POP_wire&enb_P_wire[1]),	.DataInput(FIFO_input),	
	.DataOutput(matrix1_2_P1_wire),	.full(),	.empty()
);

FIFO M5_FIFO
(
	.clk(clk),	.rst(rst),	.push(push_input[5]),	.pop(flag_2nda_ronda_P1_w&enb_POP_wire&enb_P_wire[1]),	.DataInput(FIFO_input),	
	.DataOutput(matrix5_2_P1_wire),	.full(),	.empty()
);

Mux2a1 MUX_P1
(
	.Data_0(matrix1_2_P1_wire),	.Data_1(matrix5_2_P1_wire),	.Selector(flag_2nda_ronda_P1_w),
	.Mux_Output(mux_2_P1_wire)
);

Register Register_Vector_P1P2_module
(
	.clk(clk),	.rst(rst),	.enb(1),	.Sync_rst(~|contadorN_P1_w),	.Data_Input(vector_2_P1_wire),
	.Data_Output(vector_2_P2_wire)
);

Processor P1_module
(
		.clk(clk),	.rst(rst),	.sync_rst(~|contadorN_P1_w),
		.Data_matrix(mux_2_P1_wire),
		.Data_vector(vector_2_P1_wire),
		.Data_output(P1_2_demux_wire)
);

Demux1a2 Demux_P1_module
(
	.Data_input(P1_2_demux_wire),	.Selector(flag_2nda_ronda_P1_w),
	.Data_out_0(demux_reg1_wire),	.Data_out_1(demux_reg5_wire)
);

Register_DBL_DW Register_1_module
(
	.clk(clk),
	.rst(rst),
	.enb((contadorN_wire==(N_input+3))?1:0),
	.Sync_rst(0),
	.Data_Input(demux_reg1_wire),
	.Data_Output(Register_1_output)
);

Register_DBL_DW Register_5_module
(
	.clk(clk),
	.rst(rst),
	.enb((contadorN_wire==(N_input+N_input+5))?1:0),
	.Sync_rst(0),
	.Data_Input(demux_reg5_wire),
	.Data_Output(Register_5_output)
);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Processor 2
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FIFO
M2_FIFO
(
	.DataInput(FIFO_input),
	.push(push_input[2]),
	.pop(enb_POP_wire&enb_P_wire[2]),
	.clk(clk),
	.rst(rst),
	.DataOutput(matrix2_2_P2_wire),
	.full(),
	.empty()
);

FIFO
M6_FIFO
(
	.DataInput(FIFO_input),
	.push(push_input[6]),
	.pop(flag_2nda_ronda_P2_w&enb_POP_wire&enb_P_wire[2]),
	.clk(clk),
	.rst(rst),
	.DataOutput(matrix6_2_P2_wire),
	.full(),
	.empty()
);

Mux2a1 MUX_P2
(
	.Data_0(matrix2_2_P2_wire),	.Data_1(matrix6_2_P2_wire),	.Selector(flag_2nda_ronda_P2_w),
	.Mux_Output(mux_2_P2_wire)
);

Register Register_Vector_P2P3_module
(
	.clk(clk),
	.rst(rst),
	.enb(1),
	.Sync_rst(~|contadorN_P2_w),
	.Data_Input(vector_2_P2_wire),
	.Data_Output(vector_2_P3_wire)
);

Processor P2_module
(
		.clk(clk),
		.rst(rst),
		.sync_rst(~|contadorN_P2_w),
		.Data_matrix(mux_2_P2_wire),
		.Data_vector(vector_2_P2_wire),
		.Data_output(P2_2_demux_wire)
);

Demux1a2 Demux_P2_module
(
	.Data_input(P2_2_demux_wire),	.Selector(flag_2nda_ronda_P2_w),
	.Data_out_0(demux_reg2_wire),	.Data_out_1(demux_reg6_wire)
);

Register_DBL_DW Register_2_module
(
	.clk(clk),
	.rst(rst),
	.enb((contadorN_wire==(N_input+4))?1:0),
	.Sync_rst(0),
	.Data_Input(demux_reg2_wire),
	.Data_Output(Register_2_output)
);


Register_DBL_DW Register_6_module
(
	.clk(clk),
	.rst(rst),
	.enb((contadorN_wire==(N_input+N_input+6))?1:0),
	.Sync_rst(0),
	.Data_Input(demux_reg6_wire),
	.Data_Output(Register_6_output)
);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Processor 3
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
FIFO
M3_FIFO
(
	.DataInput(FIFO_input),
	.push(push_input[3]),
	.pop(enb_POP_wire&enb_P_wire[3]),
	.clk(clk),
	.rst(rst),
	.DataOutput(matrix3_2_P3_wire),
	.full(),
	.empty()
);

FIFO
M7_FIFO
(
	.DataInput(FIFO_input),
	.push(push_input[7]),
	.pop(flag_2nda_ronda_P3_w&enb_POP_wire&enb_P_wire[3]),
	.clk(clk),
	.rst(rst),
	.DataOutput(matrix7_2_P3_wire),
	.full(),
	.empty()
);


Mux2a1
MUX_P3
(
	.Data_0(matrix3_2_P3_wire),
	.Data_1(matrix7_2_P3_wire),
	.Selector(flag_2nda_ronda_P3_w),
	.Mux_Output(mux_2_P3_wire)
);


Processor P3_module
(
		.clk(clk),		.rst(rst),
		.sync_rst(~|contadorN_P3_w),
		.Data_matrix(mux_2_P3_wire),
		.Data_vector(vector_2_P3_wire),
		.Data_output(P3_2_demux_wire)
);

Demux1a2	Demux_P3_module
(
	.Data_input(P3_2_demux_wire),	.Selector(flag_2nda_ronda_P3_w),
	.Data_out_0(demux_reg3_wire),	.Data_out_1(demux_reg7_wire)
);

Register_DBL_DW	Register_3_module
(
	.clk(clk),		.rst(rst),	.enb((contadorN_wire==(N_input+5))?1:0),	.Sync_rst(0),	.Data_Input(demux_reg3_wire),
	.Data_Output(Register_3_output)
);

Register_DBL_DW Register_7_module
(
	.clk(clk),		.rst(rst),		.enb((contadorN_wire==(N_input+N_input+7))?1:0),		.Sync_rst(0),		.Data_Input(demux_reg7_wire),
	.Data_Output(Register_7_output)
);


Processor P1
(
	.clk(clk),	.rst(rst),	.sync_rst(),	.Data_matrix(),	.Data_vector(),
	.Data_output()
);

Processor P2
(
	.clk(clk),	.rst(rst),	.sync_rst(),	.Data_matrix(),	.Data_vector(),
	.Data_output()
);

Processor P3
(
	.clk(clk),	.rst(rst),	.sync_rst(),	.Data_matrix(),	.Data_vector(),
	.Data_output()
);

Processor P4
(
	.clk(clk),	.rst(rst),	.sync_rst(),	.Data_matrix(),	.Data_vector(),
	.Data_output()
);

endmodule
