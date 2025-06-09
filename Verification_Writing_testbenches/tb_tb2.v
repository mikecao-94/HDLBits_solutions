module top_module();

reg clk, in;
reg [2:0] s;
wire out;

q7 dut (.clk(clk),
        .in(in),
        .s(s),
        .out(out)
        );

initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Toggle every 5 ps => 10 ps full period
end

initial begin
    // t = 0
    in = 0;
    s = 3'd2;

    #10 s = 3'd6;           // t = 10
    #10 s = 3'd2; in = 1;   // t = 20
    #10 s = 3'd7; in = 0;   // t = 30
    #10 s = 3'd0; in = 1;   // t = 40
    #30 in = 0;             // t = 70
end

endmodule
