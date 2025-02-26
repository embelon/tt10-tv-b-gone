/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_tv_b_gone (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);


  // ui_in[0] => button
  // uo_out[0] => IR LED
  // uo_out[1] => activity LED





  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out[7]  = ui_in[7] + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 8'h00;
  assign uio_oe  = 8'h00;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[6:1], uo_out[6:2], uio_in[7:0], 1'b0};

endmodule
