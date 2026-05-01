# 🚦 FPGA Traffic Light Controller
A Verilog implementation of a timed traffic light system for the **DE10-Lite (MAX 10)** board.

## 📂 Project Structure
*   **/src**: Main Verilog logic files.
*   **/testbench**: Simulation files for verification.
*   **auto_pin_assignment.tcl**: Script to automate hardware pin setup.

## 🚀 Quick Start for Windows (Quartus)
1. **Download** this repository as a ZIP.
2. **Open Quartus** and create a new project named `MainCode`.
3. **Add all files** from the `src` folder to the project.
4. **Select Device**: MAX 10 `10M50DAF484C7G`.
5. **Run the Script**: Open the **Tcl Console** (View > Utility Windows) and type:  
   `source auto_pin_assignment.tcl`
6. **Compile**: Hit 'Start Compilation'.

## ⚠️ Important Note on Clock Speed
*   For **Board Testing**: Ensure `HALF_PERIOD = 25000000` in `ClockDivider.v`.
*   For **Simulation**: Set `HALF_PERIOD = 50` so the waves move faster!
