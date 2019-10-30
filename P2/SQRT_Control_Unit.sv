module SQRT_Control_Unit
import mdr_pkg::*;
(
	input clk, rst, start, count_flag,
	
	output logic enable_cont,
	output logic enable_sync_rst, 
	output logic enable_reg, 
	output logic enable_ready, 
	output logic enable_reg_Q,
	output logic enable_reg_R, 
	output logic enable_shift
);
enum logic [2:0]{IDLE, RST, SETUP, PROCESS, SIGNO, SIGNO2, READY} State;

always_ff@(posedge clk or negedge rst) begin
	if(rst == 0)
		State <= READY;
	else
		case(State)
		
			IDLE: 
				if(start == 0)
					State <= IDLE;
				else if(start == 1)
					State <= RST;
			RST:
				State <= SETUP;
				
			SETUP:
				State <= PROCESS;
				
			PROCESS:
				if(count_flag == 0)
					State <= PROCESS;
				else if(count_flag == 1)
					State <= SIGNO;
					
			SIGNO:
				State <= SIGNO2;
				
			SIGNO2:
				State <= READY;
				
			READY:
				State <= IDLE;
				
			default:
				State <= READY;
		endcase	
end

always_comb begin

	case(State)
			IDLE:
			begin
				enable_cont = 0;
				enable_sync_rst = 0;
				enable_reg = 0;
				enable_ready = 0;
				enable_shift = 0;
				enable_reg_Q = 0;
				enable_reg_R = 0;
			end
			RST:
			begin
				enable_cont = 0;
				enable_sync_rst = 1;
				enable_reg = 1;
				enable_ready = 0;
				enable_shift = 1;
				enable_reg_Q = 0;
				enable_reg_R = 0;
			end
			SETUP:
			begin
				enable_cont = 0;
				enable_sync_rst = 0;
				enable_reg = 0;
				enable_ready = 0;
				enable_shift = 1;
				enable_reg_Q = 0;
				enable_reg_R = 0;
			end
			PROCESS:
				begin
				enable_cont = 1;
				enable_sync_rst = 0;
				enable_reg = 1;// SE DEJA EN 0 PORQUE VA CONECTADO AL SELECTOR DEL MUX DEL REGISTRO P
				enable_ready = 0;
				enable_shift = 1;
				enable_reg_Q = 0;
				enable_reg_R = 0;
			end
			
			SIGNO:
			begin
				enable_cont = 0;
				enable_sync_rst = 0;
				enable_reg = 1;
				enable_ready = 1;
				enable_shift = 0;
				enable_reg_Q = 1;
				enable_reg_R = 1;
			end
			
			SIGNO2:
			begin
				enable_cont = 0;
				enable_sync_rst = 0;
				enable_reg = 1;
				enable_ready = 1;
				enable_shift = 0;
				enable_reg_Q = 0;
				enable_reg_R = 1;
			end
			
			READY:
			begin
				enable_cont = 0;
				enable_sync_rst = 0;
				enable_reg = 1;
				enable_ready = 1;
				enable_shift = 0;
				enable_reg_Q = 0;
				enable_reg_R = 0;
			end
		endcase	
end

endmodule
