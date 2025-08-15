// This module is a linear feedback shift register, (LFSR), that is flexible such that you can specify the number of DFFs in the LFSR as well as the location
// of the taps, (as they change as a function of the length of the LFSR. 
module LFSR #(
	parameter WIDTH = 5,
	parameter logic  [WIDTH - 1:0] TAPS = 5'b10100
)(
	input logic clk,
	input logic reset,
	output logic [WIDTH - 1: 0] out
);

	logic [WIDTH-1:0] lfsr_reg;	// The register itself of declared length
	logic feedback;	// What comes out of the XNOR, (IN)

	assign feedback = ~^(lfsr_reg & TAPS);  // XNOR of tap bits
	assign out = lfsr_reg;

   always_ff @(posedge clk) begin
		if (reset)
			lfsr_reg <= 1;  // Assigning a binary 1 to the LFSR, this is our starting point
		else
			lfsr_reg <= {lfsr_reg[WIDTH-2:0], feedback};	// Set the register to hold everything except the MSB and then left shift it all by 1, (feedback bit)
	end
endmodule