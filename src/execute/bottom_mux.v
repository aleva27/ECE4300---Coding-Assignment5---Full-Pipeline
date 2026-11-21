// bottom_mux.v (5 bit) - Implements a multiplexer that selects from two inputs (5 bits), a and b, based on the select input (sel). 
// Its inputs are instrout_1511(rd address) and instrout_2016 (rt address) from ID/EX latch, and regdst.
// The output is muxout, which is sent to EX/MEM latch. 
// This mux determines the destination register (rt or rd)
`timescale 1ns / 1ps

module bottom_mux(

//#(parameter BITS = 32)(
output wire [4:0] y, // Output of Multiplexer (y = muxout [4:0])
input wire [4:0] a, // Input 1 of Multiplexer (a = rd/instr_1511) RegDst = 1 -> R-type Instruction
input wire [4:0] b, // Input 0 of Multiplexer (b = rt/instr_2016) RegDst = 0 -> I-type Instruction
input wire sel // Select Input (sel = RegDst)
   );
   
   assign y = sel ? a : b; // if (sel) {y=a}; else {y=b}

endmodule // mux
