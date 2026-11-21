//fetch.v - the whole fetch stage combined, during which the instruction is fetched from memory and the next program counter is calculated
`timescale 1ns/1ps // time unit: 1 nanosecond, time precision: 1 picosecond

module fetch(
  input clk, // clock signal
  input rst, // reset signal
  input mem_pc_src, // select signal for the PC multiplexer (0 selects PC + 4 (normal increment), 1 selects mem_npc (branch/jump from later stage))
  input [31:0] mem_npc, // alternative next program counter value from the memory stage (used for branch/jump instructions)
  output [31:0] if_id_instr, // IF/ID instruction to be passed to the next pipeline stage
  output [31:0] if_id_npc // Next Program Counter (NPC) to be passed to the next pipeline stage
);

  // Internal wires used for connecting the submodules within the fetch stage
  wire [31:0] pc_out, pc_4, pc_mux, instr_data; 
  // pc_out: current PC value, pc_4: PC + 4, pc_mux: output of PC multiplexer, instr_data: instruction fetched from memory

  // Instantiate and connect the submodules: mux, pc, adder, mem, and if_id_latch

  // Mux contains one output, two inputs, and a select signal
  mux mux0(
    .out(pc_mux),
    .in1(mem_npc),
    .in0(pc_4),
    .sel(mem_pc_src)
  );

  // Program Counter (PC) contains a clock, reset, and input for the next PC value, and outputs the current PC value
  pc pc0 (
    .clk(clk),
    .rst(rst),
    .pc_in(pc_mux),
    .pc_out(pc_out)
  );

  // Adder contains a clock, reset, and input for the current PC value, and outputs the next PC value (PC + 4)
  adder adder0 (
    .clk(clk),
    .rst(rst),
    .pc_in(pc_out),
    .pc_out(pc_4)
  );

  // Memory (mem) contains a clock, reset, address input, and outputs the instruction at the specified address
  mem mem0 (
    .clk(clk),
    .rst(rst),
    .addr(pc_out),
    .instr_out(instr_data)
  );

  // IF/ID Latch contains a clock, reset, and inputs for the current PC and instruction, and outputs the latched PC and instruction to the next pipeline stage
  if_id_latch latch0 (
    .clk(clk),
    .rst(rst),
    .pc_in(pc_4),
    .instr_in(instr_data),
    .pc_out(if_id_npc),
    .instr_out(if_id_instr)
  );

endmodule
