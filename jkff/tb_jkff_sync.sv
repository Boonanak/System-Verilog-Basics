// This module is a testbench for the jkff_sync module. This module is purposefully not flexible
// because then it could be considered a register with slightly different operation. In this tb we
// explicitly test the four states of the jkff. Those being hold, set, toggle, and reset. Each
// step with a 10 ms delay in between to ensure continuity. It can also be seen on the generated
// wave that the output q is 0 for 25 ms. That is because in the tb there is 2 instances of 10 ms
// delays prior to when it is set and changes only happen on the rising edge of the clk which is
// 5 ms later.

`timescale 1ns/1ps //default timescale

module tb_jkff_sync;
	
	// Testbench signals
	logic rst;
	logic j;
	logic k;
	logic clk;
	logic [1:0] q;
	
	// Instantiate DUT
	jkff_sync DUT (
		.rst(rst),
		.j(j),
		.k(k),
		.clk(clk),
		.q(q)
	);
	
	// Generate clock
	initial clk = 0;
	always #5 clk = ~clk; //every 5 seconds invert the clk
	
	initial begin
		rst = 1; //We want reset to initially be 1 to avoid undefined behavior
		j = 0; //Initialize on hold
		k = 0; //Initialize on hold
		#10;
		
		// Stimulus
		
		// Release reset
		rst = 0;
		#10;
		
		// Case 1: Set
		j = 1;
		k = 0;
		#10;		
		
		// Case 2: Hold
		j = 0;
		k = 0;
		#10;
		
		// Case 3: Toggle
		j = 1;
		k = 1;
		#10;
		
		// Case 4: Reset
		j = 0;
		k = 1;
		#10;
		
		$finish;
	end
	
endmodule