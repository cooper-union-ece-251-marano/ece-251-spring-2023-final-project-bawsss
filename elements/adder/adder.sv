///////////////////////////////////////////////////////////////////////////////
//
// 16 bit ADDER module
//
// An adder module for your Computer Architecture Elements Catalog
//
// module: sl2
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef ADDER
`define ADDER
`timescale 1ns/100ps

module adder (
    input logic [15:0] a,
    input logic [15:0] b,
    output logic [15:0] result
    );

    assign result = a + b;

endmodule

`endif // ADDER
