%Script to help generate colors. See vga_pixel_gen.sv for use
close all
x = 1:1280;

red = zeros(1280);
green = zeros(1280);
blue = zeros(1280);

%multicolor gen
for i = 1:1280
    x(i);
    red(i) = bitand(x(i), 64);
    green(i) = bitand(x(i), 128);
    blue(i) = bitand(x(i), 32);
end

hold on

plot(x, red, 'r');
plot(x, green, 'g');
plot(x, blue, 'b');

%gray gen
for i = 1:1280
    x(i);
    red(i) = bitand(x(i), 224);
    green(i) = bitand(x(i), 224);
    blue(i) = bitand(x(i), 224);
end

figure

plot(x, red, 'r');
plot(x, green, 'g');
plot(x, blue, 'b');




