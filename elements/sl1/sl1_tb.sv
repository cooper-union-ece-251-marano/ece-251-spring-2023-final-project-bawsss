///////////////////////////////////////////////////////////////////////////////
//
// SHIFT LEFT ONE TESTBENCH module
//
// A sl1 testbench module for your Computer Architecture Elements Catalog
//
// module: sl1_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./sl1.sv"

module sl1_tb();
    logic [15:0] in;
    logic [15:0] out;

    reg clk, reset; //reset for initializing testvectors

    logic [31:0] testvectors[0:1000];
    logic [31:0] tmp;
    integer vectornum, errors;
    logic [15:0] expectedOut;


    sl1 uut (
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
        $dumpfile("sl1.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("sl1_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; tmp = testvectors[vectornum];

        in = tmp[31:16];

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
            if (testvectors[vectornum] === 32'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
