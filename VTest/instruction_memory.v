`timescale 1ns / 1ps

module InstructionMemory(intruction, pc, clk);

input  clk;
input  [31:0] pc;
output [31:0] instruction;
reg    [31:0] instruction;

// initialize instruction memory
reg [31:0] imemory [127:0];

// instructions go here
initial begin

    //memory[0] = 32'b00000000000000000000000000000000;

end

// set the next instruction
always @(posedge clk) begin
    instruction = imemory[pc];
end

endmodule