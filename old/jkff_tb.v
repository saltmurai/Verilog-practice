module jk_ff();  
   reg j;  
   reg k;  
   reg clk;  
  
   always #5 clk = ~clk;  
  
   jk_ff    jk0 ( j, k, clk, q);  
  
   initial begin  
      j <= 0;  
      k <= 0;  
  
      #5 j <= 0;  
         k <= 1;  
      #20 j <= 1;  
          k <= 0;  
      #20 j <= 1;  
          k <= 1;  
      #20 $finish;  
   end  
endmodule