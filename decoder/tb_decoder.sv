// This tb tests all aspects of the combinational decoder module. Once it is configured safely,
// first the enable input is tested, the input is tried to be set at 10 ns but it can be seen on
// the wave that the output doesn't actually reflect this until 20 ns. This is because only then
// then is enable switched to on, (it rememebers the value that was set before it though). Then
// the decoder is simply tested as designed, various values are entered into the input and the
// output properly reflects the one hot, (2^N), representations of these inputs.
`timescale 1ns/1ps //default timescale

module tb_decoder;

	// Parameters
	parameter WIDTH = 3; //Just using a smaller width to prevent out from being too large
	
	// Testbench signals
	logic enable;
	logic [WIDTH-1:0] in;
	logic [(1 << WIDTH) - 1 : 0] out;
	
	// Instantiate DUT
	decoder #(.WIDTH(WIDTH)) DUT (
		.enable(enable),
		.in(in),
		.out(out)
	);
	
	initial begin
		enable = 0; //We want enable to initially be 0 to avoid undefined behavior
		in = 3'b000; //Ensure safe startup
		#10;
		
		// Stimulus
		
		// Test enable
		in = 3'b100;
		#10;
		
		// Set enable
		enable = 1;
		#10;
		
		// Change in
		in = 3'b001;
		#10;
		
		// Change in
		in = 3'b111;
		#10;
		
		// For better visualization in wave
		enable = 0;
		#10;
		
		$finish;
	end
	
endmodule