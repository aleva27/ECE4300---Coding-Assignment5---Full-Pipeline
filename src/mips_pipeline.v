// mips_pipeline.v - Top module of the full MIPS pipeline

module mips_pipeline(
    input wire clk,
    input wire rst
);

    // FETCH Stage
    wire [31:0] if_id_instr;
    wire [31:0] if_id_npc;
    wire        mem_pc_src;
    wire [31:0] branch_target;

    fetch fetch_stage(
        .clk(clk),
        .rst(rst),
        .mem_pc_src(mem_pc_src),
        .mem_npc(branch_target),
        .if_id_instr(if_id_instr),
        .if_id_npc(if_id_npc)
    );

    // DECODE Stage
    wire        wb_reg_write;
    wire [4:0]  wb_write_reg;
    wire [31:0] wb_write_data;
    wire [1:0]  id_ex_wb;
    wire [2:0]  id_ex_mem;
    wire [3:0]  id_ex_ex;
    wire [31:0] id_ex_npc, id_ex_rdata1, id_ex_rdata2, id_ex_sign_ext;
    wire [4:0]  id_ex_rt, id_ex_rd;
    wire [5:0]  id_ex_funct;

    decode decode_stage(
        .clk(clk),
        .rst(rst),
        .wb_reg_write(wb_reg_write),
        .wb_write_reg_location(wb_write_reg),
        .mem_wb_write_data(wb_write_data),
        .if_id_instr(if_id_instr),
        .if_id_npc(if_id_npc),
        .id_ex_wb(id_ex_wb),
        .id_ex_mem(id_ex_mem),
        .id_ex_execute(id_ex_ex),
        .id_ex_npc(id_ex_npc),
        .id_ex_readdat1(id_ex_rdata1),
        .id_ex_readdat2(id_ex_rdata2),
        .id_ex_sign_ext(id_ex_sign_ext),
        .id_ex_instr_bits_20_16(id_ex_rt),
        .id_ex_instr_bits_15_11(id_ex_rd),
        .id_ex_funct(id_ex_funct)
    );

    // EXECUTE Stage
    wire [1:0]  ex_mem_wb;
    wire [2:0]  ex_mem_control;
    wire [31:0] ex_mem_branch_target, ex_mem_alu_result, ex_mem_rdata2;
    wire        ex_mem_zero;
    wire [4:0]  ex_mem_write_reg;

    execute execute_stage(
        .clk(clk),
        .rst(rst),
        .ctlwb_in(id_ex_wb),
        .ctlm_in(id_ex_mem),
        .regdst(id_ex_ex[3]),
        .alusrc(id_ex_ex[0]),
        .alu_op(id_ex_ex[2:1]),
        .funct(id_ex_funct),
        .npc(id_ex_npc),
        .rdata1(id_ex_rdata1),
        .rdata2(id_ex_rdata2),
        .s_extend(id_ex_sign_ext),
        .instr_2016(id_ex_rt),
        .instr_1511(id_ex_rd),
        .ctlwb_out(ex_mem_wb),
        .ctlm_out(ex_mem_control),
        .adder_out(ex_mem_branch_target),
        .zero(ex_mem_zero),
        .alu_result_out(ex_mem_alu_result),
        .rdata2_out(ex_mem_rdata2),
        .muxout_out(ex_mem_write_reg)
    );

    // MEMORY & WRITEBACK Stage
    wire        mem_wb_memtoreg;
    wire [31:0] mem_read_data, mem_alu_result;

    memory memory_stage(
        .clk(clk),
        .rst(rst),
        .wb_ctlout(ex_mem_wb),
        .branch(ex_mem_control[2]),
        .memread(ex_mem_control[1]),
        .memwrite(ex_mem_control[0]),
        .zero(ex_mem_zero),
        .alu_result(ex_mem_alu_result),
        .rdata2out(ex_mem_rdata2),
        .five_bit_muxout(ex_mem_write_reg),
        .MEM_PCSrc(mem_pc_src),
        .MEM_WB_regwrite(wb_reg_write),
        .MEM_WB_memtoreg(mem_wb_memtoreg),
        .read_data(mem_read_data),
        .mem_alu_result(mem_alu_result),
        .mem_write_reg(wb_write_reg)
    );

    writeback writeback_stage(
        .mem_to_reg(mem_wb_memtoreg),
        .read_data(mem_read_data),
        .mem_alu_result(mem_alu_result),
        .write_data(wb_write_data)
    );

    assign branch_target = ex_mem_branch_target;

endmodule
