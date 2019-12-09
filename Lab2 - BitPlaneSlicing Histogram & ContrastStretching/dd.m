clear;
sample = rgb2gray(imread('fractal.png'));
[length,width,~] = size(sample);
for i = 1:length
    for j = 1:width
        plane1(i,j) = mod(sample(i,j),2);
        disp(plane1(i,j))
    end
end