`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: qqqq
// 
// Create Date: 2024/11/30 19:34:10
// Design Name: 
// Module Name: control
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

`define OP_ARI 3'b010
`define OP_MEM 3'b000
`define OP_BRANCH 3'b001
`define OP_JAL 3'b011
`define OP_LUI 3'b100
`define OP_AUPIC 3'b110

`define LW 7'b0000011
`define SW 7'b0100011
`define BEQ 7'b1100011
`define ADD 7'b0110011
`define ADDI 7'b0010011
`define JAL 7'b1101111
`define JALR 7'b1100111
`define LUI 7'b0110111
`define AUIPC 7'b0010111

module control (
    input [6:0] opcode,    // 7-bit opcode
    input [2:0] funct3,    // 3-bit funct3
    output reg memtoreg,   // Mem to reg select
    output reg regwrite,   // Register write enable
    output reg memread,    // Memory read enable
    output reg memwrite,   // Memory write enable
    output reg [2:0] memop,      // Memory operation (8 situation)
    output reg [2:0] aluop,// ALU operation select
    output reg alusrc,     // ALU source select
    output reg pc_rs1_sel  // Select PC or RS1 for jump instructions
);

    always @(*) begin
        // Default values
        memtoreg = 0;
        regwrite = 0;
        memread = 0;
        memwrite = 0;
        aluop = 2'b00;
        alusrc = 0;
        memop = 0;
        pc_rs1_sel = 0;

        case(opcode)
            `LW: begin // Load instruction (LW)
                regwrite = 1;
                memread = 1;
                memtoreg = 1;
                aluop = `OP_MEM;
                alusrc = 1;
                case(funct3)
                    3'b000:memop = 3'b000; // LB
                    3'b001:memop = 3'b001; // LH
                    3'b010:memop = 3'b010; // LW
                    3'b100:memop = 3'b011; // LBU
                    3'b101:memop = 3'b100; // LHU
                    default:memop = 3'bx;
                endcase
            end
            `SW: begin // Store instruction (SW)
                memwrite = 1;
                aluop = `OP_MEM;
                alusrc = 1;
                case(funct3)
                    3'b000:memop = 3'b101; // SB
                    3'b001:memop = 3'b110; // SH
                    3'b010:memop = 3'b111; // SW
                    default:memop = 3'bx;
                endcase
            end
            `BEQ: begin // Branch instructions (BEQ, BNE, etc.)
                aluop = `OP_BRANCH;
                alusrc = 0;
                pc_rs1_sel = 0; // Select PC for branches
            end
            `ADDI: begin // I-type arithmetic (ADDI, SLTI, etc.)
                regwrite = 1;
                aluop = `OP_ARI;
                alusrc = 1;
            end
            `ADD: begin // R-type arithmetic (ADD, SUB, AND, OR, etc.)
                regwrite = 1;
                aluop = `OP_ARI;
                alusrc = 0;
            end
            `JAL: begin // JAL instruction
                regwrite = 1;
                aluop = `OP_JAL;
                pc_rs1_sel = 0; // Select PC for jump address
            end
            `JALR: begin // JALR instruction
                regwrite = 1;
                aluop = `OP_JAL;
                pc_rs1_sel = 1; // Select RS1 for jump address
            end
            `LUI: begin // LUI instruction
                regwrite = 1;
                aluop = `OP_LUI;
                alusrc = 1;
            end
            `AUIPC: begin // AUIPC instruction
                regwrite = 1;
                aluop = `OP_AUPIC;
                alusrc = 1;
            end
            default: begin
                // Default case for invalid opcode
                regwrite = 0;
            end
        endcase
    end
endmodule
