module top_module ( input clk, input d, output q );

wire q1,q2;
// Create three instances of my_dff, with three different instance names (dff_1, dff_2, and dff_3).
// Connect ports by position: ( input clk, input d, output q)

    my_dff dff_1 (clk, d, q1);
    my_dff dff_2 (clk, q1, q2);
    my_dff dff_3 (clk, q2, q);
    
endmodule
