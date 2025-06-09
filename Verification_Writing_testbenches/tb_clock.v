module top_module();
    reg clk;

    // Instantiate the DUT
    dut my_dut (.clk(clk));

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle every 5 ps => 10 ps full period
    end
endmodule
