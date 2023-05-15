///////////////////////////////////////////////////////////////////////////////
//
// MUX2 module
//
// An mux2 module for your Computer Architecture Elements Catalog
//
// module: mux2
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef MUX2
`define MUX2
`timescale 1ns/100ps

module mux2
    #(parameter n = 16) (
    input logic [(n-1):0] a, b,
    input logic s,
    output logic [(n-1):0] result
    );

    assign result = s ? b : a;

endmodule

`endif // MUX2
