`timescale 1ns / 1ps

// perform all operations given opcodes / functions
module ALU(opcode, shamt, funct, in1, in2, result, rw, clk);

input clk;
input [5:0] opcode;
input [4:0] shamt;
input [5:0] funct;
input [31:0] in1;
input [31:0] in2;

output [31:0] result;
reg    [31:0] result;

// same as register's rw, read == 0, write == 1
output rw;
reg    rw;

// wires to hold intermediate signals
wire [31:0] sum;
wire [31:0] diff;
wire [31:0] and_;
wire [31:0] or_;
wire [31:0] srl_;
wire [31:0] sll_;

// modules to perform the operations
RippleCarryAdder add_op(in1, in2, carryout, sum, 1'b0);
RippleCarrySubtractor sub_op(in1, in2, carry, diff, 1'b0);
AND and_op(in1, in2, and_);
OR or_op(in1, in2, or_);
// in2 is Rt
ShiftRight srl_op(in2, shamt, srl_);
ShiftLeft  sll_op(in2, shamt, sll_);

/*
perform given opcodes
opcodes here:
https://opencores.org/projects/plasma/opcodes
*/
always @(*) begin

    // if the opcode specifies the alu
    if(opcode == 6'b000000) begin

        /*
        For all operations:
            read from registers
            operate
            write to registers
        */

        // ADD
        if(funct == 6'b100000) begin
            rw = 1'b0;
            result = sum;
            rw = 1'b1;
        end
        // SUB
        if(funct == 6'b100010) begin
            rw = 1'b0;
            result = diff;
            rw = 1'b1;
        end
        // AND
        if(funct == 6'b100100) begin
            rw = 1'b0;
            result = and_;
            rw = 1'b1;
        end
        // OR
        if(funct == 6'b100101) begin
            rw = 1'b0;
            result = or_;
            rw = 1'b1;
        end
        // SRL, Shift right logical
        if(funct == 6'b000010) begin
            rw = 1'b0;
            result = srl_;
            rw = 1'b1;
        end
        // SLL, Shift left logical
        if(funct == 6'b000000) begin
            rw = 1'b0;
            result = sll_;
            rw = 1'b1;
        end
    end
    
    // LW, load word
    if(opcode == 6'b100011) begin
        rw = 1'b0;
        result = sum;
        rw = 1'b1;
    end

    // SW, store word
    if(opcode == 6'b101011) begin
        rw = 1'b0;
        result = sum;
        
    end

    // BEQ, branch on equals
    if(opcode == 6'b000100) begin
        rw = 1'b0;
        if(diff == 32'b00000000000000000000000000000000) begin
            result = diff;
        end
    end

    // BNE, branch not equals
    if(opcode == 6'b000101) begin
        rw = 1'b0;
        if(diff != 32'b00000000000000000000000000000000) begin
            result = diff;
        end
    end

end

endmodule
