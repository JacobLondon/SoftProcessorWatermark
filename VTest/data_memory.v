`timescale 1ns / 1ps

module DataMemory(opcode, address, value, clk, result);

input [5:0]  opcode;    // 6 bit op code
input [31:0] address;   // data memory address
input [31:0] value;     // the value from the register
input clk;
output [31:0] result;   // the result of load/store the register

// initialize the data memory
reg [31:0] dmemory [255:0];

// clear some memory for testbench
initial begin

    dmemory[0] = 32'b00000000000000000000000000000000;
    dmemory[1] = 32'b00000000000000000000000000000000;
    dmemory[2] = 32'b00000000000000000000000000000000;
    dmemory[3] = 32'b00000000000000000000000000000000;
    dmemory[4] = 32'b00000000000000000000000000000000;
    dmemory[5] = 32'b00000000000000000000000000000000;
    dmemory[6] = 32'b00000000000000000000000000000000;
    dmemory[7] = 32'b00000000000000000000000000000000;
    dmemory[8] = 32'b00000000000000000000000000000000;
    dmemory[9] = 32'b00000000000000000000000000000000;
    dmemory[10] = 32'b00000000000000000000000000000000;
    dmemory[11] = 32'b00000000000000000000000000000000;
    dmemory[12] = 32'b00000000000000000000000000000000;
    dmemory[13] = 32'b00000000000000000000000000000000;
    dmemory[14] = 32'b00000000000000000000000000000000;
    dmemory[15] = 32'b00000000000000000000000000000000;
    dmemory[16] = 32'b00000000000000000000000000000000;
    dmemory[17] = 32'b00000000000000000000000000000000;
    dmemory[18] = 32'b00000000000000000000000000000000;
    dmemory[19] = 32'b00000000000000000000000000000000;

end

// load word
assign result = dmemory[address];

// store word
always @(negedge clk) begin
    // SW, store word
    if(opcode == 6'b101011) begin
        dmemory[address] = value;
    end
end

endmodule