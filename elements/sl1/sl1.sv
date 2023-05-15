///////////////////////////////////////////////////////////////////////////////
//
// SHIFT LEFT ONE module
//
// A sl1 module for your Computer Architecture Elements Catalog
//
// module: sl1
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef SL1
`define SL1
`timescale 1ns/100ps

module sl1 (
    input logic [15:0] in,
    output logic [15:0] out
    );

    always @* begin
        out <= in << 1;
    end

endmodule

`endif // SL1
