module MUX3 (
    input [12:0] pc,
    input [12:0] rs1,
    input pc_rs1_sel,
    output [12:0] add2_address
);
    assign add2_address = (pc_rs1_sel) ? rs1 : pc;
endmodule
