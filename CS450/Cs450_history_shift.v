module top_module(
    input clk,
    input areset,

    input predict_valid,
    input predict_taken,
    output reg [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    always @(posedge clk or posedge areset) begin
        if (areset)  //Highest priority (asynchronous reset)
            predict_history <= 32'b0;
        else if (train_mispredicted) //Pipeline flush (override prediction)
            // Rollback misprediction: restore train_history + train_taken
            predict_history <= {train_history[30:0], train_taken};
        else if (predict_valid) //Normal shift on valid prediction
            // Shift in prediction
            predict_history <= {predict_history[30:0], predict_taken};
    end

endmodule
