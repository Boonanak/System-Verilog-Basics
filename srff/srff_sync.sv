// This module is a syncronous set-rest flip flop. This can be compared to the d flip flop which
// takes in only one d input while this one has two inputs, a set and reset input which either
// turn on or turn off, (set only turns on and rst only turns off). This particular implmentation
// defines the behavior of inputting set and rst and the same time at a rising clock edge as
// another way to hold the value it currently has.
module srff_sync (

	//io
	input logic clk,
	input logic set,
	input logic rst,
	output logic q

);

	//sequential logic
	always_ff @(posedge clk) begin
		if(set && !rst) begin
			q <= 1'b1;
		end else if (!set && rst) begin
			q <= 1'b0;
		end else begin // The default behavior is to hold so this else block isn't neccesary
			q <= q;
		end
	end
	
endmodule