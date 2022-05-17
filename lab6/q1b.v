module Sequence_Detector(z,w,clk,rst);
	output reg z;
	input w,clk,rst;
	
	reg[4:0] state,next_state;
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
			state <= S0;
		else
			state <= next_state;
	end
	
	always @(state,w)
	begin
		case(state)
			S0 : if(w) next_state = S1; else next_state = S5;
			S1 : if(w) next_state = S2; else next_state = S5;
			S2 : if(w) next_state = S3; else next_state = S5;
			S3 : if(w) next_state = S4; else next_state = S5;
			S4 : if(w) next_state = S1; else next_state = S0;
			S5 : if(w) next_state = S1; else next_state = S6;
			S6 : if(w) next_state = S1; else next_state = S7;
			S7 : if(w) next_state = S1; else next_state = S8;
			S8 : if(w) next_state = S1; else next_state = S0;
		endcase
	end
	
	always @(state,w)
	begin	
		case(state)
			S7 : if(w == 1'b0) z = 1'b1; else z = 1'b0;
			S3 : if(w)  z = 1'b1; else z = 1'b0;
			S0,S1,S2,S4,S5,S6,S8 : z = 1'b0;
		endcase
	end
endmodule


module q1b_tb();
	wire z;
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
			#10 $display("%d : z = %b , w = %b , clk = %b , rst = %b ",$time,z,w,clk,rst);
	end
	
	initial begin
		#200 $finish;
	end
    initial
	begin
		$dumpfile("q1b.vcd");
		$dumpvars(0,q1b_tb);
	end
endmodule