module Counter #(	parameter NBitsForCounter = 5)//CeilLog2(Maximum_Value)
(
	input clk, rst, enb, sync_rst,
	input [4:0] N_input,	//Sync_rst activo en alto

	output Flag,
	output[NBitsForCounter-1:0] Counting 
);

bit MaxValue_Bit;

logic [NBitsForCounter-1 : 0] Counting_logic;
logic [4 : 0] Maximum_Value;
assign Maximum_Value = N_input;


	always_ff@(posedge clk or negedge rst) begin
		if (rst == 1'b0)
		begin
			Counting_logic <= {NBitsForCounter{1'b0}};
		end
		else begin
				if(enb == 1'b1) begin
					if(sync_rst == 1'b1)
						
						Counting_logic <= 0;
						
					else if(Counting_logic == Maximum_Value)
					
						Counting_logic <= 0;
					else
					Counting_logic <= Counting + 1'b1;
				end
		end
	end

//--------------------------------------------------------------------------------------------
always_comb
	if(Counting_logic == Maximum_Value)
		MaxValue_Bit = 1;
	else
		MaxValue_Bit = 0;
//---------------------------------------------------------------------------------------------
assign Flag = MaxValue_Bit;

assign Counting = Counting_logic;
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
endmodule	//FIN DEL MÓDULO