///////////////////////////////////////////////////////////////////////////////
//
// INSTRUCTION MEMORY TESTBENCH module
//
// An imem testbench module for your Computer Architecture Elements Catalog
//
// module: imem_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./imem.sv"

module imem_tb();
    logic [4:0] address;
    logic [15:0] instruction;

    reg clk, reset; //reset for initializing testvectors

    logic [23:0] testvectors[0:1000];
    logic [23:0] tmp;
    integer vectornum, errors;
    logic [15:0] expectedInstruction;


    imem uut (
             .address(address),
             .instruction(instruction)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("imem.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("imem_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; tmp = testvectors[vectornum];

        address = tmp[23:16];

        expectedInstruction = tmp[15:0];
    end

    always @(negedge clk) begin
        #1;
        if (~reset) begin
            if (instruction !== expectedInstruction) begin
                $display("Error:\tinputs: address = %h", address);
                $display("\tinstruction = %h, expectedInstruction = %h", instruction, expectedInstruction);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 24'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
