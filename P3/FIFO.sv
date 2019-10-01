module FIFO
import mxv_pkg::*;
(
	input	clk,	rst,	push,	 pop,
	input [DW_FIFO-1:0]	DataInput,
	output full, empty,
	output [DW_FIFO-1:0]	DataOutput
);

wire [AW_FIFO-1:0]address_Read;
wire [AW_FIFO-1:0]address_Write;
wire [AW_FIFO-1:0]element_number_wire;

simple_dual_port_ram_single_clock Memoria_RAM
(
	.clk(clk),	.we(push_input&~full),	.data(DataInput),	.read_addr(address_Read),	.write_addr(address_Write),
	.q(DataOutput)
);

Contador_lineal #(	.Maximum_Value(2**AW_FIFO-1)) contador_pop_modulo
(
	.clk(clk),	.rst(rst),	.enb(pop_input&~empty),	.sync_rst(1'b0),	
	.Flag(),		.Counting(address_Read) 
);

Contador_lineal #(	.Maximum_Value(2**AW_FIFO-1)) contador_push_modulo
(
	.clk(clk),	.rst(rst),	.enb(push_input&~full),	.sync_rst(1'b0),
	.Flag(),		.Counting(address_Write) 
);

Contador_circular #(	.Maximum_Value(2**AW_FIFO-1)) contador_NumTotal_modulo
(
	.clk(clk),	.rst(rst),	.enb((push_input&~full) | (pop_input&~empty)),	.sync_rst(1'b0),	.op(push_input),
	.Flag(),		.Counting(element_number_wire) 
);

assign empty = (element_number_wire == {(2**AW_FIFO-1){1'b0}})?1'b1:1'b0;
assign full = (element_number_wire == {(AW_FIFO){1'b1}})?1'b1:1'b0;

endmodule	
