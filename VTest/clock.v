`timescale 1ns / 1ps

// generate a clock signal for the processor
module Clock(clk);
output clk;
reg    clk;

initial begin
    clk = 1'b0;
end

always begin
    clk = #1 ~clk;
end
endmodule

