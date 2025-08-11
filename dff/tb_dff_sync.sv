// This module is a testbench for the dff_sync module. This module is purposefully not flexible
// because then it could be considered a register with slightly different operation. This
// demonstrates the laoding ability of the dff. 

`timescale 1ns/1ps //default timescale

module tb_ff_sync;
	
	// Testbench signals
	logic d;
	logic q;
	logic rst;
	logic clk;
	
	// Instantiate DUT
	dff_sync DUT (
		.d(d),
		.q(q),
		.rst(rst),
		.clk(clk)
	);
	
	// Generate clock
	initial clk = 0;
	always #5 clk = ~clk; //every 5 seconds invert the clk
	
	initial begin
		rst = 1; //We want reset to initially be 1 to avoid undefined behavior
		d = 0;
		q = 0;
		#10;
		
		// Stimulus
		
		// Release reset
		rst = 0;
		#10;
		
		// Set d
		d = 1;
		#10;		
		
		// Reset
		d = 0;
		#10;
		
		$finish;
	end
	
endmodule