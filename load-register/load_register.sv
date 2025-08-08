// This is a flexible module for a load register, it is slightly different than a regular register
// in the sense that it will only load d to q if the ld flag is high, otherwise it will just keep
// the old value. This module is also flexible in the sense that it can be instantiated with any
// size but if no size is specified then the default size is 8 bits. This is essentially just a
// series of d flip flops strung together to create a wide register that can  be used to hold
//  multiple bits of input, it it loaded, (or emptied), at the rising edge of clk.
module load_register #(
	
	parameter WIDTH = 8 // Default size is 8 bits
)(
	// io
	input logic [WIDTH - 1:0] d,
	input logic rst,
	input logic clk,
	input logic ld,
	output logic [WIDTH - 1:0] q

);

	// sequential
	always_ff @(posedge clk) begin
		if (rst) begin
			q <= '0; //set entire bus to 0
		end else if (ld) begin
			q <= d; //load register with new data at next rising clk edge
		end else begin
			q <= q; //maintain old value of q
		end
	end
	
endmodule