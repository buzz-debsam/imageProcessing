n = 8;
f = 2*pi/n;                 
w = (0:f:2*pi-f/2).' * 1i;  
x = 0:n-1;                  
a = exp(-w*x);
basis = zeros(n*n);
for i = 1:n
    for j = 1:n
        temp = a(:,i)*a(:,j).';
        basis(n*(i-1)+1:n*(i-1)+n,n*(j-1)+1:n*(j-1)+n) = temp;
    end
end
real_basis = real(basis);
img_basis = imag(basis);
abs_basis = abs(basis);
subplot(1,3,1);
imshow(real_basis,[]);
subplot(1,3,2);
imshow(img_basis,[]);
subplot(1,3,3)
imshow(abs_basis,[]);
dft