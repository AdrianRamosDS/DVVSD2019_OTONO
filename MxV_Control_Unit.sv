module MxV_Control_Unit
import mxv_pkg::*;
(
	input clk, rst, start, enb_CMD2, flag_cont, contador_mux_flag, flag_finish_SEND,	
	output logic enb_sync_rst, enb_cont, enb_POP, enb_cont_mux, enb_con_0a12, enb_sync_rst_Tx, flag_SM_cmd_MxV
);


enum logic [2:0]{IDLE, PROCESS, SAVE, TRANSMIT, FINISH, TRANSMIT2, FINISH2} State;

always_ff@(posedge clk or negedge rst) begin
	
	if(rst == 0)
		State <= IDLE;
	else
		case(State)
			IDLE: 
				if(start == 1)
					State <= PROCESS;
				else if(enb_CMD2 == 1)
					State <= TRANSMIT2;
				else
					State <= IDLE;
			PROCESS:
				if(flag_cont==0)
					State <= PROCESS;
				else
					State <= SAVE;
			SAVE:
				if(contador_mux_flag == 0)
					State <= SAVE;
				else 
					State <= TRANSMIT;
			TRANSMIT:
				if(flag_finish_SEND == 0)
					State <= TRANSMIT;
				else 
					State <= FINISH;
			FINISH:
				State <= IDLE;
			TRANSMIT2:
				if(flag_finish_SEND == 0)
					State <= TRANSMIT2;
				else 
					State <= FINISH2;
			FINISH2:
				State <= IDLE;
			
			default:
				State <= IDLE;
		endcase	
end

always_comb begin
	
	enb_cont = 0;
	enb_POP = 0;
	enb_cont_mux  = 0;
	enb_con_0a12 = 0;
	flag_SM_cmd_MxV = 0;
	enb_sync_rst = 1;
	enb_sync_rst_Tx = 0;
	
	case(State)
			IDLE:
			begin
				enb_cont = 0;
				enb_POP =0;
				enb_cont_mux = 0;
				enb_con_0a12 = 0;
				flag_SM_cmd_MxV = 0;
				enb_sync_rst = 1;
				enb_sync_rst_Tx = 0;
			end
			PROCESS:
			begin
				enb_cont = 1;
				enb_POP = 1;
				enb_cont_mux = 0;
				enb_con_0a12 =0;
				flag_SM_cmd_MxV = 0;
				enb_sync_rst = 0;
				enb_sync_rst_Tx = 0;
			end
			SAVE:
			begin
				enb_cont = 0;
				enb_POP =0;
				enb_cont_mux  = 1;
				enb_con_0a12 =0;
				flag_SM_cmd_MxV = 0;
				enb_sync_rst = 0;
				enb_sync_rst_Tx = 0;
			end
			TRANSMIT:
			begin
				enb_cont = 0;
				enb_POP = 0;
				enb_cont_mux  = 0;
				enb_con_0a12 =1;
				flag_SM_cmd_MxV = 0;
				enb_sync_rst = 0;
				enb_sync_rst_Tx = 0;
			end
			FINISH:
				begin
				enb_cont = 0;
				enb_POP = 0;
				enb_cont_mux  = 0;
				enb_con_0a12 =0;
				flag_SM_cmd_MxV = 1;
				enb_sync_rst = 0;
				enb_sync_rst_Tx = 1;
			end
			TRANSMIT2:
			begin
				enb_cont = 0;
				enb_POP = 0;
				enb_cont_mux  = 0;
				enb_con_0a12 =1;
				flag_SM_cmd_MxV = 0;
				enb_sync_rst = 0;
				enb_sync_rst_Tx = 0;
			end
			FINISH2:
				begin
				enb_cont = 0;
				enb_POP = 0;
				enb_cont_mux  = 0;
				enb_con_0a12 =0;
				flag_SM_cmd_MxV = 0;
				enb_sync_rst = 0;
				enb_sync_rst_Tx = 1;
			end
		endcase	
end

endmodule
