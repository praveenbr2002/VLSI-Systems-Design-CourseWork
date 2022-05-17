module Type_wand(A,y);
input A;
output y;
wand k;
supply0 B;
assign k = A & B;
assign k = A | B;
assign y = k;
endmodule

module Type_wor(A,y);
input A;
output y;
wor k;
supply1 B;
assign k = A & B;
assign k = A | B;
assign y = k;
endmodule

module oq_tb;
reg A,B;
wire x,y;
Type_wor t1(A,x);
Type_wand t2(B,y);
initial
begin
A = 1;
B = 1;
end
initial
begin
$monitor("WOR    A=%b x=%b\nWAND   B=%b y=%b",A,x,B,y);
end
endmodule