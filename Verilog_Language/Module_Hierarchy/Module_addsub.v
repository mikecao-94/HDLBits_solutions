module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire [15:0] sum_hi, sum_lo;
    wire [31:0] new_b;
    wire cout;
    
    //assign new_b = (sub) ? ~b:b; //this work as well
    assign new_b = {32{sub}} ^b;
    
    add16 add_lo (.a(a[15:0]),
                    .b(new_b[15:0]),
                    .cin(sub),
                    .sum(sum_lo),
                    .cout(cout)
                   );
    
    add16 add_hi (.a(a[31:16]),
                    .b(new_b[31:16]),
                    .cin(cout),
                  	.sum(sum_hi),
                    .cout()
                   );
    
    assign sum = {sum_hi,sum_lo};
endmodule
