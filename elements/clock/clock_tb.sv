///////////////////////////////////////////////////////////////////////////////
//
// CLOCK TESTBENCH module
//
// A clock testbench module for your Computer Architecture Elements Catalog
//
// module: clock
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps
`include "../clock/clock.sv"

module tb_clock;
    wire clk;
    logic enable;

   initial begin
        $dumpfile("clock.vcd");
        $dumpvars(0, uut);
        //$monitor("enable = %b clk = %b", enable, clk);
        $monitor("time=%0t \t enable=%b clk=%b",$realtime, enable, clk);
    end

    initial begin
        enable <= 0;
        #10 enable <= 1;
        #100 enable <= 0;
        $finish;
    end

   clock uut(
        .ENABLE(enable),
        .CLOCK(clk)
    );
endmodule
