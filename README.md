# Coding Assignment 5 - Full MIPS Pipeline
<!--
Replace every item in square brackets before submitting.
Keep this README focused on what the design does, how it is used, and how it was
verified.
-->
## Design Scope and Assumptions
- **In scope:** A five-stage MIPS pipeline that connects the Fetch (IF), Decode (ID), Execute (EX), Memory (MEM), and Write Back (WB) stages from previous coding assignments. The pipeline supports R-type instructions (add, subtract, AND, OR, set-on-less-than(, load word (LW), store word (SW), and branch if equal (BEQ). Pipeline latches (IF/ID, ID/EX, EX/MEM, MEM/WB) separate the stages, so up to five instructions can be in different stages at once.
- **Out of scope:** Hazard handling (forwarding, stalls, and flushing), exceptions, and any instruction other than the ones listed in our scope. Our next iteration, optimization, will implement some of these hazard detection aspects.
- **Assumptions:** 32-bit data and addresses. All pipeline latches and the register file write use the same clock and update on the rising clock edge. Every other part of each stage is combinational. The fetch stage uses byte addressing, so the PC increases by 4 per instruction. The data memory has 256 words and uses the ALU result directly as the word index. The instruction memory is preloaded with the test pgoram.
- **Limitations:** Currently, there is no forwarding, stalling or flushing. A dependent instruction has to be separated from the instruction it depends on by enough nops or it will read the old register value. A branch is resolved in the memory stage, so the instructions fetched after a branch entr the pipeline before the branch outcome is known, and they are not flushed.

## Requirements
| Requirement | Description | Verification Method |
|---|---|---|
| REQ-01 | [The design shall ...] | [Test case, waveform, calculation, or
inspection] |
| REQ-02 | [The design shall ...] | [Test case, waveform, calculation, or
inspection] |
| REQ-03 | [The design shall ...] | [Test case, waveform, calculation, or
inspection] |

## Architecture
### Timing or Behavioral Summary
Save diagrams in the repository's `images/` folder. Use relative paths so they
display on GitHub.
![Timing Diagram](images/[timing-diagram-filename].png)

## Implementation
### Source Code
| File | Description |
|---|---|
| [`[module].v`](LINK_TO_IMPLEMENTATION_CODE) | [Primary implementation module] |
| [`[component].v`](LINK_TO_COMPONENT_CODE) | [Supporting component] |
| [`[testbench].v`](LINK_TO_TESTBENCH_CODE) | [Verification testbench] |
### Implementation Notes
- [Explain one important design decision.]
- [Identify any parameterization, reusable module, or interface convention.]
- [Document any deliberate simplification made for this lab.]
  
## Verification
### Verification Strategy
The design is verified using **[simulation, formal checks, hardware testing, or
another method]**.
Verification covers:
- [Normal operating case]
- [Boundary or maximum-value case]
- [Reset or initialization case]
- [Invalid, stalled, or exceptional case, if applicable]
### Testbench and Waveform
Save screenshots and waveform images in the repository's `images/` folder.
![Testbench or waveform](images/[testbench-screenshot-filename].png)
The testbench source is available [*here*](LINK_TO_TESTBENCH_CODE).
### Results
| Test Case | Expected Result | Observed Result | Status |
|---|---|---|---|
| TC-01 — [Name] | [Expected behavior] | [Observed behavior] | Pass / Fail |
| TC-02 — [Name] | [Expected behavior] | [Observed behavior] | Pass / Fail |
| TC-03 — [Name] | [Expected behavior] | [Observed behavior] | Pass / Fail |

## Reproduction Instructions
### Tools and Versions
- **Simulator / synthesis tool:** [Name and version]
- **Language / standard:** [Verilog/SystemVerilog version]
- **Operating system:** [macOS, Windows, Linux, or other]
- **Additional dependencies:** [List any required tools or libraries]
### Build and Run
```bash
# Replace these commands with the commands required for this lab.
[compile-command]
[run-command]
```
Expected output:
```text
[Paste a short representative output or result here.]
```

## Repository Organization
```text
.
├── README.md
├── data/
│ ├── data.mem
│ └── instr.mem
├── images/
│ └── MIPS_Pipeline.png
├── src/
│ ├── decode/
│ │ ├── control.v
│ │ ├── decode.v
│ │ ├── idExLatch.v
│ │ ├── regFile.v
│ │ └── signExt.v
│ ├── execute/
│ │ ├── adder.v
│ │ ├── alu.v
│ │ ├── alu_control.v
│ │ ├── bottom_mux.v
│ │ ├── ex_mem.v
│ │ ├── execute.v
│ │ └── top_mux.v
│ ├── fetch/
│ │ ├── adder.v
│ │ ├── fetch.v
│ │ ├── if_id_latch.v
│ │ ├── mem.v
│ │ ├── mux.v
│ │ └── pc.v
│ ├── memory_writeback/
│ │ ├── and.v
│ │ ├── data_memory.v
│ │ ├── mem_wb_latch.v
│ │ ├── memory.v
│ │ └── writeback.v
│ └── mips_pipeline.v
├── tb/
│ └── mips_pipeline_tb.v
└── README.md
```

## Known Issues and Future Improvements
- [Document any known issue, unverified behavior, or technical debt.]
- [Describe a realisti
