`timescale 1ns / 1ps

// perform all operations given opcodes / functions
module ALU(opcode, func, in1, in2, result, readwrite, clk);

input clk;
input [5:0] opcode;
input [5:0] func;
input [31:0] in1;
input [31:0] in2;

output [31:0] result;
reg    [31:0] result;

// same as register's readwrite, read == 0, write == 1
output readwrite;
reg    readwrite;

// wires to hold temporary signals
wire [31:0] sum;
wire [31:0] difference;
wire [31:0] product;
wire [31:0] sum_or;
wire sum_cout, sub_cout;

// modules to perform the operations
RippleCarryAdder      add(in1, in2, sum_cout, sum, 1'b0);
RippleCarrySubtractor sub(in1, in2, sub_cout, difference, 1'b0);
And prod(in1, in2, product);
Or  or_op(in1, in2, sum_or);

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
        if(func == 6'b100000) begin
            readwrite = 1'b0;
            result = sum;
            readwrite = 1'b1;
        end
        // SUB
        if(func == 6'b100010) begin
            readwrite = 1'b0;
            result = difference;
            readwrite = 1'b1;
        end
        // AND
        if(func == 6'b100100) begin
            readwrite = 1'b0;
            result = product;
            readwrite = 1'b1;
        end
        // OR
        if(func == 6'b100101) begin
            readwrite = 1'b0;
            result = sum_or;
            readwrite = 1'b1;
        end
    end

    // LW, load word
    if(opcode == 6'b100011) begin
        readwrite = 1'b0;
        result = sum;
        readwrite = 1'b1;
    end
    // SW, store word
    if(opcode == 6'b101011) begin
        readwrite = 1'b0;
        result = sum;
        readwrite = 1'b1;
    end
    // BEQ, branch on equals
    if(opcode == 6'b000100) begin
        readwrite = 1'b0;
        if(difference == 32'b00000000000000000000000000000000) begin
            result = difference;
        end
    end

end

endmodule
