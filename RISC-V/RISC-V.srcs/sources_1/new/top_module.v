`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/30 15:59:29
// Design Name: 
// Module Name: top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_module(
    input clk,
    input rst
    );
    // 给这些变量声明中间变量

    // 例化 pc 模块
    pc pc_inst(
        .clk(clk),
        .rst(rst),
        .PC_sel(PC_sel),
        .PC_hold(PC_hold),
        .Add_2_out(Add_2_out),
        .Read_address(Read_address)
    );

    // 例化 instruction_memory 模块
    blk_mem_gen_0 instruction_memory_inst(
        .clka(clk),
        .addra(Read_address),
        .douta(instruction)
    );

    // 例化  IF_ID 模块
    IF_ID IF_ID_inst(
        .clk(clk),
        .IFID_clear(IFID_clear),
        .IFID_hold(IFID_hold),
        .pc_IF(Read_address),
        .instruction_IF(instruction)
    );

    // 例化 jump_ctrl_unit 
    Jump_ctrl_unit Jump_ctrl_unit_inst(
        .jump(jump),
        .pc_sel(PC_sel),
        .IFID_clear(IFID_clear),
        .IDEX_clear(IDEX_clear)
    );

    // 例化 Hazard_Detection_Forwarding_unit 模块
    Hazard_Detection_Forwarding_unit Hazard_Detection_Forwarding_unit_inst(
        .EX_MEM_RegWrite(EX_MEM_RegWrite),
        .MEM_WB_RegWrite(MEM_WB_RegWrite),
        .EX_MEM_RD(EX_MEM_RD),
        .MEM_WB_RD(MEM_WB_RD),
        .ID_EX_RS1(ID_EX_RS1),
        .ID_EX_RS2(ID_EX_RS2),
        .ID_EX_RD(ID_EX_RD),
        .IF_ID_RS1(IF_ID_RS1),
        .IF_ID_RS2(IF_ID_RS2),
        .ID_EX_MemRead(ID_EX_MemRead),
        .IF_ID_hold(IF_ID_hold),
        .PC_hold(PC_hold),
        .ID_EX_clear(ID_EX_clear),
        .Forward_A(Forward_A),
        .Forward_B(Forward_B)
    );

    // 例化 ID_EX 模块
    ID_EX ID_EX_inst(
        .clk(clk),
        .memtoreg_ID(memtoreg_ID),
        .regwrite_ID(regwrite_ID),
        .memread_ID(memread_ID),
        .memwrite_ID(memwrite_ID),
        .memop_ID(memop_ID),
        .aluop_ID(aluop_ID),
        .alusrc_ID(alusrc_ID),
        .pc_rs1_sel_ID(pc_rs1_sel_ID),
        .pc_ID(pc_ID),
        .rs1_ID(rs1_ID),
        .rs2_ID(rs2_ID),
        .imm_ID(imm_ID),
        .IF_ID_rs1(IF_ID_rs1),
        .IF_ID_rs2(IF_ID_rs2),
        .func_ID(func_ID),
        .IF_ID_rd(IF_ID_rd),
        .ID_EX_clr(ID_EX_clr),
        .memtoreg_EX(memtoreg_EX),
        .regwrite_EX(regwrite_EX),
        .memread_EX(memread_EX),
        .memwrite_EX(memwrite_EX),
        .memop_EX(memop_EX),
        .aluop_EX(aluop_EX),
        .alusrc_EX(alusrc_EX),
        .pc_rs1_sel_EX(pc_rs1_sel_EX),
        .pc_EX(pc_EX),
        .rs1_EX(rs1_EX),
        .rs2_EX(rs2_EX),
        .imm_EX(imm_EX),
        .ID_EX_rs1(ID_EX_rs1),
        .ID_EX_rs2(ID_EX_rs2),
        .func_EX(func_EX),
        .ID_EX_rd(ID_EX_rd)
    );

    // 例化 EX_MEM 模块
    EX_MEM EX_MEM_inst (
        .clk(clk),
        .memtoreg_EX(memtoreg_EX),
        .regwrite_EX(regwrite_EX),
        .memread_EX(memread_EX),
        .memwrite_EX(memwrite_EX),
        .memop_EX(memop_EX),
        .alu_out_EX(alu_out_EX),
        .rs2_EX(rs2_EX),
        .ID_EX_rd(ID_EX_rd),
        .memtoreg_MEM(memtoreg_MEM),
        .regwrite_MEM(regwrite_MEM),
        .memread_MEM(memread_MEM),
        .memwrite_MEM(memwrite_MEM),
        .memop_MEM(memop_MEM),
        .alu_out_MEM(alu_out_MEM),
        .rs2_MEM(rs2_MEM),
        .EX_MEM_rd(EX_MEM_rd)
    );

    // 例化 MEM_WB 模块
    MEM_WB MEM_WB_inst(
        .clk(clk),
        .memtoreg_MEM(memtoreg_MEM),
        .regwrite_MEM(regwrite_MEM),
        .dataread_MEM(dataread_MEM),
        .alu_out_MEM(alu_out_MEM),
        .EX_MEM_rd(EX_MEM_rd),
        .memtoreg_WB(memtoreg_WB),
        .regwrite_WB(regwrite_WB),
        .dataread_WB(dataread_WB),
        .alu_out_WB(alu_out_WB),
        .MEM_WB_rd(MEM_WB_rd)
    );

    // 例化 control 模块
    control control_inst(
        .opcode(opcode),
        .func3(func3),
        .memtoreg(memtoreg),
        .regwrite(regwrite),
        .memread(memread),
        .memwrite(memwrite),
        .aluop(aluop),
        .alusrc(alusrc),
        .memop(memop),
        .pc_rs1_sel(pc_rs1_sel)
    );

    // 例化 ALU_Control
    ALU_Control ALU_Control_inst(
        .func3(func3),
        .func7(func7),
        .aluop(aluop),
        .ALU_ctrl(ALU_ctrl)
    );

    // 例化 ALU 
    ALU ALU_inst(
        .ALU_ctrl(ALU_ctrl),
        .pc_in(pc_in),
        .num1(num1),
        .num2(num2),
        .ALU_out(ALU_out),
        .jump(jump)
    );

    // 例化 imm_gen 
    imm_gen imm_gen_inst(
        .instruction(instruction),
        .imm(imm)
    );

    // 例化 registers
    registers registers_inst(
        .clk(clk),
        .instruction(instruction),
        .Write_data(Write_data),
        .Write_register(Write_register),
        .RegWrite(RegWrite),
        .Read_data_1(Read_data_1),
        .Read_data_2(Read_data_2)
    );

    // 例化 MUX3 MUX4 MUX6
    MUX3 MUX3_inst(
        .pc(pc),
        .jump_address(jump_address),
        .jump(jump),
        .pc_out(pc_out)
    );
    
    // 去 MUX4.V 里面找 mux4
    MUX4 MUX4_inst(
        .rs1_EX(rs1_EX),
        .data_WB(data_WB),
        .alu_out_MEM(alu_out_MEM),
        .forward_A(forward_A),
        .num1(num1)
    );

    // 去 MUX6.V 里面找 mux6
    MUX6 MUX6_inst(
        .rs2_EX(rs2_EX),
        .data_WB(data_WB),
        .alu_out_MEM(alu_out_MEM),
        .forward_B(forward_B),
        .rs2(rs2)
    );

    // ADD2 
    ADD2 ADD2_inst(
        .add2_address(add2_address),
        .imm(imm),
        .jump_address(jump_address)
    );

endmodule
