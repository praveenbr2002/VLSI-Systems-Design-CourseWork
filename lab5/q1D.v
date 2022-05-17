module d_flipflop(D,clock,reset,Q);
	input wire D,clock,reset;
	output reg Q;
	
	always @(posedge clock) begin
		if(reset) begin
			Q<=1'b0;
		end
		else begin
			Q<=D;
		end
	end
endmodule

module D_ff_tb();

	reg D,clock,reset;
	wire Q;
	
	always begin
		#10 clock=~clock;
	end
	
	initial begin
		D=0;reset=1; clock=1;
		#20 D=0;reset=0; 
		#20 D=1;reset=0;
		#20
	$finish;
	end
	
	initial begin
		$monitor("D = %b Clock = %b reset = %b Q = %b",D,clock,reset,Q);
	end

	d_flipflop DFF (D,clock,reset,Q);

	initial begin
		$dumpfile("D.vcd");
		$dumpvars(0,DFF);
	end
endmodule;