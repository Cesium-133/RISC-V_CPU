module top_module(
    input wire clk_100MHZ, //clock for BRAM
    input wire clk_50MHZ, //main clock(cpu,vga,debounce)
    input wire clk_1000HZ, //clock for segment display
    input wire rst,
    input wire [9:0] rawdata,
    input wire rawbubble, //冒泡排序开始信号
    input wire [14:0] num_choose, //有优先级的数据输入位选信号
    output wire [11:0] vga,
    output wire H_SYNC,
    output wire V_SYNC,
    output wire [6:0] seg,
    output wire [3:0] AN
);

    wire [9:0] data;
    wire [9:0] score;
    wire [194:0] display_num; //从内存io部分读出的数据
    wire [9:0] io_addr_MEM;
    wire [31:0] io_data_in_MEM; //15个四位十进制数输入内存io部分。通过外部键盘输入合并
    wire [31:0] io_data_read_MEM;
    wire ioread_MEM; //内存io部分读使能，只需要读内存io部分的数据给vga
    wire iowrite_MEM; //内存io部分写使能，只在模式
    wire en;
    wire bubble;
    wire [14:0] io_addr;
    wire [31:0] io_data_in;
    wire [31:0] io_data_read;

    CPU cpu_inst (
        .clk(clk_50MHZ),
        .clk1(clk_100MHZ),
        .rst(rst),
        .inst_ram_wen(),
        .inst_ram_waddr(),
        .inst_ram_wdata(),
        .ioread_MEM(ioread_MEM),
        .iowrite_MEM(iowrite_MEM),
        .io_addr_MEM(io_addr_MEM),
        .io_data_in_MEM(io_data_in_MEM),
        .io_data_read_MEM(io_data_read_MEM)
    );

    vga vga_inst (
        .clk(clk_50MHZ),
        .RST(rst),
        .display_num(display_num),
        .H_SYNC(H_SYNC),
        .V_SYNC(V_SYNC),
        .vga(vga)
    );

    seven_segment_display seven_segment_display_inst (
        .clk(clk_1000HZ),
        .rst_n(rst),
        .en(en),
        .score(score),
        .seg(seg),
        .AN(AN)
    );

    RISC_V_button_in RISC_V_button_in_inst (
        .rawdata(rawdata),
        .clk(clk_50MHZ),
        .rst(rst),
        .data(data)
    );

    btn_dbc_for_riscv btn_dbc_for_basys3_button(
        .clk(clk_50MHZ),
        .rst(rst),
        .btn_in(rawbubble),
        .btn(bubble)
    );

endmodule