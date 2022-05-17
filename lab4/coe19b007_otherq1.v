module IF();
    wire input1;
    assign input1 = 10;
    initial 
    begin
        if(input1%2 == 0) 
        begin
            $display("Even\n");
        end
    else 
        begin
            $display("Odd\n");
        end
    end
endmodule

