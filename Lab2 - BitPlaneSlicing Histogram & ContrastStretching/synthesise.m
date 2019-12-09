function synthesise()
img = zeros(512);
for x = 1:511
    for y = 1:511
        i = 255*(cos(2*pi*(x/50+y/25)));
        if i<0
            img(x,y) = 0;
        else
            img(x,y) = i;
        end
    end
end
imshow(img);
