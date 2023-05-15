///////////////////////////////////////////////////////////////////////////////
//
// BAWSSS COMPUTER TESTBENCH module
//
// A bawsss_computer testbench module for your Computer Architecture Elements Catalog
//
// module: bawsss_computer_tb
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./bawsss_computer.sv"
`include "../clock/clock.sv"

module bawsss_computer_tb();

    logic clk;
    logic clk_enable;
    logic rst;
    logic [15:0] writeData, address;
    logic memWrite;

    bawsss_computer dut(.clk(clk), .rst(rst), .writeData(writeData), .address(address), .memWrite(memWrite));

    clock dut1(.ENABLE(clk_enable), .CLOCK(clk));


    initial begin
        $dumpfile("bawsss_computer.vcd");
        $dumpvars(0, dut);
    end

    initial begin
        #0 clk_enable <= 0; #50 rst <= 1; #50; rst <= 0; #50 clk_enable <= 1;
    end

    always @(negedge clk or posedge clk) begin
        if (memWrite) begin
            if (address === 0) begin
                $display("Address: %h", address);
                $display("Output (hex): %h", writeData);
                $display("Output (dec): %d", writeData);
                $finish();
            end
        end
    end


endmodule
