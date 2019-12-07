module CMD3_Control
import mxv_pkg::*;
(
	input clk, rst, Flag_Rx,
	input [7:0]UART_Rx,
	input [3:0]N_input,
	
	output logic [7:0]enable_FIFO,//comenzar a contar ciclos
	output logic enable_cont_SM //limpiar registros
);

wire matrix_end_flag_wire;
wire enable_FIFO_flag_wire;
bit enable_cont_fila;
wire [3:0]select_FIFO_wire;

enum logic [2:0]{FE, L, CMD, MATRIZ, EF} State;

CounterParameter
contador_fila
(
	.clk(clk),	.rst(rst),	.enb(enable_cont_fila&Flag_Rx),	.sync_rst_enb(~enable_cont_fila),	//Sync_rst activo en alto
	.N_input(N_input-1),	//Sync_rst activo en alto
	.Flag(enable_FIFO_flag_wire),
	.Counting() 
);


CounterParameter
contador_FIFO
(
	.clk(clk),	.rst(rst),	.enb(enable_FIFO_flag_wire&Flag_Rx),	.sync_rst_enb(~enable_FIFO_flag_wire),	//Sync_rst activo en alto
	.N_input(N_input-1),	//Sync_rst activo en alto
	.Flag(matrix_end_flag_wire),
	.Counting(select_FIFO_wire) 
);


always_ff@(posedge clk or negedge rst) begin
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
				if( (UART_Rx ==8'h18|UART_Rx ==8'h27|UART_Rx ==8'h38|UART_Rx ==8'h51|UART_Rx ==8'h66) )
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
					State <= MATRIZ;
				else
					State <= FE;
			end
		MATRIZ:
			if(Flag_Rx == 0)
				State <= MATRIZ;
			else if(Flag_Rx == 1)
			begin
				if((enable_FIFO_flag_wire&matrix_end_flag_wire) == 0)
					State <= MATRIZ;
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
	enable_FIFO = 0;
	case(State)
			FE:
			begin
				enable_cont_SM = 0;
				enable_cont_fila = 0;
				enable_FIFO =0;
			end
			L:
			begin
				enable_cont_SM = 0;
				enable_cont_fila = 0;
				enable_FIFO = 0;
			end
			CMD:
				begin
				enable_cont_SM = 0;
				enable_cont_fila = 0;
				enable_FIFO =0;
			end
			MATRIZ:
			begin
				enable_FIFO = 1<<select_FIFO_wire;
				enable_cont_SM = 0;
				enable_cont_fila = 1;
			end
			EF:
			begin
				enable_cont_SM = 1;
				enable_cont_fila = 0;
				enable_FIFO = 0;
			end
		endcase	
end

endmodule
