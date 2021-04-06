module counter(clk, reset, q);

input clk, reset;
output reg [7:0] q;

always @ (posedge clk or posedge reset)
    if (reset) q <= 0;
    else q <= q + 1;

endmodule