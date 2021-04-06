module counter_tb();
reg clk, reset;
wire [8:0] q;

counter dut(clk, reset, q);
initial begin 
clk=0;
forever #5 clk=~clk;
end
initial begin
reset=1;
#20;
reset=0;
#20;
reset = 1;
end
endmodule 