//Booth Multiplier in behavioral style
//a - Multiplicand 
//b - Multiplier
//prod - {A, Q}
module booth_mul(a, b, p);
    input signed[3:0] a, b;
    output reg signed[7:0] p;
    reg[1:0] check;
    reg Q_1;
    integer i;
    
    always @(a,b)
        begin
            //Initialize valued for Prod & Q1
            p = 8'd0;
            Q_1 = 1'b0;
            p[3:0] = a;
            for(i = 0; i < 4; i = i + 1)
            begin
                //concat of q[0] & q[-1]
                check = {a[i], Q_1};
                if(check == 2'b10)
                    p[7:4] = p[7:4] - b;
                else if(check == 2'b01)
                    p[7:4] = p[7:4] + b;               
                //arithematic right shift
                p = p >>> 1;
                Q_1 = a[i];
            end
        end
endmodule

module BoothTB;
  // Inputs
  reg  [3:0] a;
  reg  [3:0] b;

  // Outputs
  wire [7:0] p;

  // Instantiate the Unit Under Test (UUT)
  booth_mul tb (.a(a),.b(b),.p(p));

  initial begin
    // Initialize Inputs
    #0 a=4'b0000;b=4'b0001;
    #30 $finish; 
  end

  initial begin
    $dumpfile("booth.vcd");
    $dumpvars(0, BoothTB);
    $monitor("x = %d \ty = %d\t\tproduct = %d ", a, b, p);
  end

  always begin 
    #4 a+=1;
  end 
  always begin
    #5 b+=1;
  end 

endmodule
