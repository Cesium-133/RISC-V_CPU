module ID_EX (
    input clk,
    input memtoreg_ID,
    input regwrite_ID,
    input memread_ID,
    input memwrite_ID,
    input memop_ID,
    input [2:0] aluop_ID,
    input alusrc_ID,
    input pc_rs1_sel_ID,
    input [12:0] pc_ID,
    input [31:0] rs1_ID,
    input [31:0] rs2_ID,
    input [31:0] imm_ID,
    input [4:0] IF_ID_rs1,
    input [4:0] IF_ID_rs2,
    input [3:0] func_ID,
    input [4:0] IF_ID_rd,
    input ID_EX_clr,

    output reg memtoreg_EX,
    output reg regwrite_EX,
    output reg memread_EX,
    output reg memwrite_EX,
    output reg memop_EX,
    output reg [2:0] aluop_EX,
    output reg alusrc_EX,
    output reg pc_rs1_sel_EX,
    output reg [12:0] pc_EX,
    output reg [31:0] rs1_EX,
    output reg [31:0] rs2_EX,
    output reg [31:0] imm_EX,
    output reg [4:0] ID_EX_rs1,
    output reg [4:0] ID_EX_rs2,
    output reg [3:0] func_EX,
    output reg [4:0] ID_EX_rd
);
    always @(posedge clk) begin
        if (ID_EX_clr) begin
            memread_EX <= 0;
            memwrite_EX <= 0;
            memop_EX <= 0;
        end else begin
            memread_EX <= memread_ID;
            memwrite_EX <= memwrite_ID;
            memop_EX <= memop_ID;
        end
    end

    always @(posedge clk) begin
        if (ID_EX_clr) begin
            memtoreg_EX <= 0;
            regwrite_EX <= 0;
        end else begin
            memtoreg_EX <= memtoreg_ID;
            regwrite_EX <= regwrite_ID;
        end
    end

    always @(posedge clk) begin
        if (ID_EX_clr) begin
            aluop_EX <= 0;
            alusrc_EX <= 0;
            pc_rs1_sel_EX <= 0;
        end else begin
            aluop_EX <= aluop_ID;
            alusrc_EX <= alusrc_ID;
            pc_rs1_sel_EX <= pc_rs1_sel_ID;
        end
    end

    always @(posedge clk) begin
        if (ID_EX_clr) begin
            pc_EX <= 12'd0;
        end else begin
            pc_EX <= pc_ID;
        end
    end

    always @(posedge clk) begin
        if (ID_EX_clr) begin
            rs1_EX <= 32'd0;
            rs2_EX <= 32'd0;
            imm_EX <= 32'd0;
        end else begin
            rs1_EX <= rs1_ID;
            rs2_EX <= rs2_ID;
            imm_EX <= imm_ID;
        end
    end

    always @(posedge clk) begin
        if (ID_EX_clr) begin
            ID_EX_rs1 <= 5'd0;
            ID_EX_rs2 <= 5'd0;
            ID_EX_rd  <= 5'd0;
        end else begin
            ID_EX_rd  <= IF_ID_rd;
            ID_EX_rs1 <= IF_ID_rs1;
            ID_EX_rs2 <= IF_ID_rs2;
        end
    end

    always @(posedge clk) begin
        if (ID_EX_clr) begin
            func_EX <= 4'd0;
        end else begin
            func_EX <= func_ID;
        end
    end
endmodule
