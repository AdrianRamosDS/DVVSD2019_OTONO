//`timescale 1ns/1ps
module TB_Matriz_x_Vector;

	logic 		clk		= 0;
	logic 		rst; 
	logic 		start		= 0;
	logic			Rx_flag 	= 0;
	logic [8:0]	push_input;
	logic [7:0]	FIFO_input;
	logic [4:0]	N_input;
	
	logic 		flag_Tx;
	logic 		flag_RESEND;
	logic [7:0]	Data_Tx;
	
Matriz_x_Vector DUV
(
	.clk(clk),
	.rst(rst),
	.start(start),
	.Rx_flag(Rx_flag),
	.push_input(push_input),
	.FIFO_input(FIFO_input),
	.N_input(N_input),

	.flag_Tx(flag_Tx),
	.flag_RESEND(flag_RESEND),
	.Data_Tx(Data_Tx)
);

/*********************************************************/
initial // clk generator
  begin
    forever #2 clk = !clk;
  end
/*********************************************************/
initial begin // rst generator
	#0 rst = 0;
	#5 rst = 1;
end

/*********************************************************/
initial begin // enable
	#5 
	start=1;
#10 Rx_flag		= 1'b1;
	 FIFO_input = 8'hFE;
#5  Rx_flag		= 1'b0;
	 
#10 Rx_flag		= 1'b1;
	 FIFO_input = 8'h03;
#5  Rx_flag		= 1'b0;

#10 FIFO_input = 8'h01;
#10 FIFO_input = 8'h04;
#10 FIFO_input = 8'hEF;

#10 FIFO_input = 8'hFE;
#10 FIFO_input = 8'h02;
#10 FIFO_input = 8'h03;
#10 FIFO_input = 8'hEF;
// MATRIZ:
#10 FIFO_input = 8'hFE;
#10 FIFO_input = 8'h18;
#10 FIFO_input = 8'h04;
#10 FIFO_input = 8'h00;
#10 FIFO_input = 8'h01;
#10 FIFO_input = 8'h02;
#10 FIFO_input = 8'h03;
#10 FIFO_input = 8'h04;
#10 FIFO_input = 8'h05;
#10 FIFO_input = 8'h06;
#10 FIFO_input = 8'h07;
#10 FIFO_input = 8'h08;
#10 FIFO_input = 8'h09;
#10 FIFO_input = 8'h0A;
#10 FIFO_input = 8'h0B;
#10 FIFO_input = 8'h0C;
#10 FIFO_input = 8'h0D;
#10 FIFO_input = 8'h0E;
#10 FIFO_input = 8'h0F;
#10 FIFO_input = 8'hEF;
//VECTOR:
#10 FIFO_input = 8'hFE;
#10 FIFO_input = 8'h06;
#10 FIFO_input = 8'h04;
#10 FIFO_input = 8'h01;
#10 FIFO_input = 8'h02;
#10 FIFO_input = 8'h03;
#10 FIFO_input = 8'h04;
#10 FIFO_input = 8'hEF;
	
	N_input = 4;
	
end

/*********************************************************/


endmodule
