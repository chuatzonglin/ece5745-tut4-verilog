/*
 * File: enum.v
 * Project: enum
 * Created Date: 2022-12-25 10:26:25
 * Author: Kuroba
 * Description: 
 * -----
 * Last Modified: 2022-12-25 10:38:29
 * Modified By: Kuroba
 * -----
 * MIT License
 * Copyright (c) 2022 Kuroba
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	----------------------------------------------------------
 */



// Declare enum type

typedef enum logic [$clog2(4)-1:0] {
    STATE_A,
    STATE_B,
    STATE_C,
    STATE_D
} state_t;


module top;

    // Declare variables

    state_t state;
    logic result;

    initial begin

        // Enum lable literals

        state = STATE_A; $display( "STATE_A = %d", state );
        state = STATE_B; $display( "STATE_B = %d", state );
        state = STATE_C; $display( "STATE_C = %d", state );
        state = STATE_D; $display( "STATE_D = %d", state );

        // Comparisons

        state = STATE_A;

        result = ( state == STATE_A );
        $display( "( STATE_A == STATE_A ) = %x", result );

        result = ( state == STATE_B );
        $display( "( STATE_A == STATE_B ) = %x", result );

        result = ( state != STATE_A );
        $display( "( STATE_A != STATE_A ) = %x", result );

        result = ( state != STATE_B );
        $display( "( STATE_A != STATE_B ) = %x", result );

    end

endmodule