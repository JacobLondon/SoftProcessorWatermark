`timescale 1ns / 1ps

module GUI(
    CLK,
    COLOR_OUT,    // VGA bit patterns going to VGA port
    HS,                  // horizontal sync
    VS,                  // vertical sync
    image_choice,
    water_choice,
    regout
    );

    input CLK;
    input image_choice, water_choice;
    input [11:0] regout;
    output HS, VS;
    output [11:0] COLOR_OUT;
    
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
    reg [11:0] COLOR_IMAGE1 [0:Size - 1];       // hold image1.rgb
    reg [11:0] COLOR_IMAGE2 [0:Size - 1];       // image2.mem
    reg [11:0] COLOR_IMAGE3 [0:Size - 1];       // water1.mem
    reg [11:0] COLOR_IMAGE4 [0:Size - 1];       // water2.mem
    reg [11:0] COLOR_IMAGE_OUT [0:Size - 1];    // output watermarked image
    
    // test area to fill with what is in register 12
    reg [10:0] counter;
    initial begin
        counter = 11'b00000000000;
    end
    always @(posedge CLK) begin
        if(counter >= 500 && counter <= 1000) begin
            COLOR_IMAGE_OUT[counter] <= regout;
        end
        counter <= counter + 1;
    end
    
    wire [12:0] STATE_IMAGE1;
    wire [12:0] STATE_IMAGE2;
    wire [12:0] STATE_IMAGE_OUT;
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
        .DOWNCOUNTER(DOWNCOUNTER1)
        );
    
    // load .mem images into memory
    initial begin
        $readmemh("image1.mem", COLOR_IMAGE1);      // image1.mem -> IMAGE1
        $readmemh("image2.mem", COLOR_IMAGE2);      // image2.mem -> IMAGE2
        $readmemh("water1.mem", COLOR_IMAGE3);      // water1.mem -> IMAGE3
        $readmemh("water2.mem", COLOR_IMAGE4);      // water2.mem -> IMAGE4
    end
    
    // define pixels from topleft of screen for images to be at
    // column pixels
    localparam COLUMN0 = 0;     // Note: sizes based on images being 64x64
    localparam COLUMN1 = 64;
    localparam COLUMN2 = 128;
    localparam COLUMN3 = 192;
    localparam COLUMN4 = 256;
    localparam COLUMN5 = 320;
    localparam COLUMN6 = 384;
    localparam COLUMN7 = 448;
    // row pixels
    localparam ROW0 = 0;
    localparam ROW1 = 64;
    localparam ROW2 = 128;
    localparam ROW3 = 192;
    localparam ROW4 = 256;
    
    // define where each picture is on the monitor
    // monitor: 640x480
    // ADDRH: horizontal pixel value
    assign STATE_IMAGE1 = (ADDRH - COLUMN3) * SizeXY + ADDRV - ROW3;
    assign STATE_IMAGE2 = (ADDRH - COLUMN5) * SizeXY + ADDRV - ROW3;
    assign STATE_IMAGE_OUT = (ADDRH - COLUMN7) * SizeXY + ADDRV - ROW3;
    // other image assign statements
    
    // draw images to screen based on where the vertical
    // and horizontal pixel is being drawn at
    always @(posedge DOWNCOUNTER2) begin
        // bounds check for column and rows
        
        // imageocation: left most on screen
        if(ADDRH >= COLUMN3 && ADDRH <  COLUMN3 + SizeXY && ADDRV >= ROW3 && ADDRV <  ROW3 + SizeXY) begin
            if(image_choice == 1'b0) begin
                COLOR_IN <= COLOR_IMAGE1[{STATE_IMAGE1}];   // give the VGA Interface the current pixel of image1.mem
            end
            else begin
                COLOR_IN <= COLOR_IMAGE2[{STATE_IMAGE1}];   // image2.mem
            end
        end
        
        // watermark location: next over to the right
        else if(ADDRH >= COLUMN5 && ADDRH <  COLUMN5 + SizeXY && ADDRV >= ROW3 && ADDRV <  ROW3 + SizeXY) begin
            if(water_choice == 1'b0) begin
                COLOR_IN <= COLOR_IMAGE3[{STATE_IMAGE2}];   // water1.mem
            end
            else begin
                COLOR_IN <= COLOR_IMAGE4[{STATE_IMAGE2}];   // water2.mem
            end
        end
        
        // output locations: furthest right
        else if(ADDRH >= COLUMN7 && ADDRH <  COLUMN7 + SizeXY && ADDRV >= ROW3 && ADDRV <  ROW3 + SizeXY) begin
            COLOR_IN <= COLOR_IMAGE_OUT[{STATE_IMAGE_OUT}];
        end
        
        // else ifs...
        else begin
            COLOR_IN <= 12'hDDD;    // make the background white if an image is not being drawn there
        end
    end
    
endmodule
