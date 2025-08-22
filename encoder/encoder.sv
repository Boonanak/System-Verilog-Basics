// This is a module for a purely combinational encoder. Syncronous behavior can be introduced as
// needed to this module but this Purely takes in instruction of N bits and returns log2(N)
// output. The input must be one hot for this implementation, which we verify first. Also
// technically we don't need the ceiling in the $clog2 statement because we are ensuring one-hot
// inputs but it is still safer to include it. This whole encoder functions on the idea that we
// are trying to find the binary representaion of the one hot input. We achieve this by searching
// through the input to find the bit that is high, when found, that bit is automatically assigned
// to out and thus also converted, (encoded), into binary.
module encoder #( 

	parameter WIDTH = 8 //default is 8 bit counter
)(
	// io
	input logic enable,
	input logic [WIDTH - 1 : 0] in, //input is one hot encoding
	output logic [$clog2(WIDTH) - 1 : 0] out // output is log2(N)
);
	
	// ensure valid one hot encoding
	
	
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