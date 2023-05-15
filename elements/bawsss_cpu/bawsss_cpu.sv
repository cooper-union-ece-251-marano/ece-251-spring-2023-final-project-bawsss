///////////////////////////////////////////////////////////////////////////////
//
// BAWSSS_CPU module
//
// A bawsss_cpu module for your Computer Architecture Elements Catalog
//
// module: bawsss_cpu
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef BAWSSS_CPU
`define BAWSSS_CPU
`timescale 1ns/100ps

`include "../datapath/datapath.sv"
`include "../controller/controller.sv"

module bawsss_cpu (
    input logic clk, rst,
    input logic [15:0] instruction, readData,
    output logic memWrite,
    output logic [15:0] aluResult, memWriteData, pc
    );
    logic zero, regWrite, pcSrc;
    logic [1:0] regDst, memToReg, jump, aluSrc;
    logic [2:0] aluCtrl;

    controller bawsss_controller(
        instruction[15:12],
        zero,
        regWrite,
        memWrite,
        pcSrc,
        regDst,
        memToReg,
        jump,
        aluSrc,
        aluCtrl
        );
    datapath bawsss_dataPath(
        clk,
        rst,
        regWrite,
        pcSrc,
        regDst,
        memToReg,
        jump,
        aluSrc,
        aluCtrl,
        instruction,
        readData,
        aluResult,
        memWriteData,
        pc,
        zero
        );
endmodule

`endif // BAWSSS_CPU
