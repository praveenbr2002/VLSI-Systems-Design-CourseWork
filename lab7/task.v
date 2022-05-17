module q3_tb;
reg [2:0] A,B,Sum;
task add;
input [2:0] A;
input [2:0] B;
output [2:0] Sum;
begin
Sum = A + B;
end
endtask
initial
begin
A = 3'b100;B = 3'b001;
add(A,B,Sum);
end
initial
begin
$monitor("A = %b = %b Sum=%b",A,B,Sum);
end
endmodule