module forloop();
    integer i;
    initial begin
        $display("For loop:-");
        for(i=1;i<6;i=i+1) begin
            $display("%d",i);
        end
    end
endmodule
module whileloop();
    integer j=1;
    initial begin
        $display("While loop:-");
        while(j<=5) begin
            $display("%d",j);
            j=j+1;
        end
    end
endmodule

module repeatloop();
    integer i=1;
    
    initial begin
        $display("Repeat:-");
        repeat(5)  
            #1 $display("%d",i++);
    end
endmodule

module foreverloop (); 
  initial
    begin
      integer i=1;  
      forever
        #10 $display("%d",i++);
    end
  
endmodule


module Ques1_tb();
    forloop fl();
    whileloop wl();
    repeatloop rl();
    //foreverloop fe();
endmodule