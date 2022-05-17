//behavioural

module mux41_bs (  input w0, 
                input w1,
                input w2,
                input w3, 
                input [1:0] sel,
                output reg [3:0] out);
   always @ (w0 or w1 or w2 or w3 or sel) begin  
      case (sel)  
         2'b00 : out <= {w3, w2, w1, w0};  
         2'b01 : out <= {w0, w3, w2, w1};  
         2'b10 : out <= {w1, w0, w3, w2};  
         2'b11 : out <= {w2, w1, w0, w3};  
      endcase  
   end  
endmodule  


//structural
module mx41_bs(w0, w1, w2, w3, sel, out );
output [3:0]out;
input w0, w1, w2, w3, s1, s2;
input [1:0] sel;
wire s0bar, s1bar, T1, T2, T3, T4;
wire [3:0]E1;
wire [3:0]E2;
wire [3:0]E3;
wire [3:0]E4;

assign E0 = {w3, w2, w1, w0};
assign E1 = {w0, w3, w2, w1};
assign E2 = {w1, w0, w3, w2};
assign E3 = {w2, w1, w0, w3};

assign out = (sel[0] == sel[1]) ? ((sel[0] == 0) ? E0 : E3) : ((sel[0] == 0) ? E2 : E1) ;
/*
not u1(s1bar, sel[1]);
not u2(s0bar, sel[0]);
and u3(T1, E0, s0bar, s1bar);
and u4(T2, E1, s0, s1bar);
and u5(T3, E2, s0bar, s1);
and u6(T4, E3, s0, s1);
or u7(out, T1, T2, T3, T4); 
*/
endmodule

module bs_tb;
  // Initialization
  reg [3:0] w;  
  reg [1:0] x;
  wire [3:0] y;

  // Instantiate the Unit Under Test (UUT)
  //mux41_bs tb1(w[0],w[1],w[2],w[3],x,y);
  mx41_bs tb2(w[0],w[1],w[2],w[3],x,y);

  initial begin
    // Initialize Inputs
    #0 w=4'b0001;x=2'b00;
    #19 
    $finish; 
  end

  always begin 
    #4 w+=3; //$monitor("\n");
  end 

  always begin
    #1 x+=1;
  end 
  
  initial begin
    $dumpfile("q1.vcd");
    $dumpvars(0, bs_tb);
    $monitor("w = %b \tx = %b\t\ty = %b ", w, x, y);
  end

endmodule