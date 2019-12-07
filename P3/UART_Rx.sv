module UART_Rx(
	input clk, reset,
	input Rx_flag, //Bit de start en fram de Rx_flag (0)
	output logic data_Rx_flag, //Indica que hemos recebido un dato
	output logic reset_count, //Indica que hemos recebido un dato
	output logic shift_Rx_flag //Indica que debes ir guardando en el registro
);

enum logic [2:0] {IDLE,DATA,FINISH} state;
 
bit enable_count;
wire countFinished;
//bit reset_count;
wire [7:0]count;

UART_Counter #(.Maximum_Value(8)) Contador
(
	.clk(clk),
	.reset(reset),
	.enable(enable_count),
	.syncReset(reset_count),
	.Flag(countFinished),
	.Counting(count)
);

/*------------------------------------------------------------------------------------------*/
/*Asignacion de estado, proceso secuencial*/
always_ff@(posedge clk, negedge reset) begin

	if(reset == 1'b0)
			state <= IDLE;
	else 
		case(state)
			
			IDLE:
				if(Rx_flag == 1'b0)
					state <= DATA;	
				else
					state <= IDLE;		
			DATA: 
				if(countFinished == 1'b1)
					state <= FINISH;
				else
					state <= DATA;
			FINISH:
				state <= IDLE;
				
			default:
					state <= IDLE;	
			endcase
end

always_comb begin
	data_Rx_flag = 1'b0;
	shift_Rx_flag = 1'b0;
	reset_count = 1'b0;
	enable_count = 1'b0;
	case(state)
		IDLE:
			begin
				data_Rx_flag = 1'b0;
				shift_Rx_flag = 1'b0;
				reset_count = 1'b1; //Hacemos reset, activo en 1
				enable_count = 1'b0;
			end
		DATA: 
			begin
				data_Rx_flag = 1'b0;
				shift_Rx_flag = 1'b1;
				reset_count = 1'b0; //Quitamos reset, activo en 0
				enable_count = 1'b1;
			end	
		FINISH:
			begin
				data_Rx_flag = 1'b1;
				shift_Rx_flag = 1'b1;
				reset_count = 1'b0; //Quitamos reset, activo en 0
				enable_count = 1'b0;
			end
		
	endcase
end


endmodule	