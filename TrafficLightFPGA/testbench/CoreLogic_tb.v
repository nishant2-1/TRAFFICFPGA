`timescale 1 ns / 100 ps

module CoreLogic_tb;

    reg        CLK;
    reg        rst_n;
    wire [5:0] ControlSignal;

    reg [1:0] state_decoded;
    reg [3:0] count_decoded;

    always begin
        #10;
        CLK <= ~CLK;
    end

    initial begin
        CLK  <= 1'b0;
        rst_n <= 1'b0;
        #40;
        $display("TEST1 Reset: ControlSignal=%b (expect 000000)",
                  ControlSignal);

        rst_n <= 1'b1;
        $display("TEST2 Full sequence (30 cycles):");
        repeat(30) begin
            #20;
            state_decoded = ControlSignal[5:4];
            count_decoded = ControlSignal[3:0];
            case (state_decoded)
                2'b00: $display("  RED   count=%0d", count_decoded);
                2'b01: $display("  AMBER count=%0d", count_decoded);
                2'b10: $display("  GREEN count=%0d", count_decoded);
                2'b11: $display("  AMBER count=%0d", count_decoded);
            endcase
        end

        rst_n <= 1'b0;
        #40;
        $display("TEST3 Mid-reset: state=%b count=%0d (expect 00,0)",
                  ControlSignal[5:4], ControlSignal[3:0]);
        rst_n <= 1'b1;
        #20;
        $display("After release: state=%b (expect RED=00)",
                  ControlSignal[5:4]);
        $stop;
    end

    CoreLogic dut (
        .CLK           (CLK),
        .rst_n         (rst_n),
        .ControlSignal (ControlSignal)
    );

endmodule
