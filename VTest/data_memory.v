`timescale 1ns / 1ps

module DataMemory(opcode, address, value, clk, result);

input [5:0]  opcode;    // 6 bit op code
input [31:0] address;   // data memory address
input [31:0] value;     // the value from the register
input clk;
output [31:0] result;   // the result of load/store the register

// initialize the data memory
reg [31:0] dmemory [255:0];

// load word
assign result = dmemory[address];

// store word
always @(negedge clk) begin
    if(opcode == 6'b101011) begin
        dmemory[address] = value
    end
end

endmodule