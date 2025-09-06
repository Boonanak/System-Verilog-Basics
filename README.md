# System Verilog Basics

This repository includes many different flexible and well-documented system verilog modules. These modules contain RTL. 

They are flexible in the sense that they are often declared with a width parameter that can be toggled to create modules of different sizes. For example, with the LFSR you can manipulate the size of the register and the location of the taps, (however you should probably follow a taps table when specifying their locations to emulate how it would actually function with real hardware).

Each module also includes a robust testbench and a capture of the resulting waveform in ModelSim to see how the module functions.

The purpose of many of these modules are not just to be proof of concepts but to make use of the object-oriented nature of System Verilog by being able to be instantiated in higher level modules if desired.

## Modules
1. [Hello World](hello-world)
2. [FSM](FSM)
3. [Set Reset Flip Flop](SRFF)
4. [JK Flip Flop](JKFF)
5. [D Flip Flop](DFF)
6. [Register](register)
7. [Load Register](load-register)
8. [Shift Register](shift-register)
9. [Linear Feedback Shift Register](LFSR)
10. [Encoder](encoder)
11. [Decoder](decoder)
12. [Basic Counter](basic-counter)
13. [Complex Counter](complex-counter)