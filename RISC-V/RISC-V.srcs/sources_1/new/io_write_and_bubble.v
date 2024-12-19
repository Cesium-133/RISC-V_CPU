module io_write_and_bubble(
    input wire clk, //应该使用100MHz时钟
    input wire rst,
    input wire [14:0] switch, //须注意bubble_sort的时候不要打开开关，否则io输入不会截断
    input wire [9:0] data,
    input wire bubble,
    output reg [31:0] io_addr_MEM,
    output wire [31:0] io_data_in_MEM,
    output wire iowrite_MEM,
    output wire ioread_MEM
);
    
    reg [1:0] cnt;
    reg flag;
    reg [3:0] count;
    reg [3:0] data_for_each_digit_3;
    reg [3:0] data_for_each_digit_2;
    reg [3:0] data_for_each_digit_1;
    reg [3:0] data_for_each_digit_0;

    //flag为0时，io写使能才为1，此时cpu数据流不会往内存中写数；flag为1时，io写使能为0，确保cpu进行冒泡排序的时候io不会写入数据
    assign ioread_MEM = 1; //io读使能一直为1，确保vga时刻都能读取并显示内存中的数据

    always @(posedge clk or posedge rst) begin //内存1~15行地址（32位）选择模块
        if (rst) begin
            io_addr_MEM <= 0;
            count <= 14;
        end
        else
        if (switch[0]) begin
            io_addr_MEM <= 32'd0;
        end
        else if (switch[1]) begin
            io_addr_MEM <= 32'd4;
        end
        else if (switch[2]) begin
            io_addr_MEM <= 32'd8;
        end
        else if (switch[3]) begin
            io_addr_MEM <= 32'd12;
        end
        else if (switch[4]) begin
            io_addr_MEM <= 32'd16;
        end
        else if (switch[5]) begin
            io_addr_MEM <= 32'd20;
        end
        else if (switch[6]) begin
            io_addr_MEM <= 32'd24;
        end
        else if (switch[7]) begin
            io_addr_MEM <= 32'd28;
        end
        else if (switch[8]) begin
            io_addr_MEM <= 32'd32;
        end
        else if (switch[9]) begin
            io_addr_MEM <= 32'd36;
        end
        else if (switch[10]) begin
            io_addr_MEM <= 32'd40;
        end
        else if (switch[11]) begin
            io_addr_MEM <= 32'd44;
        end
        else if (switch[12]) begin
            io_addr_MEM <= 32'd48;
        end
        else if (switch[13]) begin
            io_addr_MEM <= 32'd52;
        end
        else if (switch[14]) begin
            io_addr_MEM <= 32'd56;
        end
        else if (bubble) begin
            io_addr_MEM <= 32'd60; //没有数据写入时，允许接受冒泡排序的信号
        end
        else if (flag == 1) begin //冒泡排序阶段，地址循环遍历0~14行，写一个计数器，每一个时钟周期到来地址就改变一次，在0~32'd56循环
            if (count == 14) begin
                count <= 0;
                io_addr_MEM <= 32'd0;
            end
            else begin
                count <= count + 1;
                io_addr_MEM <= io_addr_MEM + 4;
            end
        end
        else begin
            io_addr_MEM <= io_addr_MEM;
        end
    end

    always @(posedge clk or posedge rst) begin //内存具体行32位数据（实际只用了14位，4位十进制数）写入模块[搭配后续assign]
        if (rst) begin
            flag <= 0; //排序之后要想再次进行排序，须全局复位
            data_for_each_digit_3 <= 0;
            data_for_each_digit_2 <= 0;
            data_for_each_digit_1 <= 0;
            data_for_each_digit_0 <= 0;
            cnt <= 0;
        end
        else
        if (io_addr_MEM <= 32'd56) begin
            case (cnt)
                2'b00: 
                    begin
                        if (data[9]) begin
                            data_for_each_digit_3 <= 9;
                            cnt <= 2'b01;
                        end
                        else if (data[8]) begin
                            data_for_each_digit_3 <= 8;
                            cnt <= 2'b01;
                        end
                        else if (data[7]) begin
                            data_for_each_digit_3 <= 7;
                            cnt <= 2'b01;
                        end
                        else if (data[6]) begin
                            data_for_each_digit_3 <= 6;
                            cnt <= 2'b01;
                        end
                        else if (data[5]) begin
                            data_for_each_digit_3 <= 5;
                            cnt <= 2'b01;
                        end
                        else if (data[4]) begin
                            data_for_each_digit_3 <= 4;
                            cnt <= 2'b01;
                        end
                        else if (data[3]) begin
                            data_for_each_digit_3 <= 3;
                            cnt <= 2'b01;
                        end
                        else if (data[2]) begin
                            data_for_each_digit_3 <= 2;
                            cnt <= 2'b01;
                        end
                        else if (data[1]) begin
                            data_for_each_digit_3 <= 1;
                            cnt <= 2'b01;
                        end
                        else if (data[0]) begin
                            data_for_each_digit_3 <= 0;
                            cnt <= 2'b01;
                        end
                        else begin
                            data_for_each_digit_3 <= data_for_each_digit_3;
                            cnt <= 2'b00;
                        end
                    end
                2'b01:
                    begin
                        if (data[9]) begin
                            data_for_each_digit_2 <= 9;
                            cnt <= 2'b10;
                        end
                        else if (data[8]) begin
                            data_for_each_digit_2 <= 8;
                            cnt <= 2'b10;
                        end
                        else if (data[7]) begin
                            data_for_each_digit_2 <= 7;
                            cnt <= 2'b10;
                        end
                        else if (data[6]) begin
                            data_for_each_digit_2 <= 6;
                            cnt <= 2'b10;
                        end
                        else if (data[5]) begin
                            data_for_each_digit_2 <= 5;
                            cnt <= 2'b10;
                        end
                        else if (data[4]) begin
                            data_for_each_digit_2 <= 4;
                            cnt <= 2'b10;
                        end
                        else if (data[3]) begin
                            data_for_each_digit_2 <= 3;
                            cnt <= 2'b10;
                        end
                        else if (data[2]) begin
                            data_for_each_digit_2 <= 2;
                            cnt <= 2'b10;
                        end
                        else if (data[1]) begin
                            data_for_each_digit_2 <= 1;
                            cnt <= 2'b10;
                        end
                        else if (data[0]) begin
                            data_for_each_digit_2 <= 0;
                            cnt <= 2'b10;
                        end
                        else begin
                            data_for_each_digit_2 <= data_for_each_digit_2;
                            cnt <= 2'b01;
                        end
                    end
                2'b10:
                    begin
                        if (data[9]) begin
                            data_for_each_digit_1 <= 9;
                            cnt <= 2'b11;
                        end
                        else if (data[8]) begin
                            data_for_each_digit_1 <= 8;
                            cnt <= 2'b11;
                        end
                        else if (data[7]) begin
                            data_for_each_digit_1 <= 7;
                            cnt <= 2'b11;
                        end
                        else if (data[6]) begin
                            data_for_each_digit_1 <= 6;
                            cnt <= 2'b11;
                        end
                        else if (data[5]) begin
                            data_for_each_digit_1 <= 5;
                            cnt <= 2'b11;
                        end
                        else if (data[4]) begin
                            data_for_each_digit_1 <= 4;
                            cnt <= 2'b11;
                        end
                        else if (data[3]) begin
                            data_for_each_digit_1 <= 3;
                            cnt <= 2'b11;
                        end
                        else if (data[2]) begin
                            data_for_each_digit_1 <= 2;
                            cnt <= 2'b11;
                        end
                        else if (data[1]) begin
                            data_for_each_digit_1 <= 1;
                            cnt <= 2'b11;
                        end
                        else if (data[0]) begin
                            data_for_each_digit_1 <= 0;
                            cnt <= 2'b11;
                        end
                        else begin
                            data_for_each_digit_1 <= data_for_each_digit_1;
                            cnt <= 2'b10;
                        end
                    end
                2'b11:
                    begin
                        if (data[9]) begin
                            data_for_each_digit_0 <= 9;
                            cnt <= 2'b00;
                        end
                        else if (data[8]) begin
                            data_for_each_digit_0 <= 8;
                            cnt <= 2'b00;
                        end
                        else if (data[7]) begin
                            data_for_each_digit_0 <= 7;
                            cnt <= 2'b00;
                        end
                        else if (data[6]) begin
                            data_for_each_digit_0 <= 6;
                            cnt <= 2'b00;
                        end
                        else if (data[5]) begin
                            data_for_each_digit_0 <= 5;
                            cnt <= 2'b00;
                        end
                        else if (data[4]) begin
                            data_for_each_digit_0 <= 4;
                            cnt <= 2'b00;
                        end
                        else if (data[3]) begin
                            data_for_each_digit_0 <= 3;
                            cnt <= 2'b00;
                        end
                        else if (data[2]) begin
                            data_for_each_digit_0 <= 2;
                            cnt <= 2'b00;
                        end
                        else if (data[1]) begin
                            data_for_each_digit_0 <= 1;
                            cnt <= 2'b00;
                        end
                        else if (data[0]) begin
                            data_for_each_digit_0 <= 0;
                            cnt <= 2'b00;
                        end
                        else begin
                            data_for_each_digit_0 <= data_for_each_digit_0;
                            cnt <= 2'b11;
                        end
                    end
                default: begin
                    data_for_each_digit_3 <= data_for_each_digit_3;
                    data_for_each_digit_2 <= data_for_each_digit_2;
                    data_for_each_digit_1 <= data_for_each_digit_1;
                    data_for_each_digit_0 <= data_for_each_digit_0;
                    cnt <= 2'b00;
                end
            endcase
        end
        else if (io_addr_MEM == 32'd60) begin
            flag <= 1;
        end
        else begin
            flag <= 0;
        end
    end

    assign io_data_in_MEM = (io_addr_MEM == 32'd60) ? 32'b1 : (1000*data_for_each_digit_3 + 100*data_for_each_digit_2 + 10*data_for_each_digit_1 + data_for_each_digit_0);
    assign iowrite_MEM = (io_addr_MEM == 32'd60) ? ((flag == 1) ? 0 : 1) : ((io_addr_MEM > 32'd60) | (switch[0]&switch[1]&switch[2]&switch[3]&switch[4]&switch[5]&switch[6]&switch[7]&switch[8]&switch[9]&switch[10]&switch[11]&switch[12]&switch[13]&switch[14] == 0) ? 0 : 1); //地址是0x3c时，根据flag判断是否写入数据；地址不是0x3c时，无switch打开时或者地址不在io内存区则不写入数据

endmodule