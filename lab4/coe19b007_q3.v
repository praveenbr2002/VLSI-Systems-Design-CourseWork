`timescale 1ps/1ps

module encoder(in0, in1, in2, in3, in4, in5, in6, in7, res);
    input in0, in1, in2, in3, in4, in5, in6, in7;
    output [2:0] res;

    wire in0bar, in1bar, in2bar;

    assign in0bar = ~in0;
    assign in1bar = ~in1;
    assign in2bar = ~in2;

    or o0(res[2],in0, in1, in2, in3);
    or o1(res[1],in0, in1, in4, in5);
    or o2(res[0],in0, in2, in4, in6);


endmodule


module enc_tb;
  reg s0, s1, s2, s3, s4, s5, s6, s7;
  wire [2:0] res;
  wire [7:0]input1;

	encoder en(s0, s1, s2, s3, s4, s5, s6, s7, res);
    assign input1 = {s0,s1,s2,s3,s4,s5,s6,s7};
	initial begin

	#0  s0=1'b0; s1=1'b0; s2=1'b0; s3=1'b0; s4=1'b0; s5=1'b0; s6=1'b0; s7=1'b1;
    #1  s0=1'b0; s1=1'b0; s2=1'b0; s3=1'b0; s4=1'b0; s5=1'b0; s6=1'b1; s7=1'b0;
    #1  s0=1'b0; s1=1'b0; s2=1'b0; s3=1'b0; s4=1'b0; s5=1'b1; s6=1'b0; s7=1'b0;
    #1  s0=1'b0; s1=1'b0; s2=1'b0; s3=1'b0; s4=1'b1; s5=1'b0; s6=1'b0; s7=1'b0;
    #1  s0=1'b0; s1=1'b0; s2=1'b0; s3=1'b1; s4=1'b0; s5=1'b0; s6=1'b0; s7=1'b0;
    #1  s0=1'b0; s1=1'b0; s2=1'b1; s3=1'b0; s4=1'b0; s5=1'b0; s6=1'b0; s7=1'b0;
    #1  s0=1'b0; s1=1'b1; s2=1'b0; s3=1'b0; s4=1'b0; s5=1'b0; s6=1'b0; s7=1'b0;
    #1  s0=1'b1; s1=1'b0; s2=1'b0; s3=1'b0; s4=1'b0; s5=1'b0; s6=1'b0; s7=1'b0;

	end

	initial begin

    $dumpfile("q4.vcd");
    $dumpvars(0,enc_tb);
	$monitor("%d\t %b%b%b%b%b%b%b%b\t %b ",$time,s0, s1, s2, s3, s4, s5, s6, s7, res);

	end
endmodule
