//Behavioural array multiplier

module am_behavioural(A,B,Sum); //main module
  input [3:0]A,B;
  output reg[7:0] Sum;
  
  reg[5:0][3:0] t;
  reg[3:0][4:0] s;
  reg[2:0] cout;
  
  always@(A,B)
  begin
    t[0] = Product(A,B[0]);
    t[1] = Product(A,B[1]);
    t[2] = Product(A,B[2]);
    t[3] = Product(A,B[3]);
    
    s[0] = t[1] + {1'b0,t[0][3:1]};
    s[1] = t[2] + s[0][4:1];
    s[2] = t[3] + s[1][4:1];

    Sum[0] = t[0][0];
    Sum[1] = s[0][0];
    Sum[2] = s[1][0];
    Sum[7:3] = s[2];
  end


  function [3:0] Product(input [3:0]C,D); 
    begin
      Product[3] = C[3]&D;
      Product[2] = C[2]&D;
      Product[1] = C[1]&D;
      Product[0] = C[0]&D;
    end   
  endfunction

endmodule

module am_behavioural_tb;   //test_bench
  reg [3:0]A,B;
  wire [7:0]Product;
  
  am_behavioural product(A,B,Product);
  initial 
  begin
    #0 A=4'b0000;B=4'b0000;
    #30 $finish;
  end
  initial 
   begin
   $dumpfile ("q2.vcd");
   $dumpvars (0,am_behavioural_tb);
   end
  initial 
  begin
   $monitor("num1=%d num2=%d Product=%d",A,B,Product);
  end
  always
  begin
   #2 A = A + 1;
  end
   always
  begin
   #6 B = B + 3;
  end
endmodule
