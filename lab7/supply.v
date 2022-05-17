module supply_type(Output);
	output Output;
	supply0 A;
	supply1 B;
	
	assign Output = A | B;
endmodule


module supply_tb();
	wire Output;
	
	supply_type S1 (Output);
	
	initial begin
		$monitor ("Output=%b",Output);
	end
endmodule