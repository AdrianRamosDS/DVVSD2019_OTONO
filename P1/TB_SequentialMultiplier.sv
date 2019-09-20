module TB_SequentialMultiplier;
//import seq_mult_pkg::*;

	logic clk=0;
	logic rst; 
	logic start = 1;
	logic [7:0] Multiplicand_INPUT = 0;
	logic [7:0] Multiplier_INPUT = 0;
	
	logic Ready;
	logic [15:0] Producto;

SequentialMultiplier
DUV
(
	.clk(clk),
	.rst(rst), 
	.start(start),
	.Multiplicand_INPUT(Multiplicand_INPUT),
	.Multiplier_INPUT(Multiplier_INPUT),
	
	.Ready(Ready),
	.Producto(Producto)
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
	Multiplicand_INPUT = -127;
	Multiplier_INPUT = 71;
	#10 start = 1;

end

/*********************************************************/


endmodule
