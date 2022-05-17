module fa_structural(a,b,cin,sum,cout); 

input a,b,cin;
output cout,sum;
wire s1,s2,s3;

xor (s1,a,b);
and (s2,a,b);
xor (sum,s1,cin); 
and (s3,s1,cin);
or (cout,s3,s2); 

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

fa_structural fa2 (ip1,ip2,ci,s,co);

initial begin
    $dumpfile ("fa2.vcd");
    $dumpvars (0,fa2);
end
    
endmodule
