module OneShot 
(
	input clk, rst, signal,
	output oneShot
);

enum logic [1:0] {IDLE, SHOT, WAITING} State;
logic shot_reg;
wire Not_Start;

assign Not_Start = signal;

always_ff@(posedge clk or negedge rst) begin

	if(rst == 1'b0)
		State <= IDLE;
	else begin
		case(State)
		
			IDLE:
				if(Not_Start == 1'b1)
					State <= SHOT;
				else 
					State <= IDLE;
					
			SHOT:
					State <= WAITING;
					
			WAITING:
				if(Not_Start == 1'b1)
					State <= WAITING;
				else 
					State <= IDLE;
					
			default:	
					State <= SHOT;
		endcase	
	end
end

always_comb begin

	case(State)
			IDLE:
				shot_reg = 1'b0;
					
			SHOT:
				shot_reg = 1'b1;
					
			WAITING:
				shot_reg = 1'b0;
					
			default:	
				shot_reg = 1'b0;
	endcase
end

assign oneShot = shot_reg;

endmodule
