///////////////////////////////////////////////////////////////////////////////
//
// DATA MEMORY module
//
// An dmem module for your Computer Architecture Elements Catalog
//
// module: dmem
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef DMEM
`define DMEM
`timescale 1ns/100ps

module dmem (
    input logic clk, memWrite,
    input logic [15:0] address, writeData,
    output logic [15:0] readData
    );

    logic [15:0] MEMORY [32767:0];

    assign readData = MEMORY[address[15:1]];

    always @(posedge clk) begin
        if (memWrite) MEMORY[address[15:1]] <= writeData;
    end
endmodule

`endif // DMEM
