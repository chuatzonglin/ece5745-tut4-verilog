/*
 * File: logic-shift.v
 * Project: logic-shift
 * Created Date: 2022-12-06 17:12:41
 * Author: Kuroba
 * Description: 
 * Compile and run using Icarus verilog
 * iverilog -g2012 -o logic-shift logic-shift.v && ./logic-shift
 * -----
 * Last Modified: 2023-01-29 19:56:58
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

    logic [7:0] A;
    logic [7:0] B;
    logic [7:0] C;

    initial begin

        // Fixed shift amount for logical shifts

        A = 8'b1110_0101;

        C = A << 1; $display( "8'b1110_0101 << 1 = %b", C );
        C = A << 2; $display( "8'b1110_0101 << 2 = %b", C );
        C = A << 3; $display( "8'b1110_0101 << 3 = %b", C );
        $display( "" );

        C = A >> 1; $display( "8'b1110_0101 >> 1 = %b", C );
        C = A >> 2; $display( "8'b1110_0101 >> 2 = %b", C );
        C = A >> 3; $display( "8'b1110_0101 >> 3 = %b", C );
        $display( "" );

        // Fixed shift amount for arithmetic shifts

        A = 8'b0110_0100;

        C = $signed(A) >>> 1; $display( "8'b0110_0100 >>> 1 = %b", C );
        C = $signed(A) >>> 2; $display( "8'b0110_0100 >>> 2 = %b", C );
        C = $signed(A) >>> 3; $display( "8'b0110_0100 >>> 3 = %b", C );
        $display( "" );

        A = 8'b1110_0101;

        C = $signed(A) >>> 1; $display( "8'b1110_0101 >>> 1 = %b", C );
        C = $signed(A) >>> 2; $display( "8'b1110_0101 >>> 2 = %b", C );
        C = $signed(A) >>> 3; $display( "8'b1110_0101 >>> 3 = %b", C );

        // For asr, $signed() is required
        C = A >>> 3; $display( "(unsigned) 8'b1110_0101 >>> 3 = %b", C );
        $display( "" );

        // Variable shift amount for logical shifts

        A = 8'b1110_0101;
        B = 8'd2;

        C = A <<  B; $display( "8'b1110_0101 <<  2 = %b", C );
        C = A >>  B; $display( "8'b1110_0101 >>  2 = %b", C );
        C = $signed(A) >>> B; $display( "8'b1110_0101 >>> 2 = %b", C );

    end

endmodule
