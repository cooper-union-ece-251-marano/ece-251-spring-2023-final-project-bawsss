///////////////////////////////////////////////////////////////////////////////
//
// DATA MEMORY TESTBENCH module
//
// An dmem testbench module for your Computer Architecture Elements Catalog
//
// module: dmem_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./dmem.sv"

module dmem_tb();
    logic memWrite;
    logic [15:0] address, writeData;

    logic [15:0] readData;

    reg clk, reset; //reset for initializing testvectors

    logic [51:0] testvectors[0:1000];
    logic [51:0] tmp;
    integer vectornum, errors;
    logic [15:0] expectedReadData;


    dmem uut (
             .clk(clk),
             .memWrite(memWrite),
             .address(address),
             .writeData(writeData),
             .readData(readData)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("dmem.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("dmem_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(negedge clk) begin
        #1; tmp = testvectors[vectornum];

        memWrite = tmp[48];
        address = tmp[47:32];
        writeData = tmp[31:16];

        expectedReadData = tmp[15:0];

    end

    always @(posedge clk) begin
        #1;
        if (~reset) begin
            if (readData !== expectedReadData) begin
                $display("Error:\tinputs: memWrite = %b, address = %h, writeData = %h", memWrite, address, writeData);
                $display("\treadData = %h, expectedReadData = %h", readData, expectedReadData);
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
