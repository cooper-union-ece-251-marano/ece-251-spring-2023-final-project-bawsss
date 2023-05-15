///////////////////////////////////////////////////////////////////////////////
//
// ALU TESTBENCH module
//
// An alu testbench module for your Computer Architecture Elements Catalog
//
// module: alu_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./alu.sv"

module alu_tb();
    logic [15:0] a, b;
    logic [2:0] ctrl;
    logic [15:0] result;
    logic zero;

    reg clk, reset;

    logic [55:0] testvectors[0:1000];
    logic [55:0] tmp;
    logic [15:0] vectornum, errors;
    logic [15:0] expectedResult;
    logic expectedZero;


    alu uut (
             .a(a),
             .b(b),
             .ctrl(ctrl),
             .result(result),
             .zero(zero)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("alu_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; tmp = testvectors[vectornum];
        ctrl = tmp[54:52];
        a = tmp[51:36];
        b = tmp[35:20];
        expectedResult = tmp[19:4];
        expectedZero = tmp[0];
    end

    always @(negedge clk) begin
        if (~reset) begin
            if ({result, zero} !== {expectedResult, expectedZero}) begin
                $display("Error:\tinputs: ctrl = %h, a = %h, b = %h", ctrl, a , b);
                $display("\tresult = %h, zero = %b\n\texpectedResult = %h, expectedZero = %h", result, zero, expectedResult, expectedZero);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 56'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
