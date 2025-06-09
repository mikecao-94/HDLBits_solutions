module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output [1:0] state
);
    parameter SNT = 2'b00, WNT = 2'b01, WT = 2'b10, ST = 2'b11;

    // always @(posedge clk or posedge areset) begin
    //     if(areset)
    //     state <= WNT;
    //     else if (train_valid == 1 && train_taken == 1 && state != ST)
    //         state <= state + 1'b1;
    //     else if (train_valid == 1 && train_taken == 0 && state != SNT)
    //         state <= state - 1'b1;
    //     else if (train_valid == 0) 
    //         state <= state;
    // end

    always @(posedge clk, posedge areset) begin
        if (areset)
            state <= WNT;
        else if (train_valid) begin
            if (train_taken)
                state <= (state == ST) ? ST : (state + 1);
            else
                state <= (state == SNT) ? SNT : (state - 1);
        end
    end

endmodule
