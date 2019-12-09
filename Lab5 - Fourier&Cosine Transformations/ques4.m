img = imread('cameraman.tif');
subplot(1,4,1);
imshow(img);
a = fft(img);
subplot(1,4,2);
imshow(a);
m = max(max(a));
percentage = 0.5;
frac = m*percentage/100;
a(a<frac) = 0;
final_img = ifft(a);

subplot(1,4,3);
imshow(uint8(real(final_img)));
subplot(1,4,4);
imshow(img-uint8(real(final_img)));

