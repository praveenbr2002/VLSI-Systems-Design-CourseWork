module fa_dataflow(a,b,cin,sum,cout); 

input a,b,cin;
output cout,sum;

assign sum = a ^ b ^ cin; 
assign cout = (a&b|((a^b)&cin)); 

endmodule

module fa_tb();

reg ip1,ip2,ci;
wire s,co;

initial 
begin
    ip1=0; ip2=0; ci=0; #5;
    ip1=0; ip2=0; ci=1; #5;
    ip1=0; ip2=1; ci=0; #5;
    ip1=0; ip2=1; ci=1; #5;
    ip1=1; ip2=0; ci=0; #5;
    ip1=1; ip2=0; ci=1; #5;
    ip1=1; ip2=1; ci=0; #5;
    ip1=1; ip2=1; ci=1; #5;
    $finish;
end

fa_dataflow fa1 (ip1,ip2,ci,s,co);

initial begin
    $dumpfile ("fa1.vcd");
    $dumpvars (0,fa1);
end
    
endmodule