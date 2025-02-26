/*
 * Copyright (c) 2025 Embelon
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module delay_timer 
#(
    parameter WIDTH = 16,
    parameter UNIT_COUNTS_US = 10,
    parameter CLK_MHZ = 8
)
(
    input   bit  clock_in,      // clock

    input   bit  reset_in,      // resets internal counter (synchronous)
    input   bit  enable_in,     // working when high

    input   bit  [WIDTH-1:0] delay_in,   // delay in number of units
    input   bit  update_delay_in,        // write enable, active high (synchronous)

    output  bit  busy           // delay still not reached if high
);

localparam COUNTS_PER_UNIT = CLK_MHZ * UNIT_COUNTS_US;
localparam UNIT_COUNTER_WIDTH = $clog2(COUNTS_PER_UNIT+1);

reg [WIDTH-1:0] delay;
reg [UNIT_COUNTER_WIDTH-1:0] unit_counter;

assign busy = (delay != 0) && enable_in;

always @(posedge clock_in) begin
    if (reset_in) begin
        delay <= 0;
        unit_counter <= COUNTS_PER_UNIT;
    end else if (busy) begin
        if (unit_counter != 0) begin
            unit_counter <= unit_counter - 1;
        end else begin
            if (delay != 0) begin
                delay <= delay - 1;
            end
            unit_counter <= COUNTS_PER_UNIT;
        end
    end else if (update_delay_in) begin
        delay <= delay_in;
        unit_counter <= COUNTS_PER_UNIT;
    end
end

endmodule