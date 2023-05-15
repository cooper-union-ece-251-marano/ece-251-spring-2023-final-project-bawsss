///////////////////////////////////////////////////////////////////////////////
//
// BAWSSS COMPUTER module
//
// A bawsss_computer module for your Computer Architecture Elements Catalog
//
// module: bawsss_computer
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef BAWSSS_COMPUTER
`define BAWSSS_COMPUTER
`timescale 1ns/100ps

`include "../bawsss_cpu/bawsss_cpu.sv"
`include "../imem/imem.sv"
`include "../dmem/dmem.sv"

module bawsss_computer (
    input logic clk, rst,
    output logic [15:0] writeData, address,
    output logic memWrite
    );

    logic [15:0] instruction, readData, pc;

    bawsss_cpu bawsss(
        clk,
        rst,
        instruction,
        readData,
        memWrite,
        address,
        writeData,
        pc
    );


    imem imem(
        pc[5:1],
        instruction
    );

    dmem dmem(
        clk,
        memWrite,
        address,
        writeData,
        readData
    );

endmodule

`endif // BAWSSS_COMPUTER