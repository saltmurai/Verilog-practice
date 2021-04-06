`timescale 1ns/1ns
module example_fsm(clk, reset, a, b, y0, y1);

input clk, reset;
input a,b;
output reg y0, y1;


parameter [1:0]    s0 = 2'b00,
                    s1 = 2'b01,
                    s2 = 2'b10;

reg [1:0] state_reg, state_next;

always @(posedge clk or posedge reset) begin
    if(reset)
        state_reg <= s0;
    else
        state_reg <= state_next;
end

always @* begin
    case(state_reg)
        s0: begin
                y1 = 1'b1;
                if (a)
                    if(b)
                        begin
                            state_next = s2;
                            y0 = 1'b1;
                        end
                    else
                        state_next = s1;
        end
        s1: begin
                y1 = 1'b1;
                if(a)
                    state_next = s0;
            end
        s2: state_next = s0;
        default: state_next = s0;
    endcase
end

assign y1 = (state_reg==s0) || (state_reg == s1);
assign y0 = (state_reg==s0) & a & b;
endmodule                     