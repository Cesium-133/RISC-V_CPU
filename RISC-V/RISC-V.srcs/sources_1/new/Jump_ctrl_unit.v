module Jump_ctrl_unit (
    input  jump,
    output pc_sel,
    output IFID_clear,
    output IDEX_clear
);
    assign pc_sel = jump;
    assign IFID_clear = jump;
    assign IDEX_clear = jump;
endmodule
