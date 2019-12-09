n = 3;
smmax = 5;
offLimit = floor(n/2);
d = 0.1;
img = rgb2gray(imread('eight.tif'));
nimg = imnoise(img,'salt & pepper',d);
[l,b] = size(nimg);
medianFil = img;


for i = 1+offLimit:l-offLimit
    for j = 1+offLimit:b-offLimit
        mask = nimg(i,j);
        for k = i-offLimit:i+offLimit
            for l = j-offLimit:j+offLimit
                if i~=k && j~=l
                    mask = [mask nimg(k,l)];
                end
            end
        end
        smax = max(mask);
        smin = min(mask);
        smedian = median(mask,2);
        if smedian-smin>0 && smedian-smax<0
            if nimg(i,j)-smin>0 && nimg(i,j)-smax<0
                medianFil(i,j) = nimg(i,j);
            else
                medianFil(i,j) = smedian;
            end
        else
%             if n<smmax
%                 n = n+2;
%                 offLimit = floor(n/2);
%                 i = 1+offLimit;
%                 j = 1+offLimit;
%             else
                medianFil(i,j) = smedian;
%             end
        end
    end
end

peaksnr = psnr(medianFil,img)
ssimVal = ssim(medianFil,img)
subplot(3,1,1);
imshow(img);
title('Original Image')

subplot(3,1,2);
imshow(nimg);
title('Image with Salt & Pepper Noise')

subplot(3,1,3);
imshow(medianFil);
title('Adaptive Median Filter')