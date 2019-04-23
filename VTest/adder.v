`timescale 1ns / 1ps

// full adder for each bit
module FullAdder(x, y, sum, carryout, carryin);

input x, y, carryin;
output sum, carryout;

xor XOR1(p, x, y);
xor XOR2(sum, p, carryin);

and ANDp(q, p, carryin);
and ANDxy(r, x, y);
or ORing(carryout, q, r);

endmodule


// 32 bit ripple carry adder for the whole register
module RippleCarryAdder(a, b, carryout, s, carryin);

input carryin;
input [31:0] a;
input [31:0] b;
output carryout;
output [31:0] s;

FullAdder adder0(a[0],b[0],s[0],c1,carryin);
FullAdder adder1(a[1],b[1],s[1],c2,c1);
FullAdder adder2(a[2],b[2],s[2],c3,c2);
FullAdder adder3(a[3],b[3],s[3],c4,c3);
FullAdder adder4(a[4],b[4],s[4],c5,c4);
FullAdder adder5(a[5],b[5],s[5],c6,c5);
FullAdder adder6(a[6],b[6],s[6],c7,c6);
FullAdder adder7(a[7],b[7],s[7],c8,c7);
FullAdder adder8(a[8],b[8],s[8],c9,c8);
FullAdder adder9(a[9],b[9],s[9],c10,c9);
FullAdder adder10(a[10],b[10],s[10],c11,c10);
FullAdder adder11(a[11],b[11],s[11],c12,c11);
FullAdder adder12(a[12],b[12],s[12],c13,c12);
FullAdder adder13(a[13],b[13],s[13],c14,c13);
FullAdder adder14(a[14],b[14],s[14],c15,c14);
FullAdder adder15(a[15],b[15],s[15],c16,c15);
FullAdder adder16(a[16],b[16],s[16],c17,c16);
FullAdder adder17(a[17],b[17],s[17],c18,c17);
FullAdder adder18(a[18],b[18],s[18],c19,c18);
FullAdder adder19(a[19],b[19],s[19],c20,c19);
FullAdder adder20(a[20],b[20],s[20],c21,c20);
FullAdder adder21(a[21],b[21],s[21],c22,c21);
FullAdder adder22(a[22],b[22],s[22],c23,c22);
FullAdder adder23(a[23],b[23],s[23],c24,c23);
FullAdder adder24(a[24],b[24],s[24],c25,c24);
FullAdder adder25(a[25],b[25],s[25],c26,c25);
FullAdder adder26(a[26],b[26],s[26],c27,c26);
FullAdder adder27(a[27],b[27],s[27],c28,c27);
FullAdder adder28(a[28],b[28],s[28],c29,c28);
FullAdder adder29(a[29],b[29],s[29],c30,c29);
FullAdder adder30(a[30],b[30],s[30],c31,c30);
FullAdder adder31(a[31],b[31],s[31],carryout,c31);

endmodule


// 32 bit subtractor utilizing the rca
module RippleCarrySubtractor(a, b, carryout, s, carryin);

input [31:0] a;
input [31:0] b;
output [31:0] s;
input carryin;
output carryout;
wire [31:0] m;

xor X0(m[0],b[0],1);
xor X1(m[1],b[1],1);
xor X2(m[2],b[2],1);
xor X3(m[3],b[3],1);
xor X4(m[4],b[4],1);
xor X5(m[5],b[5],1);
xor X6(m[6],b[6],1);
xor X7(m[7],b[7],1);
xor X8(m[8],b[8],1);
xor X9(m[9],b[9],1);
xor X10(m[10],b[10],1);
xor X11(m[11],b[11],1);
xor X12(m[12],b[12],1);
xor X13(m[13],b[13],1);
xor X14(m[14],b[14],1);
xor X15(m[15],b[15],1);
xor X16(m[16],b[16],1);
xor X17(m[17],b[17],1);
xor X18(m[18],b[18],1);
xor X19(m[19],b[19],1);
xor X20(m[20],b[20],1);
xor X21(m[21],b[21],1);
xor X22(m[22],b[22],1);
xor X23(m[23],b[23],1);
xor X24(m[24],b[24],1);
xor X25(m[25],b[25],1);
xor X26(m[26],b[26],1);
xor X27(m[27],b[27],1);
xor X28(m[28],b[28],1);
xor X29(m[29],b[29],1);
xor X30(m[30],b[30],1);
xor X31(m[31],b[31],1);

RippleCarryAdder sub(a, m, carryout, s, 1);

endmodule


