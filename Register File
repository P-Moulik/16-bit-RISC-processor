`timescale 1ns / 1ps

module reg_file(
    input i_clk,
    input i_en,
    input i_we,
    input [2:0] i_sel_a,
    input [2:0] i_sel_b,
    input [2:0] i_sel_d,
    input [15:0]i_data_d,
    
    output reg [15:0] o_data_a,
    output reg [15:0] o_data_b
    );
    
    reg [15:0] regs [7:0];
    
    integer count;
    
    initial begin
        o_data_a = 0;
        o_data_b = 0;
        
        for (count = 0; count < 8; count = count + 1)
        begin
            regs[count] = 0;
        end
    end
    
    always@(negedge i_clk)
    begin
        if(i_en)
        begin
            if(i_we)
            begin
                regs[i_sel_d] <= i_data_d;
            end
        
        o_data_a <= regs[i_sel_a];
        o_data_b <= regs[i_sel_b];
        end
    end
endmodule
