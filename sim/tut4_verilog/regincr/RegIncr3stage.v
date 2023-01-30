/*
 * File: RegIncr3stage.v
 * Project: regincr
 * Created Date: 2023-01-30 16:42:46
 * Author: Kuroba
 * Description: 
 * -----
 * Last Modified: 2023-01-30 17:45:09
 * Modified By: Kuroba
 * -----
 * MIT License
 * Copyright (c) 2023 Kuroba
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	----------------------------------------------------------
 */



`ifndef TUT4_VERILOG_REGINCR_REG_INCR_3STAGE_V
`define TUT4_VERILOG_REGINCR_REG_INCR_3STAGE_V

`include "tut4_verilog/regincr/RegIncr.v"
`include "tut4_verilog/regincr/RegIncr2stage.v"

module tut4_verilog_regincr_RegIncr3stage (
    input logic clk,
    input logic reset,
    input logic [7:0] in_,
    output logic [7:0] out

);

    // Testing import from 2 modules
    logic [7:0] reg_incr_0_out;
    tut4_verilog_regincr_RegIncr reg_incr_0
    (
        .clk    (clk),
        .reset  (reset),
        .in_    (in_),
        .out    (reg_incr_0_out)
    );

    tut4_verilog_regincr_RegIncr2stage reg_incr_2stage_1
    (
        .clk    (clk),
        .reset  (reset),
        .in_    (reg_incr_0_out),
        .out    (out)
    );
    
endmodule

`endif /* TUT4_VERILOG_REGINCR_REG_INCR_3STAGE_V */