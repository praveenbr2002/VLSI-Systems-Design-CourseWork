module full_adder(a,b,cin,sum,cout); 

input a,b,cin;
output cout,sum;
wire s1,s2,s3; 

xor(s1,a,b);
and(s2,a,b);
xor(sum,s1,cin);
and(s3,s1,cin);
or(cout,s3,s2); 
endmodule

module ripple_carry_adder(a,b,cin,cout,sum); 
input [3:0]a,b;
input cin; 
output [3:0]sum; 
output cout; 
wire t[3:0];
full_adder f1(a[0],b[0],cin,sum[0],t[0]);
full_adder f2(a[1],b[1],t[0],sum[1],t[1]);
full_adder f3(a[2],b[2],t[1],sum[2],t[2]);
full_adder f4(a[3],b[3],t[2],sum[3],cout); 
endmodule


module rca_tb; 
reg [3:0]a,b; 
reg cin;
wire [3:0]sum; 
wire cout;
ripple_carry_adder ra(a,b,cin,cout,sum); 
initial begin
#0 a=4'b0100;b=4'b0001;cin=0;
#10 $finish; 
end
initial begin
$monitor("num1=%d num2=%d cin=%b sum=%d cout=%b",a,b,cin,sum,cout);
end 
initial begin
$dumpfile ("ra.vcd");
$dumpvars (0,ra); 
end
always begin #1 a+=1;
end 
always begin
#2 b+=1;
end 
always begin
#4 cin+=1;
end 
endmodule

