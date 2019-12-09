img = [1 2 3;...
       3 4 5;...
       5 6 6];
   
[length,breadth] = size(img);
imgSize = length*breadth;
newImg = reshape(img,[imgSize,1]);


count = histc(newImg,unique(newImg));
newImg = unique(newImg);
[count,idx] = sort(count,'descend');
newImg = newImg(idx);
temp = newImg;
tempc = count;
for i = 1:size(newImg)-2
    x = size(temp,1);
    v = temp(x-1)*10+temp(x);
    s = tempc(x-1)+tempc(x);
    temp = temp(1:x-2);
    temp = [temp;v];
    tempc = tempc(1:x-2);
    tempc = [tempc;s];
    [tempc,id] = sort(tempc,'descend');
    temp = temp(id);
end
symbol = zeros(size(newImg));
var2 = temp(2);

while var2~=0
    symbol(mod(var2,10)) = 1;
    var2 = floor(var2/10);
end
symbol = string(symbol);
while temp(1)>10
    var1 = mod(temp(1),10);
    var2 = floor(temp(1)/10);
    symbol(var1) = symbol(var1)+"0";
    while var2~=0
        symbol(mod(var2,10)) = symbol(mod(var2,10))+"1";
        var2 = floor(var2/10);
    end
    temp(1) = floor(temp(1)/10);
end
while temp(2)>10
    var1 = mod(temp(2),10);
    var2 = floor(temp(2)/10);
    symbol(var1) = symbol(var1)+"0";
    while var2~=0
        symbol(mod(var2,10)) = symbol(mod(var2,10))+"1";
        var2 = floor(var2/10);
    end
    temp(2) = floor(temp(2)/10);
end
Lavg = 0;
symbol = symbol(idx);
for i = 1:size(newImg,1)
    Lavg = Lavg+strlength(symbol(i))*count(i);
end
Lavg = Lavg/imgSize
entropy =0;
for i = 1:size(newImg,1)
    entropy = entropy+(count(i)/imgSize*log2(count(i)/imgSize));
end
entropy = -entropy
efficiency = entropy/Lavg

