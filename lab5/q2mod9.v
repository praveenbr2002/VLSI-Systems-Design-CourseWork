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


module mod9_Counter(reset,Q,clock);
input clock,reset;
output [3:0] Q;
wire t1,t2,t3;
and(t1,Q[0],Q[1]);
and(t2,t1,Q[2]);
or(t3,t2,Q[3]);

t_flipflop T_1(~Q[3],clock,reset,Q[0]);
t_flipflop T_2(Q[0],clock,reset,Q[1]);
t_flipflop T_3(t1,clock,reset,Q[2]);
t_flipflop T_4(t3,clock,reset,Q[3]);
endmodule

module mod9_tb;
reg clock,reset;
wire [3:0] Q;
mod9_Counter M1(reset,Q,clock);
initial
begin
    #0 clock = 1;reset = 1;
    #1 reset = 0;
    #50 $finish;
end
always
begin
    #2 clock = ~clock;
end
initial
begin
    $monitor($time," \tQ = %d \tclock = %b",Q,clock);
end
initial
begin
$dumpfile("mod_9.vcd");
$dumpvars(0,mod9_tb);
end
endmodule
