n = 8;   
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
% a = dctmtx(n);
basis = zeros(n*n);

for i = 1:n
    for j = 1:n
        temp = a(:,i)*a(:,j).';
        basis(n*(i-1)+1:n*(i-1)+n,n*(j-1)+1:n*(j-1)+n) = temp;
    end
end
imshow(basis,[]);