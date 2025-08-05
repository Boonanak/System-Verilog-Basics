// This module is a testbench for the register module. After creating a register with a width of
// 8, instantiating the signals, and generating the clk we begin testing the register. First
// seeing if it properly resets the values held in the register syncronously as desired. When
// looking at the waveform generated from this tb it will appear that the output q lags the
// input d by one clk cycle but in reality it is actually functioning as desired. Per the 
// code written below the reset signals changes on the falling edge of the clk so q is not
// updated until the next rising edge of the clk which occurs #5 after.
`timescale 1ns/1ps //default timescale

module tb_register;

	// Parameters
	parameter WIDTH = 8;
	
	// Testbench signals
	logic clk;
	logic rst;
	logic [WIDTH - 1:0] d;
	logic [WIDTH - 1:0] q;
	
	// Instantiate DUT
	register #(.WIDTH(WIDTH)) DUT (
		.clk(clk),
		.rst(rst),
		.d(d),
		.q(q)
	);
	
	// Generate clock
	initial clk = 0;
	always #5 clk = ~clk; //every 5 seconds invert the clk
	
	initial begin
		rst = 1; //We want reset to initially be 1 to avoid undefined behavior
		d = '0; //Initally doesn't hold any data
		
		// Stimulus
		
		// Test reset
		rst = 1;
		d = 8'b10101010;
		#10; //Clock changes state every 5 time units, (in this case 5 ns), #10 waits a full cycle
		
		// Release reset
		rst = 0;
		d = 8'b10101010;
		#10;
		
		// Change data
		d = 8'b01010101;
		#10
		
		// Change data again
		d = 8'b11110000;
		#10
		
		
		// Reset again
		rst = 1;
		d = 8'b00001111;
		#10
		
		// Load with new data
		d = 8'b01100110;
		#10
		
		$finish;
	end
	
endmodule