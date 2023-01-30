/*
 * File: if.sv
 * Project: if
 * Created Date: 2023-01-30 07:24:21
 * Author: Kuroba
 * Description: 
 * -----
 * Last Modified: 2023-01-30 07:26:37
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
    logic sel;

    initial begin

        // if statement

        a = 8'd30;
        b = 8'd16;

        if ( a == b ) begin
            $display( "30 == 16" );
        end

        if ( a != b ) begin
            $display( "30 != 16" );
        end

        // if else statement

        sel = 1'b1;

        if ( sel == 1'b0 ) begin
            a = 8'h0a;
        end
        else begin
            a = 8'h0b;
        end

        $display( "sel = 1, a = %x ", a );

        // if else statement w/ X

        sel = 1'bx;

        if ( sel == 1'b0 ) begin
            a = 8'h0a;
        end
        else begin
            a = 8'h0b;
        end

        $display( "sel = x, a = %x ", a );

    end

endmodule