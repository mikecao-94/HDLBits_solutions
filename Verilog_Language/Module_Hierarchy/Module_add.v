module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] sum_hi, sum_lo;
    wire cout;

//module add16 ( input[15:0] a, input[15:0] b, input cin, output[15:0] sum, output cout );    
    add16 add_lo (a[15:0], b[15:0], 1'b0, sum_lo,cout );
    add16 add_hi (a[31:16], b[31:16], cout, sum_hi, );

    assign sum = {sum_hi, sum_lo};

endmodule
