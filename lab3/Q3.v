module first();
    initial begin
        $display("Called first module");
    end
endmodule
module generatef();
    generate
        genvar i;
        for(i=1;i<=5;i=i+1) begin
            first f();
        end
    endgenerate
endmodule
module Ques3_tb();
    generatef g();
endmodule