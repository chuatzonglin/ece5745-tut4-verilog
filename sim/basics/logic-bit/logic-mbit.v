/*
 * File: logic-mbit.v
 * Project: logic-bit
 * Created Date: 2022-12-06 12:53:15
 * Author: Kuroba
 * Description: 
 * Compile and run using Icarus verilog
 * iverilog -g2012 -o logic-mbit logic-mbit.v && ./logic-mbit
 * -----
 * Last Modified: 2022-12-23 20:56:10
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

    // Declare multi-bit logic variables

    logic [ 3:0] A; // 4-bit logic variable
    logic [ 3:0] B; // 4-bit logic variable
    logic [ 3:0] C; // 4-bit logic variable
    logic [11:0] D; // 12-bit logic variable

    initial begin
        
        // Multi-bit literals

        A = 4'b0101;            $display( "4'b0101            = %x", A );
        D = 12'b1100_1010_0101; $display( "12'b1100_1010_0101 = %x", D );
        D = 12'hca5;            $display( "12'hca5            = %x", D );
        D = 12'd1058;           $display( "12'd1058           = %x", D );
        $display( "" );
        

        // Bitwise logical operators for doing AND, OR, XOR, and NOT
        
        A = 4'b0101;
        B = 4'b0011;
        
        C = A & B;  $display( "4'b0101 & 4'b0011  = %b", C );
        C = A | B;  $display( "4'b0101 | 4'b0011  = %b", C );
        C = A ^ B;  $display( "4'b0101 ^ 4'b0011  = %b", C );
        C = A ^~ B; $display( "4'b0101 ^~ 4'b0011 = %b", C );
        C = ~B;     $display( "~4'b0011           = %b", C );
        $display( "" );

        // Bitwise logical operators when some bits are X
        
        A = 4'b0101;
        B = 4'b00xx;
        
        C = A & B;  $display( "4'b0101 &  4'b00xx = %b", C );
        C = A | B;  $display( "4'b0101 |  4'b00xx = %b", C );
        C = A ^ B;  $display( "4'b0101 ^  4'b00xx = %b", C );
        C = A ^~ B; $display( "4'b0101 ^~ 4'b00xx = %b", C );
        C = ~B;     $display( "~4'b00xx           = %b", C );
        $display( "" );

        // Reduction operators
        
        A = 4'b0101;
        
        C = &A;  $display( " & 4'b0101 = %b", C );
        C = ~&A; $display( "~& 4'b0101 = %b", C );
        C = |A;  $display( " | 4'b0101 = %b", C );
        C = ~|A; $display( "~| 4'b0101 = %b", C );
        C = ^A;  $display( "^ 4'b0101  = %b", C );
        C = ^~A; $display( "^~ 4'b0101 = %b", C );
        $display( "" );

        // Relational operator

        A = 4'b0110;
        B = 4'b0110;

        C = A == B;    $display( "4'b0101 == 4'b0011 = %b", C );
        C = &(~(A ^ B));  $display( "4'b0101 == 4'b0011 = %b", C );
    end

    
endmodule