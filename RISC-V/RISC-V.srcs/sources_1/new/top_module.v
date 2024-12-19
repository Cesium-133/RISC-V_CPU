module top_module(
    input wire clk_100MHZ, //clock for BRAM, debounce, io_write_and_bubble, data_prepare_for_vga
    input wire clk_50MHZ, //main clock (cpu)
    input wire clk_40MHZ, //clock for vga
    input wire clk_1000HZ, //clock for segment display
    input wire rst,
    input wire [9:0] rawdata,
    input wire rawbubble, //冒泡排序开始信号
    input wire [14:0] switch, //有优先级的数据输入位选信号
    output wire [11:0] vga,
    output wire H_SYNC,
    output wire V_SYNC,
    output wire [6:0] seg,
    output wire [3:0] AN
);

    wire [9:0] data;
    wire [209:0] display_num; //从内存io部分读出的数据
    wire [31:0] io_addr_MEM;
    wire [31:0] io_data_in_MEM; //15个四位十进制数输入内存io部分。通过外部键盘输入合并
    wire [31:0] io_data_read_MEM;
    wire ioread_MEM; //内存io部分读使能，只需要读内存io部分的数据给vga
    wire iowrite_MEM; //内存io部分写使能，只在模式
    wire en;
    wire bubble;

    assign en = switch[14] | switch[13] | switch[12] | switch[11] | switch[10] | switch[9] | switch[8] | switch[7] | switch[6] | switch[5] | switch[4] | switch[3] | switch[2] | switch[1] | switch[0];

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
        .clk(clk_40MHZ),
        .RST(rst),
        .display_num(display_num),
        .H_SYNC(H_SYNC),
        .V_SYNC(V_SYNC),
        .vga(vga)
    );

    data_prepare_for_vga data_prepare_for_vga_inst (
        .clk(clk_100MHZ),
        .rst(rst),
        .io_data_read_MEM(io_data_read_MEM[13:0]),
        .io_addr_MEM(io_addr_MEM),
        .display_num(display_num)
    );

    io_write_and_bubble io_write_and_bubble_inst (
        .clk(clk_100MHZ),
        .rst(rst),
        .switch(switch),
        .data(data),
        .bubble(bubble),
        .io_addr_MEM(io_addr_MEM),
        .io_data_in_MEM(io_data_in_MEM),
        .ioread_MEM(ioread_MEM),
        .iowrite_MEM(iowrite_MEM)
    );

    seven_segment_display seven_segment_display_inst (
        .clk(clk_1000HZ),
        .rst_n(rst),
        .en(en), //全部开关都关闭时，不显示
        .score(io_data_in_MEM[13:0]),
        .seg(seg),
        .AN(AN)
    );

    RISC_V_button_in RISC_V_button_in_inst (
        .rawdata(rawdata),
        .clk(clk_100MHZ),
        .rst(rst),
        .data(data)
    );

    btn_dbc_for_riscv btn_dbc_for_bubble(
        .clk(clk_100MHZ),
        .rst(rst),
        .btn_in(rawbubble),
        .btn(bubble)
    );

endmodule