

/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out [7:4]=0 ;  // Example: ou_out is the sum of ui_in and uio_in
  //assign uio_out = 0;
  //assign uio_oe [7:1] = 0;


  assign uio_out = 0;
  assign uio_oe = 0;

  // List all unused inputs to prevent warnings
  //wire _unused = &{ena, clk, rst_n, uio_in [7:1], 1'b0};

  wire _unused = &{ena , uio_in [7:0], ui_in, [7:1], 1'b0};
  assign uio_oe [0]= 1'b0;

// wire para interconectar

wire uart_reg [7:0] = 0;
wire uart_rdy = 0;

/*mux_2to1_4b U0(
    .a_i(ui_in [3:0]),
    .b_i(ui_in [7:4]),
    .s_i(uio_in [0]),
    .q_o(uo_out [3:0]));
*/

reg_pp_8b_en_ar U0(
  .clk_i(clk),
  .rst_n_i(rst_n),
  .d_i(uart_reg),
  .en_i(wire uart_rdy),
  .q_o(uo_out[7:0])
);

UART_rx U1(
  .clk          (clk), 
  .reset        (rst_n), 
  .rx_data_in   (ui_in[0]), 
  .rx_data_rdy  (wire uart_rdy), 
  .rx_data_out  (uart_reg)
  );

endmodule
