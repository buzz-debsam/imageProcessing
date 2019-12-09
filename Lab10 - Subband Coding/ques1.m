img = im2double(imread('cameraman.tif'));
timg = [img zeros(size(img,1),1)];

s1img0 = zeros(size(img));
s1img1 = zeros(size(img));

[length,breadth] = size(img);

for i=1:length
    for j=1:breadth
        s1img0(i,j) = (timg(i,j)*(-0.7071068)+timg(i,j+1)*0.7071068)/2;
        s1img1(i,j) = (timg(i,j)*(0.7071068)+timg(i,j+1)*0.7071068)/2;
    end
end

s1img0 = s1img0(:,1:2:end);
ts1img0 = [s1img0;zeros(1,size(s1img0,2))];

s1img1 = s1img1(:,1:2:end);
ts1img1 = [s1img1;zeros(1,size(s1img1,2))];

s2img01 = zeros(size(s1img0));
s2img02 = zeros(size(s1img0));
s2img11 = zeros(size(s1img1));
s2img12 = zeros(size(s1img1));

[length,breadth] = size(s1img0);
for i=1:breadth
    for j=1:length
        s2img01(j,i) = (ts1img0(j,i)*(-0.7071068)+ts1img0(j+1,i)*0.7071068)/2;
        s2img02(j,i) = (ts1img0(j,i)*(0.7071068)+ts1img0(j+1,i)*0.7071068)/2;
        
        s2img11(j,i) = (ts1img1(j,i)*(-0.7071068)+ts1img1(j+1,i)*0.7071068)/2;
        s2img12(j,i) = (ts1img1(j,i)*(0.7071068)+ts1img1(j+1,i)*0.7071068)/2;
    end
end

s2img01 = s2img01(1:2:end,:);
s2img02 = s2img02(1:2:end,:);
s2img11 = s2img11(1:2:end,:);
s2img12 = s2img12(1:2:end,:);

subplot(3,2,1)
imshow(s2img01,[]);
subplot(3,2,2)
imshow(s2img02,[]);
subplot(3,2,3)
imshow(s2img11,[]);
subplot(3,2,4)
imshow(s2img12,[]);

fimg = [[s2img01 s2img02];[s2img11 s2img12]];
subplot(1,3,1)
imshow(img);
title('Original Image');
subplot(1,3,2)
imshow(fimg,[]);
title('One stage decomposition');

m = true(256,1);
m(2:2:end) = false;

x2img01 = zeros(256,128);
x2img02 = zeros(256,128);
x2img11 = zeros(256,128);
x2img12 = zeros(256,128);

x2img01(m,:) = s2img01;
x2img01(~m,:) = s2img01;
x2img02(m,:) = s2img02;
x2img02(~m,:) = s2img02;
x2img11(m,:) = s2img11;
x2img11(~m,:) = s2img11;
x2img12(m,:) = s2img12;
x2img12(~m,:) = s2img12;

tx2img01 = [x2img01;zeros(1,size(x2img01,2))];
tx2img02 = [x2img02;zeros(1,size(x2img02,2))];
tx2img11 = [x2img11;zeros(1,size(x2img11,2))];
tx2img12 = [x2img12;zeros(1,size(x2img12,2))];

[length,breadth] = size(x2img01);


for i=1:breadth
    for j=1:length
        x2img01(j,i) = (tx2img01(j,i)*(0.7071068)+tx2img01(j+1,i)*(-0.7071068))/2;
        x2img02(j,i) = (tx2img02(j,i)*(0.7071068)+tx2img02(j+1,i)*0.7071068)/2;
        
        x2img11(j,i) = (tx2img11(j,i)*(0.7071068)+tx2img11(j+1,i)*(-0.7071068))/2;
        x2img12(j,i) = (tx2img12(j,i)*(0.7071068)+tx2img12(j+1,i)*0.7071068)/2;
    end
end

x2img0 = x2img01+x2img02;
x2img1 = x2img11+x2img12;

m = true(1,256);
m(1,2:2:end) = false;
x1img0 = zeros(256,256);
x1img1 = zeros(256,256);

x1img0(:,m) = x2img0;
x1img0(:,~m) = x2img0;
x1img1(:,m) = x2img1;
x1img1(:,~m) = x2img1;

tx1img0 = [x1img0 zeros(size(x1img0,1),1)];
tx1img1 = [x1img1 zeros(size(x1img1,1),1)];

[length,breadth] = size(x1img0);

for i=1:length
    for j=1:breadth
        x1img0(i,j) = (tx1img0(i,j)*(0.7071068)+tx1img0(i,j+1)*(-0.7071068))/2;
        x1img1(i,j) = (tx1img1(i,j)*(0.7071068)+tx1img1(i,j+1)*0.7071068)/2;
    end
end

x1img = x1img0+x1img1;
subplot(1,3,3)
imshow(x1img,[]);
title('Reconstructed Image');

mserr = img-x1img;
mserr = mserr.^2;
mse = sum(sum(mserr))/(length*breadth);
disp(mse);



