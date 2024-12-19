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
            case (debounce) //状态机时序 将持续时间不小于一个时钟周期（须经过2个时钟上升沿）的高电平信号转换为一个时钟周期的高电平信号
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