`timescale 1ns / 1ps

// full adder for each bit
module FullAdder(a, b, cout, sum, cin);

input a, b, cin;
output sum, cout;

wire p, q, r;

xor xor0(p, a, b);
xor xor1(sum, p, cin);

and and1(q, p, cin);
and and2(r, a, b);
or  or1(cout, q, r);

endmodule


// 32 bit ripple carry adder for the whole register
module RippleCarryAdder(a, b, cout, s, cin);

input cin;
input [31:0] a;
input [31:0] b;

output cout;
output [31:0] s;

wire [31:1] c;

FullAdder adder0( a[0],  b[0],  s[0],  c[1],  cin);
FullAdder adder1( a[1],  b[1],  s[1],  c[2],  c[1]);
FullAdder adder2( a[2],  b[2],  s[2],  c[3],  c[2]);
FullAdder adder3( a[3],  b[3],  s[3],  c[4],  c[3]);
FullAdder adder4( a[4],  b[4],  s[4],  c[5],  c[4]);
FullAdder adder5( a[5],  b[5],  s[5],  c[6],  c[5]);
FullAdder adder6( a[6],  b[6],  s[6],  c[7],  c[6]);
FullAdder adder7( a[7],  b[7],  s[7],  c[8],  c[7]);
FullAdder adder8( a[8],  b[8],  s[8],  c[9],  c[8]);
FullAdder adder9( a[9],  b[9],  s[9],  c[10], c[9]);
FullAdder adder10(a[10], b[10], s[10], c[11], c[10]);
FullAdder adder11(a[11], b[11], s[11], c[12], c[11]);
FullAdder adder12(a[12], b[12], s[12], c[13], c[12]);
FullAdder adder13(a[13], b[13], s[13], c[14], c[13]);
FullAdder adder14(a[14], b[14], s[14], c[15], c[14]);
FullAdder adder15(a[15], b[15], s[15], c[16], c[15]);
FullAdder adder16(a[16], b[16], s[16], c[17], c[16]);
FullAdder adder17(a[17], b[17], s[17], c[18], c[17]);
FullAdder adder18(a[18], b[18], s[18], c[19], c[18]);
FullAdder adder19(a[19], b[19], s[19], c[20], c[19]);
FullAdder adder20(a[20], b[20], s[20], c[21], c[20]);
FullAdder adder21(a[21], b[21], s[21], c[22], c[21]);
FullAdder adder22(a[22], b[22], s[22], c[23], c[22]);
FullAdder adder23(a[23], b[23], s[23], c[24], c[23]);
FullAdder adder24(a[24], b[24], s[24], c[25], c[24]);
FullAdder adder25(a[25], b[25], s[25], c[26], c[25]);
FullAdder adder26(a[26], b[26], s[26], c[27], c[26]);
FullAdder adder27(a[27], b[27], s[27], c[28], c[27]);
FullAdder adder28(a[28], b[28], s[28], c[29], c[28]);
FullAdder adder29(a[29], b[29], s[29], c[30], c[29]);
FullAdder adder30(a[30], b[30], s[30], c[31], c[30]);
FullAdder adder31(a[31], b[31], s[31], cout,  c[31]);

endmodule


// 32 bit subtractor utilizing the rca
module RippleCarrySubtractor(a, b, cout, s, cin);

input cin;
input [31:0] a;
input [31:0] b;

output cout;
output [31:0] s;

wire [31:0] m;

xor xor0( m[0],  b[0],  1);
xor xor1( m[1],  b[1],  1);
xor xor2( m[2],  b[2],  1);
xor xor3( m[3],  b[3],  1);
xor xor4( m[4],  b[4],  1);
xor xor5( m[5],  b[5],  1);
xor xor6( m[6],  b[6],  1);
xor xor7( m[7],  b[7],  1);
xor xor8( m[8],  b[8],  1);
xor xor9( m[9],  b[9],  1);
xor xor10(m[10], b[10], 1);
xor xor11(m[11], b[11], 1);
xor xor12(m[12], b[12], 1);
xor xor13(m[13], b[13], 1);
xor xor14(m[14], b[14], 1);
xor xor15(m[15], b[15], 1);
xor xor16(m[16], b[16], 1);
xor xor17(m[17], b[17], 1);
xor xor18(m[18], b[18], 1);
xor xor19(m[19], b[19], 1);
xor xor20(m[20], b[20], 1);
xor xor21(m[21], b[21], 1);
xor xor22(m[22], b[22], 1);
xor xor23(m[23], b[23], 1);
xor xor24(m[24], b[24], 1);
xor xor25(m[25], b[25], 1);
xor xor26(m[26], b[26], 1);
xor xor27(m[27], b[27], 1);
xor xor28(m[28], b[28], 1);
xor xor29(m[29], b[29], 1);
xor xor30(m[30], b[30], 1);
xor xor31(m[31], b[31], 1);

RippleCarryAdder sub(a, m, cout, s, 1);

endmodule