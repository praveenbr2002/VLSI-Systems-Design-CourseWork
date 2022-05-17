`timescale 1ps/1ps

module MUX(w1, w2, w3, w4, sel0, sel1, y);
     input w1, w2, w3, w4;
     input sel0, sel1;
     output y;
     wire negsel0, negsel1;
     wire r1, r2, r3, r4;

     assign negsel0 = ~sel0;
     assign negsel1 = ~sel1;

     and a0(r1,sel0,sel1,w4);
     and a1(r2,sel0,negsel1,w3);
     and a2(r3,negsel0,sel1,w2);
     and a3(r4,negsel0,negsel1,w1);
     or o1(y, r1, r2, r3, r4);

endmodule


module que1_2(M, sel0, sel1, y);
    input [3:0] M;
    input sel0, sel1;
    output [3:0] y;
    wire y1, y2, y3, y4;
    reg w1, w2, w3, w4;
    wire [1:0] sel;
    assign sel = {sel0, sel1};

    always @ (*) begin

        case(sel)
            2'b00: begin
                w1 = M[1]; // 1
                w2 = M[2]; // 1
                w3 = M[3]; // 0
                w4 = 0;    // 1
            end
            2'b01: begin
                w1 = M[2]; // 1
                w2 = 0;    // 1
                w3 = M[0]; // 0
                w4 = M[1]; // 1
            end
            2'b10: begin
                w1 = M[3]; // 1
                w2 = M[0]; // 1
                w3 = M[1]; // 0
                w4 = M[2]; // 1
            end
            2'b11: begin
                w1 = M[0]; // 1
                w2 = M[1]; // 1
                w3 = M[2]; // 0
                w4 = M[3]; // 1
            end
        endcase

    end

    MUX mux1(w1, w2, w3, w4, sel0, sel1, y1); // 0
    MUX mux2(w2, w3, w4, w1, sel0, sel1, y2); // 1
    MUX mux3(w3, w4, w1, w2, sel0, sel1, y3); // 2
    MUX mux4(w4, w1, w2, w3, sel0, sel1, y4); // 3

    assign y[0] = y1;
    assign y[1] = y2;
    assign y[2] = y3;
    assign y[3] = y4;

endmodule


module que12_tb;
  reg[3:0] w;
  reg sel0, sel1;
  wire [3:0] y;

	que1_2 op(w, sel0, sel1, y);

	initial begin

	#0  w=4'b1011;sel0=1'b0;sel1=1'b0;
    #1  w=4'b1011;sel0=1'b0;sel1=1'b1;
    #1  w=4'b1011;sel0=1'b1;sel1=1'b0;
    #1  w=4'b1011;sel0=1'b1;sel1=1'b1;
    #1
    $finish;

	end

	initial begin

    $dumpfile("q1.vcd");
    $dumpvars(0,que12_tb);
	$monitor("w=%b \t s=%b%b \ty=%b ",w,sel0,sel1,y);

	end
endmodule
