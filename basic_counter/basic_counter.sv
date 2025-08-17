// This is a module for a very basic up counter, (although it can be parameterized to be of
// various lengths, this module can only count up and by one at time, if reset is not pressed
// then the module will not count up. It starts from 0. If reset is not true and count is not true
// then the modules previous value of out is held.
module basic_counter #( 

	parameter WIDTH = 8 //default is 8 bit counter
)(
	// io
	input logic count,
	input logic reset, 	
	input logic clk,
	output logic [WIDTH - 1 : 0] out
	
);
		
	// sequential
	always_ff @(posedge clk) begin
		// if statements are MUXes
		if (reset)
			out <= 0;
		else if (count)
			out <= out + 1;
		//Unwritten else holds the past Q value, does this by default, not true in always_comb
	end
endmodule