`timescale 1ps/1ps
module example_fsm_tb ();

reg clk, reset, a, b;
wire y0, y1;

example_fsm dut(clk, reset, a, b, y0, y1);

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

initial begin
    reset = 1;
    #5;
    reset = 0; //state 0
    #5;
    a = 1'b1;
    b = 1'b1; //state 0 -> state 2 -> state 0
    #50
    a = 1'b0;
    b = 1'b0; //state 0 -> state 1
    #50
    a = 1'b1; //state 1 -> state 0
end


endmodule //example_fsm_tb