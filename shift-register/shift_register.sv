// This allows us to use the new mode type, however it must be compiled seperately first
import shift_register_pkg::*;


// This is a flexible module for a shift register, it is flexible in the sense that it can be
// instantiated with any size but if no size is specified then the default size is 8 bits. This
// not only a series of d flip flops strung together to create a wide register that can be used
// to hold multiple bits of input, but this register has the additonal capability to also shift
// the data by one bit per cycle. This could be made to be even a bit more flexible to control
// how much to shift the data by each clock cycle but doing so would require a larger MUX to also
// include a SHIFT_AMT variable. It is loaded, (or emptied), or shifted at the rising edge of clk.
module shift_register #(
	
	parameter WIDTH = 8 // Default size is 8 bits
)(
	//io
	input logic [WIDTH - 1:0] d,
	input logic rst,
	input logic clk,
	input shift_mode_t mode, //Not a logic type but a custom type from enum
	output logic [WIDTH - 1:0] q

);

	//sequential
	always_ff @(posedge clk) begin
		if(rst) begin
			q <= '0; // Sets entire bus to 0
		end else begin
			case(mode)
				HOLD: q <= q;
				LOAD: q <= d;
				SHIFT_RIGHT: q <= q / 2; //Could also use q <= q >> 1
				SHIFT_LEFT: q <= q * 2; //Could also use q <= q << 1
			endcase
		end
	end
	
endmodule