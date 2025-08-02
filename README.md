# Design and Implementation of a 5-Stage Pipelined RISC Processor

### Course: CS F342: Computer Architecture

## 1. Project Description

This project involves the design, implementation, and verification of a 5-stage pipelined RISC processor. The processor follows the classic Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), and Write Back (WB) pipeline stages. The primary goal was to create a functional processor that can execute a specific set of instructions while effectively handling data hazards using a dedicated forwarding unit. This design ensures that the processor can operate efficiently without requiring pipeline stalls for data dependencies.

## 2. Instruction Set Architecture (ISA)

The processor is designed to execute a subset of instructions, which are handled by the `Control_Unit` module based on their `opcode`. The following instructions are supported:

| **Instruction** | **Opcode** | **Description** |
| :--- | :--- | :--- |
| `nor` | `4'b0000` | Performs a bitwise NOR operation. |
| `nand` | `4'b0001` | Performs a bitwise NAND operation. |
| `sw` | `4'b0011` | Stores a word to data memory. |
| `xnori` | `4'b0111` | Performs a bitwise XNOR with an immediate value. |
| `add` | `4'b1111` | Performs an addition. |

## 3. Components

The project is modularized into several Verilog components that work together to form the complete processor.

* `ALU_Unit.v`: The Arithmetic Logic Unit, responsible for performing all arithmetic and logical operations.

* `Control_Unit.v`: Generates the control signals for all other modules based on the instruction opcode.

* `Data_Memory.v`: A memory unit for storing and retrieving data.

* `EX_M.v`: The pipeline register between the Execute and Memory stages.

* `Forwarding_Unit.v`: Detects data hazards and generates control signals to forward data from later pipeline stages.

* `ID_EX.v`: The pipeline register between the Decode and Execute stages.

* `IF_ID.v`: The pipeline register between the Fetch and Decode stages.

* `Instruction_Memory.v`: A memory unit that stores the program instructions.

* `M_WB.v`: The pipeline register between the Memory and Write Back stages.

* `PC_Register.v`: The Program Counter register, which holds the address of the current instruction.

* `Register_File.v`: A set of 16 general-purpose registers for storing data.

* `Sign_Extender.v`: Extends a 16-bit immediate value to a 32-bit value for use in operations.

* `Top.v`: The top-level module that instantiates and connects all other components, serving as the testbench for simulation.

## 4. Pipeline Diagram

<img width="1214" height="637" alt="Screenshot 2025-08-02 at 4 46 03 PM" src="https://github.com/user-attachments/assets/6fa19ca4-d86a-4c5d-bfbf-5ff4e6f74360" />

## 5. Abstract

This project details the design, implementation, and verification of a 5-stage pipelined RISC processor. The processor is capable of executing a specific subset of instructions and utilizes a standard IF-ID-EX-MEM-WB pipeline structure. A key feature of the design is a dedicated forwarding unit to detect and resolve data hazards, allowing for efficient execution of instructions without requiring pipeline stalls. The entire processor was implemented in Verilog HDL and verified through simulation, successfully demonstrating the intended functionality and producing the expected final register state.

## 6. Simulation and Verification

The processor's functionality was validated through simulation using the `Top.v` module as a testbench. The simulation successfully executed a predefined instruction sequence, and the final value observed in the register file matched the expected result, confirming the correct functionality of the forwarding unit and the overall pipelined design.

## 7. How to Use

1. **Clone the repository:** Clone this repository to your local machine.

2. **Open the project:** Use a Verilog IDE or a command-line tool (e.g., Icarus Verilog, ModelSim).

3. **Run the simulation:** Compile all the Verilog modules and run the `Top.v` module, which contains the testbench to simulate the processor's operation.
