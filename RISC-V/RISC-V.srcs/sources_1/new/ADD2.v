module ADD2 (
    input  [12:0] add2_address,
    input  [12:0] imm,
    output [12:0] jump_address
);
    assign jump_address = add2_address + imm;
endmodule
