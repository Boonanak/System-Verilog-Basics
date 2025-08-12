// This fsm is an example of a elevator that uses output encoding, (each floor is considered it's
// own state. The floor that the elevator is on is then displayed on the 7 segment display.
// Currently it is only 4 levels tall but this could be easily expanded to represent an elevator
// of more floors. When it comes to reading the 7 segment display the mapping is in the format of
// 0b0gfedcba, (the first 0 is for the ground pin). This elevator fsm assumes that you start on
// the ground floor and considers an entry of 11 to be invalid, (it doesn't make any sense to
// press the up button at the same time that you press the down button. This is represented as a
// Moore FSM where the action appears on the FSMs state, the action's output value is a function
// of the present state, and the output only occurs when you are already at the next state.
import fsm_pkg::*;

module fsm (
	input logic clk,
	input logic rst,
	input logic u,
	input logic d,
	output logic [6:0] seg, // Output to 7-segment display
	output state_t presState
);
	// Create instance of new variable type state_t, (from imported package)
	state_t nextState;

	// Sequential logic 
	// Updates presState to nextState on the rising clk edge
	always_ff @(posedge clk) begin
		if (rst) // Note, no begin or end needed if only one line in if and else statements
			presState <= S1; // if reset true, assign present state to S1, (our starting state)
		else
			presState <= nextState; // if reset not true, set next state to the present state
	end
	
	// Combinational logic
	// Following paths through fsm
	always_comb begin
		
		nextState = presState;
		
		case (presState)
			
			S1: begin
				if (u)
					nextState = S2;
				else if (d)
					nextState = S1;  // Already on bottom floor
				else
					nextState = S1;
			end
			
			S2: begin
				if (u)
					nextState = S3;
				else if (d)
					nextState = S1;
				else
					nextState = S2;
			end
			
			S3: begin
				if (u)
					nextState = S4;
				else if (d)
					nextState = S2;
				else
					nextState = S3;
			end
			
			S4: begin
				if (u)
					nextState = S4; // Already on top floor
				else if (d)
					nextState = S3;
				else
					nextState = S4;
			end
		
		endcase
	end
	
	// Combinational logic
	// Output logic, tying the state to what we want outputted to the 7-seg
	always_comb begin
		
		case(presState)
			S1: seg = 7'b00000110;
			S2: seg = 7'b01011011;
			S3: seg = 7'b01001111;
			S4: seg = 7'b01100110;
			default: seg = 7'b0000000;
		endcase
	end
	
endmodule