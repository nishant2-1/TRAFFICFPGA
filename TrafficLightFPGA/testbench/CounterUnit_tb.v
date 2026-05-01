`timescale 1 ns / 100 ps

module CounterUnit_tb;

    reg       CLK;
    reg [3:0] Setting;
    reg       rst_n;
    wire[3:0] Count;

    always begin
        #10;
        CLK <= ~CLK;
    end

    initial begin
        CLK     <= 1'b0;
        rst_n   <= 1'b0;
        Setting <= 4'd9;
        #40;
        $display("TEST1 Reset: Count=%0d (expect 0)", Count);

        rst_n <= 1'b1;
        $display("TEST2 Count up to 9:");
        repeat(12) begin
            #20;
            $display("  Count=%0d", Count);
        end

        Setting <= 4'd2;
        $display("TEST3 Count up to 2:");
        repeat(8) begin
            #20;
            $display("  Count=%0d (limit=2)", Count);
        end

        rst_n <= 1'b0;
        #40;
        $display("TEST4 Mid-reset: Count=%0d (expect 0)", Count);

        $stop;
    end

    CounterUnit dut (
        .CLK     (CLK),
        .Setting (Setting),
        .rst_n   (rst_n),
        .Count   (Count)
    );

endmodule
