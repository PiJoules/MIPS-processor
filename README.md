# MIPS Processor in VHDL
Term project for ECEC 355.

![The MIPS Processor](http://i.imgur.com/6R3Xz.png)

## Usage
1. Download all the .vhd files here and add them to a project in modelsim.
2. Place binary mips instructions in a file `instructions.txt` and place it in the same directory as these .vhd files. The mips compiler will read the binary instructions from this file and run it after the first clock cycle.
3. On the modelsim command line, run `source setup.tcl`. This is a small script that automatically compiles the code, generates the simulation (though it doesn't run it), and adds the objects into the wave view. If this doesn't work, then you can just compile and run the normal way.

## How the code runs
The first clock cycle is always dedicated to reading the code from `instructions.txt` and saving it into the instruction memory (found in `instruction_memory.vhd`). It has nothing to do with the processor itself. This is just a preliminary action. Starting on the second clock cycle is when the program runs.

Every clock cycle after the first reads an instruction from the instruction memory and increments the program counter accordingly. The program will continue to run until the pc has reached an address greater than the address of the last instruction in memory. The instruction, data, and register memory will still persist after the program ends and will only change if it is overwritten, or the simulation ends.

## Suported Instructions
| Instruction | Format | Operation | Syntax |
|-------------|--------|-----------|--------|
| Add | R | R[rd] = R[rs] + R[rt] | add $rd, $rs, $rt |
| Add immediate | I | R[rt] = R[rs] + immed. | addi $rt, $rs, immed. |
| And | R | R[rd] = R[rs] & R[rt] | and $rd, $rs, $rt |
| Branch On Equal | I | if (R[rs]==R[rt]) PC=PC+4+BranchAddr | beq $rs, $rt, BranchAddr |
| Jump | J | PC=JumpAddr | j JumpAddr |
| Or | R | R[rd] = R[rs] \| R[rt] | or $rd, $rs, $rt |
| Set Less Than | R | R[rd] = (R[rs] < R[rt]) ? 1 : 0 | slt $rd, $rs, $rt |

## Components
Details of the major parts of the processor.
- main.vhd
  - The main script that is run. This is what should be selected as the design unit when simulating.
- pc.vhd
  - The program counter for pointing to the next instruction.
- instruction_memory.vhd
  - The block of memory that reads the instructions from a file and saves it into a 128 byte block of memory.
- control.vhd
  - Sets all the flags coming out of the controller appropriately given the 6-bit opcode
- registers.vhd
  - The block of 32 32-bit registers.
- sign_extend.vhd
  - Turns the 16-bit immediate to a 32-bit one by appending zeros. (Doesn't work yet with negative numbers.)
- alu_control.vhd
  - Given the 6-bit opcode and the 6-bit function, this chooses the operation the ALU should perform.
- alu.vhd
  - The ALU that performs either addition, subtraction, and-ing, or-ing, or set-on-less-than operations given the output of the ALU control.
- mux.vhd
  - Simple multiplexer implementation. Can only choose from 2 different inputs for now since 2 are all that's required.
- adder.vhd
  - The only reason why I made this is because the picture had an adder component in it. If the picture had a dragon on it, I would print out an ascii dragon to the wave view.
- shifter.vhd
  - For all your bit shifting needs.
- sign_extend.vhd
  - For ll you sign extending needs. Isn't this a very accurate description.
- memory.vhd
  - Sample text

## Todo
1. Add `lw` and `sw` support.
2. Profit.
3. Ayy lmao.