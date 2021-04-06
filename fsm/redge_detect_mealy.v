module red (clk, reset, level, tick); //mealy-based design
    input clk, reset, level
    output reg tick;

//define state 
localparam [1:0]
    zero = 2'b00,
    one = 2'b10;
reg [1:0] state_reg, state_next;

//state register
always @(posedge clk or posedge reset) begin
    if(reset)
        state_reg = zero;
    else
        state_reg <= state_next;
end

always @* begin
    state_next = state_reg;
    tick = 1'b0;
    case(state_reg)
        zero:
            if(level)
                begin
                tick = 1'b1;
                state_next = one;
                end            
        one: 
            if(~level)
                state_next = zero;
        default: state_next = zero;
    endcase
end
endmodule