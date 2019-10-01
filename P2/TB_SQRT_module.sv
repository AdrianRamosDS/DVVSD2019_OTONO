module TB_SQRT_module;

	logic clk = 0;
	logic rst;
	logic start;
	logic [15:0] Data = 0;	
	logic [15:0] Result;
	logic [15:0] Reminder;
	logic Ready;

SQRT_module DUV
(
	.clk(clk),
	.rst(rst), 
	.start(start),
	.Data(Data),	
	.Result(Result),
	.Reminder(Reminder),
	.Ready(Ready)
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
	#6 start = 0;
	Data = 172;
	#10 start = 1;

end

/*********************************************************/


endmodule
