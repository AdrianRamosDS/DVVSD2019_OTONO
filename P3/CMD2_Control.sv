module CMD2_Control
import mxv_pkg::*;
(
	input clk, rst, Flag_Rx,
	input [7:0]UART_Rx,
	
	output logic enable_cont//comenzar a contar ciclos
);


enum logic [2:0]{FE, L, CMD, EF} State;

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
					if(UART_Rx == 8'h02)
						State <= CMD;
					else
						State <= FE;
				end
			CMD:
				if(Flag_Rx == 0)
					State <= CMD;
				else if(Flag_Rx == 1)
				begin
					if(UART_Rx == 3)
						State <= EF;
					else
						State <= FE;
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
		enable_cont = 0;
		case(State)
				FE:
				begin
					enable_cont = 0;
				end
				L:
				begin
					enable_cont = 0;
				end
				CMD:
					begin
					enable_cont = 0;
				end
				EF:
				begin
					enable_cont = 1;
				end
			endcase	
	end

endmodule
