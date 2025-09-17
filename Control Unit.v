`timescale 1ns / 1ps

module ctrl_unit(
    input i_clk,
    input i_reset,
    
    output o_enfetch,
    output o_endec,
    output o_enrgrd,
    output o_enalu,
    output o_enrgwr,
    output o_enmem
    );
    
    reg [5:0] state;
    
    initial begin
        state <= 6'b000001;
    end
    
    always @(posedge i_clk)
    begin
        if(i_reset)
        begin
            state <= 6'b000001;
        end
        
        else
        begin
            case(state)
                6'b000001 : state <= 6'b000010;
                6'b000010 : state <= 6'b000100;
                6'b000100 : state <= 6'b001000;
                6'b001000 : state <= 6'b010000;
                6'b010000 : state <= 6'b100000;
                6'b100000 : state <= 6'b000001;
                default   : state <= 6'b000001;
            endcase
        end
    end
    
    assign o_enfetch    = state[0];
    assign o_endec      = state[1];
    assign o_enrgrd     = state[2] | state [4];
    assign o_enalu      = state[3];
    assign o_enrgwr     = state[4];
    assign o_enmem      = state[5];        
endmodule
