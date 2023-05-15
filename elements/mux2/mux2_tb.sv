///////////////////////////////////////////////////////////////////////////////
//
// MUX2 TESTBENCH module
//
// A mux2 testbench module for your Computer Architecture Elements Catalog
//
// module: mux2_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef MUX2_TB
`define MUX2_TB

`timescale 1ns/100ps
`include "./mux2.sv"

module mux2_tb();
    parameter n = 16;
    logic s;
    logic [(n-1):0] a, b;
    logic [(n-1):0] result;

    reg clk;

    logic reset;
    logic [51:0] testvectors[0:1000];
    logic [51:0] tmp;
    logic [15:0] vectornum, errors;
    logic [15:0] expectedResult;

    mux2 uut (
                .a(a),
                .b(b),
                .s(s),
                .result(result)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("mux2.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("mux2_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(negedge clk) begin
        #1; tmp = testvectors[vectornum];
        a = tmp[51:36];
        b = tmp[35:20];
        s = tmp[16];
        expectedResult = tmp[15:0];
    end

    always @(posedge clk) begin
        if (~reset) begin
            if ({result} !== {expectedResult}) begin
                $display("Error\tinputs: a = %h, b = %h, s = %h", a, b, s);
                $display("\tresult = %h, expectedResult = %h", result, expectedResult);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 52'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end
endmodule
`endif //MUX2_TB
