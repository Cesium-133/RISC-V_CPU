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


module CPU(
    input clk,
    input clk1,
    input rst,
    //IO to CPU inst bus
    input wire inst_ram_wen,
    input wire [31:0] inst_ram_waddr,
    input wire [31:0] inst_ram_wdata,
    //IO to MEM
    input wire ioread_MEM,
    input wire iowrite_MEM,
    input wire [31:0] io_addr_MEM,
    input wire [31:0] io_data_in_MEM,
    output wire [31:0] io_data_read_MEM
    );
    // �?有端口的中间变量，注意位宽�?�大小写和类�?
    wire PC_sel;
    wire PC_hold;
    wire [31:0] Add_2_out;
    wire [31:0] Read_address;
    wire [31:0] instruction_IF;
    wire [31:0] instruction_ID;
    wire [31:0] pc_ID;
    wire IF_ID_clear;
    wire IF_ID_hold;
    wire jump;
    wire ID_EX_clear_jump;
    wire memtoreg;
    wire regwrite;
    wire memread;
    wire memwrite;
    wire [2:0] aluop;
    wire alusrc;
    wire [2:0] memop;
    wire pc_rs1_sel;
    wire [31:0] imm;
    wire [31:0] Write_data;
    wire [31:0] Read_data_1;
    wire [31:0] Read_data_2;
    wire regwrite_WB;
    wire memtoreg_EX;
    wire regwrite_EX;
    wire memread_EX;
    wire memwrite_EX;
    wire [2:0] memop_EX;
    wire [2:0] aluop_EX;
    wire alusrc_EX;
    wire pc_rs1_sel_EX;
    wire [31:0] pc_EX;
    wire [31:0] rs1_EX;
    wire [31:0] rs2_EX;
    wire [31:0] imm_EX;
    wire [4:0] ID_EX_rs1;
    wire [4:0] ID_EX_rs2;
    wire [3:0] func_EX;
    wire [4:0] ID_EX_rd;   
    wire [4:0] ALU_ctrl;
    wire [31:0] num1;
    wire [31:0] num2;
    wire [31:0] num2_MUX5;
    wire [31:0] add2_address;
    wire [31:0] ALU_out;

    wire memtoreg_MEM;
    wire regwrite_MEM;
    wire memread_MEM;
    wire memwrite_MEM;
    wire [2:0] memop_MEM;
    wire [4:0] EX_MEM_rd;
    wire [31:0] alu_out_MEM;
    wire [31:0] rs2_MEM;
    wire [31:0] dataread_MEM;
    wire [31:0] cpu_data_in_MEM;
    wire [31:0] cpu_data_read_MEM;

    wire memtoreg_WB;
    wire [31:0] dataread_WB;
    wire [31:0] alu_out_WB;
    wire [4:0] MEM_WB_rd;

    wire ID_EX_clear_forward;
    wire [1:0] Forward_A;
    wire [1:0] Forward_B;

    pc pc_inst(
        .clk(clk),
        .rst(rst),
        .PC_sel(PC_sel),
        .PC_hold(PC_hold),
        .Add_2_out(Add_2_out),
        .Read_address(Read_address)
    );

    blk_mem_gen_0 instruction_memory_inst(
        .clka(clk1),    // input wire clka
        .wea(inst_ram_wen),      // input wire [0 : 0] wea
        .addra(inst_ram_waddr),  // input wire [12 : 0] addra
        .dina(inst_ram_wdata),    // input wire [31 : 0] dina
        .clkb(clk1),    // input wire clkb
        .addrb(Read_address[14:2]),  // input wire [12 : 0] addrb
        .doutb(instruction_IF)  // output wire [31 : 0] doutb
    );

    IF_ID IF_ID_inst(
        .clk(clk),
        .rst(rst),
        .IFID_clear(IF_ID_clear),
        .IFID_hold(IF_ID_hold),
        .pc_IF(Read_address),
        .instruction_IF(instruction_IF),
        .pc_ID(pc_ID),
        .instruction_ID(instruction_ID)
    );

    Jump_ctrl_unit Jump_ctrl_unit_inst(
        .jump(jump),
        .pc_sel(PC_sel),
        .IFID_clear(IF_ID_clear),
        .IDEX_clear(ID_EX_clear_jump)
    );

    control control_inst(
        .opcode(instruction_ID[6:0]),
        .funct3(instruction_ID[14:12]),
        .memtoreg(memtoreg),
        .regwrite(regwrite),
        .memread(memread),
        .memwrite(memwrite),
        .aluop(aluop),
        .alusrc(alusrc),
        .memop(memop),
        .pc_rs1_sel(pc_rs1_sel)
    );

    imm_gen imm_gen_inst(
        .instruction(instruction_ID),
        .imm(imm)
    );

    registers registers_inst(
        .clk(clk),
        .rst(rst),
        .instruction(instruction_ID),
        .Write_data(Write_data),
        .Write_register(MEM_WB_rd),
        .RegWrite(regwrite_WB),
        .Read_data_1(Read_data_1),
        .Read_data_2(Read_data_2)
    );

    ID_EX ID_EX_inst(
        .clk(clk),
        .rst(rst),
        .memtoreg_ID(memtoreg),
        .regwrite_ID(regwrite),
        .memread_ID(memread),
        .memwrite_ID(memwrite),
        .memop_ID(memop),
        .aluop_ID(aluop),
        .alusrc_ID(alusrc),
        .pc_rs1_sel_ID(pc_rs1_sel),
        .pc_ID(pc_ID),
        // instruction 
        .rs1_ID(Read_data_1),
        .rs2_ID(Read_data_2),
        .imm_ID(imm),
        .IF_ID_rs1(instruction_ID[24:20]),
        .IF_ID_rs2(instruction_ID[19:15]),
        .func_ID({instruction_ID[30], instruction_ID[14:12]}),
        .IF_ID_rd(instruction_ID[11:7]),
        .ID_EX_clr(ID_EX_clear_jump | ID_EX_clear_forward),


        // output
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

    ALU_Control ALU_Control_inst(
        .funct3(func_EX[2:0]),
        .funct7(func_EX[3]),
        .aluop(aluop),
        .ALU_ctrl(ALU_ctrl)
    );

    MUX7 MUX7_inst(
        .memtoreg_WB(memtoreg_WB),
        .dataread_wb(dataread_WB),
        .alu_out_wb(alu_out_WB),
        .writedata(Write_data)
    );

    MUX4 MUX4_inst(
        .rs1_EX(rs1_EX),
        .data_WB(Write_data),
        .alu_out_MEM(alu_out_MEM),
        .forward_A(Forward_A),
        .num1(num1)
    );

    MUX5 MUX5_inst(
        .rs2_EX(rs2_EX),
        .data_WB(Write_data),
        .alu_out_MEM(alu_out_MEM),
        .forward_B(Forward_B),
        .rs2(num2_MUX5)
    );

    MUX3 MUX3_inst(
        .pc(pc_EX),
        .rs1(num1),
        .pc_rs1_sel(pc_rs1_sel_EX),
        .add2_address(add2_address)
    );

    MUX6 MUX6_inst(
        .rs2(num2_MUX5),
        .imm(imm_EX),
        .alu_src(alusrc_EX),
        .num2(num2)
    );

    ADD2 ADD2_inst(
        .add2_address(add2_address),
        .imm(imm_EX),
        .jump_address(Add_2_out)
    );

    ALU ALU_inst(
        .ALU_ctrl(ALU_ctrl),
        .pc_in(pc_EX),
        .num1(num1),
        .num2(num2),
        .ALU_out(ALU_out),
        .jump(jump)
    );

    EX_MEM EX_MEM_inst (
        .clk(clk),
        .rst(rst),
        .memtoreg_EX(memtoreg_EX),
        .regwrite_EX(regwrite_EX),
        .memread_EX(memread_EX),
        .memwrite_EX(memwrite_EX),
        .memop_EX(memop_EX),
        .alu_out_EX(ALU_out),
        .rs2_EX(num2),
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

    blk_mem_gen_1 DATA_MEMORY_inst(
        .clka(clk1),    // input wire clka
        .ena(memread_MEM | memwrite_MEM),      // input wire ena
        .wea(memwrite_MEM),      // input wire [0 : 0] wea
        .addra(alu_out_MEM[14:2]),  // input wire [12 : 0] addra
        .dina(cpu_data_in_MEM),    // input wire [31 : 0] dina
        .douta(cpu_data_read_MEM),  // output wire [31 : 0] douta
        .clkb(clk1),    // input wire clkb
        .enb(ioread_MEM | iowrite_MEM),      // input wire enb
        .web(iowrite_MEM),      // input wire [0 : 0] web
        .addrb(io_addr_MEM[14:2]),  // input wire [12 : 0] addrb
        .dinb(io_data_in_MEM),    // input wire [31 : 0] dinb
        .doutb(io_data_read_MEM)  // output wire [31 : 0] doutb
    );

    mem_operation_read mem_operation_read_inst(
        .memop_MEM(memop_MEM),
        .cpu_data_read_MEM(cpu_data_read_MEM),
        .dataread_MEM(dataread_MEM)
    );

    mem_operation_write mem_operation_write_inst(
        .memop_MEM(memop_MEM),
        .cpu_data_in_MEM(cpu_data_in_MEM),
        .rs2_MEM(rs2_MEM)
    );

    MEM_WB MEM_WB_inst(
        .clk(clk),
        .rst(rst),
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

    Hazard_Detection_Forwarding_unit Hazard_Detection_Forwarding_unit_inst(
        .EX_MEM_RegWrite(regwrite_MEM),
        .MEM_WB_RegWrite(regwrite_WB),
        .EX_MEM_RD(EX_MEM_rd),
        .MEM_WB_RD(MEM_WB_rd),
        .ID_EX_RS1(ID_EX_rs1),
        .ID_EX_RS2(ID_EX_rs2),
        .ID_EX_RD(ID_EX_rd),
        .IF_ID_RS1(instruction_ID[24:20]),
        .IF_ID_RS2(instruction_ID[19:15]),
        .ID_EX_MemRead(memread_EX),
        // output
        .IF_ID_hold(IF_ID_hold),
        .PC_hold(PC_hold),
        .ID_EX_clear(ID_EX_clear_forward),
        .Forward_A(Forward_A),
        .Forward_B(Forward_B)
    );
endmodule
