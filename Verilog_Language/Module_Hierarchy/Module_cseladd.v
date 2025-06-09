module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] sum_lo, sum_hi;
    wire [15:0] sum_hi_0, sum_hi_1;
 
    wire sel;
    add16 adder_1a (.a(a[31:16]),
                  .b(b[31:16]),
                  .cin(1'b0),
                  .sum(sum_hi_0),
                  .cout()
                 );
     add16 adder_1b (.a(a[31:16]),
                  .b(b[31:16]),
                  .cin(1'b1),
                  .sum(sum_hi_1),
                  .cout()
                 );
    add16 adder2 (.a(a[15:0]),
                  .b(b[15:0]),
                  .cin(1'b0),
                  .sum(sum_lo),
                  .cout(sel)
                 );
    
    //mux to select between 2 sum_hi
    assign sum_hi = (sel) ? sum_hi_1 : sum_hi_0;
    
    assign sum = {sum_hi,sum_lo};

endmodule
