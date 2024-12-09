module MUX6 (
    input [31:0] rs2_EX,
    input [31:0] data_WB,
    input [31:0] alu_out_MEM,
    input [1:0] forward_B,
    output reg [31:0] rs2
);
    always @(*) begin
        case (forward_B)
            2'b00:   rs2 = rs2_EX;
            2'b01:   rs2 = data_WB;
            2'b10:   rs2 = alu_out_MEM;
            default: rs2 = 32'd0;
        endcase
    end
endmodule
