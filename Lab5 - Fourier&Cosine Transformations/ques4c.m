n = 256;
f = 2*pi/n;                 
w = (0:f:2*pi-f/2).' * 1i;  
x = 0:n-1;                  
a = exp(-w*x);

img = imread('cameraman.tif');
subplot(1,5,1);
imshow(img);
nimg = im2double(img);
subplot(1,5,2);
dftImg = (a*nimg)*(a.');

imshow(real(dftImg));

subplot(1,5,3);
imshow(imag(dftImg));
subplot(1,5,4);
idftImg = (conj(a).'*dftImg)*(conj(a));
imshow(real(idftImg),[]);
subplot(1,5,5);
imshow(imag(idftImg),[]);