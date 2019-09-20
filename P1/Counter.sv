module Counter #(	parameter MAXIMUM_VALUE = 8,	parameter NBITS_FOR_COUNTER = CeilLog2(MAXIMUM_VALUE))
(
	// Input Ports
	input clk,
	input rst,
	input enable,
	input Sync_Reset,
	
	// Output Ports
	output flag
);

bit MaxValue_Bit;

logic [NBITS_FOR_COUNTER-1 : 0] Count_logic;

	always_ff@(posedge clk or negedge rst) begin: counter
		if (rst == 1'b0)
			Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
		else begin
				if(enable == 1'b1) begin
					if(Sync_Reset == 0)
					
						Count_logic <= Count_logic + 1'b1;
						
					else
						Count_logic <= 0;
						
				end
		end
	end: counter

//--------------------------------------------------------------------------------------------

always_comb
	if(Count_logic == MAXIMUM_VALUE-1)
		MaxValue_Bit = 1;
	else
		MaxValue_Bit = 0;

		
//---------------------------------------------------------------------------------------------
assign flag = MaxValue_Bit;

//----------------------------------------------------------------------------------------------

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
   
 /*Log Function*/
     function integer CeilLog2;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i < data; i=i+1)
             result = i + 1;
          CeilLog2 = result;
       end
    endfunction

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
endmodule
