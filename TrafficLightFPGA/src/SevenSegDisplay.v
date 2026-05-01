// SevenSegDisplay.v
// Unit 4.2: BCD conversion + 7-segment encoding
// BCD_to_7-Seg.pptx: SOP expression approach
// DE10-Lite: active-low segments (0=ON, 1=OFF), common anode
// HEX[6:0] = {g, f, e, d, c, b, a}

module SevenSegDisplay (
    input  wire [3:0] Count,
    output reg  [6:0] SevenSegH,  // Tens digit
    output reg  [6:0] SevenSegL   // Units digit
);
    reg [3:0] tens, units;

    // BCD conversion (Unit 4.2 approach for fixed input range 0-10)
    always @(*) begin
        if (Count == 4'd10) begin
            tens  = 4'd1;
            units = 4'd0;
        end else begin
            tens  = 4'd0;
            units = Count;
        end
    end

    // 7-segment function: BCD digit to active-low segment encoding
    // Truth table from BCD_to_7-Seg.pptx and DE10-Lite User Manual
    function [6:0] to7seg;
        input [3:0] digit;
        case (digit)
            4'd0: to7seg = 7'b1000000; // 0: a,b,c,d,e,f on, g off
            4'd1: to7seg = 7'b1111001; // 1: b,c on only
            4'd2: to7seg = 7'b0100100; // 2: a,b,d,e,g on
            4'd3: to7seg = 7'b0110000; // 3: a,b,c,d,g on
            4'd4: to7seg = 7'b0011001; // 4: b,c,f,g on
            4'd5: to7seg = 7'b0010010; // 5: a,c,d,f,g on
            4'd6: to7seg = 7'b0000010; // 6: a,c,d,e,f,g on
            4'd7: to7seg = 7'b1111000; // 7: a,b,c on
            4'd8: to7seg = 7'b0000000; // 8: all segments on
            4'd9: to7seg = 7'b0010000; // 9: a,b,c,d,f,g on
            default: to7seg = 7'b1111111; // blank
        endcase
    endfunction

    always @(*) begin
        SevenSegH = to7seg(tens);
        SevenSegL = to7seg(units);
    end

endmodule
