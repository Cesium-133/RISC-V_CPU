module ADD2 (
    input  [31:0] add2_address,
    input  [31:0] imm,
    output [31:0] jump_address
);
    assign jump_address = add2_address + imm;
endmodule
