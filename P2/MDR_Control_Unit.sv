module MDR_Control_Unit
import mdr_pkg::*;
(
	input clk, rst, start, load, ready, error,
	output logic enable_sync_rst,
	output logic enable_operacion,
	output logic enable_reg,
	output logic enable_ready,
	output logic enable_error,
	output logic load_x,
	output logic load_Y,
	output logic load_op
);

enum logic [2:0]{IDLE,SETUP,LOADX,LOADY,OP,PROCESS, ERROR, READY} State;

always_ff@(posedge clk or negedge rst) begin
	
			if (rst == 0)
				State <=IDLE;
			else 
				case(State)
				
				IDLE: 
				if(start == 1)
					State <= IDLE;
				else if(start == 0)
					State <= SETUP;
					
				SETUP:
					State <= LOADX;
					
				LOADX:
					if(load == 1)
						State <= LOADX;
					else if(load == 0)
						State <= LOADY;
						
				LOADY:
					if(load == 1)
						State <= LOADY;
					else if(load == 0)
						State <= OP;
				OP:
					if(load == 1)
						State <= OP;
					else if(load == 0)
						State <= PROCESS;
					
				PROCESS:
					if(error == 1)
						State <= ERROR;
					else if(ready == 1)
						State <= READY;
					else
						State <= PROCESS;
				ERROR:
					State <= IDLE;
					
				READY:
					State<=IDLE;
					
				default:
					State <= IDLE;
			endcase	
end

always_comb begin
	
	case(State)
	IDLE:	begin
		enable_operacion=0;
		enable_sync_rst=0;
		enable_reg=0;
		enable_ready=0;
		enable_error=0;
		load_x=0;
		load_Y=0;
		load_op=0;
	end
	
	SETUP:	begin
		enable_operacion=0;
		enable_sync_rst=1;
		enable_reg=1;
		enable_ready=1;
		enable_error=1;
		load_x=1;
		load_Y=1;
		load_op=0;
	end
	
	LOADX:	begin
		enable_operacion=0;
		enable_sync_rst=0;
		enable_reg=1;
		enable_ready=0;
		enable_error=0;
		load_x=1;
		load_Y=0;
		load_op=0;
	end
	
	LOADY:	begin
		enable_operacion=0;
		enable_sync_rst=0;
		enable_reg=1;
		enable_ready=0;
		enable_error=0;
		load_x=0;
		load_Y=1;
		load_op=0;
	end
	
	OP: 	begin
		enable_operacion=0;
		enable_sync_rst=0;
		enable_reg=1;
		enable_ready=0;
		enable_error=0;
		load_x=0;
		load_Y=0;
		load_op=1;
	end
	
	PROCESS: 	begin
		enable_operacion=1;
		enable_sync_rst=0;
		enable_reg=1;
		enable_ready=0;
		enable_error=0;
		load_x=0;
		load_Y=0;
		load_op=0;
	end
	
	ERROR: 	begin
		enable_operacion=0;
		enable_sync_rst=0;
		enable_reg=1;
		enable_ready=0;
		enable_error=1;
		load_x=0;
		load_Y=0;
		load_op=0;
	end
	
	READY:	begin
		enable_operacion=0;
		enable_sync_rst=0;
		enable_reg=1;
		enable_ready=1;
		enable_error=0;
		load_x=0;
		load_Y=0;
		load_op=0;
	end
	
	endcase

end

endmodule
