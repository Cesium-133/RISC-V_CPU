module EX_MEM (
    input clk,
    input rst,
    input memtoreg_EX,
    input regwrite_EX,
    input memread_EX,
    input memwrite_EX,
    input memop_EX,
    input [31:0] alu_out_EX,
    input [31:0] rs2_EX,
    input [4:0] ID_EX_rd,
    output reg memtoreg_MEM,
    output reg regwrite_MEM,
    output reg memread_MEM,
    output reg memwrite_MEM,
    output reg memop_MEM,
    output reg [31:0] alu_out_MEM,
    output reg [31:0] rs2_MEM,
    output reg [4:0] EX_MEM_rd
);
    always @(posedge clk) begin
        if (rst) begin
            memread_MEM <= 0;
            memwrite_MEM <= 0;
            memop_MEM <= 0;
        end else begin
            memread_MEM <= memread_EX;
            memwrite_MEM <= memwrite_EX;
            memop_MEM <= memop_EX;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            memtoreg_MEM <= 0;
            regwrite_MEM <= 0;
        end else begin
            memtoreg_MEM <= memtoreg_EX;
            regwrite_MEM <= regwrite_EX;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            alu_out_MEM <= 0;
            rs2_MEM <= 0;
            EX_MEM_rd <= 0;
        end else begin
            alu_out_MEM <= alu_out_EX;
            rs2_MEM <= rs2_EX;
            EX_MEM_rd <= ID_EX_rd;
        end
    end
endmodule
