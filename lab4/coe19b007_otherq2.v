module CASE();
    wire input1;
    assign input1 = 10;
    initial 
    begin
        case(input1%2)
            1'b0:
                $display("Even");
            1'b1:
                $display("Odd");
            default:
                $display("default case");
        endcase
    end
endmodule