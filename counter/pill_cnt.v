module pill_cnt(clk,rst_n,en,cnt);

input clk,rst_n, en;
output reg [7:0] cnt;

wire [7:0] nxt_cnt;

always @(posedge clk, negedge rst_n)
   if (!rst_n)
      cnt <= 8'h00;
   else
      cnt <= nxt_cnt;

assign nxt_cnt = (en) ? cnt + 1:cnt;

endmodule
