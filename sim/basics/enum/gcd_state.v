/*
 * File: gcd_state.v
 * Project: enum
 * Created Date: 2022-12-25 10:37:02
 * Author: Kuroba
 * Description: 
 * -----
 * Last Modified: 2022-12-25 10:48:58
 * Modified By: Kuroba
 * -----
 * MIT License
 * Copyright (c) 2022 Kuroba
 * -----
 * HISTORY:
 * Date      	By	Comments
 * ----------	---	----------------------------------------------------------
 */




typedef enum logic [4 : 0]{
    STATE_IDLE,
    STATE_CALC,
    STATE_DONE
} state_t;

module top;

    state_t state;
    logic result;

    initial begin
        // Enum lable literals

        state = STATE_IDLE; $display( "STATE_A = %b", state );
        state = STATE_CALC; $display( "STATE_B = %b", state );
        state = STATE_DONE; $display( "STATE_C = %b", state );

        // Comparisons

        state = STATE_IDLE;

        result = ( state == STATE_IDLE );
        $display( "( STATE_IDLE == STATE_IDLE ) = %x", result );

        result = ( state == STATE_CALC );
        $display( "( STATE_IDLE == STATE_CALC ) = %x", result );

        result = ( STATE_IDLE != STATE_IDLE );
        $display( "( STATE_IDLE != STATE_IDLE ) = %x", result );

        result = ( STATE_IDLE != STATE_CALC );
        $display( "( STATE_IDLE != STATE_CALC ) = %x", result );

        
    end
    
endmodule