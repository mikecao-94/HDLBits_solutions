module top_module();

    reg clk;
    reg reset;
    reg t;
    wire q;

    // Instantiate the T flip-flop
    tff u_tff (
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );

    // Clock generation (10 time units period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialize
        reset = 1;  // Apply reset
        t = 0;
        #10 reset = 0;  // Deassert reset
        #10 t = 1;      // Toggle enabled
        #10 t = 0;      // Stop toggling
    end

endmodule
