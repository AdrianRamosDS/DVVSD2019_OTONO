module TB_MDR;

	logic 		 clk = 0;
	logic 		 rst;
	logic 		 Start;
	logic 		 Load;
	logic [1:0]  Op;
	logic [15:0] Data = 0;
	logic 		 error;
	logic 		 Load_X;
	logic 		 Load_Y;	
	logic 		 Ready;
	logic [15:0] Result;
	logic [15:0] Reminder;

MDR DUV
(
	.clk(clk),	
	.rst(rst),	
	.Start(Start),	 
	.Load(Load),	
	.Op(Op),	 
	.Data(Data),	
	.error(error),	 
	.Load_X(Load_X),	 
	.Load_Y(Load_Y),	
	.Ready(Ready),
	.Result(Result),	
	.Reminder(Reminder)	
);

/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk = !clk;
  end
/*********************************************************/
initial begin // reset generator
	#0 rst = 0;
	#5 rst = 1;
end

/*********************************************************/
initial begin // enable
	#6 Start = 0;
	#2 Op = 0;
	Data = 172;
	Load_X = 1;
	#10 Start = 1;

end

/*********************************************************/


endmodule
