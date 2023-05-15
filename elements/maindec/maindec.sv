///////////////////////////////////////////////////////////////////////////////
//
// MAINDEC module
//
// An maindec module for your Computer Architecture Elements Catalog
//
// module: maindec
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
// author: Andy Jaku <andy.jaku@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef MAINDEC
`define MAINDEC
`timescale 1ns/100ps
`include "../maindec/maindec.svh"
`include "../alu/alu.svh"

module maindec (
    input logic [3:0] op,
    output logic regWrite, branch, memWrite,
    output logic [1:0] regDst, memToReg, jump, aluSrc,
    output logic [2:0] aluCtrl
    );

    logic [13:0] ctrl;
    assign {regWrite, regDst, branch, memWrite, memToReg, jump, aluSrc, aluCtrl} = ctrl;

    always @*
        case(op)
            `MAINDEC_CTRL_ADD:  ctrl <= {11'b10100000000, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_SUB:  ctrl <= {11'b10100000000, `ALU_CTRL_SUB};
            `MAINDEC_CTRL_MOVE: ctrl <= {11'b10100000000, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_JR:   ctrl <= {11'b00000001000, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_AND:  ctrl <= {11'b10100000000, `ALU_CTRL_AND};
            `MAINDEC_CTRL_OR:   ctrl <= {11'b10100000000, `ALU_CTRL_OR};
            `MAINDEC_CTRL_SLL:  ctrl <= {11'b10100000010, `ALU_CTRL_SLL};
            `MAINDEC_CTRL_SRL:  ctrl <= {11'b10100000010, `ALU_CTRL_SRL};
            `MAINDEC_CTRL_SLT:  ctrl <= {11'b10100000000, `ALU_CTRL_SLT};

            `MAINDEC_CTRL_BEQ:  ctrl <= {11'b00010000000, `ALU_CTRL_SUB};
            `MAINDEC_CTRL_ADDI: ctrl <= {11'b10000000001, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_SUBI: ctrl <= {11'b10000000001, `ALU_CTRL_SUB};
            `MAINDEC_CTRL_LW:   ctrl <= {11'b10000010001, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_SW:   ctrl <= {11'b00001000001, `ALU_CTRL_ADD};

            `MAINDEC_CTRL_J:    ctrl <= {11'b00000000100, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_JAL:  ctrl <= {11'b11000100100, `ALU_CTRL_ADD};
            default: ctrl <= 14'bx; // illegal
        endcase
endmodule

`endif // MAINDEC
