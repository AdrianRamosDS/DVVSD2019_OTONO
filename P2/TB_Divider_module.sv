module TB_Divider_module;

	logic clk = 0;
	logic rst;
	logic start;
	logic [15:0] Dividendo = 0;
	logic [15:0] Divisor = 0;
	logic 		 Ready;
	logic [15:0] Result;
	logic [15:0] Reminder;

DIVIDER_module DUV
(
	.clk(clk),
	.rst(rst), 
	.start(start),
	.Dividendo(Dividendo),
	.Divisor(Divisor),
	
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
	#6 start = 0;
	Dividendo = 59;
	Divisor = 6;
	#10 start = 1;
	#20 start = 0;

end

/*********************************************************/


endmodule
