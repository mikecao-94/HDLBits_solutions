module top_module();
    reg [1:0] in;
    wire out;

    andgate dut (in, out);
    
    initial begin
    //initial value 
    in = 2'b00;  
    #10 in = 2'b01;
    #10 in = 2'b10;
    #10 in = 2'b11; 
    end
    
endmodule
