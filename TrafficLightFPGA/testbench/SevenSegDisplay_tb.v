`timescale 1 ns / 100 ps

module SevenSegDisplay_tb;

    reg  [3:0] Count;
    wire [6:0] SevenSegH, SevenSegL;

    integer i;
    initial begin
        $display("Count | SevenSegH  | SevenSegL  | Tens | Units");
        for (i = 0; i <= 10; i = i + 1) begin
            Count = i; #20;
            $display("  %2d  | %7b    | %7b    |  %0d   |  %0d",
                      Count, SevenSegH, SevenSegL,
                      (Count==10)?1:0, (Count==10)?0:Count);
        end
        $stop;
    end

    SevenSegDisplay dut (
        .Count     (Count),
        .SevenSegH (SevenSegH),
        .SevenSegL (SevenSegL)
    );

endmodule
