`timescale 1ns / 1ps

module main_test();
    reg clk;
    reg rst;
    reg ram_we = 0;
    reg [15:0] data_i = 0;
    
    wire [2:0] sel_a;
    wire [2:0] sel_b;
    wire [2:0] sel_d;
    wire [15:0] data_a;
    wire [15:0] data_b;
    wire [15:0] data_d;
    wire [4:0] aluop;
    wire [7:0] imm;
    wire [15:0] data_o;
    wire [1:0] opcode;
    wire [15:0] pco;
    
    wire shld_branch;
    wire enfetch;
    wire enalu;
    wire endec;
    wire enmem;
    wire enrgrd;
    wire enrgwr;
    wire regwe;
    wire update;
    
    assign enrgwr = regwe & update;
    assign opcode = (rst) ? 2'b11 : ((shld_branch) ? 2'b10 : ((enalu) ? 2'b01 : 2'b00));
    
    reg_file UUT1(
        clk,
        enrgrd,
        enrgwr,
        sel_a,
        sel_b,
        sel_d,
        data_d,
        
        data_a,
        data_b
    );
    
    inst_dec UUT2(
        clk,
        endec,
        data_o,
        aluop,
        sel_a,
        sel_b,
        sel_d,
        imm,
        regwe
    );
    
    alu UUT3(
        clk,
        enalu,
        aluop,
        data_a,
        data_b,
        imm,
        data_d,
        shld_branch
    );
    
    ctrl_unit UUT4(
        clk,
        rst,
        enfetch,
        endec,
        enrgrd,
        enalu,
        update,
        enmem
    );
    
    pc_unit UUT5(
        clk,
        opcode,
        data_d,
        pco
    );
    
    fake_ram UUT6(
        clk,
        ram_we,
        pco,
        data_i,
        data_o
    );
    
    initial begin
        clk = 0;
        rst = 1;
        #20;
        rst = 0;
    end
    
    always begin
        #5;
        clk = ~clk;
    end
    
endmodule
