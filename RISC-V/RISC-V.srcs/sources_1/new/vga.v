`define H_SYNC_END 128  // 行同步脉冲结束时间
`define V_SYNC_END 4  // 列同步脉冲结束时间
`define H_SYNC_TOTAL 1056  // 行扫描总像素数
`define V_SYNC_TOTAL 628  // 列扫描总像素数
`define H_SHOW_START 216  // 显示区行开始像素点
`define V_SHOW_START 27  // 显示区列开始像素点

module vga (
    input RST,
    input clk,
    input [209:0] display_num,
    output reg [11:0] vga,
    output reg H_SYNC,
    output reg V_SYNC
);
    wire [3:0] block;
    reg [10:0] x_nct;
    reg [9:0] y_nct;
    reg display_area;
    reg [7:0] block_hcounter;
    reg [6:0] block_vcounter;
    reg [1:0] block_H;
    reg [2:0] block_V;
    reg [2:0] digit;
    reg [11:0] addr_num;
    reg [11:0] num0;
    reg [11:0] num1;
    reg [11:0] num2;
    reg [11:0] num3;
    reg [11:0] num4;
    reg [11:0] num5;
    reg [11:0] num6;
    reg [11:0] num7;
    reg [11:0] num8;
    reg [11:0] num9;

    blk_mem_gen_0 blk0 (
        .clka (clk),   // input wire clka
        .addra(addr_num),     // input wire [16 : 0] addra
        .douta(num0)  // output wire [11 : 0] dout_noflag
    );
    blk_mem_gen_1 blk1 (
        .clka (clk),   // input wire clka
        .addra(addr_num),     // input wire [16 : 0] addra
        .douta(num1)  // output wire [11 : 0] dout_noflag
    );
    blk_mem_gen_2 blk2 (
        .clka (clk),   // input wire clka
        .addra(addr_num),     // input wire [16 : 0] addra
        .douta(num2)  // output wire [11 : 0] dout_noflag
    );
    blk_mem_gen_3 blk3 (
        .clka (clk),   // input wire clka
        .addra(addr_num),     // input wire [16 : 0] addra
        .douta(num3)  // output wire [11 : 0] dout_noflag
    );
    blk_mem_gen_4 blk4 (
        .clka (clk),   // input wire clka
        .addra(addr_num),     // input wire [16 : 0] addra
        .douta(num4)  // output wire [11 : 0] dout_noflag
    );
    blk_mem_gen_5 blk5 (
        .clka (clk),   // input wire clka
        .addra(addr_num),     // input wire [16 : 0] addra
        .douta(num5)  // output wire [11 : 0] dout_noflag
    );
    blk_mem_gen_6 blk6 (
        .clka (clk),   // input wire clka
        .addra(addr_num),     // input wire [16 : 0] addra
        .douta(num6)  // output wire [11 : 0] dout_noflag
    );
    blk_mem_gen_7 blk7 (
        .clka (clk),   // input wire clka
        .addra(addr_num),     // input wire [16 : 0] addra
        .douta(num7)  // output wire [11 : 0] dout_noflag
    );
    blk_mem_gen_8 blk8 (
        .clka (clk),   // input wire clka
        .addra(addr_num),     // input wire [16 : 0] addra
        .douta(num8)  // output wire [11 : 0] dout_noflag
    );
    blk_mem_gen_9 blk9 (
        .clka (clk),   // input wire clka
        .addra(addr_num),     // input wire [16 : 0] addra
        .douta(num9)  // output wire [11 : 0] dout_noflag
    );

    assign block = block_V + 5 * (block_H - 1);
    // 水平计数器
    always @(posedge clk or posedge RST) begin
        if (RST) x_nct <= 0;
        else if (x_nct == `H_SYNC_TOTAL - 1) x_nct <= 0;
        else x_nct <= x_nct + 1;
    end

    // 垂直计数器
    always @(posedge clk or posedge RST) begin
        if (RST) y_nct <= 0;
        else if (y_nct == `V_SYNC_TOTAL - 1 && x_nct == `H_SYNC_TOTAL - 1) y_nct <= 0;
        else if (x_nct == `H_SYNC_TOTAL - 1) y_nct <= y_nct + 1;
        else y_nct <= y_nct;
    end

    // 行同步信号生成
    always @(*) begin
        if (RST) H_SYNC = 0;
        else if (x_nct >= 0 && x_nct <= 127) H_SYNC = 1;
        else H_SYNC = 0;
    end

    // 列同步信号生成
    always @(*) begin
        if (RST) V_SYNC = 0;
        else if (y_nct >= 0 && y_nct <= 3) V_SYNC = 1;
        else V_SYNC = 0;
    end

    always @(*) begin  //划定显示区域 为中央600*400的区域
        if (RST) display_area = 0;
        else if (x_nct >= 316 && x_nct < 916 && y_nct >= 127 && y_nct <= 527) begin
            display_area = 1;
        end else display_area = 0;
    end

    always @(posedge clk) begin  //块内横坐标
        if (RST) block_hcounter <= 0;
        else if (block_hcounter == 199 && display_area) block_hcounter <= 0;
        else if (display_area) block_hcounter <= block_hcounter + 1;
        else block_hcounter <= 0;
    end

    always @(posedge clk or posedge RST) begin  //列数
        if (RST) block_H <= 1;
        else if (display_area && block_hcounter == 199 && block_H == 3) block_H <= 1;
        else if (display_area && block_hcounter == 199) block_H <= block_H + 1;
        else block_H <= block_H;
    end

    always @(posedge clk or posedge RST) begin  //块内纵坐标
        if (RST) block_vcounter <= 0;
        else if (display_area && block_hcounter == 199 && block_H == 3 && block_vcounter == 79)
            block_vcounter <= 0;
        else if (display_area && block_hcounter == 199 && block_H == 3)
            block_vcounter <= block_vcounter + 1;
        else block_vcounter <= block_vcounter;
    end

    always @(posedge clk or posedge RST) begin  //行数
        if (RST) block_V <= 1;
        else if(display_area && block_hcounter == 199 && block_H == 3 && block_vcounter == 79 && block_V == 5)
            block_V <= 1;
        else if (display_area && block_hcounter == 199 && block_H == 3 && block_vcounter == 79)
            block_V <= block_V + 1;
        else block_V <= block_V;
    end

    always @(*) begin  //显示数的位数
        if (RST) digit = 0;
        else if (display_area && block_vcounter >= 10 && block_vcounter < 70) begin
            if (block_hcounter >= 20 && block_hcounter < 60) digit = 4;
            else if (block_hcounter >= 60 && block_hcounter < 100) digit = 3;
            else if (block_hcounter >= 100 && block_hcounter < 140) digit = 2;
            else if (block_hcounter >= 140 && block_hcounter <= 180) digit = 1;
            else digit = 0;
        end else digit = 0;
    end

    always @(*) begin  //地址读取信号计算
        if(display_area&&block_vcounter>=10&&block_vcounter<70&&block_hcounter>=20&&block_hcounter<=180)
            addr_num = (block_hcounter - 20 - 40 * (4 - digit)) + 40 * (block_vcounter - 10);
        else addr_num = 0;
    end

    always @(*) begin  //确定显示数
        if(display_area&&block_vcounter>=10&&block_vcounter<70&&block_hcounter>=20&&block_hcounter<=180)begin
            if (digit == 4) begin
                case (display_num[14*(block-1)+:14] / 10 / 10 / 10)
                    0: vga = 12'hfff;
                    1: vga = num1;
                    2: vga = num2;
                    3: vga = num3;
                    4: vga = num4;
                    5: vga = num5;
                    6: vga = num6;
                    7: vga = num7;
                    8: vga = num8;
                    9: vga = num9;
                    default: vga = 12'h2e4;
                endcase
            end
            if (digit == 3) begin
                case (display_num[14*(block-1)+:14] / 10 / 10 % 10)
                    0: begin
                        if (display_num[14*(block-1)+:14] / 10 / 10 / 10 == 0) vga = 12'hfff;
                        else vga = num0;
                    end
                    1: vga = num1;
                    2: vga = num2;
                    3: vga = num3;
                    4: vga = num4;
                    5: vga = num5;
                    6: vga = num6;
                    7: vga = num7;
                    8: vga = num8;
                    9: vga = num9;
                    default: vga = 12'h2e4;
                endcase
            end
            if (digit == 2) begin
                case (display_num[14*(block-1)+:14] / 10 % 10)
                    0: begin
                        if(display_num[14*(block-1)+:14]/10/10/10==0&&display_num[15*(block-1)+:15]/10/10==0)
                            vga = 12'hfff;
                        else vga = num0;
                    end
                    1: vga = num1;
                    2: vga = num2;
                    3: vga = num3;
                    4: vga = num4;
                    5: vga = num5;
                    6: vga = num6;
                    7: vga = num7;
                    8: vga = num8;
                    9: vga = num9;
                    default: vga = 12'h2e4;
                endcase
            end
            if (digit == 1) begin
                case (display_num[14*(block-1)+:14] % 10)
                    0: vga = num0;
                    1: vga = num1;
                    2: vga = num2;
                    3: vga = num3;
                    4: vga = num4;
                    5: vga = num5;
                    6: vga = num6;
                    7: vga = num7;
                    8: vga = num8;
                    9: vga = num9;
                    default: vga = 12'h2e4;
                endcase
            end
        end else vga = 12'hfff;
    end
endmodule
