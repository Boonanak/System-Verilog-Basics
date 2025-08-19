// This allows us to use the new mode type, however it must be compiled seperately first
import pkg_complex_counter::*;

// This testbench tests the functionality of the complex counter module. It specifically tests
// that it is able to properly function under the reset, step, and load flags and that is able
// to properly switch between modes, (those being hold, up, down, and load).
`timescale 1ns/1ps //default timescale

module tb_complex_counter;

	// Parameters
	parameter WIDTH = 8;
	
	// Testbench signals
	logic rst;
	logic clk;
	logic [WIDTH-1:0] ld;
	logic [WIDTH-1:0] stp;
	logic [WIDTH - 1:0] out;
	count_mode_t mode;
	
	// Instantiate DUT
	complex_counter #(.WIDTH(WIDTH)) DUT (
		.rst(rst),
		.clk(clk),
		.stp(stp),
		.ld(ld),
		.out(out),
		.mode(mode)
	);
	
	// Generate clock
	initial clk = 0;
	always #5 clk = ~clk; //every 5 seconds invert the clk
	
	initial begin
		rst = 1; //We want reset to initially be 1 to avoid undefined behavior
		stp = 1; //Start by stepping by just 1
		ld = 0; //Initially do not load anything
		mode = HOLD; //Start in hold mode
		#10;
		
		// Stimulus
		
		// Release reset
		rst = 0;
		#10;
		
		// Step up 1
		mode  = UP;
		#10;
		
		// Step down 1
		mode = DOWN;
		#10;
		
		// Reset
		rst = 1;
		#10;
		
		// LOAD
		rst = 0;
		ld = 8'b00001111;
		mode = LOAD;
		#10;
		
		// Step up 3
		stp = 8'b00000011;
		mode = UP;
		#10;
		
		// Step down 2
		stp = 8'b00000010;
		mode = DOWN;
		#10;
		
		// For better visualization in wave
		#10;
		
		$finish;
	end
	
endmodule