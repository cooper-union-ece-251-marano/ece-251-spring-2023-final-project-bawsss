///////////////////////////////////////////////////////////////////////////////
//
// MAINDEC module header
//
// An maindec module header for your Computer Architecture Elements Catalog
//
// module: maindec
// hdl: Verilog
//
// author: Fred Kim <fred.kim@cooper.edu>
//
///////////////////////////////////////////////////////////////////////////////

`ifndef MAINDEC_SVH
`define MAINDEC_SVH

`define MAINDEC_CTRL_ADD    4'b0000
`define MAINDEC_CTRL_SUB    4'b0001
`define MAINDEC_CTRL_MOVE   4'b0010
`define MAINDEC_CTRL_JR     4'b0011
`define MAINDEC_CTRL_AND    4'b0100
`define MAINDEC_CTRL_OR     4'b0101
`define MAINDEC_CTRL_SLL    4'b0110
`define MAINDEC_CTRL_SRL    4'b0111
`define MAINDEC_CTRL_SLT    4'b1000
`define MAINDEC_CTRL_BEQ    4'b1001
`define MAINDEC_CTRL_ADDI   4'b1010
`define MAINDEC_CTRL_SUBI   4'b1011
`define MAINDEC_CTRL_LW     4'b1100
`define MAINDEC_CTRL_SW     4'b1101
`define MAINDEC_CTRL_J      4'b1110
`define MAINDEC_CTRL_JAL    4'b1111

`endif // MAINDEC_SVH
