# MIPS Processor in VHDL
Term project for ECEC 355

## Usage
1. Download all the .vhd files here and add them to a project in modelsim.
2. Place binary mips instructions in a file `instructions.txt` and place it in the same directory as these .vhd files. The mips compiler will read the binary instructions from this file and run it after the first clock cycle.
3. On the modelsim command line, run `source setup.tcl`. This is a small script that automatically compiles the code, generates the simulation (though it doesn't run it), and adds the objects into the wave view. If this doesn't work, then you can just compile and run the normal way.

## How the code runs
The first clock cycle is always dedicated to reading the code from `instructions.txt` and saving it into the instruction memory (found in `instruction_memory.vhd`). It has nothing to do with the processor itself. This is just a preliminary action. Starting on the second clock cycle is when the program runs. Every clock cycle after the first reads an instruction from the instruction memory and increments the program counter accordingly. The program will continue to run until the pc has reached an address greater than the address of the last instruction in memory.

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