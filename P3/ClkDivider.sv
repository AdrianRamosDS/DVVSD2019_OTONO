module ClkDivider
#(
	parameter FRECUENCY = 115200, 								// parametro de frecuencia deseada
	parameter Maximum_Value = funct_div(FRECUENCY), 		// Valor maximo del contador 
	parameter NBitsForCounter = CeilLog2(Maximum_Value) 	// parametro correpondiente al tamaño de bits
)

(
	input clk,
	input rst,
	output Flag_toggle
);


bit MaxValue_Bit;
bit Flag_toggle_Bit=1'b0;

logic [NBitsForCounter-1 : 0] Counting_logic;

	always_ff@(posedge clk or negedge rst) begin
		if (rst == 1'b0)
		begin
			Counting_logic <= {NBitsForCounter{1'b0}};
			Flag_toggle_Bit <=1'b0;
		end //prmer if
		else begin
			if(MaxValue_Bit == 1'b1)
			begin
					Flag_toggle_Bit <= ~Flag_toggle_Bit;
					Counting_logic <= 0;
			end
			else
					Counting_logic <= Counting_logic + 1'b1;
		end
	end //always
//--------------------------------------------------------------------------------------------

always_comb
	if(Counting_logic == Maximum_Value-1)
			MaxValue_Bit = 1;
	
	else
		MaxValue_Bit = 0;

		
assign Flag_toggle = Flag_toggle_Bit;
   
/************************************************************************* 
* Frecuency Function
* Descripción: Función encargada de encontrar el valor maximo del contador
**************************************************************************/
     function integer funct_div;
       input integer data;
       integer result;
       begin
			 result = (50000000/data)/2;
          funct_div = result;
       end
    endfunction

/************************************************************************* 
* Log Function
* Descripción: Función encargada del tamaño de bits
**************************************************************************/
     function integer CeilLog2;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i < data; i=i+1)
             result = i + 1;
          CeilLog2 = result;
       end
    endfunction

/************************************************************************* 
**************************************************************************/ 
 
endmodule
