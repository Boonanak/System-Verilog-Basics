// This tb tests all aspects of the combinational encoder module. Once it is configured safely,
// first the enable input is tested, the input is tried to be set at 10 ns but it can be seen on
// the wave that the output doesn't actually reflect this until 20 ns. This is because only then
// then is enable switched to on, (it rememebers the value that was set before it though). It then
// tests the behavior of the module, (also note all inputs are one hot to ensure safe use of This
// module as it is designed with that in mind. It is also important to remember that the input
// indexing is indexed from 0.
`timescale 1ns/1ps //default timescale

module tb_encoder;

	// Parameters
	parameter WIDTH = 8;
	
	// Testbench signals
	logic enable;
	logic [WIDTH - 1 : 0] in;
	logic [$clog2(WIDTH) - 1 : 0] out;
	
	// Instantiate DUT
	encoder #(.WIDTH(WIDTH)) DUT (
		.enable(enable),
		.in(in),
		.out(out)
	);
	
	initial begin
		enable = 0; //We want enable to initially be 0 to avoid undefined behavior
		in = 8'b00000000; //Ensure safe startup
		#10;
		
		// Stimulus
		
		// Test enable
		in = 8'b10000000;
		#10;
		
		// Set enable
		enable = 1;
		#10;
		
		// Change in
		in = 8'b00100000;
		#10;
		
		// Change in
		in = 8'b00000100;
		#10;
		
		// For better visualization in wave
		enable = 0;
		#10;
		
		$finish;
	end
	
endmodule