package uart_pkg;

localparam DW 		= 8;
localparam DW_DBL = 16;
localparam DW_FIFO = 8;	// FIFO DATA WIDTH
localparam AW_FIFO = 4;	// FIFO ADDRESS WIDTH
localparam AW_RAM = 3;	// RAM  ADDRESS WIDTH

typedef logic [3:0] 		 uint4_t;
typedef logic [7:0] 		 uint8_t;
typedef logic [15:0] 	 uint16_t;
typedef logic [31:0] 	 uint32_t;

endpackage
