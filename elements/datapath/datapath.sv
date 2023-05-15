///////////////////////////////////////////////////////////////////////////////
//
// DATAPATH module
//
// A datapath module for your Computer Architecture Elements Catalog
//
// module: datapath
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef DATAPATH
`define DATAPATH
`timescale 1ns/100ps

`include "../maindec/maindec.sv"
`include "../mux2/mux2.sv"
`include "../mux3/mux3.sv"
`include "../adder/adder.sv"
`include "../dff/dff.sv"
`include "../alu/alu.sv"
`include "../signext/signext.sv"
`include "../sl1/sl1.sv"
`include "../regfile/regfile.sv"


module datapath (
    input logic clk, rst, regWrite, pcSrc,
    input logic [1:0] regDst, memToReg, jump, aluSrc,
    input logic [2:0] aluCtrl,

    input logic [15:0] instruction, readData,

    output logic [15:0] aluResult, memWriteData, pc,
    output logic zero
    );


    logic [15:0] pcNext, pcPlus2, pcBranch, pcBranchNext;
    logic [15:0] signImmediate,signImmediateSHIFTED;

    logic [3:0] writeAddr;
    logic [15:0] regWriteData;

    logic [15:0] aluA, aluB;

    //from left to right of mips architecture

    //pc
    dff pcReg(rst, clk, pcNext, pc);
    adder add(pc, 16'b10, pcPlus2);

    sl1 shImmediate(signImmediate,signImmediateSHIFTED);
    adder addAlu(pcPlus2,signImmediateSHIFTED, pcBranch);

    mux2 #(16) branchMux(pcPlus2, pcBranch, pcSrc, pcBranchNext);
    mux3 #(16) pcMux(pcBranchNext, {pcPlus2[15:13], instruction[11:0], 1'b0}, aluA, jump, pcNext);

    //regfile
    mux3 #(4) writeAddrMux(instruction[7:4], instruction[3:0], 4'b1111, regDst, writeAddr);
    regfile rf(instruction[11:8], instruction[7:4], writeAddr, regWriteData, regWrite, clk, aluA, memWriteData);
    signext signExtender(instruction[3:0], signImmediate);
    mux3 #(16) memMux(aluResult, readData, pcPlus2, memToReg, regWriteData);


    //alu
    mux3 #(16) aluBMux(memWriteData,signImmediate, {12'b0,instruction[7:4]}, aluSrc, aluB);
    alu alu(aluA, aluB, aluCtrl, aluResult, zero);



endmodule

`endif // DATAPATH
