`timescale 1ns / 1ps

module Processor();

reg [31:0] in1;
reg [31:0] in2;
reg [4:0] addr3;
reg [31:0] data3;
reg chksignal;      // tell when to jump
reg [31:0] in;
reg [31:0] address;

wire [5:0] opcode;
wire [4:0] shamt;
wire [5:0] funct;
wire [31:0] pc;
wire [31:0] inst;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [15:0] addr;
wire [31:0] result;
wire [31:0] Rs;
wire [31:0] Rt;
wire [31:0] out;
wire [31:0] extendaddr;
wire [31:0] newpc;

wire [31:0] regout;

// generate a clock waveform
Clock CLK(clk);
// increment pc and control jumping
PC pc_(pc, in, clk);
PC_ALU pc_alu(newpc, pc, extendaddr, chksignal);
// memory for registers, instructions, and data
RegisterFile register_file(rw, rs, rt, Rs, Rt, addr3, data3, clk, regout);
InstructionMemory inst_mem(inst, pc, clk);
DataMemory data_mem(opcode, Rt, address, clk, out);
// split instructions based on R, I, J type
Splitter split(inst, opcode, rs, rt, rd, shamt, funct, addr);
// perform operations based on opcode
ALU alu_(opcode, shamt, funct, in1, in2, result, rw, clk);
// extend sign of the address
SignExtend sign_extend(addr, extendaddr);

// program loop
always @(*) begin

    // ALU operation
    if(opcode == 6'b000000) begin
        // functions' opcodes
        if(funct == 6'b100000       // ADD
            || funct == 6'b100010   // SUB
            || funct == 6'b100100   // AND
            || funct == 6'b100101   // OR
            || funct == 6'b000010   // LSR
            || funct == 6'b000000)  // LSL
        begin
            // perform the R operation
            in1 = Rs;
            in2 = Rt;
            addr3 = rd;         // write address from RegisterFile
            data3 = result;     // load
            chksignal = 1'b0;   // don't jump
            in = newpc;         // go to next instruction

        end
    end

    // LW, load word
    if(opcode == 6'b100011) begin
        in1 = Rs;
        in2 = extendaddr;
        address = result;
        addr3 = rt;
        data3 = out;
        chksignal = 1'b0;
        in = newpc;
    end

    // SW, store word
    if(opcode == 6'b101011) begin
        in1 = Rs;
        in2 = extendaddr;
        address = result;
        chksignal = 1'b0;
        in = newpc;
    end

    // BEQ, branch on equals
    if(opcode == 6'b000100) begin
        in1 = Rs;
        in2 = Rt;

        // if EQ, then jump
        if(result == 32'b00000000000000000000000000000000) begin
            chksignal = 1'b1;
            in = newpc;
        end
    end

end

/*
TEST VARS:
regout
*/
initial begin
    $monitor("pc = %5d | inst=%b | in1 = %5d | in2 = %5d | result = %5d | time=%5d | clk = %5d | regout = %12d", pc, inst, in1, in2, result, $time, clk, regout);
    #30
    $finish;
end

endmodule
