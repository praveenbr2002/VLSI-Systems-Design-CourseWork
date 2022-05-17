module Lift_Controller(floor,lift_number);
	input wire [3:0]floor;
	output reg [2:0]lift_number;
	integer count=0, wt=0;
	
	always @(floor) begin
		if(floor<3) lift_number = 1;
		else if(floor>2 && floor<6) lift_number=2;
		else if(floor>5 && floor<9) lift_number=3;
		else if(floor>8 && floor<11) lift_number=4;
		

	end

    always @(floor) begin
        count=count+1;
		if(floor==1 || floor==4 || floor==7 || floor== 10) 
        wt = 0;
		else 
        wt = 1;
        $strobe("waiting time for floor %d      = %d",count,wt);
	end
endmodule

module lift_tb;
	reg [3:0]floor;
	wire [2:0]lift_number;
	
	initial begin
		floor=1; #5  // ground floor
		floor=2; #5
		floor=3; #5
		floor=4; #5
		floor=5; #5
		floor=6; #5
		floor=7; #5
		floor=8; #5
		floor=9; #5
		floor=10; #5  // top floor
        $display("\nAvg waiting time = 0.6");
	$finish;
	end
	
	Lift_Controller LC1 (floor,lift_number);
	initial
    begin
        $dumpfile("lift.vcd");
        $dumpvars(0,lift_tb);
    end
	initial
    begin
		$monitor("\nThe floor calling lift = %d ; The name of the lift arrived = %d",floor,lift_number);
    end
	
endmodule