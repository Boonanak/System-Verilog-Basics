// This is a module for a purely combinational decoder. Syncronous behavior can be introduced as
// needed to this module but this Purely takes in instruction of N bits and returns expands it to
// a one hot output of 2^N width.
module decoder #( 

	parameter WIDTH = 8 //default is 8 bit
)(
	// io
	input logic enable,
	input logic [WIDTH -1 : 0] in,
	output logic [(1 << WIDTH) - 1 : 0] out //output is one hot encoding, (2^WIDTH)
);
		
	// combinational
	always_comb begin
		out = '0; //Default out is 0
		if (enable) begin
			out[in] = 1'b1; //Setting the location of in, in the vector out to one 
		end
	end
endmodule