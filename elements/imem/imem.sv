///////////////////////////////////////////////////////////////////////////////
//
// INSTRUCTION MEMORY module
//
// An imem module for your Computer Architecture Elements Catalog
//
// module: imem
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef IMEM
`define IMEM
`timescale 1ns/100ps

module imem (
    input logic [4:0] address,
    output logic [15:0] instruction
    );

    logic [15:0] MEMORY [31:0];

    initial begin
        $readmemh("imem_datafile.dat", MEMORY);
    end

    assign instruction = MEMORY[address];

endmodule

`endif // IMEM
