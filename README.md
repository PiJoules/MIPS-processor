# MIPS Processor in VHDL
Term project for ECEC 355

## Usage
Place binary mips instructions in a file `instructions.txt`, then compile and run the code normally in Modelsim. The project will first load the instructions into memory, then run the program normally.

## Components
Details of the major parts of the processor.
- main.vhd
  - The main script that is run. This is what should be selected as the design unit when simulating.
- pc.vhd
  - The program counter for pointing to the next instruction.
- instruction_memory.vhd
  - The block of memory that reads the instructions from a file and saves it into a 128 byte block of memory.

## Todo
1. Write all the other required components in.
2. Profit.
3. Ayy lmao.