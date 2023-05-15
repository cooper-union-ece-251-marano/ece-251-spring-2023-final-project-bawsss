///////////////////////////////////////////////////////////////////////////////
//
// MUX3 TESTBENCH module
//
// A mux3 testbench module for your Computer Architecture Elements Catalog
//
// module: mux3_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////
`ifndef MUX3_TB
`define MUX3_TB

`timescale 1ns/100ps
`include "./mux3.sv"

module mux3_tb();
    parameter n = 16;
    logic [1:0] s;
    logic [(n-1):0] a, b, c;
    logic [(n-1):0] result;

    reg clk;

    logic reset;
    logic [71:0] testvectors[0:1000];
    logic [71:0] tmp;
    logic [15:0] vectornum, errors;
    logic [15:0] expectedResult;

    mux3 uut (
                .a(a),
                .b(b),
                .c(c),
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
        $dumpfile("mux3.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("mux3_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(negedge clk) begin
        #1; tmp = testvectors[vectornum];
        a = tmp[71:56];
        b = tmp[55:40];
        c = tmp[39:24];
        s = {tmp[20],tmp[16]};
        expectedResult = tmp[15:0];
    end

    always @(posedge clk) begin
        if (~reset) begin
            if ({result} !== {expectedResult}) begin
                $display("Error\tinputs: a = %h, b = %h, c = %h, s = %h", a, b, c, s);
                $display("\tresult = %h, expectedResult = %h", result, expectedResult);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 72'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end
endmodule
`endif //MUX2_TB
