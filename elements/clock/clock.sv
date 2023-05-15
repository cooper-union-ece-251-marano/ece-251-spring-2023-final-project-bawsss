///////////////////////////////////////////////////////////////////////////////
//
// CLOCK module
//
// A clock module for your Computer Architecture Elements Catalog
//
// module: clock
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef CLOCK
`define CLOCK
`timescale 1ns/100ps

module clock (
    input ENABLE,
    output reg CLOCK
    );

    reg start_clock;
    real clock_on = 5;
    real clock_off = 5;

    initial begin
        CLOCK <= 0;
        start_clock <= 0;
    end

    always @(posedge ENABLE or negedge ENABLE) begin
        if (ENABLE) begin
            start_clock = 1;
        end
        else begin
            start_clock = 0;
        end
    end

    always @(start_clock) begin
        CLOCK = 0;
        while (start_clock) begin
            #(clock_off) CLOCK = 1;
            #(clock_on) CLOCK = 0;
        end
        CLOCK = 0;
    end
endmodule

`endif // CLOCK
