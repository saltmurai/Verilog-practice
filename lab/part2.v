module compare( v, comp);
    input [3:0] v;
    output comp;

assign comp = v[3] & (v[2] & v[1]);
endmodule

module mux4bit(a, b, sel, out);
    input [3:0] a, b;
    input sel;
    output [3:0] out;

assign out = (sel) ? a : b;
endmodule



module circuit_A(data, out);
    input [2:0] data;
    output reg [2:0] out;

assign out[0] = data[0];
assign out[1] = ~data[1];
assign out[2] = data[2] & data[1];
endmodule

module seven_seg1(comp, segment);
  input comp;
  output [0:6] segment;

endmodule

module seven_seg0(data, segment);
  input [3:0] data;
  output [0:6] segment;

  assign segment[0] = ((~data[3] & ~data[2] & ~data[1] &  data[0]) | (~data[3] &  data[2] & ~data[1] & ~data[0]));
  assign segment[1] = ((~data[3] &  data[2] & ~data[1] &  data[0]) | (~data[3] &  data[2] &  data[1] & ~data[0]));
  assign segment[2] =  (~data[3] & ~data[2] &  data[1] & ~data[0]);
  assign segment[3] = ((~data[3] & ~data[2] & ~data[1] &  data[0]) | (~data[3] &  data[2] & ~data[1] & ~data[0]) | (~data[3] &  data[2] & data[1] & data[0]) | (data[3] & ~data[2] & ~data[1] & data[0]));
  assign segment[4] = ~((~data[2] & ~data[0]) | (data[1] & ~data[0]));
  assign segment[5] = ((~data[3] & ~data[2] & ~data[1] &  data[0]) | (~data[3] & ~data[2] &  data[1] & ~data[0]) | (~data[3] & ~data[2] & data[1] & data[0]) | (~data[3] & data[2] & data[1] & data[0]));
  assign segment[6] = ((~data[3] & ~data[2] & ~data[1] &  data[0]) | (~data[3] & ~data[2] & ~data[1] & ~data[0]) | (~data[3] &  data[2] & data[1] & data[0]));
endmodule

module part2 (SW, HEX0, HEX1, HEX2, HEX3);
  input [17:0] SW;
  output [0:6] HEX0, HEX1, HEX2, HEX3;

  wire comp;
  wire [3:0] M, A;
  assign A[3] = 0;

  comparator C0 (SW[3:0], comp);
  circuitA A0 (SW[3:0], A[2:0]);
  mux_4bit_2to1 M0 (comp, SW[3:0], A, M);
  circuitB B0 (comp, HEX1);
  b2d_7seg S0 (M, HEX0);

endmodule

// module seven_seg (data, segment);
//   input [3:0] data;
//   output [0:6] segment;

//   assign segment[0] = ((~data[3] & ~data[2] & ~data[1] &  data[0]) | (~data[3] &  data[2] & ~data[1] & ~data[0]));
//   assign segment[1] = ((~data[3] &  data[2] & ~data[1] &  data[0]) | (~data[3] &  data[2] &  data[1] & ~data[0]));
//   assign segment[2] =  (~data[3] & ~data[2] &  data[1] & ~data[0]);
//   assign segment[3] = ((~data[3] & ~data[2] & ~data[1] &  data[0]) | (~data[3] &  data[2] & ~data[1] & ~data[0]) | (~data[3] &  data[2] & data[1] & data[0]) | (data[3] & ~data[2] & ~data[1] & data[0]));
//   assign segment[4] = ~((~data[2] & ~data[0]) | (data[1] & ~data[0]));
//   assign segment[5] = ((~data[3] & ~data[2] & ~data[1] &  data[0]) | (~data[3] & ~data[2] &  data[1] & ~data[0]) | (~data[3] & ~data[2] & data[1] & data[0]) | (~data[3] & data[2] & data[1] & data[0]));
//   assign segment[6] = ((~data[3] & ~data[2] & ~data[1] &  data[0]) | (~data[3] & ~data[2] & ~data[1] & ~data[0]) | (~data[3] &  data[2] & data[1] & data[0]));
// endmodule

// module comparator (V, comp);
//   input [3:0] V;
//   output comp;

//   assign comp = (V[3] & (V[2] | V[1]));
// endmodule

// module circuitA (V, A);
//   input [2:0] V;
//   output [2:0] A;

//   assign A[0] = V[0];
//   assign A[1] = ~V[1];
//   assign A[2] = (V[2] & V[1]);
// endmodule

// module circuit_B(comp, segment);
//   input comp;
//   output [0:6] segment;

//   assign segment[0] = comp;
//   assign segment[1:2] = 2'b00;
//   assign segment[3:5] = {3{comp}};
//   assign segment[6] = 1;
// endmodule

// module mux_4bit_2to1 (s, U, V, M);
//   // if ~s, send U
//   input s;
//   input [3:0] U, V;
//   output [3:0] M;

//   assign M = ({4{~s}} & U) | ({4{s}} & V);
// endmodule