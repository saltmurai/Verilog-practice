module seven_segment(input [3:0] data, 
                     output [6:0] segment);

assign segment[6] = (~data[2] & ~data[0]) | data[1] | (data[2] & data[0] | data[3]);
assign segment[5] = ~data[2] | (~data[1] & data[0]) | (data[1] & data[0]);
assign segment[4] = (~data[1] | data[0] | data[2]);
assign segment[3] = (~data[2] & ~data[0]) | (~data[2] & data[1]) | (data[2] & ~data[1] & data[0]) | (data[1] & ~data[0]) | data[4];
assign segment[2] = (~data[2] & data[0]) | (data[1] & ~data[0]);
assign segment[1] = (~data[1] & ~data[0]) | (data[2] & ~data[1]) | (data[2] & ~data[0]) | data[3] ;
assign segment[0] = (~data[2] & data[1]) | (data[2] & ~data[1]) | data[3] | (data[2] & ~data[0]);

endmodule

module main(input [7:0]sw, 
            output [13:0] segments);

seven_segment hex1 (.data(sw[7:4]), .segment(segments[13:7]));
seven_segment hex2 (.data(sw[3:0]), .segment(segments[6:0]));

endmodule
