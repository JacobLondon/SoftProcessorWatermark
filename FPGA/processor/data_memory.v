`timescale 1ns / 1ps

module DataMemory(opcode, Rt, addr, clk, out);

input clk;
input [5:0] opcode; // 6 bit opcode
input [31:0] addr;  // data memory address
input [31:0] Rt;    // value of the register
output [31:0] out;  // result of load/store the register

// initialize data memory
//reg [31:0] memdata [255:0];
reg [31:0] memdata [32:0];

// clear some memory
initial begin

    memdata[0] = 32'b00000000000000000000000000000000;
    memdata[1] = 32'b00000000000000000000000000000000;
    memdata[2] = 32'b00000000000000000000000000000000;
    memdata[3] = 32'b00000000000000000000000000000000;
    memdata[4] = 32'b00000000000000000000000000000000;
    memdata[5] = 32'b00000000000000000000000000000000;
    memdata[6] = 32'b00000000000000000000000000000000;
    memdata[7] = 32'b00000000000000000000000000000000;
    memdata[8] = 32'b00000000000000000000000000000000;
    memdata[9] = 32'b00000000000000000000000000000000;
    memdata[10] = 32'b00000000000000000000000000000000;
    memdata[11] = 32'b00000000000000000000000000000000;
    memdata[12] = 32'b00000000000000000000000000000000;
    memdata[13] = 32'b00000000000000000000000000000000;
    memdata[14] = 32'b00000000000000000000000000000000;
    memdata[15] = 32'b00000000000000000000000000000000;
    memdata[16] = 32'b00000000000000000000000000000000;
    memdata[17] = 32'b00000000000000000000000000000000;
    memdata[18] = 32'b00000000000000000000000000000000;
    memdata[19] = 32'b00000000000000000000000000000000;

end

// load word
assign out = memdata[addr];

// store word
always @(negedge clk) begin
    // SW, store word
    if(opcode==6'b101011) begin
        memdata[addr] = Rt;
    end

end

endmodule
