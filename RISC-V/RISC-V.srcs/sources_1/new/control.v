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
module control (
    input [6:0] opcode,    // 7-bit opcode
    input [2:0] funct3,    // 3-bit funct3
    output reg memtoreg,   // Mem to reg select
    output reg regwrite,   // Register write enable
    output reg memread,    // Memory read enable
    output reg memwrite,   // Memory write enable
    output reg [1:0] aluop,// ALU operation select
    output reg alusrc,     // ALU source select
    output reg memop,      // Memory operation (read/write)
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
            7'b0000011: begin // Load instruction (LW)
                regwrite = 1;
                memread = 1;
                memtoreg = 1;
                aluop = 2'b00;
                alusrc = 1;
            end
            7'b0100011: begin // Store instruction (SW)
                memwrite = 1;
                aluop = 2'b00;
                alusrc = 1;
                memop = 1;
            end
            7'b1100011: begin // Branch instructions (BEQ, BNE, etc.)
                aluop = 2'b01;
                alusrc = 0;
                pc_rs1_sel = 0; // Select PC for branches
            end
            7'b0010011: begin // I-type arithmetic (ADDI, SLTI, etc.)
                regwrite = 1;
                aluop = 2'b10;
                alusrc = 1;
            end
            7'b0110011: begin // R-type arithmetic (ADD, SUB, AND, OR, etc.)
                regwrite = 1;
                aluop = 2'b10;
                alusrc = 0;
            end
            7'b1101111: begin // JAL instruction
                regwrite = 1;
                aluop = 2'b11;
                pc_rs1_sel = 0; // Select PC for jump address
            end
            7'b1100111: begin // JALR instruction
                regwrite = 1;
                aluop = 2'b11;
                pc_rs1_sel = 1; // Select RS1 for jump address
            end
            default: begin
                // Default case for invalid opcode
                regwrite = 0;
            end
        endcase
    end
endmodule
