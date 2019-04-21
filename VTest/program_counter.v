`timescale 1ns / 1ps

// base program counter module
module ProgramCounter(pc, in, clk);

input [31:0] in;
input clk;
output [31:0] pc;
reg    [31:0] pc;

initial begin
    pc=32'b00000000000000000000000000000000;
end

always @(negedge clk) begin
    pc = in;
end

endmodule


// module for controlling jumping or going to the next instruction
module ProgramCounterHelper(nextPC, pc, jumpExtendAddress, branchSignal);

input [31:0] pc;
input [31:0] jumpExtendAddress;
input branchSignal;

output [31:0] nextPC

// go to jump location or continue to next instruction
assign nextPC = branchSignal ? (pc + jumpExtendAddress) : (pc + 1);

endmodule
