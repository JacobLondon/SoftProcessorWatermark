`timescale 1ns / 1ps

module InstructionMemory(inst, pc, clk);
input clk;
input  [31:0] pc;
output [31:0] inst;
reg    [31:0] inst;

// initialize inst memory
reg [31:0] memdata [127:0];


// generate insts here
// http://www.kurtm.net/mipsasm
initial begin

    memdata[0] = 32'b00000001100010110110000000100000;
    memdata[1] = 32'b00010001100010110000000000000000;
    memdata[2] = 32'b00000001100010110110000000100000;
    memdata[3] = 32'b00010001100010010000000000000000;
    memdata[4] = 32'b00000001100010110110000000100000;
    memdata[5] = 32'b00000000000000000000000000000000;

end

// set the next inst
always @(posedge clk) begin
    inst = memdata[pc];
end

endmodule
