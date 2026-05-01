# -------------------------------------------------------------------------- #
# DE10-Lite Automated Pin Assignment Script
# -------------------------------------------------------------------------- #

# Set the target FPGA device
set_global_assignment -name DEVICE 10M50DAF484C7G

# Clock and Reset
set_location_assignment PIN_P11 -to clk_50MHz
set_location_assignment PIN_C10 -to rst_n

# Traffic Light LEDs
set_location_assignment PIN_A8  -to Red
set_location_assignment PIN_A9  -to Amber
set_location_assignment PIN_A10 -to Green

# 7-Segment Display: HEXL (Right Side - Units)
set_location_assignment PIN_C14 -to HexL[0]
set_location_assignment PIN_E15 -to HexL[1]
set_location_assignment PIN_C15 -to HexL[2]
set_location_assignment PIN_C16 -to HexL[3]
set_location_assignment PIN_E16 -to HexL[4]
set_location_assignment PIN_D17 -to HexL[5]
set_location_assignment PIN_C17 -to HexL[6]

# 7-Segment Display: HEXH (Left Side - Tens)
set_location_assignment PIN_F18 -to HexH[0]
set_location_assignment PIN_E20 -to HexH[1]
set_location_assignment PIN_E19 -to HexH[2]
set_location_assignment PIN_J18 -to HexH[3]
set_location_assignment PIN_H19 -to HexH[4]
set_location_assignment PIN_F19 -to HexH[5]
set_location_assignment PIN_F20 -to HexH[6]

# Force Quartus to refresh the assignments
export_assignments
