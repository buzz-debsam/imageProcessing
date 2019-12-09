img = imread('cameraman.tif');
img = im2double(img);
covariance = cov(img);

[eigVec,eigVal] = eig(covariance);
eigVal = diag(eigVal);
tempEV = eigVal;

[eigVal,idx] = sort(eigVal,'descend');
eigVec = eigVec(idx,:);
mx = mean(img,2);
mse = 0;
for i=1:256
    A = eigVec(1:i,:);
% A = eigVec;
    Y = A*(img-mx);
    rimg = A.'*Y+mx;
    err = img-rimg;
    err = err.^2;
    mse = [mse sqrt(sum(sum(err)))];
end
mse = mse(2:257);
subplot(2,2,1)
imshow(img);
subplot(2,2,2)
imshow(Y);
subplot(2,2,3)
imshow(rimg);
subplot(2,2,4)
plot(mse);
