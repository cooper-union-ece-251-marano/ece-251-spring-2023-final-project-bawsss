# **16-bit MIPS Inspired CPU**
## **ECE-251 Final Project**
### By Fred Kim and Andy Jaku
## **--------------------------------------------**
## **How to use**
When in the home directory, perform:

    cd bawsssASSEMBLER

Within the directory you can create a new .txt file which should contain the assembly code you want to run.
There are also two prepared assembly programs you could, leaf.txt or fib.txt.

```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

def leafProcedure(g, h, i, j):
  f = (g+h) - (i+j)
  return f
```

Within leaf.txt and fib.txt, you need to change the immediate commented as INPUT: to the desired value

Once you've either created a new file, or adjusted the existing files, type:

    python3 assembler.py FILENAME.txt

You are now ready to simulate the CPU, type:

    cd ..
    cd elements/bawsss_computer
    make clean compile simulate

The final output should appear within the terminal (Fibonacci of 9)

```bash
/bin/rm -f bawsss_computer.vvp *.vcd a.out compiler.out
iverilog -g2012  -o bawsss_computer.vvp bawsss_computer.sv bawsss_computer_tb.sv
vvp -M .  bawsss_computer.vvp -lxt2
WARNING: ./../imem/imem.sv:27: $readmemh: Standard inconsistency, following 1364-2005.
WARNING: ./../imem/imem.sv:27: $readmemh(imem_datafile.dat): Not enough words in the file for the requested range [0:31].
LXT2 info: dumpfile bawsss_computer.vcd opened for output.
Address: 0000
Output (hex): 0022
Output (dec):    34
```

Youtube Video: https://youtu.be/MxGjCnYkfdc
Sorry for the bad quality, recently downloaded ubuntu and OBS doesn't seem to work.

## **--------------------------------------------**

## **Overall Description**

We designed a 16-Bit Mips based CPU. The CPU itself is composed of 14 essential components, listed below:

    adder
    alu
    clock
    controller
    datapath
    dff
    dmem
    imem
    maindec
    mux2
    mux3
    regfile
    signext
    sl1

Each component is responsible for an aspect of the CPU which can be visualized within the diagram below.

### **CPU Diagram**
![PC](/images/PC.png)

The brains of the CPU reside within the control signals, which dictate the flow of information within the CPU depending on the OPCODE supplied to the controller. The control signals were carefully derived from MIPS implementations and Prof. Marano's OttoBit CPU.

### **Control Signals**
![control](/images/control.png)

Compared to the OttoBit CPU, a few changes needed to be made to the control signals. As can be seen within the image, the following control signals had their behavior altered

    regDst
    memToReg
    jump
    aluSrc
    aluCtrl

Altered: regDst [1] -> [1:0] allows for an additional selection pin to R[15] which is needed when trying to perform the jal instruction.


Altered: memToReg [1:0] -> [2:0] accomdates the jal instruction, as the desired input for regWriteData is PC + 2 rather than the previously alloted inputs.

Altered: jump [1:0] -> [2:0] allows for a distinction between the desired pcNext as jr requires it to be PC + 2, meanwhile jal wants the input from the immediate.

Altered: alurSrc [1] -> [1-0] distinguishes the sll and srl opcodes from the immediate opcodes, which is necessary since rt doubles a shamt for the shift instructions.

Altered: aluCtrl encompasses the aluOp control signals, removing the need for an aluDecoder. Instead, all alu operations are defined as by the [2:0] aluCtrl signal.

A few short comings of our decisions:


Off the bat, by limiting the immediates to only four bits, no value larger than +- 7 can be added or subtracting, making the CPU inconvenient for use.

Aditionally, due to a limited number of instructions, multiply and divide were not implemented, further limiting the scope of the cpu.

Both of these limitations could be overcome through clever workings of the assembler, however, there was not enough time to implement those features.

## **--------------------------------------------**

## **ISA**
Inspired by MIPS, source for MIPS Reference Sheet:

https://inst.eecs.berkeley.edu/~cs61c/resources/MIPS_Green_Sheet.pdf

| ISA Aspect | Implementation |
| ------------- | ------- |
| Address Bus Size | 0 |
| Adressability | Byte |
| Instruction Length | 16 bits |
| PC Increment | 2 bytes |
| Immediate Size | 4 bits |

### **Instructions**
![instructions](/images/instructions.png)

### **R-Type ISA**
![r](/images/r.png)

### **I-Type ISA**
![i](/images/i.png)

### **J-Type ISA**
![j](/images/j.png)

### **Registers**

| Register | Location |
| -------- | -------- |
| $zero | 0 |
| $at | 1 |
| $v0 | 2 |
| $v1 | 3 |
| $a0 | 4 |
| $a1 | 5 |
| $t0 | 6 |
| $t1 | 7 |
| $t2 | 8 |
| $t3 | 9 |
| $s0 | A |
| $s1 | B |
| $s2 | C |
| $s3 | D |
| $sp | E |
| $ra | F |

*Note: $zero is pre-set to store the value 0.

### **Memory**
Within the CPU, memory is split into Instruction Memory (imem) and Data Memory (dmem).
#### **Instruction Memory**
The instruction memory is as large as the assembly file, and is represented as machine code which
is generated by assembler.py and stored within imem_datafile.dat (in the bawsss_computer directory)
#### **Data Memory**
The data memory is where memory is written into, and it is [15:0] [32767:0] 2D array of memory slots.

## **--------------------------------------------**

## **Details of Implementation**

#### **ALU Operations**
| Syntax | Operation |
| ------ | --------- |
| a & b | and |
| a | b | or |
| a + b | odd |
| a << b | sll |
| ~(a | b) | nor |
| a >> b | srl |
| a - b | slt |


### **Example of Timing Diagrams**
The following instructions were run, and the output is displayed below

| Type | Instruction | Machine Code |
| - | ----------- | ------------ |
| I | addi $a0 $zero 7 | A047 |
| I | addi $a0 $a0 3   | A443 |
| R | add $s0 $a0 $a0  | 044A |
| R | sll $s0 $s0      | 6A2A |
| R | srl $s1 $s0 1    | 7A1B |
| R | slt $at $s1 $s0  | 8BA1 |
| J | jal 0xA          | F001 |
| J | jr $ra           | 3F00 |
| J | j 0x0            | E000 |

#### **Timing Diagram**
![irj](/images/irj.png)