//Arithmetic Logic Unit
//  a, b - Inputs
//  out - Output
//  cf - Carry Out
//  zf -  Zero flag
//  nf - Negative or Sign flag
//  pf - Parity flag
//  of - Overflow flag
module alu8(a, b, sel, out, cf, zf, nf, pf, of);
    input [7:0] a, b;
    input [3:0] sel;
    output cf, zf, nf, pf, of;
    reg zf, pf, of;
    output [7:0] out;
    integer count;
    reg [8:0] a_reg;
    reg [8:0] result;
    wire temp;
    assign out = result[7:0];
    assign cf = result[8];
    assign nf = result[7];

    always @(*)
    begin
        zf = 1'b0;
        pf = 1'b0;
        of = 1'b0;
        case (sel)
            4'd0:
                result = a + b; // Addition
            4'd1:
                result = a - b; // Subtraction 
            4'd2:
                result = a * b; // Multiplication
            4'd3:
                result = a / b; // Division
            4'd4:
                result = a & b; // Bitwise AND
            4'd5:
                result = a | b; // Bitwise OR
            4'd6:
                result = a ^ b; // Bitwise XOR
            4'd7:
                result = ~(a | b); // Bitwise NAND
            4'd8:
                result = ~(a & b); // Bitwise NOR
            4'd9:
                result = ~(a ^ b); // Bitwise XNOR
            4'd10:
                result = a << b; // Left Shift
            4'd11:
                result = a >> b; // Right shift
            4'd12:
                begin   // Rotate Left with Carry
                    a_reg = a;
                    for(integer i = 0; i < b; i++)
                    begin
                        a_reg = {a_reg[6:0], a_reg[7]};
                    end 
                    result = a_reg;
                end
            4'd13:
                begin   // Rotate Left with Carry
                    a_reg = a;
                    for(integer i = 0; i < b; i++)
                    begin
                        a_reg = {a_reg[0], a_reg[7:1]};
                    end 
                    result = a_reg;
                end       
            4'd14:
                result = (a == b) ? 8'd1 : 8'd0;
        endcase

        if(out == 8'd0)
            zf = 1'b1;

        count = 1'b0;
        for(integer j = 0; j < 8; j++) begin
            if(result[j] == 1'b1)
                count++;
        end
        if(count % 2 == 0)
            pf = 1'b1;

        if(a[7] == b[7]) begin
            if(result[7] != a[7])
                of = 1'b1;
        end
    end

endmodule

module alu8_tb;
    reg[7:0] a, b;
    reg[3:0] sel;

    wire[7:0] out;
    wire cf, zf, nf, pf, of;

    alu8 alu1(a, b, sel, out, cf, zf, nf, pf, of);
    initial begin
        a = 8'b11110000;
        b = 8'b10101010;
    end
    initial begin
        #0      sel=4'b0000;
        #14     $finish;
    end
    always begin
    #1 sel += 1;  
    end
    initial begin
        $dumpfile("alu8.vcd");
        $dumpvars(0,alu8_tb);
        $monitor("  a=%b   b=%b   sel=%d   out=%b   carry=%b zf=%b nf=%b pf=%b of=%b", a, b, sel, out, cf, zf, nf, pf, of);
    end

endmodule
