module simple_dual_port_ram_single_clock_16bits
import mxv_pkg::*;
(
	input clk, we,
	input uint16_t data,
	input [(AW_RAM-1):0] read_addr, write_addr,
	output uint16_t q
);

uint16_t ram[2**AW_RAM-1:0];

always_ff @ (posedge clk) begin
	if (we)
		ram[write_addr] <= data;
	q <= ram[read_addr];
end
	
endmodule
