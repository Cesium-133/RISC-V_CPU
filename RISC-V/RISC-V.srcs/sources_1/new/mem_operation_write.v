`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/15 13:45:00
// Design Name: 
// Module Name: mem_operation_write
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


module mem_operation_write(
    input wire [2:0] memop_MEM,
    input wire [31:0] rs2_MEM,
    output reg [31:0] cpu_data_in_MEM
    );
    always @(*) begin
        case(memop_MEM)
            3'b101:cpu_data_in_MEM[7:0] = rs2_MEM[7:0];
            3'b110:cpu_data_in_MEM[15:0] = rs2_MEM[15:0];
            3'b111:cpu_data_in_MEM = rs2_MEM;
            default:cpu_data_in_MEM = 32'bx;
        endcase
    end
endmodule
