module io_write_and_bubble(
    input wire clk, //Ӧ��ʹ��100MHzʱ��
    input wire rst,
    input wire [14:0] switch, //��ע��bubble_sort��ʱ��Ҫ�򿪿��أ�����io���벻��ض�
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

    //flagΪ0ʱ��ioдʹ�ܲ�Ϊ1����ʱcpu�������������ڴ���д����flagΪ1ʱ��ioдʹ��Ϊ0��ȷ��cpu����ð�������ʱ��io����д������
    assign ioread_MEM = 1; //io��ʹ��һֱΪ1��ȷ��vgaʱ�̶��ܶ�ȡ����ʾ�ڴ��е�����

    always @(posedge clk or posedge rst) begin //�ڴ�1~15�е�ַ��32λ��ѡ��ģ��
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
            io_addr_MEM <= 32'd60; //û������д��ʱ���������ð��������ź�
        end
        else if (flag == 1) begin //ð������׶Σ���ַѭ������0~14�У�дһ����������ÿһ��ʱ�����ڵ�����ַ�͸ı�һ�Σ���0~32'd56ѭ��
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

    always @(posedge clk or posedge rst) begin //�ڴ������32λ���ݣ�ʵ��ֻ����14λ��4λʮ��������д��ģ��[�������assign]
        if (rst) begin
            flag <= 0; //����֮��Ҫ���ٴν���������ȫ�ָ�λ
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
    assign iowrite_MEM = (io_addr_MEM == 32'd60) ? ((flag == 1) ? 0 : 1) : ((io_addr_MEM > 32'd60) | (switch[0]&switch[1]&switch[2]&switch[3]&switch[4]&switch[5]&switch[6]&switch[7]&switch[8]&switch[9]&switch[10]&switch[11]&switch[12]&switch[13]&switch[14] == 0) ? 0 : 1); //��ַ��0x3cʱ������flag�ж��Ƿ�д�����ݣ���ַ����0x3cʱ����switch��ʱ���ߵ�ַ����io�ڴ�����д������

endmodule