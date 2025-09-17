# 16-bit-RISC-processor

## 📌 Overview
This project implements a simple **16-bit RISC Processor** in Verilog HDL.  
It is designed with modular components such as instruction decoder, ALU, control unit, program counter, register file, and fake RAM.  
The testbench integrates all modules together to verify the processor functionality.

---

## 🏗️ Modules Implemented
- **Instruction Decoder** – Extracts opcode, register selectors, and immediate values from the instruction.  
- **ALU (Arithmetic Logic Unit)** – Performs arithmetic, logical, shift, and branching operations.  
- **Control Unit** – Generates control signals for instruction execution stages.  
- **Register File** – Holds general-purpose registers and supports read/write operations.  
- **Program Counter (PC)** – Maintains the address of the next instruction.  
- **Fake RAM** – Provides simple instruction and data storage for testing.

---

## 🧪 Main Testbench (`main_test`)
- Integrates **all modules** into a working processor system.  
- Simulates **fetch, decode, execute, memory, and write-back** stages.  
- Includes instruction execution with branching and memory operations.  
- Clock and reset are generated inside the testbench.  
- Produces waveforms for verifying correct processor behavior.


