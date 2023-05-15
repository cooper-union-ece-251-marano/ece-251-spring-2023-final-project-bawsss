///////////////////////////////////////////////////////////////////////////////
//
// MAIN DECODER TESTBENCH module
//
// An maindec testbench module for your Computer Architecture Elements Catalog
//
// module: maindec_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./maindec.sv"
`include "./maindec.svh"

module maindec_tb();
    logic [3:0] op;
    logic regWrite, branch, memWrite;
    logic [1:0] regDst, memToReg, jump, aluSrc;
    logic [2:0] aluCtrl;

    reg clk, reset;

    logic [71:0] testvectors[0:1000];
    logic [71:0] tmp;
    logic [15:0] vectornum, errors;
    logic expectedRegWrite, expectedBranch, expectedMemWrite;
    logic [1:0] expectedRegDst, expectedMemToReg, expectedJump, expectedAluSrc;
    logic [2:0] expectedAluCtrl;


    maindec uut (
             .op(op),
             .regWrite(regWrite),
             .regDst(regDst),
             .branch(branch),
             .memWrite(memWrite),
             .memToReg(memToReg),
             .jump(jump),
             .aluSrc(aluSrc),
             .aluCtrl(aluCtrl)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("maindec.vcd");
        $dumpvars(0, uut);
    end

    initial begin
        $readmemh("maindec_tb.tv", testvectors);
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; tmp = testvectors[vectornum];

        op                  = {tmp[68],tmp[64],tmp[60],tmp[56]}; //4
        expectedRegWrite    = tmp[52]; //1
        expectedRegDst      = {tmp[48], tmp[44]}; //2
        expectedBranch      = tmp[40]; //1
        expectedMemWrite    = tmp[36]; //1
        expectedMemToReg    = {tmp[32], tmp[28]}; //2
        expectedJump        = {tmp[24], tmp[20]}; //2
        expectedAluSrc      = {tmp[16], tmp[12]}; //2
        expectedAluCtrl     = {tmp[8], tmp[4], tmp[0]}; //3
    end

    always @(negedge clk) begin
        if (~reset) begin
            if ({regWrite, regDst, branch, memWrite, memToReg, jump, aluSrc, aluCtrl} !== {expectedRegWrite, expectedRegDst, expectedBranch, expectedMemWrite, expectedMemToReg, expectedJump, expectedAluSrc, expectedAluCtrl}) begin
                $display("Error:\tinput: op %b", op);
                $display("\tcontrol results = %b\n\texpected result = %b", {regWrite, regDst, branch, memWrite, memToReg, jump, aluSrc, aluCtrl}, {expectedRegWrite, expectedRegDst, expectedBranch, expectedMemWrite, expectedMemToReg, expectedJump, expectedAluSrc, expectedAluCtrl});
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
