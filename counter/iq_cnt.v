module iq_cnt(clk,rst_n,en,cnt);

input clk, rst_n, en;
output reg [7:0] cnt;

always @(posedge clk, negedge rst_n) begin
   if(!rst_n)
        cnt <= 8'h00;
   else if(en)
        cnt = cnt + 1;
    else
        cnt = cnt;
end
endmodule