///////////////////////////////////////////////////////////////////////////////
//
// ADDER TESTBENCH module
//
// An adder testbench module for your Computer Architecture Elements Catalog
//
// module: adder_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./adder.sv"

module adder_tb();
    logic [15:0] a;
    logic [15:0] b;
    logic [15:0] result;

    reg clk, reset; //reset for initializing testvectors

    logic [47:0] testvectors[0:1000];
    logic [47:0] tmp;
    integer vectornum, errors;
    logic [15:0] expectedResult;


    adder uut (
             .a(a),
             .b(b),
             .result(result)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("adder_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; tmp = testvectors[vectornum];

        a = tmp[47:32];
        b = tmp[31:16];

        expectedResult = tmp[15:0];
    end

    always @(negedge clk) begin
        #1;
        if (~reset) begin
            if (result !== expectedResult) begin
                $display("Error:\tinputs: a = %h, b=%h", a, b);
                $display("\tresult = %h, expectedResult = %h", result, expectedResult);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 48'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
