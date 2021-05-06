module Lab2(LEDR, SW, HEX0, HEX1, HEX3, HEX5);
	input [9:0] SW;
	output [9:0] LEDR;
	output [0:6] HEX0, HEX1, HEX3, HEX5;
	wire [3:0] X, Y, s;
	wire [4:0] c;
	wire Correct;
	wire [4:0] Sum;
	wire Err0, Err1;
	
	assign X = SW[7:4];
	assign Y = SW[3:0];
	assign c[0] = SW[8];
	
    //Check input phai nho hon 9 
	Error_Check E0(X, Err0);
	Error_Check E1(Y, Err1);
	
	Full_Adder F0(X[0], Y[0], c[0], c[1], s[0]);
	Full_Adder F1(X[1], Y[1], c[1], c[2], s[1]);
	Full_Adder F2(X[2], Y[2], c[2], c[3], s[2]);
	Full_Adder F3(X[3], Y[3], c[3], c[4], s[3]);
	
    //correct = 1 khi sum > 9
	Comparator C1({c[4], s[3:0]}, Correct);
	Mux5_1 H1({c[4], s[3:0]}, Correct, Sum[4:0]);
	
    //Hien thi tong
	BCD_7seg Disp1(Sum[3:0], HEX0);
	BCD_7seg1 Disp2(Sum[4], HEX1);
	
    //Hien thi gia tri X & Y
    BCD_7seg Disp3(Y, HEX3);
	BCD_7seg Disp4(X, HEX5);
	
	assign LEDR [3:0] = s[3:0];
	assign LEDR [4] = c[4];
	assign LEDR [8:5] = 1'b0;
	assign LEDR [9] = Err0 | Err1;
	
endmodule
module Full_Adder(a, b, cin, cout, s);
	
	input a, b, cin;
	output cout, s;
	
	assign {cout, s} = a + b + cin;
	
endmodule

module BCD_7seg1( DisplValue,ay);
    input Value;
    output [0:6] Display;

    assign Display[0:6] = (~Value) ? 7'b0000001 : 7'b1001111;
endmodule

module BCD_7seg(Value, Display);
	input [3:0] Value;
	output [0:6] Display;
	
	assign Display[0] = (Value[3] & Value[0] & (Value[2] ^ Value[1])) | (~Value[3] & ~Value[1] & (Value[2] ^ Value[0]));
	assign Display[1] = (Value[3] & Value[2] & (Value[1] | ~Value[0])) | (Value[3] & Value[1] & Value[0]) | (~Value[3] & Value[2] & (Value[1] ^ Value[0]));
	assign Display[2] = (Value[3] & Value[2] & (Value[1] | ~Value[0])) | (~Value[3] & ~Value[2] & Value[1] & ~Value[0]);
	assign Display[3] = (Value[2] & Value[1] & Value[0]) | (~Value[2] & ~Value[1] & Value[0]) | (~Value[3] & Value[2] & ~Value[1] & ~Value[0]) | (Value[3] & ~Value[2] & Value[1] & ~Value[0]);
	assign Display[4] = (~Value[3] & Value[2] & (~Value[1] | Value[0])) | (~Value[2] & Value[0] & (~Value[3] | ~Value[1]));
	assign Display[5] = (~Value[3] & ~Value[2] & (Value[1] | Value[0])) | (~Value[3] & Value[0] & (~Value[2] | Value[1])) | (Value[3] & Value[2] & ~Value[1] & Value[0]);
	assign Display[6] = (~Value[3] & ~Value[2] & ~Value[1]) | (~Value[3] & Value[2] & Value[1] & Value[0]) | (Value[3] & Value[2] & ~Value[1] & ~Value[0]);
	
endmodule

module Comparator(Value, Correction);
	
	input [4:0] Value;
	output Correction;
	
	assign Correction = Value[4] | (Value[3] & (Value[2] | Value[1]));
	
endmodule

module Mux5_1(Value, C, Out);
	
	input [4:0] Value;
	input C;
	output [4:0] Out;
	
	assign Out = Value + (5'b00110 & {5{C}});
	//11111
	
endmodule
module Error_Check(Value, Error);
	
	input [3:0] Value;
	output Error;
	
	assign Error = Value[3] & (Value[2] | Value[1]);
	
endmodule