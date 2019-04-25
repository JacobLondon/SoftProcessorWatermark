`timescale 1ns / 1ps

// base program counter module
module PC(pc, in, clk);

input [31:0] in;
input clk;
output [31:0] pc;
reg    [31:0] pc;

initial begin
    pc = 32'b00000000000000000000000000000000;
end

always @(negedge clk) begin
    pc = in;
end

endmodule


// module for controlling jumping or going to the next instruction
module PC_ALU(newpc, pc, extendaddr, chksignal);

input [31:0] pc;
input [31:0] extendaddr;
input chksignal;

output [31:0] newpc;

// helper wires to determine jumping location
wire negative;
wire [31:0] ones;
assign negative = extendaddr[31];
assign ones = ~extendaddr[31:0];

// jump if chksignal (control for jumping forward or backward), else increment pc
assign newpc = (chksignal) ? ((negative) ? (pc - ones) : (pc + extendaddr)) : (pc + 1);

endmodule

