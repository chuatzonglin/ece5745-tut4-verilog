/*
 * File: logic-sbit.v
 * Project: logic-sbit
 * Created Date: 2022-12-06 11:49:34
 * Author: Kuroba
 * Description:  
 * Compile and run using Icarus verilog
 * iverilog -g2012 -o logic-sbit logic-sbit.v && ./logic-sbit
 * -----
 * Last Modified: 2022-12-06 12:30:49
 * Modified By: Kuroba
 * -----
 * MIT License
 * Copyright (c) 2022 Kuroba
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	----------------------------------------------------------
 */



module top ();

    // Declare single-bit logic variables.
    logic a;
    logic b;
    logic c;
    logic [1:0] d;

    initial begin
        // Single-bit literals

        a = 1'b0; $display( "1'b0 = %x ", a );
        a = 1'b1; $display( "1'b1 = %x ", a );
        a = 1'bx; $display( "1'bx = %x ", a );
        a = 1'bz; $display( "1'bz = %x ", a );
        $display( "" );

        // Bitwise logical operators for doing AND, OR, XOR, and NOT

        a = 1'b0;
        b = 1'b1;

        c = a & b; $display( "0 & 1 = %x ", c );
        c = a | b; $display( "0 | 1 = %x ", c );
        c = a ^ b; $display( "0 ^ 1 = %x ", c );
        c = ~b;    $display( "~1    = %x ", c );
        $display( "" );

        // Bitwise logical operators for doing AND, OR, XOR, and NOT with X
        a = 1'b0;
        b = 1'bx;

        c = a & b; $display( "0 & x = %x ", c );
        c = a | b; $display( "0 | x = %x ", c );
        c = a ^ b; $display( "0 ^ x = %x ", c );
        c = ~b;    $display( "~x    = %x ", c );
        $display( "" );

        // Boolean logical operators
        a = 1'b0;
        b = 1'b1;

        c = a && b; $display( "0 && 1 = %x ", c );
        c = a || b; $display( "0 || 1 = %x ", c );
        c = !b;     $display( "!1     = %x ", c );
        $display( "" );

        // Boolean logical operators
        a = 1'b1;
        b = 1'b1;
        c = 1'b1;

        d[0] = a ^ b ^ c;
        d[1] = (a & b) | (b & c) | (c & a);
        $display( "a + b + c = %x ", d );
        $display( "" );


    end
    
endmodule