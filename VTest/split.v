`timescale 1ns / 1ps

// determine the instruction type R or I/J
module Split(instruction, opcode, rs, rt, rd, func, address);

input [31:0] instruction;

output [5:0] opcode;

// the areas of the instruction
output [4:0] rs;
output [4:0] rt;
output [4:0] rd;
output [5:0] func;
output [15:0] address;
reg [4:0] rs;
reg [4:0] rt;
reg [4:0] rd;
reg [5:0] func;
reg [15:0] address;

// opcode location is the same for all inst types
assign opcode = instruction[31:26];

// when there is a new instruction
always @(instruction) begin
    // R instruction (ALU)
    if(instruction[31:26] == 6'b000000) begin
        rs = instruction[25:21];
        rt = instruction[20:16];
        rd = instruction[15:11];
    end
    // I or J instruction
    else begin
        rs = instruction[25:21];
        rt = instruction[20:16];
        address = instruction[15:0];
    end
end

endmodule
