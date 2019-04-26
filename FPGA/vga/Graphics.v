`timescale 1ns / 1ps

module Graphics(
    input clk,
    output [11:0] COLOR_OUT,
    output HS,
    output VS,
    input image_choice,
    input water_choice
    );
    
    wire [11:0] regout;
    
    Processor MIPS(.clk(clk), .regout(regout));
    
    GUI GraphicsGUI(
        .CLK(clk),
        .COLOR_OUT(COLOR_OUT),
        .HS(HS),
        .VS(VS),
        .image_choice(image_choice),
        .water_choice(water_choice),
        .regout(regout)
        );
    
    
endmodule
