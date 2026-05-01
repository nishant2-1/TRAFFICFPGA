`timescale 1 ns / 100 ps

module Decoder_tb;

    reg  [5:0] ControlSignal;
    wire [3:0] Count;
    wire       Green, Red, Amber;

    initial begin
        $display("State | UpCnt | Countdown | Red | Amber | Green");
        $display("------+-------+-----------+-----+-------+------");

        // RED state (bits[5:4]=00), upcount 0 to 9
        ControlSignal = {2'b00, 4'd0}; #10;
        $display("RED   |   0   |     %0d     |  %b  |   %b   |   %b",
                  Count, Red, Amber, Green);
        ControlSignal = {2'b00, 4'd5}; #10;
        $display("RED   |   5   |     %0d     |  %b  |   %b   |   %b",
                  Count, Red, Amber, Green);
        ControlSignal = {2'b00, 4'd9}; #10;
        $display("RED   |   9   |     %0d     |  %b  |   %b   |   %b",
                  Count, Red, Amber, Green);

        // AMBER state (bits[5:4]=01), upcount 0 to 2
        ControlSignal = {2'b01, 4'd0}; #10;
        $display("AMBER |   0   |     %0d     |  %b  |   %b   |   %b",
                  Count, Red, Amber, Green);
        ControlSignal = {2'b01, 4'd2}; #10;
        $display("AMBER |   2   |     %0d     |  %b  |   %b   |   %b",
                  Count, Red, Amber, Green);

        // GREEN state (bits[5:4]=10), upcount 0 to 9
        ControlSignal = {2'b10, 4'd0}; #10;
        $display("GREEN |   0   |     %0d     |  %b  |   %b   |   %b",
                  Count, Red, Amber, Green);
        ControlSignal = {2'b10, 4'd9}; #10;
        $display("GREEN |   9   |     %0d     |  %b  |   %b   |   %b",
                  Count, Red, Amber, Green);

        $stop;
    end

    Decoder dut (
        .ControlSignal (ControlSignal),
        .Count         (Count),
        .Green         (Green),
        .Red           (Red),
        .Amber         (Amber)
    );

endmodule
