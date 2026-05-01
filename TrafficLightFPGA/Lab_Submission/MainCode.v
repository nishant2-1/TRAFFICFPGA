// MainCode.v – Top-level traffic light control
// Pure structural: only wires and module instantiations
// Pin mapping (Unit 4.1, DE10-Lite User Manual):
//   Clk_50MHz = PIN_P11   (50MHz clock)
//   rst_n     = PIN_B8    (KEY[0], active-low)
//   Red       = PIN_A8    (LEDR[0], active-high)
//   Amber     = PIN_A9    (LEDR[1], active-high)
//   Green     = PIN_A10   (LEDR[2], active-high)
//   HexL[6:0] = HEX0[6:0] PIN_C17 to PIN_C14
//   HexH[6:0] = HEX1[6:0] PIN_B17 to PIN_C18
module MainCode (
    input  wire       Clk_50MHz,
    input  wire       rst_n,
    output wire [6:0] HexH,
    output wire [6:0] HexL,
    output wire       Green,
    output wire       Red,
    output wire       Amber
);
    wire       CLK_1Hz;
    wire [5:0] ControlSignal;
    wire [3:0] Count;

    ClockDivider cd (
        .CLK_50MHz (Clk_50MHz),
        .rst_n     (rst_n),
        .CLK_1Hz   (CLK_1Hz)
    );

    CoreLogic cl (
        .CLK           (CLK_1Hz),
        .rst_n         (rst_n),
        .ControlSignal (ControlSignal)
    );

    Decoder d (
        .ControlSignal (ControlSignal),
        .Count         (Count),
        .Green         (Green),
        .Red           (Red),
        .Amber         (Amber)
    );

    SevenSegDisplay ssd (
        .Count     (Count),
        .SevenSegH (HexH),
        .SevenSegL (HexL)
    );

endmodule

// Add the ~ to invert the signals for the physical board
//assign HexL = ~HexL_internal; 
//assign HexH = ~HexH_internal;