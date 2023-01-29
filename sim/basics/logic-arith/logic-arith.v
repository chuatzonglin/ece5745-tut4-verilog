/*
 * File: logic-arith.v
 * Project: logic-arith
 * Created Date: 2022-12-06 17:36:51
 * Author: Kuroba
 * Description: 
 * Compile and run using Icarus verilog
 * iverilog -g2012 -o logic-arith logic-arith.v && ./logic-arith
 * -----
 * Last Modified: 2022-12-07 11:23:29
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
    logic [8:0] D;
    logic [8:0] E;
    logic [8:0] F;

    initial begin

        // Basic arithmetic with no overflow or underflow

        A = 8'd28;
        B = 8'd15;

        C = A + B; $display( "8'd28 + 8'd15 = %d", C );
        C = A - B; $display( "8'd28 - 8'd15 = %d", C );

        // Basic arithmetic with overflow and underflow

        A = 8'd250;
        B = 8'd15;

        C = A + B; $display( "8'd250 + 8'd15 = %d", C );
        C = B - A; $display( "8'd15 - 8'd250 = %d", C );

        D = 9'd200;
        E = 9'd400;

        F = D + E + E - E - E;
        $display( "9'd200 + 9'd400 + 9'd400 - 9'd400 - 9'd400 = %d", F );

    end

endmodule