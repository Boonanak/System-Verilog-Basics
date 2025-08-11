// This module is a testbench for the srff_sync module. This module is purposefully not flexible
// because then it could be considered a register with slightly different operation. In this tb we
// explicitly test the states of the srff. It is like a dff but more rudimentary, (there
// is two explcit inputs, (s and r), to toggle the output on and off. In a dff there is just one.
// Although the state where the set and reset inputs are both on at the same time is logically not
// defined in this setup, we cover it with the hold functionality. It can be seen in the waveform
// that the ouput q does not go high until 15 ms which is due to the fact there there is one
// instance of a delay by 10 ms prior to the first time the output is set and because the output
// only changes on the rising edge of the clk, (which explains the other 5ms). It is also
// important to see that when set and reset are both set to 1, the output simply holds the
// previous value as designed.

`timescale 1ns/1ps //default timescale

module tb_srff_sync;

	
	// Testbench signals
	logic clk;
	logic rst;
	logic set;
	logic q; //Don't have to declare a width because q is only 1 bit
	
	// Instantiate DUT
	srff_sync DUT (
		.clk(clk),
		.rst(rst),
		.set(set),
		.q(q)
	);
	
	// Generate clock
	always #5 clk = ~clk; //every 5 seconds invert the clk
	
	initial begin
		
	// Init values
	rst = 1; //We want reset to initially be 1 to avoid undefined behavior
	clk = 0;
	set = 0;
	#10;
	
	// Stimulus
		
    // Test: Set only
    set = 1;
    rst = 0;
    #10;

    // Test: Hold value
    set = 0;
    rst = 0;
    #10;

    // Test: Reset only
    set = 0;
    rst = 1;
    #10;

    // Test: Hold again
    set = 0;
    rst = 0;
    #10;

    // Test: Both set and reset (undefined state covered by hold)
    set = 1;
    rst = 1;
    #10;

    // Back to no set/rst
    set = 0;
    rst = 0;
    #10;
		
	$finish;
	
end
	
endmodule