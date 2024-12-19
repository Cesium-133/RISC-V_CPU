module data_prepare_for_vga(
    input clk, //100MHZ时钟
    input rst,
    input wire [13:0] io_data_read_MEM, //只接低14位有效
    input wire [31:0] io_addr_MEM,
    output wire [209:0] display_num
);

    reg [13:0] display_num_0;
    reg [13:0] display_num_1;
    reg [13:0] display_num_2;
    reg [13:0] display_num_3;
    reg [13:0] display_num_4;
    reg [13:0] display_num_5;
    reg [13:0] display_num_6;
    reg [13:0] display_num_7;
    reg [13:0] display_num_8;
    reg [13:0] display_num_9;
    reg [13:0] display_num_10;
    reg [13:0] display_num_11;
    reg [13:0] display_num_12;
    reg [13:0] display_num_13;
    reg [13:0] display_num_14;

    assign display_num = {display_num_14, display_num_13, display_num_12, display_num_11, display_num_10, display_num_9, display_num_8, display_num_7, display_num_6, display_num_5, display_num_4, display_num_3, display_num_2, display_num_1, display_num_0};

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            display_num_0 <= 0;
            display_num_1 <= 0;
            display_num_2 <= 0;
            display_num_3 <= 0;
            display_num_4 <= 0;
            display_num_5 <= 0;
            display_num_6 <= 0;
            display_num_7 <= 0;
            display_num_8 <= 0;
            display_num_9 <= 0;
            display_num_10 <= 0;
            display_num_11 <= 0;
            display_num_12 <= 0;
            display_num_13 <= 0;
            display_num_14 <= 0;
        end
        else if (io_addr_MEM == 32'd0) begin
            display_num_0 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd4) begin
            display_num_1 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd8) begin
            display_num_2 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd12) begin
            display_num_3 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd16) begin
            display_num_4 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd20) begin
            display_num_5 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd24) begin
            display_num_6 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd28) begin
            display_num_7 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd32) begin
            display_num_8 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd36) begin
            display_num_9 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd40) begin
            display_num_10 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd44) begin
            display_num_11 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd48) begin
            display_num_12 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd52) begin
            display_num_13 <= io_data_read_MEM;
        end
        else if (io_addr_MEM == 32'd56) begin
            display_num_14 <= io_data_read_MEM;
        end
        else begin
            display_num_0 <= display_num_0;
            display_num_1 <= display_num_1;
            display_num_2 <= display_num_2;
            display_num_3 <= display_num_3;
            display_num_4 <= display_num_4;
            display_num_5 <= display_num_5;
            display_num_6 <= display_num_6;
            display_num_7 <= display_num_7;
            display_num_8 <= display_num_8;
            display_num_9 <= display_num_9;
            display_num_10 <= display_num_10;
            display_num_11 <= display_num_11;
            display_num_12 <= display_num_12;
            display_num_13 <= display_num_13;
            display_num_14 <= display_num_14;
        end
    end

endmodule