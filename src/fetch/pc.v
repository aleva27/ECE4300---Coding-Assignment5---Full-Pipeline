//pc.v - program counter, stores the address of the instruction being fetched

`timescale 1ns/1ps // time unit: 1 nanosecond, time precision: 1 picosecond

module pc(
  input clk,
  input rst,
  input [31:0] pc_in,
  output reg [31:0] pc_out
);

  initial pc_out = 32'b0; //setting initial value

  always @(posedge clk) begin
    if (rst) pc_out <= 32'b0;
    else pc_out <= pc_in;
  end
endmodule
