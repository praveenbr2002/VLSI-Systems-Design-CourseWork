module Run_Length_Encoding(arr,op);
input [3:0][3:0] arr;
output reg [47:0] op;
reg previous,present,insert=0;
integer i,j,index;
reg size;
reg [1:0] count;
reg [3:0] Temp;
always@(*)
begin
op = 0;
size =4;
index = 47;
$display("\nValue    0 - Black    1 - White");
$display("Count    00 - 1    01 - 2    10 - 3   11 - 4");
for(i = 0;i<4;i = i + 1)
begin
Temp = arr[i];
for(j = 3;j>=0; j = j - 1)
begin
count = 0;

while((j>0) && (Temp[j] == Temp[j - 1]))
begin
j = j - 1;
count = count + 1;
end

$display("%b(value) - %b(count) \t\t row - %d",Temp[j],count+1'b1,i + 1);
op[index]= Temp[j];
index = index - 1;
{op[index],op[index - 1]} = count;
index = index - 2;
end
end
end
endmodule

module RLE_test_bench;
reg [3:0][3:0] Input;
wire [47:0] Output;
Run_Length_Encoding R1(Input,Output);
initial
begin
#0  Input[0] = 4'b1111;Input[1] = 4'b1110;Input[2] = 4'b1101;Input[3] =4'b1000;
#10 Input[0] = 4'b0100;Input[1] = 4'b1000;Input[2] = 4'b1100;Input[3] =4'b0111;
#10 Input[0] = 4'b0000;Input[1] = 4'b0001;Input[2] = 4'b0010;Input[3] =4'b0111;
#10 Input[0] = 4'b1011;Input[1] = 4'b0111;Input[2] = 4'b0011;Input[3] =4'b1000;
#10 $finish;
end
initial
begin
$monitor("The 2-D Matrix is :\n%b\n%b\n%b\n%b\n",Input[0],Input[1],Input[2],Input[3],"48-bit output of the above matrix is : %b",Output);
end
initial
begin
$dumpfile("RLE.vcd");
$dumpvars(0,RLE_test_bench);
end
endmodule