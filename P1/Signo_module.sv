module Signo_module
(
	input signo_1,
	input signo_2,
	output signo
);

logic signo_operacion;

always_comb begin
		signo_operacion = signo_1 ^ signo_2;
end

assign signo = signo_operacion;

endmodule
