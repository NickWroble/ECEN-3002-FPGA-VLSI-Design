clc
clear all 
close all

I = imread('watermelon.png');

%imshow(I)

fid = fopen('image.mif','wt');

fprintf(fid,"%s\n\n", "% Mif file for an 8x8 watermelon photo");

fprintf(fid,"%s\n", "DEPTH = 64;");
fprintf(fid,"%s\n", "WIDTH = 24;");
fprintf(fid,"%s\n", "ADDRESS_RADIX = DEC;");
fprintf(fid,"%s\n", "DATA_RADIX = HEX;");
fprintf(fid,"%s\n", "CONTENT");
fprintf(fid,"%s\n\n", "BEGIN");



for y = 0:7 %vertical pixels
    for x = 0:7 %horizontal pixels
        fprintf(fid, "[%d] : ", x + 8*y);
        fprintf(fid, "%s", dec2hex(I(x + 1, y + 1, 1), 2));
        fprintf(fid, "%s", dec2hex(I(x + 1, y + 1, 2), 2));
        fprintf(fid, "%s", dec2hex(I(x + 1, y + 1, 3), 2));
        fprintf(fid, ";\n");
    end
end

fprintf(fid,"%s", "END;");

fclose(fid);