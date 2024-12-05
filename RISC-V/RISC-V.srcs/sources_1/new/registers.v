`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/02 20:37:57
// Design Name: 
// Module Name: registers
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


module registers(
    input wire clk,
    input wire [31:0] instruction,
    input wire [31:0] Write_data,
    input wire [4:0] Write_register,
    input wire RegWrite,
    output wire [31:0] Read_data_1,
    output wire [31:0] Read_data_2
    );

    wire [4:0] Read_register_1;
    wire [4:0] Read_register_2;
    reg [31:0] registers_pile [0:31];

    assign Read_register_1 = instruction[19:15];
    assign Read_register_2 = instruction[24:20];

    assign Read_data_1 = (Read_register_1 == 0) ? 32'b0 : registers_pile[Read_register_1];
    assign Read_data_2 = (Read_register_2 == 0) ? 32'b0 : registers_pile[Read_register_2];

    always @(posedge clk) begin
        if(RegWrite) begin
            if(Write_register == 0) begin
                registers_pile[Write_register] <= 32'b0;
            end
            else begin
                registers_pile[Write_register] <= Write_data;
            end
        end
    end

endmodule
