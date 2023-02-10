//========================================================================
// GCD Unit RTL Implementation
//========================================================================

`ifndef TUT4_VERILOG_GCD_GCD_UNIT_V
`define TUT4_VERILOG_GCD_GCD_UNIT_V

`include "vc/muxes.v"
`include "vc/regs.v"
`include "vc/arithmetic.v"
`include "vc/trace.v"

//========================================================================
// GCD Unit Datapath
//========================================================================

module tut4_verilog_gcd_GcdUnitDpath
(
  input  logic        clk,
  input  logic        reset,

  // Data signals

  input  logic [31:0] recv_msg,
  output logic [15:0] send_msg,

  // Control signals

  input  logic        a_reg_en,   // Enable for A register
  input  logic        b_reg_en,   // Enable for B register
  input  logic        a_mux_sel,  // Sel for mux in front of A reg
  input  logic        b_mux_sel,  // sel for mux in front of B reg
  input  logic        sub_mux_sel,   

  // Status signals

  output logic        is_sub_in1_zero,  // Output of zero comparator
  output logic        is_a_lt_b   // Output of less-than comparator
);

  localparam c_nbits = 16;

  // Split out the a and b operands

  logic [c_nbits-1:0] recv_msg_a;
  assign recv_msg_a = recv_msg[31:16];

  logic [c_nbits-1:0] recv_msg_b;
  assign recv_msg_b = recv_msg[15:0];

  // A Mux

  logic [c_nbits-1:0] b_reg_out;
  logic [c_nbits-1:0] sub_out;
  logic [c_nbits-1:0] a_mux_out;

  vc_Mux2#(c_nbits) a_mux
  (
    .sel   (a_mux_sel),
    .in0   (recv_msg_a),
    .in1   (sub_out),
    .out   (a_mux_out)
  );

  // A register

  logic [c_nbits-1:0] a_reg_out;

  vc_EnReg#(c_nbits) a_reg
  (
    .clk   (clk),
    .reset (reset),
    .en    (a_reg_en),
    .d     (a_mux_out),
    .q     (a_reg_out)
  );

  // B Mux

  logic [c_nbits-1:0] b_mux_out;

  vc_Mux2#(c_nbits) b_mux
  (
    .sel   (b_mux_sel),
    .in0   (recv_msg_b),
    .in1   (sub_in1_mux_out),
    .out   (b_mux_out)
  );

  // B register

  vc_EnReg#(c_nbits) b_reg
  (
    .clk   (clk),
    .reset (reset),
    .en    (b_reg_en),
    .d     (b_mux_out),
    .q     (b_reg_out)
  );

  // Less-than comparator

  vc_LtComparator#(c_nbits) a_lt_b
  (
    .in0   (a_reg_out),
    .in1   (b_reg_out),
    .out   (is_a_lt_b)
  );

  // Mux for selecting input of subtractor
  logic [c_nbits-1:0] sub_in0_mux_out;

  vc_Mux2#(c_nbits) sub_in0_mux
  (
    .sel   (sub_mux_sel),
    .in0   (a_reg_out),
    .in1   (b_reg_out),
    .out   (sub_in0_mux_out)
  );

  logic [c_nbits-1:0] sub_in1_mux_out;
  
  vc_Mux2#(c_nbits) sub_in1_mux
  (
    .sel   (sub_mux_sel),
    .in0   (b_reg_out),
    .in1   (a_reg_out),
    .out   (sub_in1_mux_out)
  );

  // Zero comparator

  vc_ZeroComparator#(c_nbits) sub_in1_zero
  (
    .in    (sub_in1_mux_out),
    .out   (is_sub_in1_zero)
  );

  // Subtractor

  vc_Subtractor#(c_nbits) sub
  (
    .in0   (sub_in0_mux_out),
    .in1   (sub_in1_mux_out),
    .out   (sub_out)
  );

  // Connect to output port

  assign send_msg = sub_out;

endmodule

//========================================================================
// GCD Unit Control
//========================================================================

