`timescale 1ps/1ps

module Decoder(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7);
input a,b,c;
output d0,d1,d2,d3,d4,d5,d6,d7;
wire abar, bbar, cbar;
not n1(abar, a);
not n2(bbar, b);
not n3(cbar, c);
and a1(d0, abar, bbar, cbar);
and a3(d1, abar, bbar, c);
and a5(d2, abar, b, cbar);
and a7(d3, abar, b, c);
and a9(d4, a, bbar, cbar);
and a11(d5, a, bbar, c);
and a13(d6, a, b, cbar);
and a15(d7, a, b, c);
endmodule

module decoder_tb ();

reg a, b, c;
wire d0,d1,d2,d3,d4,d5,d6,d7;
integer i=0;
Decoder dec1(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7);
wire [7:0] result;
assign result = {d0,d1,d2,d3,d4,d5,d6,d7};

initial begin
#0;
for(i=0; i<8; i++)
begin
c=i[0];
b=i[1];
a=i[2];
#1;
end
end

initial begin
$monitor("%0d\t%b%b%b \t %b",
$time,a,b,c,result); //to monitor changes
$dumpfile("q3.vcd");
$dumpvars(0,decoder_tb);
end

endmodule
