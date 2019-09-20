module BCDa7segmentos
(
	// Input Ports
	input [15:0] A_input,

	// Output Ports
	output [3:0] DecMillar,
	output [3:0] UniMillar,
	output [3:0] Centenas,
	output [3:0] Decenas,
	output [3:0] Unidades
);


wire [3:0] C1_wire, C2_wire, C3_wire, C4_wire, C5_wire, C6_wire, C7_wire, C8_wire, C9_wire, C10_wire, C11_wire, C12_wire, C13_wire, C14_wire, C15_wire, C16_wire;
wire [3:0] C17_wire, C18_wire, C19_wire, C20_wire, C21_wire, C22_wire, C23_wire, C24_wire, C25_wire, C26_wire, C27_wire, C28_wire, C29_wire, C30_wire, C31_wire, C32_wire, C33_wire, C34_wire;

//Se crea una conexion de 7 modulos, donde recorremos en uno la posicion
//Con esto, podemos ir sumando un 3 si el numero que entra al modulo es mayor o igual a 5
Corrimiento C1(
	.A_input({1'b0,A_input[15:13]}),
	.B_output(C1_wire)
);

Corrimiento C2(
	.A_input({C1_wire[2:0],A_input[12]}),
	.B_output(C2_wire)
);

Corrimiento C3(
	.A_input({C2_wire[2:0],A_input[11]}),
	.B_output(C3_wire)
);

Corrimiento C4(
	.A_input({C3_wire[2:0],A_input[10]}),
	.B_output(C4_wire)
);

Corrimiento C5(
	.A_input({C4_wire[2:0],A_input[9]}),
	.B_output(C5_wire)
);

Corrimiento C6(
	.A_input({C5_wire[2:0], A_input[8]}),
	.B_output(C6_wire)
);

Corrimiento C7(
	.A_input({C6_wire[2:0], A_input[7]}),
	.B_output(C7_wire)
);

Corrimiento C8(
	.A_input({C7_wire[2:0], A_input[6]}),
	.B_output(C8_wire)
);

Corrimiento C9(
	.A_input({C8_wire[2:0], A_input[5]}),
	.B_output(C9_wire)
);

Corrimiento C10(
	.A_input({C9_wire[2:0], A_input[4]}),
	.B_output(C10_wire)
);

Corrimiento C11(
	.A_input({C10_wire[2:0], A_input[3]}),
	.B_output(C11_wire)
);

Corrimiento C12(
	.A_input({C11_wire[2:0], A_input[2]}),
	.B_output(C12_wire)
);

Corrimiento C13(
	.A_input({C12_wire[2:0], A_input[1]}),
	.B_output(C13_wire)
);

Corrimiento C14(
	.A_input({1'b0, C1_wire[3],C2_wire[3],C3_wire[3]}),
	.B_output(C14_wire)
);


Corrimiento C15(
	.A_input({C14_wire[2:0],C4_wire[3]}),
	.B_output(C15_wire)
);


Corrimiento C16(
	.A_input({C15_wire[2:0],C5_wire[3]}),
	.B_output(C16_wire)
);

Corrimiento C17(
	.A_input({C16_wire[2:0],C6_wire[3]}),
	.B_output(C17_wire)
);

Corrimiento C18(
	.A_input({C17_wire[2:0],C7_wire[3]}),
	.B_output(C18_wire)
);

Corrimiento C19(
	.A_input({C18_wire[2:0],C8_wire[3]}),
	.B_output(C19_wire)
);


Corrimiento C20(
	.A_input({C19_wire[2:0],C9_wire[3]}),
	.B_output(C20_wire)
);

Corrimiento C21(
	.A_input({C20_wire[2:0],C10_wire[3]}),
	.B_output(C21_wire)
);

Corrimiento C22(
	.A_input({C21_wire[2:0],C11_wire[3]}),
	.B_output(C22_wire)
);

Corrimiento C23(
	.A_input({C22_wire[2:0],C12_wire[3]}),
	.B_output(C23_wire)
);

Corrimiento C24(
	.A_input({1'b0,C14_wire[3],C15_wire[3], C16_wire[3]}),
	.B_output(C24_wire)
);

Corrimiento C25(
	.A_input({C24_wire[2:0],C17_wire[3]}),
	.B_output(C25_wire)
);

Corrimiento C26(
	.A_input({C25_wire[2:0],C18_wire[3]}),
	.B_output(C26_wire)
);

Corrimiento C27(
	.A_input({C26_wire[2:0],C19_wire[3]}),
	.B_output(C27_wire)
);


Corrimiento C28(
	.A_input({C27_wire[2:0],C20_wire[3]}),
	.B_output(C28_wire)
);

Corrimiento C29(
	.A_input({C28_wire[2:0],C21_wire[3]}),
	.B_output(C29_wire)
);

Corrimiento C30(
	.A_input({C29_wire[2:0],C22_wire[3]}),
	.B_output(C30_wire)
);

Corrimiento C31(
	.A_input({1'b0,C24_wire[3],C25_wire[3],C26_wire[3]}),
	.B_output(C31_wire)
);

Corrimiento C32(
	.A_input({C31_wire[2:0],C27_wire[3]}),
	.B_output(C32_wire)
);

Corrimiento C33(
	.A_input({C32_wire[2:0],C28_wire[3]}),
	.B_output(C33_wire)
);

Corrimiento C34(
	.A_input({C33_wire[2:0],C29_wire[3]}),
	.B_output(C34_wire)
);

assign Centenas = {C30_wire[2:0],C23_wire[3]};
assign Decenas = {C23_wire[2:0],C13_wire[3]};
assign Unidades = {C13_wire[2:0],A_input[0]};
assign UniMillar = {C34_wire[2:0],C30_wire[3]};
assign DecMillar = {C31_wire[3],C32_wire[3],C33_wire[3],C34_wire[3]};


endmodule
