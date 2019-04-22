`timescale 1ns / 1ps

module InstructionMemory(instruction, pc, clk);

input  clk;
input  [31:0] pc;
output [31:0] instruction;
reg    [31:0] instruction;

// initialize instruction memory
reg [31:0] imemory [127:0];

// instructions here
// http://www.kurtm.net/mipsasm/
initial begin

    imemory[0] = 32'b00000000000000010001000000100010;
    imemory[1] = 32'b00000000001000100001100000100100;
    imemory[2] = 32'b00000000010000010011000000100101;
    imemory[3] = 32'b00000001100010010101000000100000;
    imemory[4] = 32'b10001100000000010001000000100000;
    imemory[5] = 32'b10101100000000010001000000100000;
    imemory[6] = 32'b00001000000000010001000000100000;

end

// set the next instruction
always @(posedge clk) begin
    instruction = imemory[pc];
end

endmodule