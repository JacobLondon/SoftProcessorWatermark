% read the image
I = imread('0.png');	
imshow(I);
		
% Extract RED, GREEN and BLUE components from the image
R = I(:, :, 1);
G = I(:, :, 2);
B = I(:, :, 3);

% raise each member of the component by appropriate value
R = R./16; % 8 bits -> 4 bits
G = G./16; % 8 bits -> 4 bits
B = B./16; % 8 bits -> 4 bits

% tranlate to integer
R = uint8(R); % float -> uint8
G = uint8(G);
B = uint8(B);

% minus one cause sometimes conversion to integers rounds up the numbers wrongly
R = R - 1; 
G = G - 1;
B = B - 1; 

% save variable COLOR to a file in HEX format for the chip to read
fileID = fopen ('0.rgb', 'w');
for i = 1:size(R(:), 1) - 1
    % COLOR (dec) -> print to file (hex)
    fprintf (fileID, '%x%x%x\n', B(i), G(i), R(i));
end
fclose(fileID);
