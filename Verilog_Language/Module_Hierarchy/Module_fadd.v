module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
 	wire [15:0] sum_lo, sum_hi;
    wire carry,cout;
    add16 add_lo (.a(a[15:0]),
                  .b(b[15:0]),
                  .cin(1'b0),
                  .sum(sum_lo),
                  .cout(carry)
                 );
    add16 add_hi (.a(a[31:16]),
                  .b(b[31:16]),
                  .cin(carry),
                  .sum(sum_hi),
                  .cout(cout)
                 );
    assign sum = {sum_hi, sum_lo};
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );

// Full adder module here
    assign sum = a^b^cin;
    assign cout = a&b | a&cin | b&cin;

endmodule
