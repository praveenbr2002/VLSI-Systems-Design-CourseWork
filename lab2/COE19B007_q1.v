//Structural array multiplier
module fa(a,b,cin,sum,cout);  //module for full adder
  input a,b,cin;
  output cout,sum;
  
  wire s1,s2,s3;
  xor(s1,a,b);
  and(s2,a,b);
  xor(sum,s1,cin);
  and(s3,s1,cin);
  or(cout,s3,s2);
endmodule

module rca(A,B,Cin,Cout,Sum); //module for 4 bit ripple carry adder
  input [3:0]A,B;
  input Cin;
  output [3:0]Sum;
  output Cout;
  wire t[3:0];
  
  fa f1(A[0],B[0],Cin,Sum[0],t[0]);
  fa f2(A[1],B[1],t[0],Sum[1],t[1]);
  fa f3(A[2],B[2],t[1],Sum[2],t[2]);
  fa f4(A[3],B[3],t[2],Sum[3],Cout);
endmodule

module mul(A,B,Product);  //module for 4*1 multiplier
  input [3:0]A;
  input B;
  output [3:0]Product;
  
  and a1(Product[3],A[3],B);
  and a2(Product[2],A[2],B);
  and a3(Product[1],A[1],B);
  and a4(Product[0],A[0],B);
endmodule 


module am_structural(A,B,Sum);  //main module
  input [3:0]A,B;
  output [7:0]Sum;
  wire [3:0]t1,t2,s1,t3,t4,t5,s2,t6,s3;
  wire [3:0]Cout;
  wire cin=1'b0;
 
  and a1(Sum[0],A[0],B[0]);
  and a2(t1[0],A[1],B[0]);
  and a3(t1[1],A[2],B[0]);
  and a4(t1[2],A[3],B[0]);
  assign t1[3]=0;
  
  mul m1(A,B[1],t2);  //first rca program
  rca f1(t1,t2,cin,Cout[0],s1);
  assign Sum[1] = s1[0];
  assign t5 = {Cout[0],s1[3:1]};
  
  mul m2(A,B[2],t3);  //second rca program
  rca f2(t5,t3,cin,Cout[1],s2);
  assign Sum[2] = s2[0];
  assign t6 = {Cout[1],s2[3:1]};
  
  mul m3(A,B[3],t4);  //third rca program
  rca f3(t6,t4,cin,Cout[2],s3);
  assign Sum[6:3] = s3;
  assign Sum[7] = Cout[2];
  
endmodule


module am_structural_tb;  //test_bench
  reg [3:0]A,B;
  wire [7:0]Product;
  
  am_structural product(A,B,Product);
  initial 
  begin
    #0 A=4'b0000;B=4'b0001;
    #75 $finish;
  end
  initial 
   begin
   $dumpfile ("q1.vcd");
   $dumpvars (0,am_structural_tb);
   end
  initial 
  begin
   $monitor("num1=%d num2=%d Product=%d",A,B,Product);
  end
  always
  begin
   #5 A = A + 1;
  end
   always
  begin
   #15 B = B + 3;
  end
  
endmodule
