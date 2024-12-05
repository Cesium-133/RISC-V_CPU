module ALU_Control (
    input [2:0] func3,
    input func7,
    input [1:0] aluop,
    output reg [4:0] ALU_ctrl
);
    parameter ADD = 5'd1;  //操作数相加
    parameter SUB = 5'd2;  //操作数相减
    parameter XOR = 5'd3;  //按位异或
    parameter OR = 5'd4;  //按位或
    parameter AND = 5'd5;  //按位与
    parameter SLL = 5'd6;  //左移位
    parameter SRL = 5'd7;  //逻辑右移
    parameter SRA = 5'd8;  //算术右移
    parameter SLT = 5'd9;  //有符号比较
    parameter SLTU = 5'd10;  //无符号比较
    parameter BEQ = 5'd11;  //等于跳转
    parameter BNE = 5'd12;  //不等于跳转
    parameter BLT = 5'd13;  //有符号小于跳转
    parameter BGE = 5'd14;  //有符号不小于跳转
    parameter BLTU = 5'd15;  //无符号小于跳转
    parameter BGEU = 5'd16;  //无符号不小于跳转
    parameter PC = 5'd17;  //操作pc

    always @(*) begin
        casez ({
            aluop, func3
        })
            5'b10_000: begin
                if (!func7) ALU_ctrl = ADD;
                else ALU_ctrl = SUB;
            end
            5'b00_???: ALU_ctrl = ADD;
            5'b10_100: ALU_ctrl = XOR;
            5'b10_110: ALU_ctrl = OR;
            5'b10_111: ALU_ctrl = AND;
            5'b10_100: ALU_ctrl = XOR;
            5'b10_001: ALU_ctrl = SLL;
            5'b10_101: begin
                if (!func7) ALU_ctrl = SRL;
                else ALU_ctrl = SRA;
            end
            5'b10_010: ALU_ctrl = SLT;
            5'b10_011: ALU_ctrl = SLTU;
            5'b01_000: ALU_ctrl = BEQ;
            5'b01_001: ALU_ctrl = BNE;
            5'b01_100: ALU_ctrl = BLT;
            5'b01_101: ALU_ctrl = BGE;
            5'b01_110: ALU_ctrl = BLTU;
            5'b01_111: ALU_ctrl = BGEU;
            5'b11_???: ALU_ctrl = PC;
            default:   ALU_ctrl = 5'd0;
        endcase
    end


endmodule
