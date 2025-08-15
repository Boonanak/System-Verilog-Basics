// This testbench module verifies that the LFSR module properly rotates through it's, (pseudo-randomly generated numbers), given the size of the LFSR
// specified. It also verifies in the beginning that reset functions as intended by having it held highfor one period of the clock.

// This is the default timescale in ModelSim, (means 1 ns time units and 1 ps is the time precision)
`timescale 1ns / 1ps	
	
module tb_LFSR;

	// Parameters
	parameter WIDTH = 10;
	parameter TAPS = 10'b1001000000;
	
  // Testbench signals
  logic clk;
  logic reset;
  logic [WIDTH-1:0] out;
  
	// Instantiate the DUT
   LFSR #(
		.WIDTH(WIDTH),
		.TAPS(TAPS)
	) uut (
		.clk(clk),
      .reset(reset),
      .out(out)
	);
	
	// Declaring the clock period value
   parameter clock_period = 10;	// This is the time, (in ns), between rising edges of the clk

	// Initialize the clock
	initial begin
		clk = 0;
		forever #(clock_period / 2) clk = ~clk;
	end
	
   // Stimulus
	initial begin
		reset = 1;
		#(clock_period);	// Hold reset for 1 cycle
      reset = 0;

		#(clock_period * 100);	// Let it run for some time (e.g., 100 cycles)

		$finish;	
	end
endmodule