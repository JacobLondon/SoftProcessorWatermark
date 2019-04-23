`timescale 1ns / 1ps

// determine th einstruction type: R or I/J
module Splitter(inst, opcode, rs, rt, rd, shamt, funct, addr);

input  [31:0] inst;

// the areas of the instruction
output [5:0] opcode;
output [4:0] rs;
output [4:0] rt;
output [4:0] rd;
output [4:0] shamt;
output [5:0] funct;
output [15:0] addr;
reg    [4:0] rs;
reg    [4:0] rt;
reg    [4:0] rd;
reg    [4:0] shamt;
reg    [5:0] funct;
reg    [15:0] addr;

// opcode location is the same for all inst types
assign opcode = inst[31:26];

// when there is a new instruction
always @(inst) begin
    // R instruction (ALU)
    if(inst[31:26] == 6'b000000) begin
        rs = inst[25:21];
        rt = inst[20:16];
        rd = inst[15:11];
        shamt = inst[10:6];
        funct = inst[5:0];
    end
    // I or J instruction
    else begin
        rs = inst[25:21];
        rt = inst[20:16];
        addr = inst[15:0];
    end

end

endmodule


