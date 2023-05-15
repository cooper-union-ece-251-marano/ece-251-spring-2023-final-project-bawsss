///////////////////////////////////////////////////////////////////////////////
//
// REGFILE TESTBENCH module
//
// A regfile testbench module for your Computer Architecture Elements Catalog
//
// module: regfile_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./regfile.sv"

module regfile_tb();
    logic [3:0] readAddr1, readAddr2, writeAddr;
    logic [15:0] writeData;
    logic regWrite;
    reg clk, reset;

    logic [15:0] readData1, readData2;

    logic [60:0] testvectors[0:1000];
    logic [60:0] tmp;
    logic [15:0] vectornum, errors;
    logic [15:0] expectedReadData1;
    logic [15:0] expectedReadData2;



    regfile uut (
                 .readAddr1(readAddr1),
                 .readAddr2(readAddr2),
                 .writeAddr(writeAddr),
                 .writeData(writeData),
                 .regWrite(regWrite),
                 .clk(clk),
                 .readData1(readData1),
                 .readData2(readData2)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("regfile.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("regfile_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(negedge clk) begin
        #1; tmp = testvectors[vectornum];
        regWrite = tmp[60];
        writeAddr = tmp[59:56];
        writeData = tmp[55:40];
        readAddr1 = tmp[39:36];
        readAddr2 = tmp[35:32];

        expectedReadData1 = tmp[31:16];
        expectedReadData2 = tmp[15:0];
    end

    always @(posedge clk) begin
        #1;
        if (~reset) begin
            if ({readData1, readData2} !== {expectedReadData1, expectedReadData2}) begin
                $display("Error:\tinputs: regWrite = %b, writeAddr = %h, writeData = %h, readAddr1 = %h, readAddr2 = %h", regWrite, writeAddr, writeData, readAddr1, readAddr2);
                $display("\treadData1 = %h, readData2 = %b\n\texpectedReadData1 = %h, expectedReadData2 = %h", readData1, readData2, expectedReadData1, expectedReadData2);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 61'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
