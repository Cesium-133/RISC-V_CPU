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
    input wire rst,
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
    assign Read_data_2 = (Read_register_2 == 0) ? 32'b0 : registers_pile[Read_register_2]; //×éºÏÂß¼­¶Á

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            registers_pile[0] <= 32'b0;
            registers_pile[1] <= 32'b0;
            registers_pile[2] <= 32'b0;
            registers_pile[3] <= 32'b0;
            registers_pile[4] <= 32'b0;
            registers_pile[5] <= 32'b0;
            registers_pile[6] <= 32'b0;
            registers_pile[7] <= 32'b0;
            registers_pile[8] <= 32'b0;
            registers_pile[9] <= 32'b0;
            registers_pile[10] <= 32'b0;
            registers_pile[11] <= 32'b0;
            registers_pile[12] <= 32'b0;
            registers_pile[13] <= 32'b0;
            registers_pile[14] <= 32'b0;
            registers_pile[15] <= 32'b0;
            registers_pile[16] <= 32'b0;
            registers_pile[17] <= 32'b0;
            registers_pile[18] <= 32'b0;
            registers_pile[19] <= 32'b0;
            registers_pile[20] <= 32'b0;
            registers_pile[21] <= 32'b0;
            registers_pile[22] <= 32'b0;
            registers_pile[23] <= 32'b0;
            registers_pile[24] <= 32'b0;
            registers_pile[25] <= 32'b0;
            registers_pile[26] <= 32'b0;
            registers_pile[27] <= 32'b0;
            registers_pile[28] <= 32'b0;
            registers_pile[29] <= 32'b0;
            registers_pile[30] <= 32'b0;
            registers_pile[31] <= 32'b0;
        end
        else if(RegWrite) begin
            if(Write_register == 0) begin
                registers_pile[Write_register] <= 32'b0;
            end
            else begin
                registers_pile[Write_register] <= Write_data;
            end
        end
    end

endmodule
