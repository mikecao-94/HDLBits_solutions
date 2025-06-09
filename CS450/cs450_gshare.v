module top_module(
    input clk,
    input areset,

    // Prediction interface (used during fetch)
    input  predict_valid,
    input  [6:0] predict_pc,
    output predict_taken,             // Prediction output based on PHT
    output reg [6:0] predict_history, // Global history register

    // Training interface (used after branch is resolved)
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    // 2-bit saturating counter states for readability
    parameter SNT = 2'b00, // Strongly Not Taken
              WNT = 2'b01, // Weakly Not Taken
              WT  = 2'b10, // Weakly Taken
              ST  = 2'b11; // Strongly Taken
    
    integer i;

    // Compute XOR index for accessing PHT
    wire [6:0] train_index  = train_history  ^ train_pc;
    wire [6:0] predict_index = predict_history ^ predict_pc;

    // Pattern History Table: 128 entries, 2 bits each
    reg [1:0] PHT [127:0];

    // Main sequential logic block
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset global history to 0
            predict_history <= 7'b0;

            // Initialize all PHT entries to weakly not taken
            for (i = 0; i < 128; i = i + 1)
                PHT[i] <= WNT;
        end else begin
            // --- Priority: training overrides prediction ---

            // If a misprediction occurred, restore history to correct state
            if (train_valid && train_mispredicted)
                predict_history <= {train_history[5:0], train_taken}; // shift in correct outcome

            // Otherwise, if valid prediction, shift in predict_taken
            else if (predict_valid)
                predict_history <= {predict_history[5:0], predict_taken}; // update global history

            // Update the PHT entry using outcome from training
            if (train_valid) begin
                if (train_taken)
                    // Increment counter toward strongly taken
                    PHT[train_index] <= (PHT[train_index] == ST) ? ST : (PHT[train_index] + 1);
                else
                    // Decrement counter toward strongly not taken
                    PHT[train_index] <= (PHT[train_index] == SNT) ? SNT : (PHT[train_index] - 1);
            end
        end
    end

    // Prediction result: use MSB of selected PHT entry
    assign predict_taken = PHT[predict_index][1];

endmodule
