module jk_flipflop(J,K,clock,reset,Q);
	input wire J,K,clock,reset;
	output reg Q;
	
	always @(posedge clock) begin
		if(reset) begin
			Q<= 1'b0;
		end
		else begin
			case({J,K})
				2'b00: begin
					Q<=Q;
				end
				2'b01: begin
					Q<=1'b0;
				end
				2'b10: begin
					Q<=1'b1;
				end
				2'b11: begin
					Q<=~Q;
				end
			endcase
		end
	end
endmodule

module JK_ff_tb();

	reg J,K,clock,reset;
	wire Q;
	
	always begin
		#10 clock=~clock;
	end
	
	initial begin
		#0 J=0;K=0;reset=1; clock=1;
		#5 J=0;K=0;reset=0; 
		#5 J=0;K=1;reset=0; 
		#5 J=1;K=0;reset=0; 
		#5 J=1;K=1;reset=0;
		#5
	$finish;
	end
	
	initial begin
		$monitor("J =%b \tK = %b \tClock = %b \treset = %b \tQ = %b",J,K,clock,reset,Q);
	end

	jk_flipflop JKFF (J,K,clock,reset,Q);

	initial begin
		$dumpfile("JK.vcd");
		$dumpvars(0,JKFF);
	end
endmodule;