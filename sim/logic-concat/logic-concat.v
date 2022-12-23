/*
 * File: logic-concat.v
 * Project: logic-concat
 * Created Date: 2022-12-23 21:07:05
 * Author: Kuroba
 * Description: 
 * -----
 * Last Modified: 2022-12-23 21:12:09
 * Modified By: Kuroba
 * -----
 * MIT License
 * Copyright (c) 2022 Kuroba
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	----------------------------------------------------------
 */



module top;

    logic [ 3:0] A; // 4-bit logic variable
    logic [ 3:0] B; // 4-bit logic variable
    logic [ 3:0] C; // 4-bit logic variable
    logic [ 7:0] D; // 8-bit logic variable
    logic [11:0] E; // 12-bit logic variable
    logic [19:0] F; // 18-bit logic variable

    initial begin

        // Basic concatenation

        A = 4'ha;
        B = 4'hb;
        C = 4'hc;
        D = 8'hde;

        E = { A, B, C }; $display( "{ 4'ha, 4'hb, 4'hc } = %x", E );
        E = { C, A, B }; $display( "{ 4'hc, 4'ha, 4'hb } = %x", E );
        E = { B, C, A }; $display( "{ 4'hb, 4'hc, 4'ha } = %x", E );

        E = { A, D }; $display( "{ 4'ha, 8'hde } = %x", E );
        E = { D, A }; $display( "{ 8'hde, 4'ha } = %x", E );

        E = { A, 8'hf0 }; $display( "{ 4'ha, 8'hf0 } = %x", E );
        E = { 8'hf0, A }; $display( "{ 8'hf0, 4'ha } = %x", E );

        // Repeat operator

        A = 4'ha;
        B = 4'hb;

        E = { 3{A} }; $display( "{ 4'ha, 4'ha, 4'ha } = %x", E );
        E = { A, {2{B}} }; $display( "{ 4'ha, 4'hb, 4'hb } = %x", E );

        F = { A, 8'h00, {2{B}}}; $display( "{ 4'ha, 4'hb, 4'hb } = %x", F );
        E = { A, 8'h00, {2{B}}}; $display( "{ 4'ha, 4'hb, 4'hb } = %x", E );

    end

endmodule