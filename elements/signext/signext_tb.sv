///////////////////////////////////////////////////////////////////////////////
//
// SIGN EXTENDER TESTBENCH module
//
// A signext testbench module for your Computer Architecture Elements Catalog
//
// module: signext_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./signext.sv"

module signext_tb();
    logic [3:0] in;
    logic [15:0] out;

    reg clk, reset; //reset for initializing testvectors

    logic [19:0] testvectors[0:1000];
    logic [19:0] tmp;
    integer vectornum, errors;
    logic [15:0] expectedOut;


    signext uut (
             .in(in),
             .out(out)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("signext.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("signext_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; tmp = testvectors[vectornum];

        in = tmp[19:16];

        expectedOut = tmp[15:0];
    end

    always @(negedge clk) begin
        #1;
        if (~reset) begin
            if (out !== expectedOut) begin
                $display("Error:\tinputs: in = %h", in);
                $display("\tout = %h, expectedOut = %h", out, expectedOut);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 20'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
