module Lab2(HEX0, HEX1, SW);
	output [0:6] HEX0, HEX1;
	input [9:0] SW;
	wire C;
	wire [3:0] Val;
	
	Comparator Com(SW[3:0], C);
	Mux4_1 Display1(SW[3:0], C, Val);
	
	BCD_7seg Segment1(Val, HEX0);
	BCD_7seg1 Segment2(C, HEX1);
	
endmodule

//normal 7 seg decoder
module BCD_7seg1(Value, Display);
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

//compartator > 9

module Comparator(Value, Correction);
	
	input [3:0] Value;
	output Correction;
	
	assign Correction = (Value[3] & (Value[2] | Value[1]));
	
endmodule

//hex display
module Mux4_1(Value, C, Out);
	
	input [3:0] Value;
	input C;
	output [3:0] Out;
	
	assign Out = Value - (4'b1010 & {4{C}});
	
endmodule