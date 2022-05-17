module Flip_Flop(next_state,w,clk,rst);
	input clk,rst,w;
	output reg [3:0]next_state;

	reg [3:0]state;
	parameter S0 = 4'b0000 ,
			  S1 = 4'b0101 ,
			  S2 = 4'b0110 ,
			  S3 = 4'b0111 ,
			  S4 = 4'b1000 ,
			  S5 = 4'b0001 ,
			  S6 = 4'b0010 ,
			  S7 = 4'b0011 ,
			  S8 = 4'b0100 ;
		
	always @(posedge clk , negedge rst)
	begin
		if(rst == 1'b0)
		begin
			state 	   = S0;
			next_state = S0;
		end
			
		else
		begin
			case(state)
				S0 : if(w) next_state = S1 ; else next_state = S5;
				S5 : if(w) next_state = S1 ; else next_state = S6;
				S6 : if(w) next_state = S1 ; else next_state = S7;
				S7 : if(w) next_state = S1 ; else next_state = S8;
				S8 : if(w) next_state = S1 ; else next_state = S8;
				S1 : if(w) next_state = S2 ; else next_state = S5;
				S2 : if(w) next_state = S3 ; else next_state = S5;
				S3 : if(w) next_state = S4 ; else next_state = S5;
				S4 : if(w) next_state = S4 ; else next_state = S5;
			endcase
			state <= next_state;	
		end
	end
endmodule

module Sequence_Detector(z,w,clk,rst);
	output z;
	output [3:0]A;
	input w,clk,rst;

	//wire [3:0]A;
	wire a3,a2,a1,a0;
	wire p,q;
		
	Flip_Flop FF1(A,w,clk,rst);

	xor X1(a3,A[3],1'b1);
	xor X2(a2,A[2],1'b1);
	xor X3(a1,A[1],1'b1);
	xor X4(a0,A[0],1'b1);
	
	and A1(p,A[3],a2,a1,a0); 
	and A2(q,a3,A[2],a1,a0); 
	or O1(z,p,q);
	
endmodule

module q1a_tb();
	wire z;
	wire [3:0]A;
	reg w,clk,rst;
	Sequence_Detector S(z,w,clk,rst);
	
	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end
	
	initial begin
			rst = 1'b0 ; 
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b0;
			#10 rst = 1'b1 ; w = 1'b0;
			#10 rst = 1'b1 ; w = 1'b0;
			#10 rst = 1'b1 ; w = 1'b0;
			#10 rst = 1'b1 ; w = 1'b0;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b1;
			#10 rst = 1'b1 ; w = 1'b0;
			#10 rst = 1'b1 ; w = 1'b0;
	end
	
	
	initial begin
		forever
			#10 $display("%d :  z = %b , w = %b , clk = %b , rst = %b ",$time,z,w,clk,rst);
	end
	
	initial begin
		#220 $finish;
	end
	
	initial
	begin
		$dumpfile("q1a.vcd");
		$dumpvars(0,q1a_tb);
	end
endmodule



/*
		#10 rst = 1'b1 ; w = 1'b1;
		#10 rst = 1'b1 ; w = 1'b1;
		#10 rst = 1'b1 ; w = 1'b1;
		#10 rst = 1'b1 ; w = 1'b1;
		#10 rst = 1'b1 ; w = 1'b1;
		#10 rst = 1'b1 ; w = 1'b0;
		#10 rst = 1'b1 ; w = 1'b0;
		#10 rst = 1'b1 ; w = 1'b0;
		#10 rst = 1'b1 ; w = 1'b0;
		#10 rst = 1'b1 ; w = 1'b0;
		#10 rst = 1'b1 ; w = 1'b0;
		#10 rst = 1'b1 ; w = 1'b0;
		#10 rst = 1'b1 ; w = 1'b1;
		#10 rst = 1'b1 ; w = 1'b1;
		#10 rst = 1'b1 ; w = 1'b0;
*/