module tut4_verilog_gcd_GcdUnitCtrl
(
  input  logic        clk,
  input  logic        reset,

  // Dataflow signals

  input  logic        recv_val,
  output logic        recv_rdy,
  output logic        send_val,
  input  logic        send_rdy,

  // Control signals

  output logic        a_reg_en,   // Enable for A register
  output logic        b_reg_en,   // Enable for B register
  output logic        a_mux_sel,  // Sel for mux in front of A reg
  output logic        b_mux_sel,  // sel for mux in front of B reg
  output logic        sub_mux_sel,  // sel for muxes in front subtractor

  // Data signals

  input  logic        is_sub_in1_zero,  // Output of zero comparator
  input  logic        is_a_lt_b   // Output of less-than comparator
);

  //----------------------------------------------------------------------
  // State Definitions
  //----------------------------------------------------------------------

  localparam STATE_IDLE = 2'd0;
  localparam STATE_CALC = 2'd1;
  localparam STATE_DONE = 2'd2;

  //----------------------------------------------------------------------
  // State
  //----------------------------------------------------------------------

  logic [1:0] state_reg;
  logic [1:0] state_next;

  always_ff @( posedge clk ) begin
    if ( reset ) begin
      state_reg <= STATE_IDLE;
    end
    else begin
      state_reg <= state_next;
    end
  end

  //----------------------------------------------------------------------
  // State Transitions
  //----------------------------------------------------------------------

  logic req_go;
  logic resp_go;
  logic is_calc_done;
  logic calc_done_resp_go;

  assign req_go       = recv_val && recv_rdy;
  assign resp_go      = send_val && send_rdy;
  assign is_calc_done = is_sub_in1_zero;
  assign calc_done_resp_go = is_calc_done && resp_go;

  always_comb begin

    state_next = state_reg;

    case ( state_reg )

      STATE_IDLE: if ( req_go         )    state_next = STATE_CALC;
      STATE_CALC: if ( calc_done_resp_go ) state_next = STATE_IDLE;
             else if ( is_calc_done   )    state_next = STATE_DONE;
      STATE_DONE: if ( resp_go        )    state_next = STATE_IDLE;
      default:    state_next = 'x;

    endcase

  end

  //----------------------------------------------------------------------
  // State Outputs
  //----------------------------------------------------------------------

  localparam a_x   = 2'dx;
  localparam a_ld  = 2'd0;
  localparam a_in0 = 2'd1;

  localparam b_x   = 1'dx;
  localparam b_ld  = 1'd0;
  localparam b_in1 = 1'd1;

  function void cs
  (
    input logic       cs_recv_rdy,
    input logic       cs_send_val,
    input logic       cs_a_mux_sel,
    input logic       cs_a_reg_en,
    input logic       cs_b_mux_sel,
    input logic       cs_b_reg_en,
    input logic       cs_sub_mux_sel
  );
  begin
    recv_rdy  = cs_recv_rdy;
    send_val  = cs_send_val;
    a_reg_en  = cs_a_reg_en;
    b_reg_en  = cs_b_reg_en;
    a_mux_sel = cs_a_mux_sel;
    b_mux_sel = cs_b_mux_sel;
    sub_mux_sel = cs_sub_mux_sel;
  end
  endfunction

  // Labels for Mealy transistions

  logic do_swap_n_sub;
  logic send_go;

  assign do_swap_n_sub = is_a_lt_b;

  // Set outputs using a control signal "table"

  always_comb begin

    cs( 0, 0, a_x, 0, b_x, 0 , 0);
    case ( state_reg )
      //                             recv send a mux  a  b mux  b   sub mux
      //                             rdy  val  sel    en sel    en  sel
      STATE_IDLE:                cs( 1,   0,   a_ld,  1, b_ld,  1 , 'x);
      
      //                             recv send               a mux  a  
      //                             rdy  val                sel    en 
      STATE_CALC:                cs( 0,   is_sub_in1_zero,   a_in0, 1, 
      //                             b mux  b    sub mux
      //                             sel    en   sel
                                     b_in1, 1 ,  do_swap_n_sub);

      //                             recv send a mux  a  b mux  b   sub mux
      //                             rdy  val  sel    en sel    en  sel
      STATE_DONE:                cs( 0,   1,   a_x,   0, b_x,   0 , 'x);
      default                    cs('x,  'x,   a_x,  'x, b_x,  'x , 'x);

    endcase

  end

endmodule

//========================================================================
// GCD Unit
//========================================================================

module tut4_verilog_gcd_GcdUnitRTL
(
  input  logic             clk,
  input  logic             reset,

  input  logic             recv_val,
  output logic             recv_rdy,
  input  logic [31:0]      recv_msg,

  output logic             send_val,
  input  logic             send_rdy,
  output logic [15:0]      send_msg
);

  //----------------------------------------------------------------------
  // Connect Control Unit and Datapath
  //----------------------------------------------------------------------

  // Control signals

  logic        a_reg_en;
  logic        b_reg_en;
  logic        a_mux_sel;
  logic        b_mux_sel;
  logic        sub_mux_sel;

  // Data signals

  logic        is_sub_in1_zero;
  logic        is_a_lt_b;

  // Control unit

  tut4_verilog_gcd_GcdUnitCtrl ctrl
  (
    .*
  );

  // Datapath

  tut4_verilog_gcd_GcdUnitDpath dpath
  (
    .*
  );

  //----------------------------------------------------------------------
  // Line Tracing
  //----------------------------------------------------------------------

  `ifndef SYNTHESIS

  logic [`VC_TRACE_NBITS-1:0] str;
  `VC_TRACE_BEGIN
  begin

    $sformat( str, "%x:%x", recv_msg[31:16], recv_msg[15:0] );
    vc_trace.append_val_rdy_str( trace_str, recv_val, recv_rdy, str );

    vc_trace.append_str( trace_str, "(" );

    $sformat( str, "%x", dpath.a_reg_out );
    vc_trace.append_str( trace_str, str );
    vc_trace.append_str( trace_str, " " );

    $sformat( str, "%x", dpath.b_reg_out );
    vc_trace.append_str( trace_str, str );
    vc_trace.append_str( trace_str, " " );

    case ( ctrl.state_reg )

      ctrl.STATE_IDLE:
        vc_trace.append_str( trace_str, "I  " );

      ctrl.STATE_CALC:
      begin
        if ( ctrl.do_swap_n_sub )
          vc_trace.append_str( trace_str, "Cs-" );
        else
          vc_trace.append_str( trace_str, "C- " );
      end

      ctrl.STATE_DONE:
        vc_trace.append_str( trace_str, "D  " );

      default:
        vc_trace.append_str( trace_str, "? " );

    endcase

    vc_trace.append_str( trace_str, ")" );

    $sformat( str, "%x", send_msg );
    vc_trace.append_val_rdy_str( trace_str, send_val, send_rdy, str );

  end
  `VC_TRACE_END

  `endif /* SYNTHESIS */

endmodule

`endif /* TUT4_VERILOG_GCD_GCD_UNIT_V */

