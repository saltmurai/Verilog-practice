module Lab2(HEX0, HEX1, SW, LEDR);
	output [0:6] HEX0, HEX1;
	input [9:0] SW;
	output [9:0] LEDR;
	
	BCD_7seg Segment1(SW[3:0], HEX0);
	BCD_7seg Segment2(SW[7:4], HEX1);
	
	assign LEDR [9:0] = 1'b0;
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


module Lab2(HEX0, HEX1, SW, LEDR);
	output [0:6] HEX0, HEX1;
	input [9:0] SW;
	output [9:0] LEDR;
	wire C;
	wire [3:0] Val;
	
	Comparator Com(SW[3:0], C);
	HexDisp Display1(SW[3:0], C, Val);
	
	BCD_7seg Segment1(Val, HEX0);
	BCD_7seg Segment2(C, HEX1);
	
	assign LEDR [9:0] = 1'b0;
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
	
	input [3:0] Value;
	output Correction;
	
	assign Correction = (Value[3] & (Value[2] | Value[1]));
	
endmodule
module HexDisp(Value, C, Out);
	
	input [3:0] Value;
	input C;
	output [3:0] Out;
	
	assign Out = Value - (4'b1010 & {4{C}});
	
endmodule
*/

module Lab2(LEDR, SW);
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





/* Step 5
module Lab2(LEDR, SW, HEX0, HEX1, HEX3, HEX5);
	input [9:0] SW;
	output [9:0] LEDR;
	output [0:6] HEX0, HEX1, HEX3, HEX5;
	wire [3:0] A, B;
	reg  [1:0] C;
	reg [4:0] Z0, T0, Sum;
	
	assign A[3:0] = SW[7:4];
	assign B[3:0] = SW[3:0];
	
	always
	begin
		C[0] = SW[8];
		Z0[4:0] = A + B + C[0];
		
		if(Z0 > 4'b1001)
		begin
			T0[4:0] = 5'b01010;
			C[1] = 1'b1;
		end
		
		else
		begin
			T0[4:0] = 5'b00000;
			C[1] = 1'b0;
		end
		
		Sum[4:0] = Z0[4:0] - T0[4:0];
	end 
	
	BCD_7seg Segment1(Sum[3:0], HEX0);
	BCD_7seg Segment2(C[1], HEX1);
	BCD_7seg Segment3(B[3:0], HEX3);
	BCD_7seg Segment4(A[3:0], HEX5);
	
	assign LEDR [3:0] = Sum[3:0];
	assign LEDR [4] = C[1];
	assign LEDR [8:5] = 4'h0;
	assign LEDR [9] = (A[3:0] > 4'b1001) | (B[3:0] > 4'b1001) ? 1 : 0;
	
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
*/

/* Step 6
module Lab2(LEDR, HEX0, HEX1, SW);
	
	input [9:0] SW;
	output [9:0] LEDR;
	output [0:6] HEX0, HEX1;
	wire [13:0] Value0, Value1, Value2, Value3;
	wire [13:0] t0, t1, t2;
	
	assign Value0[5:0] = SW[5:0];
  assign Value0[13:6] = 1'b0;
	
	BCD_Converter B0(Value0[13:0], t0[13:0]);
	BCD_Converter B1(t0[13:0], Value1[13:0]);
	BCD_Converter B2(Value1[13:0], t1[13:0]);
	BCD_Converter B3(t1[13:0], Value2[13:0]);
	BCD_Converter B4(Value2[13:0], t2[13:0]);
	BCD_Converter B5(t2[13:0], Value3[13:0]);
		
	BCD_7seg Segment0(Value3[9:6], HEX0);
	BCD_7seg Segment1(Value3[13:10], HEX1);
	
	assign LEDR[9:0] = SW[9:0];
	
endmodule
module BCD_Converter(Value, temp);
	
	input [13:0] Value;
	output [13:0] temp;
	wire [13:0] temp2;
	wire C0, C1;
	
	Greater_Than G0(Value[13:10], C0);
	Greater_Than G1(Value[9:6], C1);
	
	assign temp2[13:10] = Value[13:10] + (4'b0011 & {4{C0}});
	assign temp2[9:6] = Value[9:6] + (4'b0011 & {4{C1}});
  assign temp2[5:0] = Value[5:0];
	
	assign temp = {temp2[12:0], 1'b0};
	
endmodule
module Greater_Than(Value, C);
	
	input [3:0] Value;
	output C;
	
	assign C = Value[3] | (Value[2] & (Value[1] | Value[0]));
	
endmodule
module Left_Shift(Value, temp);
	
	input [13:0] Value;
	output [13:0] temp;
	
	assign temp = Value << 1'b1;
	
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
