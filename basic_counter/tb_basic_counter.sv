// This module is a testbench for the load register module. We first create a counter with a width
// of 8, instantiate our signals and the DUT itself, and initializing the clk we begin testing our
// counter. Since all this counter can do is count up by 1 at a time and be reset when needed that
// is all we test. Once we confirm that reset does in fact work we count for 3 full cycles,
// (getting to 00000011 or 3), we reset the count and being counting again, (this time getting to
// 00000100 or 4). It is also important to note that in the beginning, (first 5 ns), out is
// undefined, this is because the first time the clk pulses is at 5ns.
`timescale 1ns/1ps //default timescale

module tb_basic_counter;

	// Parameters
	parameter WIDTH = 8;
	
	// Testbench signals
	logic count;
	logic reset;
	logic clk;
	logic [WIDTH - 1 : 0] out;
	
	// Instantiate DUT
	basic_counter #(.WIDTH(WIDTH)) DUT (
		.count(count),
		.reset(reset),
		.clk(clk),
		.out(out)
	);
	
	// Generate clock
	initial clk = 0;
	always #5 clk = ~clk; //every 5 ns invert the clk
	
	initial begin
		reset = 1; //We want reset to initially be 1 to avoid undefined behavior
		count = 0; //Initally do not count
		
		// Stimulus
		
		// Test reset
		count = 1;
		#10; //Clock changes state every 5 time units, (in this case 5 ns), #10 waits a full cycle
		
		// Release reset
		reset = 0;
		count = 1;
		#30;
		
		// reset
		reset = 1;
		#10;
		
		// turn off reset
		reset = 0;
		#10;
		
		
		// Count again
		count = 1;
		#30;
		
		$finish;
	end
	
endmodule