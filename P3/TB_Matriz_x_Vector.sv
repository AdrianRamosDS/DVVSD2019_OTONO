//`timescale 1ns/1ps
module TB_Matriz_x_Vector;

	logic 		clk		= 0;
	logic 		rst; 
	logic 		start		= 0;
	logic			Rx_flag 	= 0;
	logic [8:0]	push_input;
	logic [7:0]	FIFO_input;
	
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
	 
#5 FIFO_input = 8'h03;
#3 FIFO_input = 8'h01;
#5 FIFO_input = 8'h04;
#5 FIFO_input = 8'hEF;

#5 FIFO_input = 8'hFE;
#5 FIFO_input = 8'h02;
#5 FIFO_input = 8'h03;
#4 FIFO_input = 8'hEF;
// MATRIZ:
#3 FIFO_input = 8'hFE;
#3 FIFO_input = 8'h18;
#5 FIFO_input = 8'h04;
#4 FIFO_input = 8'h00;
#4 FIFO_input = 8'h01;
#4 FIFO_input = 8'h02;
#4 FIFO_input = 8'h03;
#4 FIFO_input = 8'h04;
#4 FIFO_input = 8'h05;
#4 FIFO_input = 8'h06;
#4 FIFO_input = 8'h07;
#4 FIFO_input = 8'h08;
#4 FIFO_input = 8'h09;
#4 FIFO_input = 8'h0A;
#4 FIFO_input = 8'h0B;
#4 FIFO_input = 8'h0C;
#4 FIFO_input = 8'h0D;
#4 FIFO_input = 8'h0E;
#4 FIFO_input = 8'h0F;
#5 FIFO_input = 8'hEF;
//VECTOR:
#5 FIFO_input = 8'hFE;
#5 FIFO_input = 8'h06;
#5 FIFO_input = 8'h04;
#5 FIFO_input = 8'h01;
#5 FIFO_input = 8'h02;
#5 FIFO_input = 8'h03;
#5 FIFO_input = 8'h04;
#5 FIFO_input = 8'hEF;
	
end

/*********************************************************/


endmodule
