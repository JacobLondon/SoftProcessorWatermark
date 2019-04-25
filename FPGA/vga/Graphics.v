`timescale 1ns / 1ps

module Graphics(
    input clk,
    output [11:0] COLOR_OUT,
    output HS,
    output VS
    );
    
    GUI GraphicsGUI(
        .CLK(clk),
        .COLOR_OUT(COLOR_OUT),
        .HS(HS),
        .VS(VS));
    
    
endmodule
