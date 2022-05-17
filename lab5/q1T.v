module t_flipflop(T,clock,reset,Q);
	input wire T,clock,reset;
	output reg Q;
	
	always @(posedge clock) begin
		if(reset) begin
			Q<=1'b0;
		end
		else begin
			case(T)
				1'b0: begin
					Q<=Q;
				end
				1'b1: begin
					Q<=~Q;
				end
			endcase
		end
	end
endmodule

module T_ff_tb();

	reg T,clock,reset;
	wire Q;
	
	always begin
		#10 clock=~clock;
	end
	
	initial begin
		T=0;reset=1; clock=1;
		#20 T=0;reset=0; 
		#20 T=1;reset=0;
		#20
	$finish;
	end
	
	initial begin
		$monitor("T = %b Clock = %b reset = %b Q = %b",T,clock,reset,Q);
	end

	t_flipflop TFF (T,clock,reset,Q);

	initial begin
		$dumpfile("T.vcd");
		$dumpvars(0,TFF);
	end
endmodule;