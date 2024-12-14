module MUX4 (
    input [31:0] rs1_EX,
    input [31:0] data_WB,
    input [31:0] alu_out_MEM,
    input [1:0] forward_A,
    output reg [31:0] num1
);
    always @(*) begin
        case (forward_A)
            2'b00:   num1 = rs1_EX;
            2'b01:   num1 = data_WB;
            2'b10:   num1 = alu_out_MEM;
            default: num1 = 32'd0;
        endcase
    end
endmodule
