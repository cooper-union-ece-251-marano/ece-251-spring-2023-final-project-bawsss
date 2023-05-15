///////////////////////////////////////////////////////////////////////////////
//
// DATAPATH TESTBENCH module
//
// A datapath testbench module for your Computer Architecture Elements Catalog
//
// module: datapath_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./datapath.sv"

module datapath_tb();
    logic rst, regWrite, pcSrc;
    logic [1:0] regDst, memToReg, jump, aluSrc;
    logic [2:0] aluCtrl;
    logic [15:0] instruction, readData;

    logic[15:0] aluResult, memWriteData, pc;
    logic zero;

    reg clk, reset; //reset for initializing testvectors

    logic [139:0] testvectors[0:1000];
    logic [139:0] tmp;
    integer vectornum, errors;
    //expected

    logic [15:0] expectedAluResult, expectedMemWriteData, expectedPc;
    logic expectedZero;


    datapath uut (
             .clk(clk),
             .rst(rst),
             .regWrite(regWrite),
             .regDst(regDst),
             .memToReg(memToReg),
             .jump(jump),
             .aluSrc(aluSrc),
             .pcSrc(pcSrc),
             .aluCtrl(aluCtrl),
             .instruction(instruction),
             .readData(readData),
             .aluResult(aluResult),
             .memWriteData(memWriteData),
             .pc(pc),
             .zero(zero)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("datapath.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("datapath_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        tmp = testvectors[vectornum];

        rst = tmp[136];
        regWrite = tmp[132];
        regDst = {tmp[128], tmp[124]};
        memToReg = {tmp[120], tmp[116]};
        jump = {tmp[112], tmp[108]};
        aluSrc = {tmp[104], tmp[100]};
        pcSrc = tmp[96];
        aluCtrl = {tmp[92], tmp[88], tmp[84]};
        instruction = tmp[83:68]; //4
        readData = tmp[67:52]; // 4


        expectedAluResult = tmp [51:36]; //4
        expectedMemWriteData = tmp[35:20]; //4
        expectedPc = tmp[19:4]; //4
        expectedZero = tmp[0]; //1


    end

    always @(negedge clk) begin
        if (~reset) begin
            if ({aluResult, memWriteData, pc, zero} !== {expectedAluResult, expectedMemWriteData, expectedPc, expectedZero}) begin
                $display("Error:\tinputs: {rst,regWrite,regDst,memToReg,jump,aluSrc,pcSrc,aluCtrl} = %b %b %b %b %b %b %b %b", rst, regWrite, regDst, memToReg, jump, aluSrc, pcSrc, aluCtrl);
                $display("      \tinstruction = %h, readData = %h", instruction, readData);
                $display("\taluResult = %h, expectedAluResult = %h", aluResult, expectedAluResult);
                $display("\tmemWriteData = %h, expectedMemWriteData = %h", memWriteData, expectedMemWriteData);
                $display("\tpc = %h, expectedPc = %h", pc, expectedPc);
                $display("\tzero = %b, expectedZero = %h", zero, expectedZero);

                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 140'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
