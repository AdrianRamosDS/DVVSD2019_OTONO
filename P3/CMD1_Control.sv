module CMD1_Control
import mxv_pkg::*;
(
	input clk, rst,
	input [7:0]UART_Rx,
	input Flag_Rx,
	input flag_RESEND,

	output logic enable_CMD2,//comenzar a contar ciclos
	output logic enable_cont,//comenzar a contar ciclos
	output logic enable_reg_N //limpiar registros
);


enum logic [3:0]{FE, L, CMD, N, EF, CMD2, EF2, RESEND} State;

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
				if(UART_Rx == 8'h03)
					State <= CMD;
				else if(UART_Rx == 8'h02)
					State <= CMD2;
				else
					State <= FE;
			end
		CMD:
			if(Flag_Rx == 0)
				State <= CMD;
			else if(Flag_Rx == 1)
			begin
				if(UART_Rx == 1)
					State <= N;
				else
					State <= FE;
			end
		N:
			if(Flag_Rx == 0)
				State <= N;
			else if(Flag_Rx == 1)
			begin
				if(UART_Rx > 8'h08)
					State <= FE;
				else
					State <= EF;
			end
		EF:
			if(Flag_Rx == 0)
				State <= EF;
			else if(Flag_Rx == 1)
				State <= FE;
		CMD2:
			if(Flag_Rx == 0)
				State <= CMD2;
			else if(Flag_Rx == 1)
			begin
				if(UART_Rx == 2)
					State <= EF2;
				else
					State <= FE;
			end
		EF2:
			if(Flag_Rx == 0)
					State <= EF2;
				else if(Flag_Rx == 1)
				begin
					if(UART_Rx == 8'hEF)
						State <= RESEND;
					else
						State <= FE;
				end
		RESEND:
			begin
				if(flag_RESEND == 1)
					State <= FE;
				else
					State <= RESEND;
			end
		default:
			State <= FE;
	endcase	
end

always_comb begin
	enable_cont = 0;
	enable_reg_N = 0;
	enable_CMD2 = 1;
	case(State)
			FE:
			begin
				enable_cont = 0;
				enable_reg_N =0;
				enable_CMD2 = 0;
			end
			L:
			begin
				enable_cont = 0;
				enable_reg_N = 0;
				enable_CMD2 = 0;
			end
			CMD:
				begin
				enable_cont = 0;
				enable_reg_N =0;
				enable_CMD2 = 0;
			end
			N:
			begin
				enable_cont = 0;
				enable_reg_N = 1;
				enable_CMD2 = 0;
			end
			EF:
			begin
				enable_cont = 1;
				enable_reg_N = 0;
				enable_CMD2 = 0;
			end
			CMD2:
			begin
				enable_cont = 0;
				enable_reg_N = 0;
				enable_CMD2 = 0;
			end
			EF2:
			begin
				enable_cont = 0;
				enable_reg_N = 0;
				enable_CMD2 = 0;
			end
			RESEND:
			begin
				enable_cont = 0;
				enable_reg_N = 0;
				enable_CMD2 = 1;
			end
		endcase	
end

endmodule
