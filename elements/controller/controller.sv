///////////////////////////////////////////////////////////////////////////////
//
// CONTROLLER module
//
// A controller module for your Computer Architecture Elements Catalog
//
// module: controller
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef CONTROLLER
`define CONTROLLER
`timescale 1ns/100ps

`include "../maindec/maindec.sv"

module controller (
    input logic [3:0] op,
    input logic zero,
    output logic regWrite, memWrite, pcSrc,
    output logic [1:0] regDst, memToReg, jump, aluSrc,
    output logic [2:0] aluCtrl
    );


    logic branch;
    maindec mainDecoder(
        op,
        regWrite,
        branch,
        memWrite,
        regDst,
        memToReg,
        jump,
        aluSrc,
        aluCtrl
        );
    assign pcSrc = branch & zero;
endmodule

`endif // CONTROLLER
