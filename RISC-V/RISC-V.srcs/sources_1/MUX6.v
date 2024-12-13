module MUX6 (
    input [31:0] rs2,
    input [31:0] imm,
    input alu_src,
    output [31:0] num2
);
    assign num2 = (alu_src) ? imm : rs2;
endmodule
