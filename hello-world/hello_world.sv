module hello_world (); //No -'s in module names
	
	// Note that this is purely for simulation, makes no sense in the context of hardwre design
	// Things in iniital blocks only run once at time 0 but then
	initial begin
		$display("Hello World");
	end
	
	// Everything in procedural blocks, (initial, always, etc), runs in parallel
	// Note that normally the order of these should be random but ModelSim schedules them n a fixed order
	initial begin
		$display("My name is Sean");
	end
	
	// However if statements are in the same block, ie two print statements in a initial block, they are outputted sequentially
	initial begin
	
		$display("I'm like hey");
		
		#1ns; //# for time delay, in this case 1 nano second delay
		
		$display("whats up hello");
	
	end
	
	// Executes forever but only on a trigger event, in this caase the trigger event is every 1 millisecond
	always #1ms begin
	
		$display("Printing every 1 millisecond");
		
	end
	
	// Can also have a always block fire on a signal instead of time
	// Here Hello world is rinted whenever the clock signal goes from 0 to 1, posedge, (you can also do the opposite with negedge
	// NOTE IN ORDER TO USE hello_world MUST TAKE A CLK INPUT
//	always @(posedge clk) begin
//	
//		$display("Hello World");
//		
//	end
	
endmodule