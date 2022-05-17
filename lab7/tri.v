module Type_tri(A,B,y);
input A,B;
output y;
tri z;
assign z = A;
assign z = B;
assign y = z;
endmodule
module test;
reg A,B;
wire y;
Type_tri t1(A,B,y);
initial
begin
#10 A = 1;B= 1'bz;
#10 A = 1'bz ;B =0;
end
initial
begin
$monitor("A = %b B =%b y = %b",A,B,y);
end
endmodule