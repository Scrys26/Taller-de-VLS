## How it works

This project implements a 2-to-1 multiplexer (MUX) with 4-bit wide inputs using Verilog.

The module has:
- Two 4-bit inputs: `a_i` and `b_i`
- One selection signal: `s_i`
- One 4-bit output: `q_o`

Operation:
- When `s_i = 0`, the output `q_o` is connected to `a_i`
- When `s_i = 1`, the output `q_o` is connected to `b_i`

The design uses a combinational `always @(*)` block so the output changes immediately whenever the inputs or selection signal change.

Truth table:

| s_i | q_o |
|-----|------|
|  0  | a_i  |
|  1  | b_i  |

## How to test

The project includes a testbench that automatically verifies the multiplexer operation.

Test procedure:
1. Initialize all inputs to zero
2. Iterate through every possible combination of:
   - Selection signal `s_i`
   - Input `a_i`
   - Input `b_i`
3. Observe the output `q_o`
4. Verify that:
   - `q_o = a_i` when `s_i = 0`
   - `q_o = b_i` when `s_i = 1`

Simulation waveform files are generated using:
- `tb.vcd`

These waveforms can be viewed using GTKWave or another VCD waveform viewer.

## External hardware

No external hardware is required for this project.