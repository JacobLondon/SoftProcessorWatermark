`timescale 1ns / 1ps

/*
Generate a clock signal
*/
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