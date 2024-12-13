`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/02 20:43:44
// Design Name: 
// Module Name: pc
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


module pc(
    input wire clk,
    input wire rst,
    input wire PC_sel,
    input wire PC_hold,
    input wire [31:0] Add_2_out,
    output reg [31:0] Read_address //pcµÄÊä³öÐÅºÅ
    );

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            Read_address <= 32'b0;
        end
        else if(PC_hold) begin
            Read_address <= Read_address;
        end
        else if(PC_sel) begin
            Read_address <= Add_2_out;
        end
        else begin
            Read_address <= Read_address + 4;
        end
    end
endmodule
