`timescale 1ns / 1ps

// Forward A control num1 of ALU
// Forward B control num2 of ALU
`define Forward_ALU 2'b10 
`define Forward_WB 2'b01
`define Forward_Rs 2'b00

module Hazard_Detection_Forwarding_unit(
    input EX_MEM_RegWrite, 
    input MEM_WB_RegWrite,
    input [4:0] EX_MEM_RD,
    input [4:0] MEM_WB_RD,
    input [4:0] ID_EX_RS1, 
    input [4:0] ID_EX_RS2,
    input [4:0] ID_EX_RD,
    input [4:0] IF_ID_RS1,
    input [4:0] IF_ID_RS2,
    input [4:0] ID_EX_MemRead,
    output reg IF_ID_hold, 
    output reg PC_hold,
    output reg ID_EX_clear,
    output reg [1:0] Forward_A,
    output reg [1:0] Forward_B
);

    //Forward A & B
    always @(*) begin
        Forward_A = `Forward_Rs;
        Forward_B = `Forward_Rs;
        if (EX_MEM_RegWrite) begin // 优先让后来的指令写
            if (EX_MEM_RD == ID_EX_RS1) begin
                Forward_A = `Forward_ALU;
            end
            if (EX_MEM_RD == ID_EX_RS2) begin
                Forward_B = `Forward_ALU;
            end
        end else if (MEM_WB_RegWrite) begin
            if (MEM_WB_RD == ID_EX_RS1) begin
                Forward_A = `Forward_WB;
            end
            if (MEM_WB_RD == ID_EX_RS2) begin
                Forward_B = `Forward_WB;
            end
        end
    end

    // Bubble
    always @(*) begin
        IF_ID_hold = 0;
        PC_hold = 0;
        ID_EX_clear = 0;
        if (ID_EX_MemRead) begin
            if (ID_EX_RD == IF_ID_RS1 || ID_EX_RD == IF_ID_RS2) begin
                IF_ID_hold = 1;
                PC_hold = 1;
                ID_EX_clear = 1;
            end
        end
    end
endmodule