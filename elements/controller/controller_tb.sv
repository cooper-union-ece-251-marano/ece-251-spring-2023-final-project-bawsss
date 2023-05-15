///////////////////////////////////////////////////////////////////////////////
//
// CONTROLLER TESTBENCH module
//
// A controller testbench module for your Computer Architecture Elements Catalog
//
// module: controller_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./controller.sv"

module controller_tb();
    logic [3:0] op;
    logic [2:0] aluCtrl;
    logic [1:0] regDst, memToReg, jump, aluSrc;
    logic regWrtie, memeWrite, pcSrc, zero;

    logic [13:0] control;

    reg clk, reset; //reset for initializing testvectors

    logic [63:0] testvectors[0:1000];
    logic [63:0] tmp;
    integer vectornum, errors;

    //expected
    logic [13:0] expectedControl;

    controller uut (
             .op(op),
             .zero(zero),
             .regWrite(regWrite),
             .regDst(regDst),
             .memWrite(memWrite),
             .memToReg(memToReg),
             .jump(jump),
             .aluSrc(aluSrc),
             .pcSrc(pcSrc),
             .aluCtrl(aluCtrl)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("controller.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("controller_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
        $display("control = {regWrite,regDst,memWrite,memToReg,jump,aluSrc,pcSrc} {aluCtrl}");
    end

    always @(negedge clk) begin
        #1; tmp = testvectors[vectornum];
        op = tmp[63:60];
        zero = tmp[56];
        expectedControl = {
            tmp[52],
            tmp[48],
            tmp[44],
            tmp[40],
            tmp[36],
            tmp[32],
            tmp[28],
            tmp[24],
            tmp[20],
            tmp[16],
            tmp[12],
            tmp[8],
            tmp[4],
            tmp[0]
            };
    end

    always @(posedge clk) begin
        #1;
        if (~reset) begin
            control = {
                regWrite,
                regDst,
                memWrite,
                memToReg,
                jump,
                aluSrc,
                pcSrc,
                aluCtrl
                };
            if (control !== expectedControl) begin
                $display("Error:\tinputs: op = %h, zero = %b", op, zero);
                $display("\tcontrol = %b %b, expectedControl = %b %b", control[9:3], control[2:0], expectedControl[9:3], expectedControl[2:0]);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 64'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
