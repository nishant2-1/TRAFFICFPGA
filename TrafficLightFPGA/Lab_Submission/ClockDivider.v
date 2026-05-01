module ClockDivider (
    input wire CLK_50MHz,
    input wire rst_n,
    output reg CLK_1Hz
);
// Calculated for 50MHz crystal. 
    // 50,000,000 / 2 = 25,000,000 for a 1 second period, 
    // but using a smaller parameter for testing in simulation.
    parameter HALF_PERIOD = 25000000;
    reg [24:0] counter;
    wire counter_max;
    assign counter_max = (counter == HALF_PERIOD - 1);


    always @(posedge CLK_50MHz or negedge rst_n) begin

        if (!rst_n) begin counter <= 25'd0; CLK_1Hz <= 1'b0; end
        else begin
            if (counter_max) begin counter <= 25'd0; CLK_1Hz <= ~CLK_1Hz; end
            else counter <= counter + 1'b1;
        end
    end
endmodule
