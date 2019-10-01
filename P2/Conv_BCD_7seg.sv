module Conv_BCD_7seg
(
	// Input Ports
	input [3:0]BCD_in,

	// Output Ports
	output [6:0]segmentos

);

 logic[6:0]segment;

//Case encargado de mostrar el numero correspondiente de la entra al display
always_comb
begin
//Solamente tomamos los casos desde 0 hasta 9
	case (BCD_in)
		0 : segmentos = 7'b1000000;
      1 : segmentos = 7'b1111001;
      2 : segmentos = 7'b0100100;
      3 : segmentos = 7'b0110000;
		4 : segmentos = 7'b0011001;
      5 : segmentos = 7'b0010010;
      6 : segmentos = 7'b0000010;
      7 : segmentos = 7'b1111000;
      8 : segmentos = 7'b0000000;
      9 : segmentos = 7'b0010000;
      default : segmentos = 7'b1111111; //Si no esta dentro del rango, se apaga el display
    endcase
end

assign segmentos = segmentos;

endmodule
