/*
 * File: ternary.sv
 * Project: ternary
 * Created Date: 2023-01-30 01:09:00
 * Author: Kuroba
 * Description: 
 * -----
 * Last Modified: 2023-01-30 07:18:18
 * Modified By: Kuroba
 * -----
 * MIT License
 * Copyright (c) 2023 Kuroba
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	----------------------------------------------------------
 */

module top;

    logic [7:0] a;
    logic [7:0] b;
    logic [7:0] c;
    logic [1:0] sel;

    initial begin

        // ternary statement

        a = 8'd30;
        b = 8'd16;

        c = ( a < b ) ? 15 : 14;
        $display( "c = %d", c );

        c = ( b < a ) ? 15 : 14;
        $display( "c = %d", c );

        // nested ternary statement

        sel = 2'b01;

        c = ( sel == 2'b00 ) ? 8'h0a
        : ( sel == 2'b01 ) ? 8'h0b
        : ( sel == 2'b10 ) ? 8'h0c
        : ( sel == 2'b11 ) ? 8'h0d
        : 8'h0e;

        $display( "sel = 1, c = %b", c );

        // nested ternary statement w/ X

        sel = 2'bxx;

        c = ( sel == 2'b00 ) ? 8'h0a
        : ( sel == 2'b01 ) ? 8'h0b
        : ( sel == 2'b10 ) ? 8'h0c
        : ( sel == 2'b11 ) ? 8'h0d
        : 8'h0e;

        $display( "sel = x, c = %b", c );

        sel = 2'bx0;

        c = ( sel == 2'b00 ) ? 8'h0a
        : ( sel == 2'b01 ) ? 8'h0b
        : ( sel == 2'b10 ) ? 8'h0c
        : ( sel == 2'b11 ) ? 8'h0d
        : 8'h0e;

        $display( "sel = x, c = %b", c );

        sel = 2'b11;

        c = ( sel == 2'b00 ) ? 8'h0a
        : ( sel == 2'b01 ) ? 8'h0b
        : ( sel == 2'b10 ) ? 8'h0c
        : 8'h0e;

        $display( "sel = 3, c = %b", c );

    end

endmodule
