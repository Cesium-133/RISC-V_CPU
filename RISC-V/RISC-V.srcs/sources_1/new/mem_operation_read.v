`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/15 13:45:26
// Design Name: 
// Module Name: mem_operation_read
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


module mem_operation_read(
    input wire [2:0] memop_MEM,
    input wire [31:0] cpu_data_read_MEM,
    output reg [31:0] dataread_MEM
    );
    always @(*) begin
        case(memop_MEM)
            3'b000:dataread_MEM = {{25{cpu_data_read_MEM[7]}},cpu_data_read_MEM[6:0]};
            3'b001:dataread_MEM = {{17{cpu_data_read_MEM[15]}},cpu_data_read_MEM[14:0]};
            3'b010:dataread_MEM = cpu_data_read_MEM;
            3'b011:dataread_MEM = {24'b0,cpu_data_read_MEM[7:0]};
            3'b100:dataread_MEM = {16'b0,cpu_data_read_MEM[15:0]};
            default:dataread_MEM = 32'bx;
        endcase
    end
endmodule
