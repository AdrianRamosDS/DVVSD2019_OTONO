module TB_MDR;

	logic 		 clk 	 = 0;
	logic 		 rst;
	logic 		 Start = 0;
	logic 		 Load  = 0;
	logic [1:0]  Op 	 = 0;
	logic [15:0] Data  = 0;
	
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
#5 Start = 1;
	Data 	= 3;
#2	Load 	= 1;
#8 Load 	= 0;
	Data = 5;
#5	Load 	= 1;
#5 Load 	= 0;
	Op 	= 0;
#5	Load 	= 1;
#5 Load 	= 0;
	
#80
	Op		= 1;
	Data 	= 172;
#2	Load 	= 1;
#8 Load 	= 0;
	Data = 3;
#5 Load 	= 1;
#5 Load 	= 0;
#10	Load 	= 1;
#10 Load 	= 0;

#240
	Op		= 2;
	Data 	= 314;
#2	Load 	= 1;
#5 Load 	= 0;
#5 Data = 3;
#5	Load 	= 1;
#5 Load 	= 0;
#5	Load 	= 1;
#5 Load 	= 0;

end

/*********************************************************/


endmodule
