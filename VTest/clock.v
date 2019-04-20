`timescale 1ns / 1ps

/*
Generate a clock signal
https://github.com/g-karthik/32BitMIPSProcessor
*/
module Clock(CLK);

output CLK;
reg    CLK;

initial begin
    out = 1'b0;
end

always begin
    out = #1 ~out
end

endmodule