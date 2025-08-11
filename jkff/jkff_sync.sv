// This module is like a set reset flip flop except it solves the invalid state of being set and
// reset being pressed at the same time. When they are pressed at the same time it counts in this
// implementation as a toggle where the flip flop toggles the value it is currently holding. This
// is once again considered syncronous because all changes occur only on the rising edge of clk.
module jkff_sync (

	//io
	input logic rst,
	input logic j,
	input logic k,
	input logic clk,
	output logic q

);

	//sequential logic
	always_ff @(posedge clk) begin
		if(rst) begin
			q <= '0;
		end else begin	
			case ({j, k})
				2'b00: q <= q; //Hold
				2'b01: q <= 1'b0; //Reset
				2'b10: q <= 1'b1; //Set
				2'b11: q <= ~q; //Toggle
			endcase
		end
	end
	
endmodule