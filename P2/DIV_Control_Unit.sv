module DIV_Control_Unit
import mdr_pkg::*;
(
	input clk, rst, start, 
	input count_flag,
	
	output logic enb_mux,
	output logic enb_sync_rst,
	output logic enb_reg, 
	output logic enb_ready, 
	output logic enb_count
);

enum logic [2:0]{IDLE, SETUP, PROCESS, SAVE, READY} State;

always_ff@(posedge clk or negedge rst) begin

	if(rst == 0)
		State <= READY;
	else
		case(State)
		
			IDLE: 
				State <= SETUP;
				
			SETUP:
				State <= PROCESS;
				
			PROCESS:
				if(count_flag == 1)
					State <= PROCESS;
				else if(count_flag == 0)
					State <= SAVE;
			SAVE:
				State <= READY;
				
			READY:
				if(start == 0)
					State <= READY;
				else if(start == 1)
					State <= IDLE;
			default:
				State <= READY;
		endcase	
end

always_comb begin

	case(State)
			IDLE: // se reinician los datos
			begin
				enb_mux = 0;
				enb_sync_rst = 1;
				enb_reg = 0;
				enb_ready = 0;
				enb_count = 0;
			end
			SETUP: begin
				enb_mux = 0;
				enb_sync_rst = 0;
				enb_reg = 0;
				enb_ready = 0;
				enb_count = 0;
			end
			PROCESS:	begin
				enb_mux = 1;
				enb_sync_rst = 0;
				enb_reg = 1;
				enb_ready = 0;
				enb_count = 0;
			end
			
			SAVE: begin
				enb_mux = 0;
				enb_sync_rst = 0;
				enb_reg = 0;
				enb_ready = 1;
				enb_count = 1;
			end
			
			READY: begin
				enb_mux = 0;
				enb_sync_rst = 0;
				enb_reg = 0;
				enb_ready = 0;
				enb_count = 0;
			end
		endcase	
end

endmodule
	