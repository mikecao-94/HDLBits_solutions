module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
	
    // State encoding
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    reg [1:0] state, next_state;

    // Asynchronous active-low reset + sequential state transition
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next_state;
    end

 // Based on current state and input x
    always @(*) begin
        case (state)
            S0: next_state = x ? S1 : S0;         // '1' detected → S1, otherwise stay
            S1: next_state = x ? S1 : S2;         // '10' detected → S2, otherwise stay in S1
            S2: next_state = x ? S1 : S0;         // '101' completes → go to S1 (overlap), else reset
            default: next_state = S0;             // Fallback state
        endcase
    end

    // === Combinational block: output logic (Mealy) ===
    // Output 'z' is 1 only when current state is S2 and input x is 1 (i.e., sequence '101' is complete)
    assign z = (state == S2 && x == 1'b1) ? 1'b1 : 1'b0;

endmodule
