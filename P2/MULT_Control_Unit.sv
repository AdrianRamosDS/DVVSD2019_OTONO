module MULT_Control_Unit
import mdr_pkg::*;
(
	input clk,
	input rst,
	input flag_cont,
	input start, // iniciar en idle
	
	output logic enable_cont,//comenzar a contar ciclos
	output logic enable_sync_rst, //limpiar registros
	output logic enable_reg, //enable de los rgistros
	output logic enable_ready, 
	output logic enable_shift
);


enum logic [1:0]{IDLE, SETUP, PROCESS, READY} State;

always_ff@(posedge clk or negedge rst) begin
	
	if(rst == 0)
		State <= READY;
	else
		case(State)
			IDLE: 
			if(start == 0)
				State <= IDLE;
			else if(start == 1)
				State <= SETUP;
			SETUP:
				State <= PROCESS;
			PROCESS:
				if(flag_cont == 0)
					State <= PROCESS;
				else if(flag_cont == 1)
					State <= READY;
			READY:
				State <= IDLE;
			default:
				State <= READY;
		endcase	
end

always_comb
begin

	case(State)
			IDLE:
			begin
				enable_cont = 1;
				enable_sync_rst = 1;
				enable_reg = 1;
				enable_ready = 0;
				enable_shift = 1;
			end
			SETUP:
			begin
				enable_cont = 1;
				enable_sync_rst = 0;
				enable_reg = 1;
				enable_ready = 0;
				enable_shift = 1;
			end
			PROCESS:
				begin
				enable_cont = 1;
				enable_sync_rst = 0;
				enable_reg = 0;// SE DEJA EN 0 PORQUE VA CONECTADO AL SELECTOR DEL MUX DEL REGISTRO P
				enable_ready = 0;
				enable_shift = 1;
			end
			
			READY:
			begin
				enable_cont = 0;
				enable_sync_rst = 0;
				enable_reg = 0;
				enable_ready = 1;
				enable_shift = 0;
			end
		endcase	
end

endmodule
