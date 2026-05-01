

/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype wire

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

  // UART_gen_netlist uses active-high reset.
  wire reset;

  // Internal UART signals.
  wire       tx;
  wire       tx_rdy;
  wire       rx_data_rdy;
  wire [7:0] uart_data_out;

  assign reset = ~rst_n;

  // Dedicated outputs: received byte from UART receiver.
  assign uo_out = uart_data_out;

  // Bidirectional pins used by the UART wrapper:
  // uio_in[0]  -> rx
  // uio_in[1]  -> tx_start
  // uio_out[2] -> tx
  // uio_out[3] -> tx_rdy
  // uio_out[4] -> rx_data_rdy
  assign uio_out[1:0] = 2'b00;
  assign uio_out[2]   = tx;
  assign uio_out[3]   = tx_rdy;
  assign uio_out[4]   = rx_data_rdy;
  assign uio_out[7:5] = 3'b000;

  // uio[0] and uio[1] are inputs. uio[2], uio[3] and uio[4] are outputs.
  assign uio_oe[1:0] = 2'b00;
  assign uio_oe[2]   = 1'b1;
  assign uio_oe[3]   = 1'b1;
  assign uio_oe[4]   = 1'b1;
  assign uio_oe[7:5] = 3'b000;

  UART U0 (
    .clk          (clk),
    .reset        (reset),
    .tx_start     (uio_in[1]),
    .tx_rdy       (tx_rdy),
    .rx_data_rdy  (rx_data_rdy),
    .data_in      (ui_in),
    .data_out     (uart_data_out),
    .rx           (uio_in[0]),
    .tx           (tx)
  );

  // List all unused inputs to prevent warnings.
  wire _unused = &{ena, uio_in[7:2], 1'b0};

endmodule
