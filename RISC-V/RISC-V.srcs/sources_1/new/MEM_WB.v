module MEM_WB (
    input clk,
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
        memtoreg_WB <= memtoreg_MEM;
        regwrite_WB <= regwrite_MEM;
    end

    always @(posedge clk) begin
        dataread_WB <= dataread_MEM;
        alu_out_WB  <= alu_out_MEM;
        MEM_WB_rd   <= EX_MEM_rd;
    end
endmodule
