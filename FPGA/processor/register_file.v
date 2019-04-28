`timescale 1ns / 1ps

module RegisterFile(rw, addr1, addr2, out1, out2, addr3, data3, clk, regout, imagein, waterin, waiting, done);

input rw;           // read == 0, write == 1
input [4:0] addr1;  // read: address of register 
input [4:0] addr2;  // read: address of register 2
output [31:0] out1; // read: value of register 
output [31:0] out2; // read: value of register 2
input [4:0] addr3;  // write: address of register 
input [31:0] data3; // write: value of register 3
input clk;
input waiting;
output done;

// initialize register memory
(* keep = "true"*) (*s = "true" *) reg [31:0] regmem [31:0];

// vga connection
output [31:0] regout;
assign regout = regmem[14]; // $t6 output pixel
input [11:0] imagein;
input [11:0] waterin;

// possible incorrect ranges for in -> pix (12 -> 32)
reg [31:0] temp_image_pix;
reg [31:0] temp_water_pix;
reg [31:0] out1_temp;
reg [31:0] out2_temp;
/*
//assign temp_image_pix[11:0] = imagein;
//assign temp_water_pix[11:0] = waterin;
always @(posedge clk) begin
    temp_image_pix[11:0] <= imagein;
    temp_water_pix[11:0] <= waterin;
end
*/
/*
always @(posedge clk) begin
    regmem[12] = temp_image_pix;
    regmem[13] = temp_water_pix;
end
*/

initial begin

    regmem[0]  = 32'b00000000000000000000000000000000;
    regmem[1]  = 32'b00000000000000000000000000000000;
    regmem[2]  = 32'b00000000000000000000000000000000;
    regmem[3]  = 32'b00000000000000000000000000000000;
    regmem[4]  = 32'b00000000000000000000000000000000;
    regmem[5]  = 32'b00000000000000000000000000000000;
    regmem[6]  = 32'b00000000000000000000000000000000;
    regmem[7]  = 32'b00000000000000000000000000000000;
    regmem[8]  = 32'b00000000000000000000000000000000;  // $t0 zero
    regmem[9]  = 32'b00000000000000000000000000000001;  // $t1 one
    regmem[10] = 32'b00000000000000000000111111111111;  // $t2 maximum value
    //regmem[10] = 32'b00000000000000000000000000000010;
    regmem[11] = 32'b00000000000000000000000000000000;  // $t3 pixel counter
    regmem[12] = 32'b00000000000000000000000000000000;  // $t4 test image
    regmem[13] = 32'b00000000000000000000000000000000;  // $t5 test water
    regmem[14] = 32'b00000000000000000000000000000000;  // $t6 output pixel
    //regmem[14] = 32'b00000000000000000000111111111111; // test program
    regmem[15] = 32'b00000000000000000000000000000000;  // $t7 DONE
    regmem[16] = 32'b00000000000000000000000000000000;  // $s0 temp image R, G, B
    regmem[17] = 32'b00000000000000000000000000000000;  // $s1 temp water R, G, B
    regmem[18] = 32'b00000000000000000000000000000000;  // $s2 temp regout R, G, B
    regmem[19] = 32'b00000000000000000000000011110000;  // $s3 green mask
    regmem[20] = 32'b00000000000000000000000000001111;  // $s4 blue mask
    regmem[21] = 32'b00000000000000000000000000000000;  // $s5 temp hold a result
    regmem[22] = 32'b00000000000000000000000000000000;  // $s6 WAITING
    regmem[23] = 32'b00000000000000000000000000000000;
    regmem[24] = 32'b00000000000000000000000000000000;
    regmem[25] = 32'b00000000000000000000000000000000;
    regmem[26] = 32'b00000000000000000000000000000000;
    regmem[27] = 32'b00000000000000000000000000000000;
    regmem[28] = 32'b00000000000000000000000000000000;
    regmem[29] = 32'b00000000000000000000000000000000;
    regmem[30] = 32'b00000000000000000000000000000000;
    regmem[31] = 32'b00000000000000000000000000000000;

end

// read
always @(posedge clk) begin
    //temp_image_pix[11:0] = imagein;
    //temp_water_pix[11:0] = waterin;

    //out1_temp = regmem[addr1];
    //out2_temp = regmem[addr2];
    
    // if writing
    if(rw == 1'b1) begin
        regmem[addr3] = data3;
    end
    
    //regmem[12] = temp_image_pix;
    //regmem[13] = temp_water_pix;
    regmem[12][11:0] = imagein;
    regmem[13][11:0] = waterin;
    regmem[22][0] = waiting;
end
/*
always @(negedge clk) begin

    out1_temp = regmem[addr1];
    out2_temp = regmem[addr2];
end
*/
//assign out1 = out1_temp;
//assign out2 = out2_temp;
assign out1 = regmem[addr1];
assign out2 = regmem[addr2];
assign done = regmem[15][0];

/*
// write
always @(negedge clk) begin
    // if writing
    if(rw == 1'b1) begin
        regmem[addr3] = data3;
    end
end
*/
endmodule
