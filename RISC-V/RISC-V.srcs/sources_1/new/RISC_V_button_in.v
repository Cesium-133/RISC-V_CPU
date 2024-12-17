module RISC_V_button_in (
    input wire [9:0] rawdata,
    input wire clk,
    input wire rst,
    output wire [9:0] data
);

    btn_dbc_for_riscv btn_dbc_inst_0 (
        .clk(clk),
        .rst(rst),
        .btn_in(rawdata[0]),
        .btn(data[0])
    );

    btn_dbc_for_riscv btn_dbc_inst_1 (
        .clk(clk),
        .rst(rst),
        .btn_in(rawdata[1]),
        .btn(data[1])
    );

    btn_dbc_for_riscv btn_dbc_inst_2 (
        .clk(clk),
        .rst(rst),
        .btn_in(rawdata[2]),
        .btn(data[2])
    );

    btn_dbc_for_riscv btn_dbc_inst_3 (
        .clk(clk),
        .rst(rst),
        .btn_in(rawdata[3]),
        .btn(data[3])
    );

    btn_dbc_for_riscv btn_dbc_inst_4 (
        .clk(clk),
        .rst(rst),
        .btn_in(rawdata[4]),
        .btn(data[4])
    );

    btn_dbc_for_riscv btn_dbc_inst_5 (
        .clk(clk),
        .rst(rst),
        .btn_in(rawdata[5]),
        .btn(data[5])
    );

    btn_dbc_for_riscv btn_dbc_inst_6 (
        .clk(clk),
        .rst(rst),
        .btn_in(rawdata[6]),
        .btn(data[6])
    );

    btn_dbc_for_riscv btn_dbc_inst_7 (
        .clk(clk),
        .rst(rst),
        .btn_in(rawdata[7]),
        .btn(data[7])
    );

    btn_dbc_for_riscv btn_dbc_inst_8 (
        .clk(clk),
        .rst(rst),
        .btn_in(rawdata[8]),
        .btn(data[8])
    );

    btn_dbc_for_riscv btn_dbc_inst_9 (
        .clk(clk),
        .rst(rst),
        .btn_in(rawdata[9]),
        .btn(data[9])
    );

endmodule