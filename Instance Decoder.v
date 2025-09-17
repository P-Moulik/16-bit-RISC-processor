`timescale 1ns / 1ps

module inst_dec(
    input        i_clk,
    input        i_en,
    input [15:0] i_inst,

    output reg [4:0] o_aluop,
    output reg [2:0] o_sel_a,
    output reg [2:0] o_sel_b,
    output reg [2:0] o_sel_d,
    output reg [15:0]o_imm,
    output reg       o_regwe
    );
    
    initial begin
        o_aluop <= 0;
        o_sel_a <= 0;
        o_sel_b <= 0;
        o_sel_d <= 0;
        o_imm   <= 0;
        o_regwe <= 0;
    end
    
    always @(negedge i_clk)
    begin
        if(i_en)
        begin
            o_aluop     <= i_inst[15:11];
            o_sel_a     <= i_inst[10:8];
            o_sel_b     <= i_inst[7:5];
            o_sel_d     <= i_inst[4:2];
            o_imm       <= i_inst[7:0];
            
            case(i_inst[15:12])
                4'b0111: o_regwe <= 0;
                4'b1100: o_regwe <= 0;
                4'b1101: o_regwe <= 0;
                default: o_regwe <= 1;
            endcase
        end
    end
endmodule
