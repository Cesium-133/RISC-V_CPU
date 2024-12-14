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

module ALU (
    input [4:0] ALU_ctrl,
    input [12:0] pc_in,
    input [31:0] num1,
    input [31:0] num2,
    output reg [31:0] ALU_out,
    output reg jump
);


    always @(*) begin
        case (ALU_ctrl)
            `ADD: ALU_out = num1 + num2;
            `SUB: ALU_out = num1 - num2;
            `XOR: ALU_out = num1 ^ num2;
            `OR: ALU_out = num1 | num2;
            `AND: ALU_out = num1 & num2;
            `SLL: ALU_out = num1 << num2;
            `SRL: ALU_out = num1 >> num2;
            `SRA: ALU_out = num1 >>> num2;
            `SLT: ALU_out = ($signed(num1) < $signed(num2)) ? 32'd1 : 32'd0;
            `SLTU: ALU_out = (num1 < num2) ? 1 : 0;
            `BEQ: jump = (num1 == num2);
            `BNE: jump = (num1 != num2);
            `BLT: jump = ($signed(num1) < $signed(num2));
            `BGE: jump = ($signed(num1) >= $signed(num2));
            `BLTU: jump = (num1 < num2);
            `BGEU: jump = (num1 >= num2);
            `PC: ALU_out = pc_in + 4;
            `LUI: ALU_out = num2;
            `AUIPC: ALU_out = pc_in + num2;
            default: begin
                ALU_out = 0;
                jump = 0;
            end
        endcase
    end

endmodule
