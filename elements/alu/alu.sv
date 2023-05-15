///////////////////////////////////////////////////////////////////////////////
//
// ALU module
//
// An alu module for your Computer Architecture Elements Catalog
//
// module: alu
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef ALU
`define ALU
`timescale 1ns/100ps
`include "../alu/alu.svh"

module alu (
    input logic [15:0] a, b,
    input logic [2:0] ctrl,
    output logic [15:0] result,
    output logic zero
    );
    assign zero = (result==0);

    always @(a or b or ctrl) begin
        case (ctrl)
            `ALU_CTRL_AND: result <= a & b;     //and
            `ALU_CTRL_OR : result <= a | b;     //or
            `ALU_CTRL_ADD: result <= a + b;     //add
            `ALU_CTRL_SLL: result <= a << b;    //sll
            `ALU_CTRL_NOR: result <= ~(a | b);  //nor
            `ALU_CTRL_SRL: result <= a >> b;    //srl
            `ALU_CTRL_SUB: result <= a - b;     //sub
            `ALU_CTRL_SLT: begin                //slt
                if (a[15] != b[15])
                    result <= (a[15] > b[15]);
                else
                    result <= (a < b);
            end
            default: result <= 0;
        endcase
    end
endmodule

`endif // ALU
