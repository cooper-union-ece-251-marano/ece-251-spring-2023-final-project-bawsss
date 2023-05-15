///////////////////////////////////////////////////////////////////////////////
//
// D FLOP FLOP WITH ASYNC RST module
//
// A dff module for your Computer Architecture Elements Catalog
//
// module: dff
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef DFF
`define DFF
`timescale 1ns/100ps

module dff (
    input logic rst, clk,
    input logic [15:0] d,
    output reg [15:0] q
    );

    always @(posedge clk, posedge rst) begin
        if (rst)
            q <= 15'b0;
        else
            q <= d;
    end

endmodule

`endif // DFF
