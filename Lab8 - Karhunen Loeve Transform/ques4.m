n = 256;   
a = zeros(n);
for i = 1:n
    for j = 1:n
        if(j-1==0)
            a(i,j) = 1/sqrt(n) * cos((pi*(2*(i-1)+1)*(j-1))/(2*n));
        else
            a(i,j) = sqrt(2/n) * cos((pi*(2*(i-1)+1)*(j-1))/(2*n));
        end
    end
end

img = imread('cameraman.tif');
img = im2double(img);

subplot(1,3,1);
imshow(img);

V = a*(img*(a.'));
subplot(1,3,2);
imshow(V);
V = V(1:50,1:50);
a = a(1:50,1:256);
U = a.'*(V*a);
subplot(1,3,3);
imshow(U,[]);
