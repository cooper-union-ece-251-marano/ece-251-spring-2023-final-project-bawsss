///////////////////////////////////////////////////////////////////////////////
//
// DFF TESTBENCH module
//
// A dff testbench module for your Computer Architecture Elements Catalog
//
// module: dff_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./dff.sv"

module dff_tb();
    logic [15:0] d;
    logic [15:0] q;
    logic rst; //rst for dff

    reg clk, reset; //reset for initializing testvectors

    logic [32:0] testvectors[0:1000];
    logic [32:0] tmp;
    integer vectornum, errors;
    logic [15:0] expectedQ;


    dff uut (
             .rst(rst),
             .clk(clk),
             .d(d),
             .q(q)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("dff.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("dff_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(negedge clk) begin
        #1; tmp = testvectors[vectornum];

        rst = tmp[32];
        d = tmp[31:16];

        expectedQ = tmp[15:0];
    end

    always @(posedge clk) begin
        #1;
        if (~reset) begin
            if (q !== expectedQ) begin
                $display("Error:\tinputs: rst = %b, d = %h", rst, d);
                $display("\tq = %h, expectedQ = %h", q, expectedQ);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 33'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
