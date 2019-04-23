input_name = 'water2.jpg'
output_name = 'water2.mem'

% read the image
I = imread(input_name);	
imshow(I);
		
% extract RED, GREEN and BLUE components from the image
R = I(:, :, 1);
G = I(:, :, 2);
B = I(:, :, 3);

% raise each member of the component by appropriate value
R = R./16; % 8 bits -> 4 bits
G = G./16; % 8 bits -> 4 bits
B = B./16; % 8 bits -> 4 bits

% translate to integer
R = uint8(R); % float -> uint8
G = uint8(G);
B = uint8(B);

% fix possible rounding error
R = R - 1; 
G = G - 1;
B = B - 1; 

% save variable COLOR to a file in HEX format
fileID = fopen (output_name, 'w');
for i = 1:size(R(:), 1) - 1
    % COLOR (dec) -> print to file (hex)
    fprintf (fileID, '%x%x%x\n', B(i), G(i), R(i));
end
fclose(fileID);
