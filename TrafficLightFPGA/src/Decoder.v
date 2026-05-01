// Unit 4.2: PURELY structural – all assign statements, no always blocks
// This is the example of continuous assignment from the course handbook
// Brief: decode 6-bit ControlSignal -> LEDs + countdown display
module Decoder (
    input  wire [5:0] ControlSignal,
    output wire [3:0] Count,
    output wire       Green,
    output wire       Red,
    output wire       Amber
);
    // Extract state and count using continuous assignment (Unit 4.2)
    wire [1:0] state;
    wire [3:0] up_count;
    assign state    = ControlSignal[5:4];
    assign up_count = ControlSignal[3:0];

    // LED decode: structural logic gates (like the course primitives)
    // Only one output HIGH at a time
    assign Red   = (state == 2'b00);
    assign Amber = (state == 2'b01) | (state == 2'b11);
    assign Green = (state == 2'b10);

    // Countdown conversion: subtract upcount from phase maximum
    // Red/Green max = 9, Amber max = 2
    // Conditional expression (Unit 4.2 mux-style assignment)
    wire [3:0] max_val;
    assign max_val = ((state == 2'b01) | (state == 2'b11)) ? 4'd2 : 4'd9;
    assign Count   = max_val - up_count;

endmodule
