module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] sum_hi0, sum_hi1, sum_hi, sum_lo;
    wire cout;

    add16 add_hi1   ();
    add16 add_hi2   ();
    add16 add_lo    ();
    
    assign sum = (cout) ? sum_hi : sum_lo;

endmodule
