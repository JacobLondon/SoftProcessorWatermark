# Image Watermark
An image watermarking tool designed to be run on a Nexys FPGA board while utilizing a softcore 32-bit MIPS processor. It outputs the watermarked image to VGA.

<img src="https://user-images.githubusercontent.com/13097797/56936977-4cb0ff80-6aaf-11e9-8b35-b0ab062ac132.png" />

# Links

Report: https://docs.google.com/document/d/1GC-dp1_2LBRvRK9D-Qm_UGnKsI6Cl1z8ytL7r9njO7Y/edit?usp=sharing

Slides: https://docs.google.com/presentation/d/1RRghf2R7uE7MKgTz-8tXAMK0WJGQOxzPDTWaPTrblRY/edit?usp=sharing

# How To Run
1. Run Vivado 2018.3 (or greater)
2. Open project -> ImageWatermark/FPGA/watermark/vivado/MIPS.xpr
3. Select -> Open Hardware Manager
4. Select -> Connect
5. Select -> Program Device

## Controls
* Connect FPGA's VGA port to a monitor
* Switch J15 controls which image is selected
* Switch L16 controls which watermark is selected

## Additional Information
* Infos: https://docs.google.com/document/d/1QwETkBvYuM0Yl76SCGv7ZICafdOZu8s39XU7XoMVrJs/edit?usp=sharing
* Paper: https://docs.google.com/document/d/1GC-dp1_2LBRvRK9D-Qm_UGnKsI6Cl1z8ytL7r9njO7Y/edit?usp=sharing

# New Images
1. Open ImageWatermark/Images/image_convert.m in MATLAB
2. Change the file input name and the destination name
3. Open project -> ImageWatermark/FPGA/watermark/vivado/MIPS.xpr
4. Add your MATLAB generated *.mem file to the project
5. Other *.mem files are located -> ImageWatermark/FPGA/vga

# New Programs
1. To create custom programs, design MIPS assembly to run in SPIM or QtSPIM
2. Test code is located -> ImageWatermark/FPGA/processor/setup
3. Convert your program to hexadecimal (http://www.kurtm.net/mipsasm/index.cgi)
4. Paste the hexadecimal code between a 'begin' and 'end' statement (see text files under /setup)
5. Run the following command: "python convert_inst.py <YOUR_FILE_NAME.txt>"
6. Paste the generated Verilog code -> ImageWatermark/FPGA/processor/inst_memory.v

# Contributors
- Jacob London
- Paul Barrameda
- Dylan Reyes
- Tiffany Dewitt
- Devin Kawamoto-Kindred
- Dr. Mohamed Aly


# Resources
* http://www.mrc.uidaho.edu/mrc/people/jff/digital/MIPSir.html
* http://www.dsi.unive.it/~gasparetto/materials/MIPS_Instruction_Set.pdf
* https://opencores.org/projects/plasma/opcodes
