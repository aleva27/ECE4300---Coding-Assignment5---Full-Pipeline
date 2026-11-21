//adder.v - increments the Program Counter (PC) by 4, in order to calculate the next sequential instruction address
`timescale 1ns/1ps // time unit: 1 nanosecond, time precision: 1 picosecond

module adder(
  input clk,
  input rst,
  input [31:0] pc_in,
  output [31:0] pc_out
);

  assign pc_out = pc_in + 32'd4;
  
endmodule
