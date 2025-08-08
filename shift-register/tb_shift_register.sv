// This allows us to use the new mode type, however it must be compiled seperately first
import shift_register_pkg::*;


// This module is a testbench for the shift register module. After creating a register with a
// width of 8, instantiating the signals, and generating the clk we begin testing the register.
// First seeing if it properly resets the values held in the register syncronously as desired.
// When looking at the waveform generated from this tb it will appear that the output q lags the
// input d by one clk cycle but in reality it is actually functioning as desired. Per the 
// code written below the reset signals changes on the falling edge of the clk so q is not
// updated until the next rising edge of the clk which occurs #5 after.
`timescale 1ns/1ps //default timescale

module tb_shift_register;

	// Parameters
	parameter WIDTH = 8;
	
	// Testbench signals
	logic clk;
	logic rst;
	logic [WIDTH - 1:0] d;
	logic [WIDTH - 1:0] q;
	shift_mode_t mode;
	
	// Instantiate DUT
	shift_register #(.WIDTH(WIDTH)) DUT (
		.clk(clk),
		.rst(rst),
		.d(d),
		.q(q),
		.mode(mode)
	);
	
	// Generate clock
	initial clk = 0;
	always #5 clk = ~clk; //every 5 seconds invert the clk
	
	initial begin
		rst = 1; //We want reset to initially be 1 to avoid undefined behavior
		d = '0; //Initally doesn't hold any data
		mode = HOLD; //Start in hold mode
		
		// Stimulus
		
		// Test reset
		rst = 1;
		d = 8'b10101010;
		#10; //Clock changes state every 5 time units, (in this case 5 ns), #10 waits a full cycle
		
		// Release reset
		rst = 0;
		d = 8'b10101010;
		#10;
		
		// Load
		mode  = LOAD;
		d = 8'b11110000;
		#10
		
		// Shift Right
		mode = SHIFT_RIGHT;
		#10
		
		
		// Shift Left
		mode = SHIFT_LEFT;
		#10
		
		$finish;
	end
	
endmodule