module IF_ID (
    input clk,
    input rst,
    input IFID_clear,
    input IFID_hold,
    input [31:0] pc_IF,
    input [31:0] instruction_IF,
    output reg [31:0] pc_ID,
    output reg [31:0] instruction_ID
);
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc_ID <= 32'd0;
        end
        else if (IFID_clear) pc_ID <= 32'd0;
        else if (IFID_hold) pc_ID <= pc_ID;
        else pc_ID <= pc_IF;
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            instruction_ID <= 32'd0;
        end
        else if (IFID_clear) instruction_ID <= 32'd0;
        else if (IFID_hold) instruction_ID <= instruction_ID;
        else instruction_ID <= instruction_IF;
    end
endmodule
