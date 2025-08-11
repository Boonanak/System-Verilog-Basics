// This is the module for a fundamental building block of digital design, a d flip flop. This
// functions just like a d latch except that it's enable input is controlled by the rising edge
// of the clock. This module take in some data d, (along with a reset and clock input), and outputs
// the data q. This is inportant as dffs are the fundamental building blocks of memory as it's
// past value can affectthe current value it takes on. This is called a syncronous dff as it also
// includes a reset input that allows the value to be resetted to 0 at the rising edge of the clk.
// We want this behavior when the initial state matters, when it only holds intermediate values,
// (like in a datapath), we do not need this behavior.
module dff_sync (

	input logic d,
	output logic q,
	input logic rst,
	input logic clk
	
);
	
	// All non-blocking assignments in this always_ff block are determiend at the rising edge of clk
	always_ff @(posedge clk) begin
		if(rst) begin
			q <= 1'b0;
		end else begin
			q <= d;
		end
		
		// If no need to include reset behavior, q <= d is sufficient
	end
	
endmodule
	
	
	