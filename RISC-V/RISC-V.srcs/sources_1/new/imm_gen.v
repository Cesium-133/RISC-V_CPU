`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/02 20:41:16
// Design Name: 
// Module Name: imm_gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imm_gen(
    input wire [31:0] instruction,
    output reg [31:0] imm
    );

    always @(*) begin
        case(instruction[6:0])
        7'b0110111: imm = {instruction[31:12],12'b0};
        7'b0010111: imm = {instruction[31:12],12'b0}; //U-type
        7'b1101111: imm = {{12{instruction[31]}},instruction[19:12],instruction[20],instruction[30:25],instruction[24:21],1'b0}; //J-type
        7'b1100011: imm = {{20{instruction[31]}},instruction[7],instruction[30:25],instruction[11:8],1'b0}; //B-type
        7'b0100011: imm = {{21{instruction[31]}},instruction[30:25],instruction[11:7]}; //S-type
        7'b0000011: imm = {{21{instruction[31]}},instruction[30:20]};
        7'b1100111: imm = {{21{instruction[31]}},instruction[30:20]};
        7'b0010011: begin
            if(instruction[14:12] == 3'b000 |
               instruction[14:12] == 3'b010 | 
               instruction[14:12] == 3'b011 | 
               instruction[14:12] == 3'b100 | 
               instruction[14:12] == 3'b110 | 
               instruction[14:12] == 3'b111)
                imm = {{21{instruction[31]}},instruction[30:20]};
            else
                imm = 32'b0;
        end //I-type(partly)
        default: imm = 32'b0;
        endcase
    end

endmodule
