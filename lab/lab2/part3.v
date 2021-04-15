module part3(LEDR, SW);
	input [9:0] SW;
	output [9:0] LEDR;
	wire [3:0] a, b, s;
	wire [4:0] c;
	
	assign a = SW[7:4];
	assign b = SW[3:0];
	assign c[0] = SW[8];
	
	Full_Adder F0(a[0], b[0], c[0], c[1], s[0]);
	Full_Adder F1(a[1], b[1], c[1], c[2], s[1]);
	Full_Adder F2(a[2], b[2], c[2], c[3], s[2]);
	Full_Adder F3(a[3], b[3], c[3], c[4], s[3]);
	
	assign LEDR [3:0] = s[3:0];
	assign LEDR [4] = c[4];
	assign LEDR [9:5] = 1'b0;
	
endmodule

module Full_Adder(a, b, cin, cout, s);
	
	input a, b, cin;
	output cout, s;
	
	assign {cout, s} = a + b + cin;
	
endmodule