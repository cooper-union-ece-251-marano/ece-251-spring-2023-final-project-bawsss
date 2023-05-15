///////////////////////////////////////////////////////////////////////////////
//
// MUX3 module
//
// An mux3 module for your Computer Architecture Elements Catalog
//
// module: mux3
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef MUX3
`define MUX3
`timescale 1ns/100ps

module mux3
    #(parameter n = 16) (
    input logic [(n-1):0] a, b, c,
    input logic [1:0] s,
    output logic [(n-1):0] result
    );

    always @ (a or b or c or s) begin
        case (s)
            2'b00: result <= a;
            2'b01: result <= b;
            2'b10: result <= c;
        endcase
    end
endmodule

`endif // MUX3
