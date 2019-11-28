module CMD4_Control
import mxv_pkg::*;
(
	// Input Ports
	input clk, rst,
	input [7:0]UART_Rx,
	input Flag_Rx,
	input [7:0]N_input,
	
	// Output Ports
	output logic enable_FIFO,//comenzar a contar ciclos
	output logic enable_MxV,//comenzar a contar ciclos
	output logic enable_cont_SM //limpiar registros
);


wire matrix_end_flag_wire;
wire enable_FIFO_flag_wire;
bit enable_cont_fila;
wire [3:0]select_FIFO_wire;


enum logic [2:0]{FE, L, CMD, VECTOR, EF} State;


CounterParameter
contador_vector
(
	.clk(clk),	.rst(rst),	.enb(enable_cont_fila&Flag_Rx),	.sync_rst_enb(~enable_cont_fila),
	.N_input(N_input-1),	//Sync_rst activo en alto
	.Flag(enable_FIFO_flag_wire),
	.Counting() 
);


always_ff@(posedge clk or negedge rst)
begin
if(rst == 0)
	State <= FE;
else
	case(State)
		FE: 
			if(Flag_Rx == 0)
					State <= FE;
				else if(Flag_Rx == 1)
				begin
					if(UART_Rx == 8'hFE)
						State <= L;
					else
						State <= FE;
				end
		L:
			if(Flag_Rx == 0)
				State <= L;
			else if(Flag_Rx == 1)
			begin
				if(UART_Rx == N_input+2)
					State <= CMD;
				else
					State <= FE;
			end
		CMD:
			if(Flag_Rx == 0)
				State <= CMD;
			else if(Flag_Rx == 1)
			begin
				if(UART_Rx == 4)
					State <= VECTOR;
				else
					State <= FE;
			end
		VECTOR:
			if(Flag_Rx == 0)
				State <= VECTOR;
			else if(Flag_Rx == 1)
			begin
				if(enable_FIFO_flag_wire == 0)
					State <= VECTOR;
				else 
					State <= EF;
			end
		EF:
			if(Flag_Rx == 0)
				State <= EF;
			else if(Flag_Rx == 1)
				State <= FE;
		default:
			State <= FE;
	endcase	
end

always_comb
begin
	enable_cont_SM = 0;
	enable_cont_fila = 0;
	enable_MxV = 0;
	enable_FIFO = 0;
	case(State)
			FE:
			begin
				enable_cont_SM = 0;
				enable_cont_fila = 0;
				enable_MxV = 0;	
				enable_FIFO =0;
			end
			L:
			begin
				enable_cont_SM = 0;
				enable_cont_fila = 0;
				enable_MxV = 0;	
				enable_FIFO = 0;
			end
			CMD:
				begin
				enable_cont_SM = 0;
				enable_MxV = 0;	
				enable_cont_fila = 0;
				enable_FIFO =0;
			end
			VECTOR:
			begin
				enable_FIFO = 1;
				enable_cont_SM = 0;
				enable_MxV = 0;	
				enable_cont_fila = 1;
			end
			EF:
			begin
				enable_cont_SM = 1;
				enable_cont_fila = 0;
				enable_MxV = 1;	
				enable_FIFO = 0;
			end
		endcase	
end

endmodule
