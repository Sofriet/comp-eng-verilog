# comp-eng-verilog

Verilog source files for **Lab 1** of *Computer Engineering 2025* at **TU Delft**.

## Contents

- **async_en_decode.v**  
  Combinational decoder that drives four LEDs.  
  Selects between:
  - binary display mode, and
  - Gray-code direction decoding,  
  based on `prog_select`.

- **LFSR.v**  
  Linear Feedback Shift Register (LFSR) implementing the polynomial:  
  **x^6 + x^5 + x^3 + 1**.

- **road_sign_fsm.v**  
  Finite State Machine modeling a road safety sign controller.  
  Includes a testbench for simulation and verification.

## Notes
All modules are synthesizable Verilog designs developed for Lab 1 of the FPGA and digital design course

