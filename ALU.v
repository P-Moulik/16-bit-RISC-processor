`timescale 1ns / 1ps

module alu(
    input i_clk,
    input i_en,
    input [4:0] i_aluop,
    input [15:0]i_data_a,
    input [15:0]i_data_b,
    input [7:0] i_imm,
    
    output [15:0] o_data_result,
    output reg    o_shld_branch 
    );
    
    reg [17:0] int_result;
    wire op_lsb;
    wire [3:0] opcode;
    
    localparam Add = 0,
               Sub = 1,
               OR  = 2,
               AND = 3,
               XOR = 4,
               NOT = 5,
               Load= 8,
               Cmp = 9,
               SHL = 10,
               SHR = 11,
               JMPA= 12,
               JMPR= 13;
               
    initial begin
        int_result <= 0;
    end
    
    assign op_lsb       = i_aluop[0];
    assign opcode       = i_aluop[4:1];
    assign o_data_result= int_result[15:0];
    
    always @(negedge i_clk)
    begin
        if(i_en)
        begin
            case(opcode)
                
                Add : begin
                    int_result <= (op_lsb ? ($signed(i_data_a) + $signed(i_data_b)) : (i_data_a + i_data_b));
                    o_shld_branch <= 0;
                end
                
                Sub : begin
                    int_result <= (op_lsb ? ($signed(i_data_a) - $signed(i_data_b)) : (i_data_a - i_data_b));
                    o_shld_branch <= 0;
                end
                
                OR  : begin
                    int_result <= i_data_a | i_data_b;
                    o_shld_branch <= 0;
                end
                
                AND : begin
                    int_result <= i_data_a & i_data_b;
                    o_shld_branch <= 0;
                end
                
                XOR : begin
                    int_result <= i_data_a ^ i_data_b;
                    o_shld_branch <= 0;
                end
                
                NOT : begin
                    int_result <= ~i_data_a ;
                    o_shld_branch <= 0;
                end
                
                Load: begin
                    int_result <= (op_lsb ? ({i_imm,8'h00}) : ({8'h00, i_imm}));
                    o_shld_branch <= 0;
                end
                
                Cmp : begin
                    if (op_lsb)
                    begin
                        int_result[0] <= ($signed(i_data_a)  == $signed(i_data_b)) ? 1 : 0;
                        int_result[1] <= ($signed(i_data_a)  == 0) ? 1 : 0;
                        int_result[2] <= ($signed(i_data_b)  == 0) ? 1 : 0;
                        int_result[3] <= ($signed(i_data_a)  > $signed(i_data_b)) ? 1 : 0;
                        int_result[4] <= ($signed(i_data_a)  < $signed(i_data_b)) ? 1 : 0;
                    end
                    
                    else
                    begin
                        int_result[0] <= (i_data_a == i_data_b) ? 1 : 0;
                        int_result[1] <= (i_data_a == 0) ? 1 : 0;
                        int_result[2] <= (i_data_b == 0) ? 1 : 0;
                        int_result[3] <= (i_data_a > i_data_b) ? 1 : 0;
                        int_result[4] <= (i_data_a < i_data_b) ? 1 : 0;
                    end
                    
                    o_shld_branch <= 0;
                end
                
                SHL : begin
                    int_result <= i_data_a << (i_data_b[3:0]);
                    o_shld_branch <= 0;
                end
                
                SHR : begin
                    int_result <= i_data_a >> (i_data_b[3:0]);
                    o_shld_branch <= 0;
                end
                
                JMPA: begin
                    int_result <= (op_lsb ? i_data_a : i_imm);
                    o_shld_branch <= 1;
                end
                
                JMPR: begin
                    int_result <= i_data_a;
                    o_shld_branch <= i_data_b[{op_lsb , i_imm[1:0]}];
                end
            endcase
        end
    end
endmodule
