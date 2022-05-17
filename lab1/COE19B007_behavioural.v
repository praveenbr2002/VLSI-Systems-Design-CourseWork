module fa_behavioural(a,b,cin,sum,cout); 

input a,b,cin;
output reg cout,sum; 
always @(a,b,cin)
begin
    cout =(a&b|((a^b)&cin)); 
    sum = a^b^cin;
end 
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

fa_behavioural fa3 (ip1,ip2,ci,s,co);

initial begin
    $dumpfile ("fa3.vcd");
    $dumpvars (0,fa3);
end
    
endmodule
