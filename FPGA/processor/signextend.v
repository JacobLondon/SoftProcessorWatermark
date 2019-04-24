`timescale 1ns / 1ps

// extend the sign of the input to 32 bits long
module SignExtend(in, out);

input  [15:0] in;
output [31:0] out;

assign out = {{16{in[15]}}, in[15:0]};

endmodule
