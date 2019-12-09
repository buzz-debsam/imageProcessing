n = 256;
f = 2*pi/n;                 
w = (0:f:2*pi-f/2).' * 1i;  
x = 0:n-1;                  
a = exp(-w*x);

H = zeros(256);
for u = 1:256
    for v = 1:256
        H(u,v) = exp(-0.001*(u*u+v*v).^(5/6));
    end
end

img = imread('cameraman.tif');
subplot(1,3,1);
imshow(img);
nimg = im2double(img);
F = (a*nimg)*(a.');
G = F.*H;

g = (conj(a).'*G)*(conj(a));
subplot(1,3,2);
imshow(real(g),[])

G = (a*g)*(a.');
F = G./H;

f = (conj(a).'*F)*(conj(a));
subplot(1,3,3);
imshow(real(f),[])

