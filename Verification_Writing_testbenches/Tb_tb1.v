module top_module ( output reg A, output reg B );//

    // generate input patterns here
    initial begin
	//Initial values
        A = 0;
        B = 0;
        
        #10 A = 1;     	// A goes high at t = 10
        #5  B = 1;     	// B goes high at t = 15
        #5 A = 0;    	// A goes low at t = 20
        #20 B = 0;    	// B goes low at t = 40
    end


endmodule
