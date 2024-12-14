module MUX7(
    input memtoreg_WB,
    input wire [31:0] dataread_wb,
    input wire [31:0] alu_out_wb,
    output [31:0] writedata
);
    assign writedata = memtoreg_WB ? dataread_wb : alu_out_wb;
endmodule