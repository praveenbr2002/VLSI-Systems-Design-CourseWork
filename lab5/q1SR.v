module sr_flipflop(S,R,clock,reset,Q);
	input wire S,R,clock,reset;
	output reg Q;
	
	always @(posedge clock) begin
		if(reset) begin
			Q<= 1'b0;
		end
		else begin
			case({S,R})
				2'b00: begin
					Q<=Q;
				end
				2'b01: begin
					Q<=1'b0;
				end
				2'b10: begin
					Q<=1'b1;
				end
				default: begin
					Q<=1'bx;
				end
			endcase
		end
	end
endmodule

module SR_tb();

	reg S,R,clock,reset;
	wire Q;
	
	always begin
		#10 clock=~clock;
	end
	
	initial begin
		S=0;R=0;reset=1; clock=1;
		#5 S=0;R=0;reset=0; 
		#5 S=0;R=1;reset=0; 
		#5 S=1;R=0;reset=0; 
		#5 S=1;R=1;reset=0;
		#5
	$finish;
	end
	
	initial begin
		$monitor("S =%b \tR = %b\t Clock = %b\t reset = %b\t Q = %b",S,R,clock,reset,Q);
	end

	sr_flipflop SRFF (S,R,clock,reset,Q);

	initial begin
		$dumpfile("SR.vcd");
		$dumpvars(0,SRFF);
	end
endmodule;