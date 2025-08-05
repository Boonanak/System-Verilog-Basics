// This is a flexible module for a register, it is flexible in the sense that it can be
// instantiated with any size but if no size is specified then the default size is 8 bits. This
// is essentially just a series of d flip flops strung together to create a wide register that can
// be used to hold multiple bits of input, it it loaded, (or emptied), at the rising edge of clk.
module register #(
	
	parameter WIDTH = 8 // Default size is 8 bits
)(
	//io
	input logic [WIDTH - 1:0] d,
	input logic rst,
	input logic clk,
	output logic [WIDTH - 1:0] q

);

	//sequential
	always_ff @(posedge clk) begin
		if(rst) begin
			q <= '0; // Sets entire bus to 0
		end else begin
			q <= d;
		end
	end
	
endmodule