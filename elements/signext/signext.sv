///////////////////////////////////////////////////////////////////////////////
//
// SIGN EXTENDER module
//
// A signext module for your Computer Architecture Elements Catalog
//
// module: signext
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef SIGNEXT
`define SIGNEXT
`timescale 1ns/100ps

module signext (
    input logic [3:0] in,
    output logic [15:0] out
    );

    always @* begin
        out <= {{12{in[3]}}, in};
    end

endmodule

`endif // SIGNEXT
