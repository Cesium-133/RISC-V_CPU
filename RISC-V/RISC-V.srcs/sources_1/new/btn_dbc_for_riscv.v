module btn_dbc_for_riscv(
    input clk,
    input btn_in,
    input rst,
    output btn
    );
    
    reg [1:0] debounce;
    always @ (posedge clk) begin
        if (rst) begin
            debounce <= 0;
        end
        begin
            case (debounce) //״̬��ʱ�� ������ʱ�䲻С��һ��ʱ�����ڣ��뾭��2��ʱ�������أ��ĸߵ�ƽ�ź�ת��Ϊһ��ʱ�����ڵĸߵ�ƽ�ź�
                0: debounce <= btn_in;
                1: debounce <= btn_in ? 2: 0;
                2: debounce <= 3;
                3: debounce <= btn_in ? 3: 0;
                default: debounce <= 0;
            endcase
        end
    end
    assign btn = debounce == 2;
    
endmodule