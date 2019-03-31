`timescale 1ns / 1ps

module GUI(
    input CLK,
    output [11:0] COLOR_OUT,    // VGA bit patterns going to VGA port
    output HS,                  // horizontal sync
    output VS                   // vertical sync
    );
    
    reg DOWNCOUNTER1 = 0;       // reduce clk to 25 MHz
    reg DOWNCOUNTER2 = 0;       // reduce clk to 50 MHz
    parameter Size = 13'd4096;  // images are 64x64 pixels = 4096
    parameter SizeXY = 7'd64;   // images have 64 pixels per row/col
    
    // slow counter to 50 MHz
    always @(posedge CLK) begin
        DOWNCOUNTER2 <= ~DOWNCOUNTER2;
    end
    
    // slow counter to 25MHz
    always @ (posedge DOWNCOUNTER2) begin
        DOWNCOUNTER1 <= ~DOWNCOUNTER1;
    end
    
    // 2D registers to hold the images in .rgb format
    // Note: each pixel has 12-bit rgb, so give it 12 bits
    reg [11:0] COLOR_IN;
    reg [11:0] COLOR_IMAGE1 [0:Size - 1];     // hold image1.rgb
    
    wire [12:0] STATE_IMAGE1;
    wire TRIG_REFRESH;      // gives a pulse when display is refreshed
    wire [9:0] ADDRH;       // get horizontal pixel value
    wire [8:0] ADDRV;       // get vertical pixel value
    
    // use the VGA Interface as a black box
    VGAInterface VGA(
        .CLK(DOWNCOUNTER2),
        .COLOR_IN (COLOR_IN),
        .COLOR_OUT(COLOR_OUT),
        .HS(HS),
        .VS(VS),
        .REFRESH(TRIG_REFRESH),
        .ADDRH(ADDRH),
        .ADDRV(ADDRV),
        .DOWNCOUNTER(DOWNCOUNTER)
        );
    
    // load .rgb images into memory
    initial
    begin
        $readmemh("image1.rgb", IMAGE1);    // image1.rgb -> IMAGE1
    end
    
    // define pixels from topleft of screen for images to be at
    // column pixels
    localparam COLUMN0 = 0;     // Note: sizes based on images being 64x64
    localparam COLUMN1 = 65;
    // row pixels
    localparam ROW0 = 65;
    localparam ROW1 = 130;
    
    // define where each picture is on the monitor
    // monitor: 640x480
    // ADDRH: horizontal pixel value
    assign STATE_IMAGE1 = (ADDRH - COLUMN0) * SizeXY + ADDRV - ROW0;
    // other image assign statements
    
    // draw images to screen based on where the vertical
    // and horizontal pixel is being drawn at
    always @(posedge DOWNCOUNTER2) begin
        // bounds check for column and rows
        if(ADDRH >= COLUMN0 && ADDRH <  COLUMN0 + SizeXY && ADDRV >= ROW0 + SizeXY && ADDRV <  ROW0 + SizeXY)
            COLOR_IN <= COLOR_IMAGE1[{STATE_IMAGE1}];   // give the VGA Interface the current pixel of image1.rgb
        // else ifs...
        else
            COLOR_IN <= 12'hFFF;    // make the background white if an image is not being drawn there
    end
    
endmodule
