% Assumes picture is 320 pixels wide, 8 bits each RGB
% Framebuffer is 57600 24 bit words
pic = imread("reese.png");
depth = 230400;
wordlen = 12;
red   = pic(:,:,1);
red   = red';
green = pic(:,:,2);
green = green';
blue  = pic(:,:,3);
blue = blue';

% Write header info
fid = fopen('mem3.mif', 'w');
fprintf(fid, 'DEPTH=%d;\n', depth);
fprintf(fid, 'WIDTH=%d;\n', wordlen);
fprintf(fid, 'ADDRESS_RADIX = DEC;\n');
fprintf(fid, 'DATA_RADIX = HEX;\n');
fprintf(fid, 'CONTENT\n');
fprintf(fid, 'BEGIN\n\n');

% Write RGB data
for i = 0 : depth - 1
    fprintf(fid, '%d\t:\t%x%x%x;\n', i, ...
        bitshift(red(i+1),-4), bitshift(green(i+1),-4), bitshift(blue(i+1),-4));
end

fprintf(fid, 'END;\n');
fclose(fid);



