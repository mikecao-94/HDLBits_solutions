module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);
	
	assign outv = vec;

	assign o0 = vec[0];
	assign o1 = vec[1];
	assign o2 = vec[2];
	// This is ok too: assign {o2, o1, o0} = vec;
    // or  assign {o0,o1,o2} = {vec[0],vec[1],vec[2]};

endmodule
