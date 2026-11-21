// mux.v - 2-to-1 multiplexer

`timescale 1ns/1ps // time unit: 1 nanosecond, time precision: 1 picosecond

module mux(
    output wire [31:0] out, // 32-bit output
    input wire [31:0] in1, // 32-bit input (PC_From_ExMem)
    input wire [31:0] in0, // 32-bit input (Adder Result)
    input wire sel // select signal (PCSrc)
);

assign out = sel ? in1 : in0; // if (sel == 1) {output = in1}; else {output = in0};

endmodule
