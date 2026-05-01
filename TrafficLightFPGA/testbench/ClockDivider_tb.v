// Using a very small period here because simulating 
    // 25 million cycles would take too long in ModelSim/Questa.
    // Testing the toggle logic specifically.
`timescale 1 ns / 100 ps

module ClockDivider_tb;

    reg  CLK_50MHz;
    reg  rst_n;
    wire CLK_1Hz;

    // Handbook clock pattern: always begin (no sensitivity list)
    always begin
        #10;
        CLK_50MHz <= ~CLK_50MHz;
    end

    initial begin
        CLK_50MHz <= 1'b0;
        rst_n     <= 1'b0;
        #40;
        $display("T=%0t | RESET active: CLK_1Hz=%b (expect 0)", $time, CLK_1Hz);
        rst_n <= 1'b1;
        #200;
        $display("T=%0t | After release: CLK_1Hz=%b (expect toggling)", $time, CLK_1Hz);
        #200;
        rst_n <= 1'b0;
        #40;
        $display("T=%0t | RESET again: CLK_1Hz=%b (expect 0)", $time, CLK_1Hz);
        #100;
        $stop;
    end

    ClockDivider dut (
        .CLK_50MHz (CLK_50MHz),
        .rst_n     (rst_n),
        .CLK_1Hz   (CLK_1Hz)
    );

endmodule

