module TB_Multiplicator_module;

	logic clk = 0;
	logic rst;
	logic start;
	logic [16-1:0] Multiplicando = 0;
	logic [16-1:0] Multiplicador = 0;
	
	logic [16-1:0] Result;

Multiplicator_module DUV
(
	.clk(clk),
	.rst(rst), 
	.start(start),
	.Multiplicando(Multiplicando),
	.Multiplicador(Multiplicador),
	
	.Result(Result)
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
	Multiplicando = 152;
	Multiplicador = 20;
	#10 start = 1;

end

/*********************************************************/


endmodule
