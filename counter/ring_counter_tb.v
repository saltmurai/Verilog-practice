module ring_counter_tb ();
reg clk, rst_n, en;
wire [7:0] cnt;

ring_counter dut (clk, rst_n, en, cnt);
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    en = 1;
    rst_n = 0;
    #20;
    rst_n = 1; 
    #100;
    rst_n = 0;
    #20;
    rst_n = 1;
end

endmodule //ring_counter_tb