`define ADD 5'd1    //操作数相加
`define SUB 5'd2    //操作数相减
`define XOR 5'd3    //按位异或
`define OR 5'd4     //按位或
`define AND 5'd5    //按位与
`define SLL 5'd6    //左移位
`define SRL 5'd7    //逻辑右移
`define SRA 5'd8    //算术右移
`define SLT 5'd9    //有符号比较
`define SLTU 5'd10  //无符号比较
`define BEQ 5'd11   //等于跳转
`define BNE 5'd12   //不等于跳转
`define BLT 5'd13   //有符号小于跳转
`define BGE 5'd14   //有符号不小于跳转
`define BLTU 5'd15  //无符号小于跳转
`define BGEU 5'd16  //无符号不小于跳转
`define PC 5'd17    //操作pc
`define LUI 5'd18   //立即数高位加载
`define AUIPC 5'd19 //立即数与pc相加

module ALU_Control (
    input [2:0] funct3,
    input funct7,
    input [2:0] aluop,
    output reg [4:0] ALU_ctrl
);


    always @(*) begin
        casez ({
            aluop, funct3
        })
            6'b010_000: begin
                if (!funct7) ALU_ctrl = `ADD;
                else ALU_ctrl = `SUB;
            end
            6'b000_???: ALU_ctrl = `ADD;
            6'b010_100: ALU_ctrl = `XOR;
            6'b010_110: ALU_ctrl = `OR;
            6'b010_111: ALU_ctrl = `AND;
            6'b010_001: ALU_ctrl = `SLL;
            6'b010_101: begin
                if (!funct7) ALU_ctrl = `SRL;
                else ALU_ctrl = `SRA;
            end
            6'b010_010: ALU_ctrl = `SLT;
            6'b010_011: ALU_ctrl = `SLTU;
            6'b001_000: ALU_ctrl = `BEQ;
            6'b001_001: ALU_ctrl = `BNE;
            6'b001_100: ALU_ctrl = `BLT;
            6'b001_101: ALU_ctrl = `BGE;
            6'b001_110: ALU_ctrl = `BLTU;
            6'b001_111: ALU_ctrl = `BGEU;
            6'b011_???: ALU_ctrl = `PC;
            6'b100_???: ALU_ctrl = `LUI;
            6'b110_???: ALU_ctrl = `AUIPC;
            default: ALU_ctrl = 6'd0;
        endcase
    end


endmodule
