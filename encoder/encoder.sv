// This is a module for a purely combinational encoder. Syncronous behavior can be introduced as
// needed to this module but this Purely takes in instruction of N bits and returns log2(N)
// output. The input must be one hot for this implementation, which we verify first This whole 
// encoder functions on the idea that we are trying to find the binary representaion of the one
// hot input. We achieve this by searching through the input to find the bit that is high, when
// found, that bit is automatically assigned to out and thus also converted, (encoded), into
// binary. This is intended to be a one hot encoder but if there is more than 1 bit in the input
// that is high then this defaults to a priority encoder because of the logic in the for loop.
module encoder #( 

	parameter WIDTH = 8 //default is 8 bit counter
)(
	// io
	input logic enable,
	input logic [WIDTH - 1 : 0] in, //input is one hot encoding
	output logic [$clog2(WIDTH) - 1 : 0] out // output is log2(N)
);
	
	// combinational
	always_comb begin
		out = '0; //Default out is 0
		if (enable) begin
			for (int i = 0; i < WIDTH; i++) begin
				if (in[i]) begin
					out = i;
				end
			end
		end
	end
endmodule