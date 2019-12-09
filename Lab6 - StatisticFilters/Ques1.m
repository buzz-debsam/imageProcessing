n = 3;
offLimit = floor(n/2);
d = 0.1;
img = rgb2gray(imread('eight.tif'));
nimg = imnoise(img,'salt & pepper',d);
[l,b] = size(nimg);
meanFil = img;
medianFil = img;
minFil = img;
maxFil = img;

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
        meanFil(i,j) = mean(mask,2);
        medianFil(i,j) = median(mask,2);
        maxFil(i,j) = max(mask);
        minFil(i,j) = min(mask);
    end
end


subplot(3,2,1);
imshow(img);
title('Original Image')

subplot(3,2,2);
imshow(nimg);
title('Image with Salt & Pepper Noise')

subplot(3,2,3);
imshow(meanFil);
title('Mean Filter')

subplot(3,2,4);
imshow(medianFil);
title('Median Filter')

subplot(3,2,5);
imshow(maxFil);
title('Max Filter')

subplot(3,2,6);
imshow(minFil);
title('Min Filter')


