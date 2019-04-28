`timescale 1ns / 1ps

module Graphics(
    input clk,
    output [11:0] COLOR_OUT,
    output HS,
    output VS,
    input image_choice,
    input water_choice
    );
    
    wire [11:0] regout_pix;
    wire [11:0] image_pix;
    wire [11:0] water_pix;
    wire [11:0] index;
    
    Processor MIPS(
        .clk(clk),
        .regout_pix(regout_pix),
        .image_pix(image_pix),
        .water_pix(water_pix),
        .index(index));
    
    GUI GraphicsGUI(
        .CLK(clk),
        .COLOR_OUT(COLOR_OUT),
        .HS(HS),
        .VS(VS),
        .image_choice(image_choice),
        .water_choice(water_choice),
        .regout(regout_pix),
        .image_pix(image_pix),
        .water_pix(water_pix),
        .index(index)
        );
    
    
endmodule
