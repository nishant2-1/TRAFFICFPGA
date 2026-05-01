// CounterUnit.v
// Brief: 'This counter MUST count upwards!'
// Brief: 'use a comparator together with a binary counter to detect the value'
// Brief: 'achieve resetting using the idea from the programme counter'

module CounterUnit (
    input  wire       CLK,
    input  wire [3:0] Setting,  // Upper limit of count range
    input  wire       rst_n,    // Active-low reset
    output reg  [3:0] Count     // Current upward count value
);
    // Unit 4.2 structural comparator: continuous assignment
    // Detects when counter has reached its target value
    wire at_limit;
    assign at_limit = (Count >= Setting);

    // Unit 4.3: Sequential always block for the counter register
    always @(posedge CLK or negedge rst_n) begin
        if (!rst_n) begin
            Count <= 4'd0;        // Reset: return to initial value
        end else begin
            if (at_limit)
                Count <= 4'd0;    // Wrap: comparator triggered
            else
                Count <= Count + 1'b1;  // Count UP only
        end
    end

endmodule
