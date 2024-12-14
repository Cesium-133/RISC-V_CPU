module MEM_WB (
    input clk,
    input rst,
    input memtoreg_MEM,
    input regwrite_MEM,
    input [31:0] dataread_MEM,
    input [31:0] alu_out_MEM,
    input [4:0] EX_MEM_rd,
    output reg memtoreg_WB,
    output reg regwrite_WB,
    output reg [31:0] dataread_WB,
    output reg [31:0] alu_out_WB,
    output reg [4:0] MEM_WB_rd
);
    always @(posedge clk) begin
        if (rst) begin
            memtoreg_WB <= 0;
            regwrite_WB <= 0;
        end else begin
            memtoreg_WB <= memtoreg_MEM;
            regwrite_WB <= regwrite_MEM;
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            dataread_WB <= 0;
            alu_out_WB  <= 0;
            MEM_WB_rd   <= 0;
        end else begin
            dataread_WB <= dataread_MEM;
            alu_out_WB  <= alu_out_MEM;
            MEM_WB_rd   <= EX_MEM_rd;
        end
    end
endmodule
