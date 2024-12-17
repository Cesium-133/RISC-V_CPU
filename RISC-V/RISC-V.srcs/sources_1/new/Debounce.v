`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/15 08:16:06
// Design Name: 
// Module Name: Debounce
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

module Debounce(
    input clk,
    input clk_100HZ,
    input rst_n,
    input btn,
    output btn_stable
    );
    
    parameter DELAY = 2000000; // 20ms
    reg [20:0] count;
    reg new, clean;

    always @(posedge clk) begin
        if (!rst_n) begin
            count <= 0;
            new <= btn;
            clean <= 0;
        end else if (btn != new) begin
            new <= btn;
            count <= 0;
        end else if (count == DELAY) begin
            clean <= new;
        end else
            count <= count + 20'd1; 
    end

    reg [1:0] pulse_state;
    always @(posedge clk_100HZ) begin
        if (!rst_n)
            pulse_state <= 2'b00;
        else
            pulse_state <= {pulse_state[0], clean};
    end

    assign btn_stable = pulse_state[0] & !pulse_state[1];

endmodule