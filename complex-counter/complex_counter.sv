// This allows us to use the new mode type, however it must be compiled seperately first
import pkg_complex_counter::*;

// This module is a complex counter, it follows the same general idea of incremetning a value that
// the basic counter introduces but expands on it to offer more advanced capability. This includes
// having four different modes it can operate in, those being hold, increment up, increment down,
// and load. Not only that but when the counter is incremented either up and down, how much it
// increments by can also be changed with the stp. I made the design choice to make step a 8 bit
// value just like what is held in the counter which allows for more freedom but at the cost of 
// being more prone to overflow if the user accidental increments or decrements by too large a
// value, data can be lost. If you wanted to prevent overflow or underflow you could introduce
// clamping logic to cap the data at 255 or 0 respectively, (assuming 8 bit width). After making
// this I ahve realized that it is absoletely valid to add in a enable flag that can also be
// toggled such that the cpu, (if this were part of a larger system), would be able to pause
// without losing a critical value, this also allows for power saving.
module complex_counter #( 

	parameter WIDTH = 8 //default is 8 bit counter
)(
	// io
	input logic rst, 	
	input logic clk,
	input logic [WIDTH-1:0] ld,
	input logic [WIDTH-1:0] stp,
	input count_mode_t mode,
	output logic [WIDTH - 1 : 0] out
	
);
		
	// sequential
	always_ff @(posedge clk) begin
		if (rst) begin
			out <= 0;
		end else begin
			case(mode)
				HOLD : out <= out;
				UP : out <= out + stp;
				DOWN : out <= out - stp;
				LOAD : out <= ld;
			endcase
		end
	end
endmodule