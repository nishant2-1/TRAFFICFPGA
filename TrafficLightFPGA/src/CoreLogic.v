// Brief: MUST be constructed using CounterUnit submodule
// Brief: 6-bit ControlSignal: state + upward count from low to high
// Sequence: Red(10s) -> Amber(3s) -> Green(10s) -> Amber(3s) -> repeat

module CoreLogic (
    input  wire       CLK,
    input  wire       rst_n,
    output reg  [5:0] ControlSignal
);
    // State encoding for bits [5:4] of ControlSignal
    parameter RED      = 2'b00;
    parameter AMBER_RG = 2'b01;  // Red to Green transition
    parameter GREEN    = 2'b10;
    parameter AMBER_GR = 2'b11;  // Green to Red transition

    // Timing: matches brief specification
    parameter RED_TIME   = 4'd09;
    parameter AMBER_TIME = 4'd02;
    parameter GREEN_TIME = 4'd09;

    reg [1:0] state;
    reg [3:0] counter_setting;
    wire[3:0] counter_count;
    reg       counter_rst;

    // Brief requirement: CoreLogic MUST use CounterUnit as submodule
    CounterUnit cu (
        .CLK     (CLK),
        .Setting (counter_setting),
        .rst_n   (counter_rst),
        .Count   (counter_count)
    );

    // Unit 4.2: Structural comparator for 'at limit' detection
    wire at_limit;
assign at_limit = (counter_count >= counter_setting);

    // Unit 4.3: Combinational always @(*) for setting selection
    always @(*) begin
        case (state)
            RED:      counter_setting = RED_TIME;
            AMBER_RG: counter_setting = AMBER_TIME;
            GREEN:    counter_setting = GREEN_TIME;
            AMBER_GR: counter_setting = AMBER_TIME;
            default:  counter_setting = RED_TIME;
        endcase
        // Counter reset: active when at limit (drives CounterUnit reset)
        counter_rst = rst_n & ~at_limit;
    end

    // Unit 4.3: Sequential state machine register
    always @(posedge CLK or negedge rst_n) begin
        if (!rst_n) begin
            state <= RED;
        end else begin
            if (at_limit) begin
                case (state)
                    RED:      state <= AMBER_RG;
                    AMBER_RG: state <= GREEN;
                    GREEN:    state <= AMBER_GR;
                    AMBER_GR: state <= RED;
                    default:  state <= RED;
                endcase
                end else begin
            end
        end
    end

    // Combinational output pack
    always @(*) begin
        if (!rst_n)
            ControlSignal = 6'b000000;
        else
            ControlSignal = {state, counter_count};
    end

endmodule
