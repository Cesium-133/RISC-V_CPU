`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/17 19:44:56
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb;

reg         clk;
reg         clk1;
reg         rst;
reg         rst1;
//inst ram bus
reg [31:0]  inst_ram_waddr;    //13b useful
reg         inst_ram_wen;
reg [31:0]  inst_ram_wdata;
//data ram bus
reg [31:0]  data_ram_waddr;     //13b useful
reg         data_ram_wen;
reg [31:0]  data_ram_wdata;

reg [7:0]   cnt;

initial begin
    clk     <= 0;
    rst     <= 1;
    rst1    <= 1;
    cnt     <= 0;
    inst_ram_waddr  <= 0;
    inst_ram_wen    <= 0;
    inst_ram_wdata  <= 0;
    data_ram_waddr  <= 0;
    data_ram_wen    <= 0;
    data_ram_wdata  <= 0;

    #98 rst1 <= 0;
end

always#10    clk     <= ~clk;
always#5   clk1    <= ~clk1;

//main counter
always@(posedge clk) begin
    if(rst) begin
        cnt         <= 0;
    end else begin
        if(cnt < 26)
            cnt     <= cnt + 1;
    end
end

//set intr and data address
always@(posedge clk) begin
    if(rst1) begin
        inst_ram_waddr  <= 0;
        data_ram_waddr  <= 0;
    end else begin
        //init data
        if(cnt==1)
            data_ram_waddr  <= 32'h809;
        else
            data_ram_waddr  <= 0;
        //init intr
        if(cnt>2 && cnt<=12)
            inst_ram_waddr  <= inst_ram_waddr + 1;
        else
            inst_ram_waddr  <= 0;
    end
end

//set intr and data content
always@(posedge clk) begin
    if(rst1) begin
        inst_ram_wen    <= 1;
        inst_ram_wdata  <= 0;
        data_ram_wen    <= 1;
        data_ram_wdata  <= 0;
    end else begin
        case(cnt)
            //init data
            0: begin
                inst_ram_wen    <= 1;
                inst_ram_wdata  <= 0;
                data_ram_wen    <= 1;
                data_ram_wdata  <= 0;
            end
            1: begin
                // Write data to memory to initialize registers
                data_ram_wen    <= 1;
                data_ram_wdata  <= 32'h1234;   // Load value 0x1234 into memory at address 2024h
            end
            2: begin
                data_ram_wen    <= 1;
                data_ram_wdata  <= 32'h5678;   // Write another value to memory
            end
            3: begin
                // Write instructions to memory
                inst_ram_wen    <= 1;
                inst_ram_wdata  <= 32'h00428283;    // lw x1, 0(rs1) (load 0x1234 into x1)
                data_ram_wen    <= 0;
                data_ram_wdata  <= 0;
            end
            4: inst_ram_wdata  <= 32'h00430283;     // lw x2, 4(rs1) (load 0x5678 into x2)
            5: inst_ram_wdata  <= 32'h00A38393;     // addi x3, x0, 10
            6: inst_ram_wdata  <= 32'h00735863;     // bge x1, x2, label(PC+16)
            7: inst_ram_wdata  <= 32'h00128293;     // checkpoint: addi
            8: inst_ram_wdata  <= 32'h00628333;     // add x3, x1, x2
            9: inst_ram_wdata  <= 32'hFE734CE3;     // blt x3, x2, label
            10: inst_ram_wdata  <= 32'h00001217;    // aupic
            11: inst_ram_wdata  <= 32'h00422F83;    // lw x4, 4(rs1)
            //12: inst_ram_wdata  <= 32'h00100076;    // ebreak
            12: begin
                inst_ram_wen    <= 0;
                inst_ram_wdata  <= 0;
            end
            13: rst             <= 0;
            default: begin
                inst_ram_wen    <= 0;
                inst_ram_wdata  <= 0;
                data_ram_wen    <= 0;
                data_ram_wdata  <= 0;
            end
        endcase
        #3000 $finish;
    end
end

CPU     CPU_dut(
    .clk            (clk),
    .rst            (rst),
    .clk1          (clk1),
    .inst_ram_waddr (inst_ram_waddr),
    .inst_ram_wen   (inst_ram_wen),
    .inst_ram_wdata (inst_ram_wdata),
    .io_addr_MEM (data_ram_waddr),
    .iowrite_MEM   (data_ram_wen),
    .io_data_in_MEM (data_ram_wdata)
);

endmodule
