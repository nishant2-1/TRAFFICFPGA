`timescale 1 ns / 100 ps

module MainCode_tb;

    reg        Clk_50MHz;
    reg        rst_n;
    wire [6:0] HexH, HexL;
    wire       Green, Red, Amber;

    always begin
        #10;
        Clk_50MHz <= ~Clk_50MHz;
    end

    initial begin
        Clk_50MHz <= 1'b0;
        rst_n     <= 1'b0;
        #40;
        $display("RESET: Red=%b Amber=%b Green=%b (expect R=1 A=0 G=0)",
                  Red, Amber, Green);
        rst_n <= 1'b1;
        repeat(300) begin
            #20;
            if (Red)   $display("RED   | HexH=%b HexL=%b", HexH, HexL);
            if (Amber) $display("AMBER | HexH=%b HexL=%b", HexH, HexL);
            if (Green) $display("GREEN | HexH=%b HexL=%b", HexH, HexL);
        end
        $stop;
    end

    MainCode dut (
        .Clk_50MHz (Clk_50MHz),
        .rst_n     (rst_n),
        .HexH      (HexH),
        .HexL      (HexL),
        .Green     (Green),
        .Red       (Red),
        .Amber     (Amber)
    );

endmodule
