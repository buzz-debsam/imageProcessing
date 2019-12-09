function haar_transform()
img = im2double(imread('cameraman.tif'));
highpassF = [-0.7071068 0.7071068];
lowpassF = [0.7071068 0.7071068];
img1 = zeros(size(img));
[l,w] = size(img);
img_t = [img zeros(size(img,1),1)];
for i = 1:l
for j = 1:w
img1(i,j) = (img_t(i,j)*0.7071068 + img_t(i,j+1)*0.7071068)/2;
img11(i,j) = (img_t(i,j)*-0.7071068 + img_t(i,j+1)*0.7071068)/2;
end
end
img1 = img1(:,1:2:end);
img1_t = [img1 ; zeros(1,size(img1,2))];
img11 = img11(:,1:2:end);
img11_t = [img11 ; zeros(1,size(img11,2))];
[l,w] = size(img1);
img20 = zeros(size(img1));
img21 = zeros(size(img1));
img22 = zeros(size(img1));
img23 = zeros(size(img1));
for j = 1:w
for i = 1:l
img20(i,j) = (img1_t(i,j)*0.7071068 + img1_t(i+1,j)*0.7071068)/2;
img21(i,j) = (img1_t(i,j)*-0.7071068 + img1_t(i+1,j)*0.7071068)/2;
img22(i,j) = (img11_t(i,j)*0.7071068 + img11_t(i+1,j)*0.7071068)/2;
img23(i,j) = (img11_t(i,j)*-0.7071068 + img11_t(i+1,j)*0.7071068)/2;
end
end
approx = img20(1:2:end,:);
horizontal = img21(1:2:end,:);
vertical = img22(1:2:end,:);
diagonal = img23(1:2:end,:);
decomposed_img = [[diagonal vertical];[horizontal approx]];
subplot(1,3,1)
imshow(img)
title('Original Image');
subplot(1,3,2)
imshow(decomposed_img,[])
title('Decomposed Image');
diag = zeros(256,128);
ver = zeros(256,128);
horz = zeros(256,128);
apprx = zeros(256,128);
for i = 1:128
for j = 1:128
diag(((i-1)*2)+1,j) = diagonal(i,j);
diag(((i-1)*2)+2,j) = diagonal(i,j);
ver(((i-1)*2)+1,j) = vertical(i,j);
ver(((i-1)*2)+2,j) = vertical(i,j);
horz(((i-1)*2)+1,j) = horizontal(i,j);
horz(((i-1)*2)+2,j) = horizontal(i,j);
apprx(((i-1)*2)+1,j) = approx(i,j);
apprx(((i-1)*2)+2,j) = approx(i,j);
end
end
diag_t = [diag ; zeros(1,size(diag,2))];
ver_t = [ver ; zeros(1,size(ver,2))];
horz_t = [horz ; zeros(1,size(horz,2))];
apprx_t = [apprx ; zeros(1,size(apprx,2))];
imgR20 = zeros(size(diag));
imgR21 = zeros(size(diag));
imgR22 = zeros(size(diag));
imgR23 = zeros(size(diag));
for j = 1:128
for i = 1:256
imgR20(i,j) = (apprx_t(i,j)*0.7071068 + apprx_t(i+1,j)*0.7071068)/2;
imgR21(i,j) = (horz_t(i,j)*-0.7071068 + horz_t(i+1,j)*0.7071068)/2;
imgR22(i,j) = (ver_t(i,j)*0.7071068 + ver_t(i+1,j)*0.7071068)/2;
imgR23(i,j) = (diag_t(i,j)*-0.7071068 + diag_t(i+1,j)*0.7071068)/2;
end
end
imgR1 = zeros(256,128);
imgR11 = zeros(256,128);
for j = 1:128
for i = 1:256
imgR1(i,j) = imgR23(i,j) + imgR22(i,j);
imgR11(i,j) = imgR21(i,j) + imgR20(i,j);
end
end
img4 = zeros(256,256);
img5 = zeros(256,256);
for j = 1:128
for i = 1:256
img4(i,((j-1)*2)+1)=imgR1(i,j);
img4(i,((j-1)*2)+2)=imgR1(i,j);
img5(i,((j-1)*2)+1)=imgR11(i,j);
img5(i,((j-1)*2)+2)=imgR11(i,j);
end
end
img4 = [img4 zeros(size(img,1),1)];
img5 = [img5 zeros(size(img,1),1)];
f1 = zeros(256,256);
f2 = zeros(256,256);
for i = 1:256
for j = 1:256
f1(i,j) = (img4(i,j)*0.7071068 + img4(i,j+1)*-0.7071068)/2;
f2(i,j) = (img5(i,j)*0.7071068 + img5(i,j+1)*0.7071068)/2;
end
end
recon_img = zeros(256,256);
for i = 1:256
for j = 1:256
recon_img(i,j) = f1(i,j)+f2(i,j);
end
end
subplot(1,3,3)
imshow(recon_img,[])
title('Reconstructed Image');
% err = immse(img,recon_img);
% disp(err);
% Calculate Mean Square Error
mserr = img - recon_img;
mserr = mserr.^2;
mse = sum(sum(mserr))/(256*256);
disp(mse);