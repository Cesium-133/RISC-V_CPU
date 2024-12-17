`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/14 11:03:09
// Design Name: 
// Module Name: seven_segment_display
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


module seven_segment_display(
    input clk_1000HZ,
    input rst_n,
    input en,
    input [13:0] score, // 要显示的数据，四位十进制数
    output reg [6:0] seg, // 七段数码管的输出
    output reg [3:0] AN
    );

    wire [3:0] unit;
    wire [3:0] ten;
    wire [3:0] hund;
    wire [3:0] thsd;
    reg [3:0] disp_seg;
    reg [1:0] cnt;
    
    // 把 score 拆成两位
    assign unit = score % 14'd10;
    assign ten = (score / 14'd10) % 14'd10;
    assign hund = (score / 14'd100) % 14'd10;
    assign thsd = score / 14'd1000;
    // 写一个两位计数器，0显示个位，1显示十位

    parameter sm_0 = 7'b1000000;
    parameter sm_1 = 7'b1111001;
    parameter sm_2 = 7'b0100100;
    parameter sm_3 = 7'b0110000;
    parameter sm_4 = 7'b0011001;
    parameter sm_5 = 7'b0010010;
    parameter sm_6 = 7'b0000010;
    parameter sm_7 = 7'b1111000;
    parameter sm_8 = 7'b0000000;
    parameter sm_9 = 7'b0010000;

    always @(posedge clk_1000HZ) begin
        if (!rst_n) 
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end

    always @(*) begin
        if (!en) begin
            seg = sm_0;
            case (cnt)
                20'd0: AN = 4'b1110;
                20'd1: AN = 4'b1101;
                20'd2: AN = 4'b1011;
                20'd3: AN = 4'b0111;
                default: AN = 4'b1110;
            endcase
        end else begin
            case (cnt)
                0: begin
                    AN = 4'b1110;
                    disp_seg = unit;
                end 
                1: begin
                    AN = 4'b1101;
                    disp_seg = ten;
                end
                2: begin
                    AN = 4'b1011;
                    disp_seg = hund;
                end
                3: begin
                    AN = 4'b0111;
                    disp_seg = thsd;
                end
                default: begin
                    AN = 4'b1110;
                    disp_seg = 3'b0;
                end
            endcase
            case(disp_seg)
                        4'd0: seg = sm_0;
                        4'd1: seg = sm_1;
                        4'd2: seg = sm_2;
                        4'd3: seg = sm_3;
                        4'd4: seg = sm_4;
                        4'd5: seg = sm_5;
                        4'd6: seg = sm_6;
                        4'd7: seg = sm_7;
                        4'd8: seg = sm_8;
                        4'd9: seg = sm_9;
                        default: seg = sm_0;
            endcase
        end
    end
endmodule
