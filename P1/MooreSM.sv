module MooreSM
(
	input clk,
	input rst,
	input start,
	input counter_flag,

	output ready,
	output load,
	output shift,
	output clear,
	output start_count_flag
);

enum logic [2:0] {IDLE, LOAD, MULTIPLY, READY} state;
logic Ready, Load, Shift, Clear, Start_Count;

always_ff@(posedge clk or negedge rst) begin

	if (rst ==  1'b0)
		state <= IDLE;
	else begin
		case(state)
				IDLE:
					if(start == 1'b1)
						state <= LOAD;
					else if(start == 1'b0)
						state <= IDLE;	
						
				LOAD:
					state <= MULTIPLY;
					
				MULTIPLY:
					if(counter_flag == 1'b1)
						state <= READY;
					else if(counter_flag == 1'b0)
						state <= MULTIPLY;
						
				READY:
					state <= IDLE;
					
				default:
					state <= IDLE;
		endcase
	end
end

always_comb begin

	Ready = 0;
	Load = 0;
	Shift = 0;
	Clear = 0;
	Start_Count = 0;
	
	case(state)
	
		IDLE: begin
			Ready = 0;
			Load = 0;
			Shift = 0;
			Clear = 1;
			Start_Count = 0;
		end
		
		LOAD: begin
			Ready = 0;
			Load = 1;
			Shift = 0;
			Clear = 1;
			Start_Count = 1;
		end
		
		MULTIPLY: begin
			Ready = 0;
			Load = 0;
			Shift = 1;
			Clear = 0;
			Start_Count = 1;
		end
		
		READY: begin
			Ready = 1;
			Load = 0;
			Shift = 0;
			Clear = 0;
			Start_Count = 0;
		end
	
	endcase
end //always_comb

assign ready = Ready;
assign load  = Load;
assign shift = Shift;
assign clear = Clear;
assign start_count_flag = Start_Count;

endmodule
