// This module is testbench for the fsm module. It assumes that the 7 segment display is active
// high. If you are on the bottom floor and down is entered and up is not then the FSM will remain
// on the first floor and vice versa if the opposite happens on the top floor. This testbench
// tests functionality such as reset, up, (down is not tested but it would function the exact same
// but opposite of up), trying to go down from the first floor, trying to go up from the top
// floor, and even the invalid state of trying to go up and down at the same point at any floor.
// The funcitonality of this FSM can be confirmed from the waveform.
import fsm_pkg::*;

`timescale 1ns/1ps //default timescale

module tb_fsm;
	
	// Testbench signals
	logic clk;
	logic rst;
	logic u;
	logic d;
	logic [6:0] seg;
	state_t presState;
	
	// Instantiate DUT
	fsm DUT (
		.clk(clk),
		.rst(rst),
		.u(u),
		.d(d),
		.seg(seg),
		.presState(presState)
	);
	
	// Generate clock
	initial clk = 0;
	always #5 clk = ~clk; //every 5 ns invert the clk
	
	initial begin
		rst = 1; //Make rest one so the initial state is floor one
		u = '0; //Initially dont go up
		d = '0; //Initally dont go down
		#10
		
		// Stimulus
		
		rst = 0;
		
		// Try going down a floor, presState should remain S1
		u = '0;
		d = '1;
		#10
		
		// Go up a floor, presState should now be S2
		u = '1;
		d = '0;
		#10
		
		// Go up a floor, presState should now be S3
		u = '1;
		d = '0;
		#10
		
		// Go up a floor, presState should now be S4
		u = '1;
		d = '0;
		#10
		
		// Go up a floor, presState should still be S4
		u = '1;
		d = '0;
		#10
		
		// Try to go up and down at the same time, output should be unpredictable
		u = '1;
		d = '1;
		#10
		
		$finish;
	end
	
endmodule