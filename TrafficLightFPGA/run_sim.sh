#!/bin/bash
MODULE=$1
echo "========================================="
echo "  Simulating: $MODULE"
echo "========================================="
rm -f sim/dump.vcd sim/sim_out

case $MODULE in
    ClockDivider)
        iverilog -o sim/sim_out \
            testbench/ClockDivider_tb.v \
            src/ClockDivider.v
        ;;
    CounterUnit)
        iverilog -o sim/sim_out \
            testbench/CounterUnit_tb.v \
            src/CounterUnit.v
        ;;
    CoreLogic)
        iverilog -o sim/sim_out \
            testbench/CoreLogic_tb.v \
            src/CoreLogic.v \
            src/CounterUnit.v
        ;;
    Decoder)
        iverilog -o sim/sim_out \
            testbench/Decoder_tb.v \
            src/Decoder.v
        ;;
    SevenSegDisplay)₹₹
        iverilog -o sim/sim_out \
            testbench/SevenSegDisplay_tb.v \
            src/SevenSegDisplay.v
        ;;
    MainCode)
        iverilog -o sim/sim_out \
            testbench/MainCode_tb.v \
            src/MainCode.v \
            src/ClockDivider.v \
            src/CoreLogic.v \
            src/CounterUnit.v \
            src/Decoder.v \
            src/SevenSegDisplay.v
        ;;
    *)
        echo "Usage: ./run_sim.sh <ClockDivider|CounterUnit|CoreLogic|Decoder|SevenSegDisplay|MainCode>"
        exit 1
        ;;
esac

if [ $? -ne 0 ]; then
    echo "❌ COMPILE FAILED — fix errors above"
    exit 1
fi

echo "✅ Compiled successfully"
echo "--- Simulation Output ---"
vvp sim/sim_out
echo "--- Done ---"